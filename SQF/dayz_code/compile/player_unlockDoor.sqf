/*
	DayZ Unlock Door
	Usage: [_obj] call player_unlockDoor;
	Made for DayZ Epoch please ask permission to use/edit/distrubute email vbawol@veteranbastards.com.
	Modified for Zupa's DoorManagement.
*/
private ["_display","_obj","_objectCharacterID"];

if (!isNil "DZE_DYN_UnlockDoorInprogress") exitWith {localize "str_epoch_player_21" call dayz_rollingMessages;};

DZE_DYN_UnlockDoorInprogress = true;

// find display and check the door opening method
_doorMethod = '';
_displayCombo = findDisplay 41144;
_displayEye = findDisplay 61144;
if(!isNull _displayEye) then {_display = _displayEye; _doorMethod = "Eye";};
if(!isNull _displayCombo) then {_display = _displayCombo; _doorMethod = "Combo";};

if (!isNull dayz_selectedDoor) then {
	if (!isNil 'KeyCodeTryTimer') then {
		if (diag_tickTime > KeyCodeTryTimer) then {
			KeyCodeTry = nil;
			KeyCodeTryTimer = nil;
		};
	};
	
	_obj = dayz_selectedDoor; // our target
	_notNearestPlayer = _obj call dze_isnearest_player;
	
	if (_notNearestPlayer) then {
		// close display since another player is closer
		_display closeDisplay 3000;
		localize "STR_EPOCH_ACTIONS_16" call dayz_rollingMessages;
	} else {
		// get object combination
		_objectCharacterID 	= _obj getVariable ["CharacterID","0"];
		
		if(DZE_doorManagement) then {
			_doorOwnerID = if(DZE_permanentPlot) then { dayz_selectedDoor getVariable ["ownerPUID","0"]; } else { dayz_selectedDoor getVariable ["characterID","0"]; };
			_doorFriendsComplex = dayz_selectedDoor getVariable ["doorfriends",[]];
			_doorAllowed = [_doorOwnerID];
			{
				_friendUID = _x select 0;
				_doorAllowed  = _doorAllowed + [_friendUID];
			} forEach _doorFriendsComplex;
			
			if( DZE_Lock_Door in _doorAllowed ) then {
				DZE_Lock_Door = dayz_selectedDoor getVariable['CharacterID','0'];
			};
		};
		
		
		
		// Check combination
		if (DZE_Lock_Door == _objectCharacterID) then {
			[player,"combo_unlock",0,false] call dayz_zombieSpeak;

			// close display
			_display closeDisplay 3000;

			// unlock if locked
			if (_obj animationPhase "Open_hinge" == 0) then {
				_obj animate ["Open_hinge", 1];
			};
			if (_obj animationPhase "Open_latch" == 0) then {
				_obj animate ["Open_latch", 1];
			};
			
			if(_doorMethod == "Eye") then {
				localize "STR_EPOCH_EYESCANNER_SUCCESS" call dayz_rollingMessages;
			};
			
			KeyCodeTry = nil;
		} else {
			["Working",0,[100,15,10,0]] call dayz_NutritionSystem;
			DZE_Lock_Door = "";
			[player,"combo_locked",0,false] call dayz_zombieSpeak;
			[player,20,true,(getPosATL player)] spawn player_alertZombies;

			if (isNil 'KeyCodeTry') then {KeyCodeTry = 0;};
			KeyCodeTry = KeyCodeTry + 1;

			if (!isNil 'KeyCodeTryTimer') then {KeyCodeTryTimer = diag_tickTime+10;};
			if (KeyCodeTry >= ((round(random 4)) + 4)) then {	
				if (isNil 'KeyCodeTryTimer') then {KeyCodeTryTimer = diag_tickTime+10;};	
				localize "str_epoch_player_19" call dayz_rollingMessages;
				_display closeDisplay 3000;
			};

			if(_doorMethod == "Eye") then {
				localize "STR_EPOCH_EYESCANNER_FAILURE" call dayz_rollingMessages;
				_display closeDisplay 3000;
			};
		};
	};
} else {
	// close display since no target
	_display closeDisplay 3000;
};
DZE_DYN_UnlockDoorInprogress = nil;