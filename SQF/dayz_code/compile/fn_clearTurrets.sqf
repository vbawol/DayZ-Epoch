//By denvdmj (probably, I found it on the biki)

local _obj = _this;

local _weaponArray = [];
_weaponArray set [count _weaponArray,[-1]];

local _findRecurse = {
	local _root = (_this select 0);
	local _path = +(_this select 1);
	local _thisThis = _this select 2;
	
	for "_i" from 0 to count _root -1 do {
	   local _class = _root select _i;
	   
	   if (isClass _class) then {
		  local _currentPath = _path + [_i];
		  {_weaponArray set [count _weaponArray, _currentPath];} count getArray (_class >> "weapons");
		  _class = _class >> "turrets";
		  if (isClass _class) then {[_class, _currentPath, _thisThis] call _findRecurse;};
	   };
	};
};

[configFile >> "CfgVehicles" >> typeOf (_obj) >> "turrets", [], _obj] call _findRecurse;

{
	local _turret = _x;
	local _mags = _obj magazinesTurret _turret;
	
	{
		local _mag = _x;
		if !(["Horn",_mag] call fnc_inString) then {
			if (DZE_clearVehicleFlares) then {
				_obj removeMagazinesTurret[_mag,_turret];
			} else {
				if !(["flare",_mag] call fnc_inString) then {
					_obj removeMagazinesTurret[_mag,_turret];
				};
			};			
		};	
	} count _mags;
} forEach _weaponArray;