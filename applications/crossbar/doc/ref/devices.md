# Devices

## About Devices

#### Schema

A device be it a SIP phone or landline number



Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`call_forward.direct_calls_only` | Determines if the calls that are not directly sent to the device should be forwarded | `boolean()` | `false` | `false` | `supported`
`call_forward.enabled` | Determines if the call forwarding should be used | `boolean()` | `false` | `false` | `supported`
`call_forward.failover` | Enable the call-forwarding parameters if the device is offline | `boolean()` | `false` | `false` | `supported`
`call_forward.ignore_early_media` | The option to determine if early media from the call forwarded number should ignored | `boolean()` | `true` | `false` |  
`call_forward.keep_caller_id` | Determines if the caller id is kept when the call is forwarded, if not the devices caller id is used | `boolean()` | `true` | `false` | `supported`
`call_forward.number` | The number to forward calls to | `string(0..15)` |   | `false` | `supported`
`call_forward.require_keypress` | Determines if the callee is prompted to press 1 to accept the call | `boolean()` | `true` | `false` | `supported`
`call_forward.substitute` | Determines if the call forwarding replaces the device | `boolean()` | `true` | `false` | `supported`
`call_forward` | The device call forward parameters | `object()` |   | `false` |  
`call_recording` | endpoint recording settings | [#/definitions/call_recording](#call_recording) |   | `false` |  
`call_restriction` | Device level call restrictions for each available number classification | `object()` | `{}` | `false` |  
`call_waiting` | Parameters for server-side call waiting | [#/definitions/call_waiting](#call_waiting) |   | `false` |  
`caller_id` | The device caller ID parameters | [#/definitions/caller_id](#caller_id) |   | `false` |  
`caller_id_options.outbound_privacy` | Determines what appears as caller id for offnet outbound calls. Values: full - hides name and number; name - hides only name; number - hides only number; none - hides nothing | `string('full' | 'name' | 'number' | 'none')` |   | `false` |  
`caller_id_options` | custom properties for configuring caller_id | `object()` |   | `false` |  
`contact_list.exclude` | If set to true the device is excluded from the contact list | `boolean()` |   | `false` | `supported`
`contact_list` | Contact List Parameters | `object()` | `{}` | `false` |  
`device_type` | Arbitrary device type used by the UI and billing system | `string()` |   | `false` |  
`dial_plan` | A list of rules used to modify dialed numbers | [#/definitions/dialplans](#dialplans) |   | `false` |  
`do_not_disturb.enabled` | Is do-not-disturb enabled for this device? | `boolean()` |   | `false` |  
`do_not_disturb` | DND Parameters | `object()` |   | `false` |  
`enabled` | Determines if the device is currently enabled | `boolean()` | `true` | `false` | `supported`
`exclude_from_queues` | Do not ring this device when calling user/agent in queue | `boolean()` | `false` | `false` |  
`flags.[]` |   | `string()` |   | `false` | `supported`
`flags` | Flags set by external applications | `array(string())` |   | `false` | `supported`
`formatters` | Schema for request formatters | [#/definitions/formatters](#formatters) |   | `false` |  
`hotdesk.users./^[a-zA-Z0-9]{32}$/` | user-specific hotdesk settings | `object()` |   | `false` |  
`hotdesk.users` | The user(s) currently hotdesked into the device | `object()` |   | `false` |  
`hotdesk` | The hotdesk status of this device | `object()` |   | `false` |  
`language` | The language for the device | `string()` |   | `false` | `supported`
`mac_address` | The MAC Address of the device (if applicable) | `string()` |   | `false` | `supported`
`media` | Configure audio/video/etc media options for this device | [#/definitions/endpoint.media](#endpointmedia) |   | `false` |  
`metaflows` | The device metaflow parameters | [#/definitions/metaflows](#metaflows) |   | `false` |  
`music_on_hold.media_id` | The ID of a media object that should be used as the music on hold | `string(0..2048)` |   | `false` |  
`music_on_hold` | The music on hold parameters used if not a property of the device owner | `object()` | `{}` | `false` |  
`mwi_unsolicited_updates` | When true enables unsolicited mwi notifications | `boolean()` | `true` | `false` |  
`name` | A friendly name for the device | `string(1..128)` |   | `true` | `supported`
`outbound_flags` | List of flags (features) this device requires when making outbound calls | `array(string()) | object()` |   | `false` |  
`owner_id` | The ID of the user object that 'owns' the device | `string(32)` |   | `false` |  
`presence_id` | Static presence ID (used instead of SIP username) | `string()` |   | `false` | `supported`
`provision.check_sync_event` | Value to use in Event header for device reload/reboot | `string()` |   | `false` |  
`provision.check_sync_reboot` | Value to append to 'check-sync' event if phone should reboot after reloading settings | `string()` |   | `false` |  
`provision.check_sync_reload` | Value to append to 'check-sync' event if phone should not reboot after reloading settings | `string()` |   | `false` |  
`provision.combo_keys./^[0-9]+$/` | Device provisioner Combo/Feature Key | [#/definitions/devices.combo_key](#devicescombo_key) |   | `false` |  
`provision.combo_keys` |   | `object()` |   | `false` |  
`provision.endpoint_brand` | Brand of the phone | `string()` |   | `false` |  
`provision.endpoint_family` | Family name of the phone | `string()` |   | `false` |  
`provision.endpoint_model` | Model name of the phone | `string() | integer()` |   | `false` |  
`provision.feature_keys./^[0-9]+$/` | Device provisioner Combo/Feature Key | [#/definitions/devices.combo_key](#devicescombo_key) |   | `false` |  
`provision.feature_keys` |   | `object()` |   | `false` |  
`provision` | Provision data | `object()` |   | `false` |  
`register_overwrite_notify` | When true enables overwrite notifications | `boolean()` | `false` | `false` |  
`ringtones.external` | The alert info SIP header added when the call is from internal sources | `string(0..256)` |   | `false` |  
`ringtones.internal` | The alert info SIP header added when the call is from external sources | `string(0..256)` |   | `false` |  
`ringtones` | Ringtone Parameters | `object()` | `{}` | `false` |  
`sip.custom_sip_headers.in` | Custom SIP Headers to be applied to calls inbound to Kazoo from the endpoint | [#/definitions/custom_sip_headers](#custom_sip_headers) |   | `false` |  
`sip.custom_sip_headers.out` | Custom SIP Headers to be applied to calls outbound from Kazoo to the endpoint | [#/definitions/custom_sip_headers](#custom_sip_headers) |   | `false` |  
`sip.custom_sip_headers.^[a-zA-z0-9_\-]+$` | The SIP header to add | `string()` |   | `false` |  
`sip.custom_sip_headers` | A property list of SIP headers | `object()` |   | `false` |  
`sip.expire_seconds` | The time, in seconds, sent to the provisioner for the registration period that the device should be configured with. | `integer()` | `300` | `false` | `supported`
`sip.ignore_completed_elsewhere` | When set to false the phone should not consider ring group calls answered elsewhere as missed | `boolean()` |   | `false` |  
`sip.invite_format` | The SIP request URI invite format | `string('username' | 'npan' | '1npan' | 'e164' | 'route' | 'contact')` | `contact` | `false` | `supported`
`sip.ip` | IP address for this device | `string()` |   | `false` | `supported`
`sip.method` | Method of authentication | `string('password' | 'ip')` | `password` | `false` | `supported`
`sip.number` | The number used if the invite format is 1npan, npan, or e164 (if not set the dialed number is used) | `string()` |   | `false` |  
`sip.password` | SIP authentication password | `string(5..32)` |   | `false` | `supported`
`sip.realm` | The realm this device should use, overriding the account realm. Should rarely be necessary. | `string(4..253)` |   | `false` |  
`sip.route` | The SIP URL used if the invite format is 'route' | `string()` |   | `false` | `supported`
`sip.static_route` | Sends all inbound calls to this string (instead of dialed number or username) | `string()` |   | `false` |  
`sip.username` | SIP authentication username | `string(2..32)` |   | `false` | `supported`
`sip` | SIP Parameters | `object()` | `{}` | `false` |  
`suppress_unregister_notifications` | When true disables deregister notifications | `boolean()` | `false` | `false` |  
`timezone` | Device's timezone | `string()` |   | `false` | `supported`

### call_recording

endpoint recording settings


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`any` | settings for any calls to/from the endpoint | [#/definitions/call_recording.source](#call_recordingsource) |   | `false` |  
`inbound` | settings for inbound calls to the endpoint | [#/definitions/call_recording.source](#call_recordingsource) |   | `false` |  
`outbound` | settings for outbound calls from the endpoint | [#/definitions/call_recording.source](#call_recordingsource) |   | `false` |  

### call_recording.parameters


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`enabled` | is recording enabled | `boolean()` |   | `false` |  
`format` | What format to store the recording on disk | `string('mp3' | 'wav')` |   | `false` |  
`record_min_sec` | The minimum length, in seconds, the recording must be to be considered successful. Otherwise it is deleted | `integer()` |   | `false` |  
`record_on_answer` | Recording should start on answer | `boolean()` |   | `false` |  
`record_on_bridge` | Recording should start on bridge | `boolean()` |   | `false` |  
`record_sample_rate` | What sampling rate to use on the recording | `integer()` |   | `false` |  
`time_limit` | Time limit, in seconds, for the recording | `integer()` |   | `false` |  
`url` | The URL to use when sending the recording for storage | `string()` |   | `false` |  

### call_recording.source


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`any` | settings for calls from any network | [#/definitions/call_recording.parameters](#call_recordingparameters) |   | `false` |  
`offnet` | settings for calls from offnet networks | [#/definitions/call_recording.parameters](#call_recordingparameters) |   | `false` |  
`onnet` | settings for calls from onnet networks | [#/definitions/call_recording.parameters](#call_recordingparameters) |   | `false` |  

### call_waiting

Parameters for server-side call waiting


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`enabled` | Determines if server side call waiting is enabled/disabled | `boolean()` |   | `false` |  

### caller_id

Defines caller ID settings based on the type of call being made


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`asserted.name` | The asserted identity name for the object type | `string(0..35)` |   | `false` |  
`asserted.number` | The asserted identity number for the object type | `string(0..35)` |   | `false` |  
`asserted.realm` | The asserted identity realm for the object type | `string()` |   | `false` |  
`asserted` | Used to convey the proven identity of the originator of a request within a trusted network. | `object()` |   | `false` |  
`emergency.name` | The caller id name for the object type | `string(0..35)` |   | `false` |  
`emergency.number` | The caller id number for the object type | `string(0..35)` |   | `false` |  
`emergency` | The caller ID used when a resource is flagged as 'emergency' | `object()` |   | `false` |  
`external.name` | The caller id name for the object type | `string(0..35)` |   | `false` |  
`external.number` | The caller id number for the object type | `string(0..35)` |   | `false` |  
`external` | The default caller ID used when dialing external numbers | `object()` |   | `false` |  
`internal.name` | The caller id name for the object type | `string(0..35)` |   | `false` |  
`internal.number` | The caller id number for the object type | `string(0..35)` |   | `false` |  
`internal` | The default caller ID used when dialing internal extensions | `object()` |   | `false` |  

### custom_sip_headers

Custom SIP headers applied to an INVITE


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`^[a-zA-z0-9_\-]+$` | The SIP header to add | `string()` |   | `false` |  

### devices.combo_key

Device provisioner Combo/Feature Key


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------

### dialplans

Permit local dialing by converting the dialed number to a routable form


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`system.[]` |   | `string()` |   | `false` |  
`system` | List of system dial plans | `array(string())` |   | `false` |  

### endpoint.media

Schema for endpoint media options


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`audio.codecs.[]` |   | `string('OPUS' | 'CELT@32000h' | 'G7221@32000h' | 'G7221@16000h' | 'G722' | 'speex@32000h' | 'speex@16000h' | 'PCMU' | 'PCMA' | 'G729' | 'GSM' | 'CELT@48000h' | 'CELT@64000h' | 'G722_16' | 'G722_32' | 'CELT_48' | 'CELT_64' | 'Speex' | 'speex')` |   | `false` |  
`audio.codecs` | A list of audio codecs the endpoint supports | `array(string('OPUS' | 'CELT@32000h' | 'G7221@32000h' | 'G7221@16000h' | 'G722' | 'speex@32000h' | 'speex@16000h' | 'PCMU' | 'PCMA' | 'G729' | 'GSM' | 'CELT@48000h' | 'CELT@64000h' | 'G722_16' | 'G722_32' | 'CELT_48' | 'CELT_64' | 'Speex' | 'speex'))` |   | `false` |  
`audio` | The audio media parameters | `object()` | `{}` | `false` |  
`bypass_media` | Default bypass media mode (The string type is deprecated, please use this as a boolean) | `boolean() | string('true' | 'false' | 'auto')` |   | `false` |  
`encryption.enforce_security` | Is Encryption Enabled? | `boolean()` | `false` | `false` |  
`encryption.methods.[]` |   | `string('zrtp' | 'srtp')` |   | `false` |  
`encryption.methods` | Supported Encryption Types | `array(string('zrtp' | 'srtp'))` | `[]` | `false` |  
`encryption` | Encryption Parameters | `object()` | `{}` | `false` |  
`fax_option` | Is T.38 Supported? | `boolean()` |   | `false` |  
`ignore_early_media` | The option to determine if early media from the endpoint should always be ignored | `boolean()` |   | `false` |  
`progress_timeout` | The progress timeout to apply to the endpoint (seconds) | `integer()` |   | `false` |  
`video.codecs.[]` |   | `string('H261' | 'H263' | 'H264' | 'VP8')` |   | `false` |  
`video.codecs` | A list of video codecs the endpoint supports | `array(string('H261' | 'H263' | 'H264' | 'VP8'))` | `[]` | `false` |  
`video` | The video media parameters | `object()` | `{}` | `false` |  

### formatters

Schema for request formatters


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`^[[:alnum:]_]+$` | Key to match in the route request JSON | `array([#/definitions/formatters.format_options](#formattersformat_options)) | [#/definitions/formatters.format_options](#formattersformat_options)` |   | `false` |  

### formatters.format_options

Schema for formatter options


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`direction` | Only apply the formatter on the relevant request direction | `string('inbound' | 'outbound' | 'both')` |   | `false` |  
`match_invite_format` | Applicable on fields with SIP URIs. Will format the username portion to match the invite format of the outbound request. | `boolean()` |   | `false` |  
`prefix` | Prepends value against the result of a successful regex match | `string()` |   | `false` |  
`regex` | Matches against the value, with optional capture group | `string()` |   | `false` |  
`strip` | If set to true, the field will be stripped from the payload | `boolean()` |   | `false` |  
`suffix` | Appends value against the result of a successful regex match | `string()` |   | `false` |  
`value` | Replaces the current value with the static value defined | `string()` |   | `false` |  

### metaflow

A metaflow node defines a module to execute, data to provide to that module, and one or more children to branch to


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`children./.+/` | A metaflow node defines a module to execute, data to provide to that module, and one or more children to branch to | [#/definitions/metaflow](#metaflow) |   | `false` |  
`children` | Children metaflows | `object()` |   | `false` |  
`data` | The data/arguments of the metaflow module | `object()` | `{}` | `false` |  
`module` | The name of the metaflow module to execute at this node | `string(1..64)` |   | `true` |  

### metaflows

Actions applied to a call outside of the normal callflow, initiated by the caller(s)


Key | Description | Type | Default | Required | Support Level
--- | ----------- | ---- | ------- | -------- | -------------
`binding_digit` | What DTMF will trigger the collection and analysis of the subsequent DTMF sequence | `string('1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' | '0' | '*' | '#')` | `*` | `false` |  
`digit_timeout` | How long to wait between DTMF presses before processing the collected sequence (milliseconds) | `integer()` |   | `false` |  
`listen_on` | Which leg(s) of the call to listen for DTMF | `string('both' | 'self' | 'peer')` |   | `false` |  
`numbers./^[0-9]+$/` | A metaflow node defines a module to execute, data to provide to that module, and one or more children to branch to | [#/definitions/metaflow](#metaflow) |   | `false` |  
`numbers` | A list of static numbers with their flows | `object()` |   | `false` |  
`patterns./.+/` | A metaflow node defines a module to execute, data to provide to that module, and one or more children to branch to | [#/definitions/metaflow](#metaflow) |   | `false` |  
`patterns` | A list of patterns with their flows | `object()` |   | `false` |  



## Fetch

> GET /v2/accounts/{ACCOUNT_ID}/devices

```shell
curl -v -X GET \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices
```

## Create

> PUT /v2/accounts/{ACCOUNT_ID}/devices

```shell
curl -v -X PUT \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices
```

## Fetch

> GET /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}

```shell
curl -v -X GET \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}
```

## Create

> PUT /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}

```shell
curl -v -X PUT \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}
```

## Change

> POST /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}

```shell
curl -v -X POST \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}
```

## Patch

> PATCH /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}

```shell
curl -v -X PATCH \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}
```

## Remove

> DELETE /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}

```shell
curl -v -X DELETE \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}
```

## Fetch

> GET /v2/accounts/{ACCOUNT_ID}/devices/status

```shell
curl -v -X GET \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/status
```

## Change

> POST /v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}/sync

```shell
curl -v -X POST \
    -H "X-Auth-Token: {AUTH_TOKEN}" \
    http://{SERVER}:8000/v2/accounts/{ACCOUNT_ID}/devices/{DEVICE_ID}/sync
```

