%%%-----------------------------------------------------------------------------
%%% @copyright (C) 2010-2019, 2600Hz
%%% @doc
%%% @end
%%%-----------------------------------------------------------------------------
-module(teletype_missed_call_sms).

-export([init/0
        ,handle_req/1
        ]).

-include("teletype.hrl").


-define(TEMPLATE_ID, <<"missed_call_sms">>).

-define(TEMPLATE_MACROS
       ,kz_json:from_list(
          [?MACRO_VALUE(<<"missed_call.reason">>, <<"missed_call_reason">>, <<"Missed Call Reason">>, <<"Reason why the call is terminated without been bridged or left a voicemail message">>)
           | ?DEFAULT_CALL_MACROS
           ++ ?USER_MACROS
           ++ ?COMMON_TEMPLATE_MACROS
          ]
         )
       ).

-define(TEMPLATE_SUBJECT, <<"Missed call from {{caller_id.name_number}}">>).
-define(TEMPLATE_CATEGORY, <<"sip">>).
-define(TEMPLATE_NAME, <<"Missed Call">>).

-define(TEMPLATE_TO, ?CONFIGURED_EMAILS(?EMAIL_ORIGINAL)).
-define(TEMPLATE_FROM, teletype_util:default_from_address()).
-define(TEMPLATE_CC, ?CONFIGURED_EMAILS(?EMAIL_SPECIFIED, [])).
-define(TEMPLATE_BCC, ?CONFIGURED_EMAILS(?EMAIL_SPECIFIED, [])).
-define(TEMPLATE_REPLY_TO, teletype_util:default_reply_to()).

-spec init() -> 'ok'.
init() ->
    kz_util:put_callid(?MODULE),
    teletype_templates:init(?TEMPLATE_ID, [{'macros', ?TEMPLATE_MACROS}
                                          ,{'subject', ?TEMPLATE_SUBJECT}
                                          ,{'category', ?TEMPLATE_CATEGORY}
                                          ,{'friendly_name', ?TEMPLATE_NAME}
                                          ,{'to', ?TEMPLATE_TO}
                                          ,{'from', ?TEMPLATE_FROM}
                                          ,{'cc', ?TEMPLATE_CC}
                                          ,{'bcc', ?TEMPLATE_BCC}
                                          ,{'reply_to', ?TEMPLATE_REPLY_TO}
                                          ]),
    teletype_bindings:bind(<<"missed_call">>, ?MODULE, 'handle_req').

-spec handle_req(kz_json:object()) -> template_response().
handle_req(JObj) ->
    handle_req(JObj, kapi_notifications:missed_call_v(JObj)).

-spec handle_req(kz_json:object(), boolean()) -> template_response().
handle_req(_, 'false') ->
    lager:debug("invalid data for ~s", [?TEMPLATE_ID]),
    teletype_util:notification_failed(?TEMPLATE_ID, <<"validation_failed">>);
handle_req(JObj, 'true') ->
    lager:debug("valid data for ~s, processing...", [?TEMPLATE_ID]),

    %% Gather data for template
    DataJObj = kz_json:normalize(JObj),

    AccountId = kz_json:get_value(<<"account_id">>, DataJObj),
    case teletype_util:is_notice_enabled(AccountId, JObj, ?TEMPLATE_ID) of
        'false' -> teletype_util:notification_disabled(DataJObj, ?TEMPLATE_ID);
        'true' -> process_req(DataJObj)
    end.

-spec process_req(kz_json:object()) -> template_response().
process_req(DataJObj) ->
    teletype_util:send_update(DataJObj, <<"pending">>),

    Data = kz_json:get_value([<<"notify">>, <<"data">>], DataJObj),
    From_user = kz_json:get_value(<<"from_user">>, Data),
    To_users = 
    case kz_json:get_value(<<"to_users">>, Data) of
        X when X == []; X =:= 'undefined' ->
            [kz_json:get_value(<<"from_user">>, DataJObj)];
         Else -> Else
    end,
    Message = kz_json:get_value(<<"message">>, Data),
    Macros = props:filter_undefined(
                 [{<<"system">>, teletype_util:system_params()}
                 ,{<<"account">>, teletype_util:account_params(DataJObj)}
                 ,{<<"missed_call">>,  build_missed_call_data(DataJObj)}
                 ,{<<"message">>,  Message}
                 | teletype_util:build_call_data(DataJObj, 'undefined')
                 ]),

    %% Populate templates
    RenderedTemplates = teletype_templates:render(?TEMPLATE_ID, Macros, DataJObj),

    AccountId = kz_json:get_value(<<"account_id">>, DataJObj),
    {'ok', TemplateMetaJObj} = teletype_templates:fetch_notification(?TEMPLATE_ID, AccountId),

    URL = kz_json:get_ne_binary_value(<<"url">>, TemplateMetaJObj),

    case send_sms(To_users, From_user, AccountId, URL, RenderedTemplates) of
        'ok' -> teletype_util:notification_completed(?TEMPLATE_ID);
        {'error', Reason} -> teletype_util:notification_failed(?TEMPLATE_ID, Reason)
    end.

-spec build_missed_call_data(kz_json:object()) -> kz_term:proplist().
build_missed_call_data(DataJObj) ->
    [{<<"reason">>, missed_call_reason(DataJObj)}
    ,{<<"is_bridged">>, kz_term:is_true(kz_json:get_value(<<"call_bridged">>, DataJObj))}
    ,{<<"is_message_left">>, kz_term:is_true(kz_json:get_value(<<"message_left">>, DataJObj))}
    ].

-spec missed_call_reason(kz_json:object()) -> kz_term:ne_binary().
missed_call_reason(DataJObj) ->
    missed_call_reason(DataJObj, kz_json:get_ne_binary_value([<<"notify">>, <<"hangup_cause">>], DataJObj)).

-spec missed_call_reason(kz_json:object(), kz_term:api_ne_binary()) -> kz_term:ne_binary().
missed_call_reason(_DataJObj, 'undefined') -> <<"no voicemail message was left">>;
missed_call_reason(_DataJObj, HangupCause) ->
    <<"No voicemail message was left (", HangupCause/binary, ")">>.


send_sms(To, From, AccountId, Url, RenderedTemplates) ->
    send_sms(To, From, AccountId, Url, RenderedTemplates, []).

send_sms([], _From, _AccountId, _Url, _RenderedTemplates, Acc) ->
    case lists:all(fun(X) -> X =:= 'ok' end, Acc) of
        'true' -> 'ok';
        'false' ->
            lager:error("At least one SMS send failed"),
            {'error', 'failed'}
    end;
send_sms([To|Others], From, AccountId, Url, RenderedTemplates, Acc) ->
    Msg = props:get_value(<<"text/plain">>, RenderedTemplates),
    Payload = kz_json:set_values([{<<"to">>, To}
                                  ,{<<"from">>, From}
                                  ,{<<"account_id">>, AccountId}
                                  ,{<<"message">>, Msg}]
                                  ,kz_json:new()),
    Data = kz_json:set_value(<<"data">>, Payload, kz_json:new()),
    Response = kz_http:put(Url, req_headers(), kz_json:encode(Data)),
    send_sms(Others, From, AccountId, Url, RenderedTemplates, [handle_resp(Response)|Acc]).

req_headers() ->
    props:filter_undefined(
      [{"Content-Type", "application/json"}
      ,{"User-Agent", kz_term:to_list(erlang:node())}
      ]).

handle_resp({'ok', 200, _, _}) -> 'ok';
handle_resp(Error) ->
    lager:error("failed to make http request to SMS server: ~p", [Error]),
    {'error', Error}.

