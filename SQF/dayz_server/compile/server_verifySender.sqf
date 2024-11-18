/*
	PVEH does not provide any information about the sender in A2, so
	this is necessary to verify the sender was not spoofed.
	
	This is useful to hinder and identify cheaters who attempt mass deletion or creation of hive objects via PVS.
*/

local _params = _this select 0;
local _function = "Server_" + (_this select 1);
local _objPos = _this select 2; //Can be object or position
local _clientKey = _this select 3;
local _playerUID = _this select 4;
local _player = _this select 5;
local _playerPos = getPosATL _player; //Use ATL as object position always is in ATL format.

local _index = dayz_serverPUIDArray find _playerUID;

if (typeName _objPos == "OBJECT") then { //_objPos needs to be in ATL format when using distance against playerPos.
	_objPos = getPosATL _objPos;
};

local _exitReason = call {
	//If object or player is null distance returns 9999+
	//If object or player was moved with setPos on client, position takes a second to update on server
	//Coordinates can be used in place of object
	if (_objPos distance _playerPos > (Z_VehicleDistance + 10)) exitwith {
		format["%1 error: Verification failed, player is too far from object. Distance: %2m/%3m limit PV ARRAY: %4",_function,round (_objPos distance _playerPos),Z_VehicleDistance + 10,_params]
	}; 
	if (_index < 0) exitwith {
		format["%1 error: PUID NOT FOUND ON SERVER. PV ARRAY: %2",_function,_params]
	};
	if (((dayz_serverClientKeys select _index) select 0 != owner _player) || ((dayz_serverClientKeys select _index) select 1 != _clientKey)) exitwith {
		format["%1 error: CLIENT AUTH KEY INCORRECT OR UNRECOGNIZED. PV ARRAY: %2",_function,_params]
	};
	"";
};

_exitReason
