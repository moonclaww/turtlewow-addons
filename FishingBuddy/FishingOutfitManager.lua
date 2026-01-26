-- Manage outfits, whether they're from OutfitDisplayFrame or something else
FishingBuddy.OutfitManager = {};

-- Inferred from Draznar's Fishing FAQ
local Accessories = {
   [19979] = { ["n"] = "钓鱼大师鱼钩", ["score"] = 5, },
   [19947] = { ["n"] = "纳特·帕格的卷尺", ["score"] = 4, },
   [19972] = { ["n"] = "幸运渔帽", ["score"] = 5, },
   [7996] = { ["n"] = "幸运渔帽", ["score"] = 5, },
   [8749] = { ["n"] = "钩织帽子", ["score"] = 3, },
   [19039] = { ["n"] = "索尔宾的防水帽", ["score"] = 3, },
   [3889] = { ["n"] = "赤色软帽", ["score"] = 3, },
   [14584] = { ["n"] = "妖鬼软帽", ["score"] = 2, },
   [4048] = { ["n"] = "纹饰帽", ["score"] = 1, },
   [10250] = { ["n"] = "Masters Hat", ["score"] = 1, },
   [9508] = { ["n"] = "机械师罩衫", ["score"] = 3, },
   [6263] = { ["n"] = "蓝色罩衫", ["score"] = 4, },
   [3342] = { ["n"] = "杉德尔船长的衬衣", ["score"] = 4, },
   [5107] = { ["n"] = "水手衬衣", ["score"] = 2, },
   [6795] = { ["n"] = "白色冒险者衬衣", ["score"] = 1, },
   [2576] = { ["n"] = "白色亚麻衬衣", ["score"] = 1, },
   [6202] = { ["n"] = "露指手套", ["score"] = 3, },
   [792] = { ["n"] = "针织便鞋", ["score"] = 4, },
   [1560] = { ["n"] = "蓝腮便鞋", ["score"] = 4, },
   [13402] = { ["n"] = "提米的靴子", ["score"] = 2, },
   [10658] = { ["n"] = "泥潭沼泽长靴", ["score"] = 2, },
   [1678] = { ["n"] = "黑色食人魔之靴", ["score"] = 1, },
   [19969] = { ["n"] = "纳特·帕格的超级钓鱼靴", ["score"] = 5, },
   [15405] = { ["n"] = "剥壳手套", ["score"] = 5, },
   [15406] = { ["n"] = "甲壳长靴", ["score"] = 3, },
   [3287] = { ["n"] = "部落短裤", ["score"] = 2, },
   [5310] = { ["n"] = "水手裤", ["score"] = 4, },
}

FishingBuddy.Commands[FishingBuddy.SWITCH] = {};
FishingBuddy.Commands[FishingBuddy.SWITCH].func = function()
					FishingBuddy.OutfitManager.Switch();
					return true;
				     end;

local OutfitManagers = {};
local OutfitManagerCount = 0;
FishingBuddy.OutfitManager.RegisterManager = function(name, init, choose, switch)
   if ( not OutfitManagers[name] ) then
      OutfitManagers[name] = {};
      OutfitManagerCount = OutfitManagerCount + 1;
   end
   OutfitManagers[name].Initialize = init;
   OutfitManagers[name].Choose = choose;
   OutfitManagers[name].Switch = switch;
end

FishingBuddy.OutfitManager.ItemStylePoints = function(itemno, enchant)
   local points = 0;
   if ( itemno ) then
      itemono = tonumber(itemno);
      enchant = tonumber(enchant);
      if (Accessories[itemno]) then
	 points = points + Accessories[itemno].score;
      end
      if ( enchant == 846 ) then
         -- bonus for being enchanted with Fishing +2
         points = points + 2;
      end
   end
   return points;
end

local PoleCheck = nil;

-- update the watcher when we're done switching outfits
FishingBuddy.OutfitManager.WaitForUpdate =
   function(arg1)
      local hasPole = FishingBuddy.API.IsFishingPole();
      if ( hasPole == PoleCheck ) then
	 FishingOutfitUpdateFrame:Hide();
	 FishingBuddy.API.FishingMode();
      end
   end

local function CheckSwitch(topole)
   PoleCheck = topole;
   FishingOutfitUpdateFrame:Show();
end
FishingBuddy.OutfitManager.CheckSwitch = CheckSwitch;

local function HasManager()
   return (OutfitManagerCount > 0);
end
FishingBuddy.OutfitManager.HasManager = HasManager;

FishingBuddy.OutfitManager.Switch = function(outfitname)
   if ( HasManager() ) then
      local outfitter = FishingBuddy.GetSetting("OutfitManager");
      if ( outfitter and OutfitManagers[outfitter] ) then
         local wasPole = OutfitManagers[outfitter].Switch(outfitname);
         CheckSwitch(not wasPole);
      end
   else
      FishingBuddy.UIError(FishingBuddy.COMPATIBLE_SWITCHER);
   end
   -- if we're now sporting a fishing pole, let's go fishing
   FishingBuddy.API.FishingMode();
end

local current_manager;

local function OutfitManagerMenuSetup()
   for manager,_ in OutfitManagers do
      local mgr = manager;
      local info = {};
      info.text = manager;
      info.func = function() FishingBuddy.OutfitManager.ChooseManager(mgr); end;
      info.checked = ( current_manager == manager )
      UIDropDownMenu_AddButton(info);
   end
end

local function SetOutfitManagerDisplay()
   if ( OutfitManagerCount == 0 ) then
      FishingBuddyOption_OutfitMenu:Hide();
      FishingBuddyOption_OutfitText:SetText(FishingBuddy.OUTFITS_TAB..": |c"..FishingBuddy.Colors.RED..FishingBuddy.NONEAVAILABLE_MSG.."|r");
   elseif ( OutfitManagerCount == 1 ) then
      FishingBuddyOption_OutfitMenu:Hide();
      FishingBuddyOption_OutfitText:SetText(FishingBuddy.OUTFITS_TAB..": |c"..FishingBuddy.Colors.GREEN..current_manager.."|r");
   else
      FishingBuddyOption_OutfitText:Hide();
      UIDropDownMenu_Initialize(FishingBuddyOption_OutfitMenu,
				OutfitManagerMenuSetup);
      local show = 1;
      for name,_ in OutfitManagers do
	 if ( name == current_manager ) then
	    break;
	 end
	 show = show + 1;
      end
      local label = getglobal("FishingBuddyOption_OutfitMenuLabel");
      label:SetText(FishingBuddy.OUTFITS_TAB..": ");
      local menu = FishingBuddyOption_OutfitMenu;
      UIDropDownMenu_SetWidth(210, menu);
      UIDropDownMenu_SetSelectedValue(menu, show);
      UIDropDownMenu_SetText(current_manager, menu);
   end
end

local function ChooseManager(manager)
   if ( manager and OutfitManagers[manager] ) then
      current_manager = manager;
      if ( not OutfitManagers[manager].initialized ) then
         OutfitManagers[manager].Initialize();
         OutfitManagers[manager].initialized = 1;
      end
      for om,info in OutfitManagers do
	 info.Choose(om == manager);
      end
      SetOutfitManagerDisplay();
      return true;
   end
end
FishingBuddy.OutfitManager.ChooseManager = ChooseManager;

FishingBuddy.OutfitManager.Initialize = function()
   -- no outfit managers, no outfit switching
   if ( not HasManager() ) then
      FishingBuddy.SetSetting("InfoBarClickToSwitch", 0);
      FishingBuddy.SetSetting("TitanClickToSwitch", 0);
      FishingBuddy.SetSetting("MinimapClickToSwitch", 0);
   else
      if ( OutfitManagerCount == 1 ) then
	 -- we pretty much have to use this one
	 current_manager = next(OutfitManagers);
      else
	 current_manager = FishingBuddy.GetSetting("OutfitManager");
	 if ( not manager or not OutfitManagers[manager] ) then
	    -- no valid ones, use the first one
	    current_manager = next(OutfitManagers);
	 end
      end
      ChooseManager(current_manager);
      -- in case we changed things (do we want/need to do this?)
      -- FishingBuddy.SetSetting("OutfitManager", current_manager);
   end
   SetOutfitManagerDisplay();
end
