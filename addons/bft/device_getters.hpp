
// [_deviceID, _callsign, _typeIconPath, _sizeIconPath, _position, _encryptionKeys, [_groupID, _color], _deviceClass, time, _refreshRate, _owner, _viewModes, _direction];
#define AD_GET_ID(DATA) (DATA select 0)
#define AD_GET_CALLSIGN(DATA) (DATA select 1)
#define AD_GET_TYPEICON(DATA) (DATA select 2)
#define AD_GET_SIZEICON(DATA) (DATA select 3)
#define AD_GET_POSITION(DATA) (DATA select 4)
#define AD_GET_ENCRYPTION(DATA) (DATA select 5)
#define AD_GET_GROUP_ID(DATA) ((DATA select 6) select 0)
#define AD_GET_COLOR(DATA) ((DATA select 6) select 1)
#define AD_GET_CLASSNAME(DATA) (DATA select 7)
#define AD_GET_TIME(DATA) (DATA select 8)
#define AD_GET_REFRESH_RATE(DATA) (DATA select 9)
#define AD_GET_OWNER(DATA) (DATA select 10)
#define AD_GET_VIEWMOES(DATA) (DATA select 11)
#define AD_GET_DIRECTION(DATA) (DATA select 12)
#define AD_GET_DEVICE_STATE(DATA) (DATA select 13)
#define AD_GET_DEVICE_STATE_VALUE(DATA) (AD_GET_DEVICE_STATE(DATA) select 0)


// [_magID, [_deviceSide, _deviceEncryptionKeys], _assignableInformation, _app, -1, _owner, _item, _deviceType, _refreshRate, _deviceModes]
// format: device ID, deviceSide [side, encryptionKeys], deviceInformation [elementType, elementSize, callsign, orbatID], appInformation [appID, appData], timeLoggedIn, owner, item, deviceType, _refreshRate [TX, RX], _deviceModes]

#define DEVICE_PARAMS(DATA) DATA params ["_id", "_sideInfo", "_typeInfo"]; // TODO finish

#define D_GET_ID(DATA) (DATA select 0)
#define D_GET_SIDE(DATA) ((DATA select 1) select 0)
#define D_GET_ENCRYPTION(DATA) ((DATA select 1) select 1)
#define D_GET_TYPE(DATA) ((DATA select 2) select 0)
#define D_GET_SIZE(DATA) ((DATA select 2) select 1)
#define D_GET_CALLSIGN(DATA) ((DATA select 2) select 2)
#define D_GET_GROUP_ID(DATA) ((DATA select 2) select 3)
#define D_GET_APP_ID(DATA) ((DATA select 3) select 0)
#define D_GET_APP_DATA(DATA) ((DATA select 3) select 1)
#define D_GET_TIME_LOGGED_IN(DATA) (DATA select 4)
#define D_GET_OWNER(DATA) (DATA select 5)
#define D_GET_CLASSNAME(DATA) (DATA select 6)
#define D_GET_DEVICETYPE(DATA) (DATA select 7)
#define D_GET_REFRESH_RATE_TX(DATA) ((DATA select 8) select 0)
#define D_GET_REFRESH_RATE_RX(DATA) ((DATA select 8) select 1)
#define D_GET_DEVICEMODES(DATA) (DATA select 9)
#define D_GET_DEVICE_STATE(DATA) (DATA select 10)
#define D_GET_DEVICE_STATE_VALUE(DATA) (D_GET_DEVICE_STATE(DATA) select 0)

// DEVICE STATES
#define STATE_NORMAL 0
#define STATE_DESTROYED 1
#define STATE_LOCKED 2
#define STATE_OFFLINE 3
