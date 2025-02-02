private ["_buyingArray","_activatingPlayer","_bTotal","_backpack","_backpacksToBuy","_buyVehicle","_buyingType","_canBuy","_count","_dir","_enoughMoney","_hasPrimary","_helipad","_isKeyOK","_item2Add","_itemsToLog","_keySelected","_location","_moneyInfo","_wealth","_parentClasses","_part_out","_pistolMagsToBuy","_priceToBuy","_primaryToBuy","_regularMagsToBuy","_sidearmToBuy","_sign","_success","_tCost","_toolAmounts","_toolClasses","_toolsToBuy","_vehiclesToBuy","_weaponsToBuy","_keyNumber","_vehName","_backpackName"];

if (count Z_BuyingArray < 1) exitWith { systemChat localize "STR_EPOCH_TRADE_BUY_NO_ITEMS"; };

_buyingArray = Z_BuyingArray;
Z_BuyingArray = [];
_pistolMagsToBuy = 0;
_regularMagsToBuy = 0;
_weaponsToBuy = 0;
_backpacksToBuy = 0;
_toolsToBuy = 0;
_sidearmToBuy = 0;
_primaryToBuy = 0;
_vehiclesToBuy = 0;
_priceToBuy = 0;
_toolAmounts = [];
_toolClasses = [];
_itemsToLog = [[],[],[],"buy"];

if (Z_SingleCurrency) then {
	{
		if (_x select 1 == "trade_weapons") then {
			_parentClasses =  [(configFile >> "CfgWeapons" >> (_x select 0)),true] call BIS_fnc_returnParents;
			if ('ItemCore' in _parentClasses || 'Binocular' in _parentClasses) then {
				_toolsToBuy = _toolsToBuy + (_x select 9);
				_toolClasses set [count _toolClasses,(_x select 0)];
				_toolAmounts set [count _toolAmounts,(_x select 9)];
			} else {
				_weaponsToBuy = _weaponsToBuy + (_x select 9);
				if ('PistolCore' in _parentClasses) then {
					_sidearmToBuy = _sidearmToBuy + (_x select 9);
				} else {
					_primaryToBuy = _primaryToBuy + (_x select 9);
				};
			};
			_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
		};
		if (_x select 1 == "trade_items") then {
			if (getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "type") == 16) then { // 16 = WeaponSlotHandGunItem (pistol ammo slot)
				_pistolMagsToBuy = _pistolMagsToBuy + (_x select 9);
			} else {
				_regularMagsToBuy = _regularMagsToBuy + (_x select 9);
			};
			_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
		};
		if (_x select 1 == "trade_backpacks") then {
			_backpacksToBuy = _backpacksToBuy + (_x select 9);
			_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
		};
		if ((_x select 1) in DZE_tradeVehicle) then {
			_vehiclesToBuy = _vehiclesToBuy + (_x select 9);
			_priceToBuy	= _priceToBuy + ((_x select 9)*(_x select 2));
		};
		_itemsToLog set [0, (_itemsToLog select 0) + [_x select 0]];
		_itemsToLog set [1, (_itemsToLog select 1) + [_x select 9]];
		_itemsToLog set [2, (_itemsToLog select 2) + [((_x select 9)*(_x select 2))]];
	} count _buyingArray;
} else {
	{
		if (_x select 1 == "trade_weapons") then {
			_parentClasses =  [(configFile >> "CfgWeapons" >> (_x select 0)),true] call BIS_fnc_returnParents;
			if ('ItemCore' in _parentClasses || 'Binocular' in _parentClasses) then {
				_toolsToBuy = _toolsToBuy + (_x select 9);
				_toolClasses set [count _toolClasses,(_x select 0)];
				_toolAmounts set [count _toolAmounts,(_x select 9)];
			} else {
				_weaponsToBuy = _weaponsToBuy + (_x select 9);
				if ('PistolCore' in _parentClasses) then {
					_sidearmToBuy = _sidearmToBuy + (_x select 9);
				} else {
					_primaryToBuy = _primaryToBuy + (_x select 9); //Include launchers in this count since they also take up 10 slots in backpack
				};
			};
			_priceToBuy	= _priceToBuy + ((_x select 11)*(_x select 2)*(_x select 9));
		};
		if (_x select 1 == "trade_items") then {
			if (getNumber (configFile >> "CfgMagazines" >> (_x select 0) >> "type") == 16) then { // 16 = WeaponSlotHandGunItem (pistol ammo slot)
				_pistolMagsToBuy = _pistolMagsToBuy + (_x select 9);
			} else {
				_regularMagsToBuy = _regularMagsToBuy + (_x select 9);
			};
			_priceToBuy	= _priceToBuy + ((_x select 11) *(_x select 2)*(_x select 9));
		};
		if (_x select 1 == "trade_backpacks") then {
			_backpacksToBuy = _backpacksToBuy + (_x select 9);
			_priceToBuy	= _priceToBuy + ((_x select 11)*(_x select 2)*(_x select 9));
		};
		if ((_x select 1) in DZE_tradeVehicle) then {
			_vehiclesToBuy = _vehiclesToBuy + (_x select 9);
			_priceToBuy	= _priceToBuy + ((_x select 11)*(_x select 2)*(_x select 9));
		};
		_itemsToLog set [0, (_itemsToLog select 0) + [_x select 0]];
		_itemsToLog set [1, (_itemsToLog select 1) + [_x select 9]];
		_itemsToLog set [2, (_itemsToLog select 2) + [((_x select 11)*(_x select 2)*(_x select 9))]];
	} count _buyingArray;
};

_canBuy = [_weaponsToBuy,[_pistolMagsToBuy,_regularMagsToBuy],_backpacksToBuy,_toolsToBuy,_sidearmToBuy,_primaryToBuy,_vehiclesToBuy,_toolClasses,_toolAmounts] call Z_allowBuying;
if (!_canBuy) exitWith {}; // Keep systemChat reasons for failure in Z_allowBuying for sanity

_enoughMoney = false;
_moneyInfo = [false, [], [], [], 0];

if (Z_SingleCurrency) then {
	_wealth = player getVariable[(["cashMoney","globalMoney"] select Z_persistentMoney),0];
	_enoughMoney = (_wealth >= _priceToBuy);	
} else {
	_moneyInfo = _priceToBuy call Z_canAfford;
	_enoughMoney = _moneyInfo select 0;
};

// Pre-check if player has enough room to accept change
_success = if (Z_SingleCurrency) then { true } else { [player,_priceToBuy,_moneyInfo,true,_regularMagsToBuy] call Z_payDefault };
if (!_success && _enoughMoney) exitWith { systemChat localize "STR_EPOCH_TRADE_GEAR_AND_BAG_FULL"; }; // Not enough room in gear or bag to accept change

if (_enoughMoney) then {
	_bTotal = 0;
	_buyVehicle = {
		_part_out = _this select 0;
		_buyingType = _this select 1;
		_keySelected = "0";
		_isKeyOK = false;
		if (_buyingType in DZE_tradeVehicleKeyless) then {
			_isKeyOK = true;
		} else {
			_keyNumber = (floor(random 2500)) + 1;
			_keySelected = format["%1%2",DZE_itemKeys call BIS_fnc_selectRandom,_keyNumber];
			_isKeyOK = 	isClass(configFile >> "CfgWeapons" >> _keySelected);
		};
		if (!_isKeyOK) exitWith {localize "str_epoch_player_107" call dayz_rollingMessages; "";};
		_activatingPlayer = player;
		_dir = round(random 360);
		_helipad = nearestObjects [player, ["HeliHCivil","HeliHempty"], 100];

		// Note server now uses createVehicle "NONE" so next closest safePos is found automatically if location is blocked
		if (count _helipad > 0) then {
			_location = [(_helipad select 0)] call FNC_GetPos;
		} else {
			_location = [player] call FNC_GetPos;
		};

		_sign = "Sign_arrow_down_large_EP1" createVehicleLocal [0,0,0];
		_sign setPos _location;
		_location = [_sign] call FNC_GetPos;
		
		if (surfaceIsWater _location && {count (_location nearEntities ["Ship",8]) > 0}) then {
			deleteVehicle _sign;
			localize "STR_EPOCH_TRADE_OBSTRUCTED" call dayz_rollingMessages;
		} else {
			[_part_out,_sign] call fn_waitForObject;
		};

		if (_buyingType in DZE_tradeVehicleKeyless) then {
			PVDZE_veh_Publish2 = [[_dir,_location],_part_out,true,"0",_activatingPlayer,dayz_authKey];
		} else {
			PVDZE_veh_Publish2 = [[_dir,_location],_part_out,false,_keySelected,_activatingPlayer,dayz_authKey];
		};
		publicVariableServer "PVDZE_veh_Publish2";
		_keySelected;
	};

	closeDialog 2;
	_item2Add = "0";

	if (Z_SellingFrom == 0) then { //backpack
		_backpack = unitBackpack player;
		{
			if (_x select 1 == "trade_weapons") then {
				_backpack addWeaponCargoGlobal [_x select 0, _x select 9];
			};
			if (_x select 1 == "trade_items") then {
				_backpack addMagazineCargoGlobal  [_x select 0, _x select 9];
			};				
			if ((_x select 1) in DZE_tradeVehicle) then {
				_item2Add = [(_x select 0), (_x select 1)] call _buyVehicle;
				if (_item2Add != "0") then {
					_backpack addWeaponCargoGlobal  [_item2Add, 1];
				};
			};
			_bTotal = _bTotal + (_x select 9);
		} count _buyingArray;
		_backpackName = getText(configFile >> "CfgVehicles" >> typeOf _backpack >> "displayname");
		if (_item2Add != "0") then {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_VEH_IN_BACKPACK",(_buyingArray select 0) select 3,_backpackName];
		} else {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_IN_BACKPACK",_bTotal,_backpackName];
		};
	};

	if (Z_SellingFrom == 1) then { //vehicle
		{
			if (_x select 1 == "trade_weapons") then {
				DZE_myVehicle addWeaponCargoGlobal [_x select 0, _x select 9];
			};
			if (_x select 1 == "trade_items") then {
				DZE_myVehicle addMagazineCargoGlobal [_x select 0, _x select 9];
			};
			if (_x select 1 == "trade_backpacks") then {
				DZE_myVehicle addBackpackCargoGlobal [_x select 0, _x select 9];
			};
			if ((_x select 1) in DZE_tradeVehicle) then {
				_item2Add = [(_x select 0), (_x select 1)] call _buyVehicle;
				if (_item2Add != "0") then {
					DZE_myVehicle addWeaponCargoGlobal [_item2Add, 1];
				};
			};
			_bTotal = _bTotal + (_x select 9);
		} count _buyingArray;
		_vehName = getText(configFile >> "CfgVehicles" >> typeOf DZE_myVehicle >> "displayname");
		if (_item2Add != "0") then {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_VEH_IN_VEHICLE",(_buyingArray select 0) select 3,_vehName];
		} else {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_IN_VEHICLE",_bTotal,_vehName];
		};
	};

	if (Z_SellingFrom == 2) then { //gear
		{
			if (_x select 1 == "trade_weapons") then {
				_count = 0;
				while {_count < (_x select 9)} do {
					_hasPrimary = (primaryWeapon player != "");
					if (_hasPrimary && getNumber (configFile >> "CfgWeapons" >> (_x select 0) >> "type") == 1) then {
						dayz_onBack = _x select 0; //Add to back
					} else {
						player addWeapon (_x select 0);
						call player_selectWeapon;
					};
					_count = _count + 1;
				};
			};
			if (_x select 1 == "trade_items") then {
				_count = 0;
				while { _count < (_x select 9)} do {
					player addMagazine (_x select 0);
					_count = _count + 1;
				};
			};
			if (_x select 1 == "trade_backpacks") then {
				player addBackpack (_x select 0);
			};
			if ((_x select 1) in DZE_tradeVehicle) then {
				_item2Add = [(_x select 0), (_x select 1)] call _buyVehicle;
				if (_item2Add != "0") then {
					player addWeapon _item2Add;					
				};
			};
			_bTotal = _bTotal + (_x select 9);
		} count _buyingArray;
		if (_item2Add != "0") then {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_VEH_IN_GEAR",(_buyingArray select 0) select 3];
		} else {
			systemChat format[localize "STR_EPOCH_TRADE_BUY_IN_GEAR",_bTotal];
		};
	};

	_success = if (Z_SingleCurrency) then {_priceToBuy <= _wealth} else {[player,_priceToBuy,_moneyInfo,false,0] call Z_payDefault};

	if (_success) then {
		if (Z_SingleCurrency) then {
			player setVariable[(["cashMoney","globalMoney"] select Z_persistentMoney),(_wealth - _priceToBuy),true];
			systemChat format[localize "STR_EPOCH_TRADE_SUCCESS_COINS",[_priceToBuy] call BIS_fnc_numberText,CurrencyName];
		} else {
			_tCost = "";
			_tCost = [_priceToBuy,true] call z_calcCurrency;
			if (_tCost != "") then { systemChat format[localize "STR_EPOCH_TRADE_BUY_SUCCESS",_tCost]; };
		};
	} else {
		systemChat localize "STR_EPOCH_TRADE_DEBUG";
	};

	_itemsToLog call Z_logTrade;
	call player_forceSave;
	if (Z_SellingFrom == 1) then {
		PVDZ_veh_Save = [DZE_myVehicle,"gear"];
		publicVariableServer "PVDZ_veh_Save";
	};

} else {
	if (Z_SingleCurrency) then {
		systemChat format[localize "STR_EPOCH_TRADE_NEED_COINS",[_priceToBuy] call BIS_fnc_numberText,CurrencyName];
	} else {
		systemChat localize "STR_EPOCH_TRADE_NEED_MONEY";
	};
};
