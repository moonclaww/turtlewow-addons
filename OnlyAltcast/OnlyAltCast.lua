
function AltCast_OnLoad()
	-- Hook UseAction
	lOriginal_UseAction = UseAction;
	UseAction = AltCast_UseAction;
	
end

function AltCast_UseAction(id, type, self)
	local cleart=nil;

	if(IsAltKeyDown()) then
		if(UnitExists("target") and UnitIsFriend("player", "target")) then
			ClearTarget();
			cleart=true;
		end
		self = 1;
	end
	
	lOriginal_UseAction(id, type, self);

	if(SpellIsTargeting() and IsAltKeyDown()) then
		SpellTargetUnit("player");
	end

	if(cleart) then
		TargetLastTarget();
	end
end	