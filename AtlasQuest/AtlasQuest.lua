-- This is AtlasQuest v 3.14.28! enjoy ;)

--Vesiontext festlegen (als variable)
local VERSION_CORE = "|cffff00003";
local VERSION_INSTANZEN = "14";
local VERSION_REST = "28|r"
ATLASQUEST_VERSION = "|cff1eff00AtlasQuest Version: |r"..VERSION_CORE.."."..VERSION_INSTANZEN.."."..VERSION_REST.."";


-- Farben
local PURPLE = "|cff999999"; -- grey atm -- removed
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local GREY = "|cff9F3FFF"; --purple now ^^
local BLUE = "|cff0070dd";
local ORANGE = "|cffff6090"; -- it is rosa now
local YELLOW = "|cffffff00";
local BLACK = "|c0000000f";
local DARKGREEN = "|cff008000";
local BLUB = "|cffd45e19";

-- Quest Color
local Grau = "|cff9d9d9d"
local Gruen = "|cff1eff00"
local Orange = "|cffFF8000"
local Rot = "|cffFF0000"
local Gelb = "|cffFFd200"
local Blau = "|cff0070dd"

--Variablen -> need explaination / register TO DO!
Allianceorhorde = 1; --variable um festzulegen ob horde oder allianz angezeigt wird

local EnglishFraction = ""; --nötig um festzustellen welcher fraktion man angehört

local LocalizedFraction = ""; -- nötig um festzustellen welcher fraktion man angehört

AQINSTANZ = ""; -- momentan angezeigtes Instanzbild (siehe AtlasQuest_Instanzen.lua)

AQINSTATM = ""; -- variable um zu sehn ob sich AQINSTANZ verändert hat (siehe function AtlasQuestSetTextandButtons())
-------------------------------------------------------------------------
---------------------------------- FUNKTIONEN ---------------------------
-------------------------------------------------------------------------

------------------/////Events: Onload//////

--------------------------------
-- Call OnLoad set Variables and hides the panel
--------------------------------
function AQ_OnLoad()
    AQFraktionCheck();
    AQSetButtontext();
    AQTEXTonload();
    AtlasQuestUeberschrift:SetText(ATLASQUEST_VERSION)
    AQATLASMAP = AtlasMap:GetTexture()
    this:RegisterForDrag("LeftButton");
    AQSlashCommandfunction();
	--ersmal nicht anzeigen
    HideUIPanel(AtlasQuestFrame);
    HideUIPanel(AtlasQuestInsideFrame);
    AQAtlasVersionCheck();
end

--------------------------------
-- Slahs command added
------------------------------
function AQSlashCommandfunction()
    SlashCmdList["ATLASQ"]=atlasquest_command;
	SLASH_ATLASQ1="/aq";
	SLASH_ATLASQ2="/atlasquest";
end

-------------------------------
-- Atlas Version Check (deaktiviert)
-------------------------------
function AQAtlasVersionCheck()
   -- if (ATLAS_VERSION == "1.8") then
   --     --do nothing
   --   else
   --       ChatFrame1:AddMessage(ATLAS_VERSIONWARNINGTEXT);
   -- end -- momentan nutzlos und fehleranfällig vll spätere wieder einführung
end

------------------------------
-- check the fraction and set the check button
-------------------------------
function AQFraktionCheck()
    EnglishFraction, LocalizedFraction = UnitFactionGroup("player");
    if ( EnglishFraction == "Horde") then
       Allianceorhorde = 2;
       AQHCB:SetChecked(true);
       AQACB:SetChecked(false);
    end
end

---------------------------------
-- set the button text
---------------------------------
function AQSetButtontext()
      STORYbutton:SetText(AQStoryB);
      OPTIONbutton:SetText(AQOptionB);
end

---------------------------------
-- show the loaded text
---------------------------------
function AQTEXTonload()
    ChatFrame1:AddMessage(ATLASQUEST_VERSION..GREY.." = loaded, by ASURN");
    ChatFrame1:AddMessage(GREY.."type /aq or /atlasquest to show/hide the panel and show the version number");
end

---------------------------------
--  Slashcommand!! show/hide panel + Version Message
---------------------------------
function atlasquest_command(param)
  if (param == "help") then
    ChatFrame1:AddMessage(RED.."Help text will be here soon");
  end
  ChatFrame1:AddMessage(ATLASQUEST_VERSION);
  ChatFrame1:AddMessage("Atlasversion: "..ATLAS_VERSION);
end

---------------------------------
--  testmessages -> atm nothing
---------------------------------
function AQTestmessages()
end

------------------ Events: Onload -> end

------------------////// Events: OnUpdate//////
function AQ_OnUpdate(arg1)
        AQ_SetCaption()
        AtlasQuest_Instanzenchecken(); ------------------------ SEE AtlasQuest_Instanzen.lua
        -- Remove panel if no quest and show again if needed
       if ( AQINSTANZ == 36) then
           HideUIPanel(AtlasQuestFrame);
           HideUIPanel(AtlasQuestInsideFrame);
       end
       AtlasQuestSetTextandButtons();
end

---------------------------------
--  Set the ZoneName (taken from atlas.lua a bit changed)
---------------------------------
function AQ_SetCaption()
    local textSource;
    if ( AtlasOptions.AtlasType == 1 ) then
		zoneID = ATLAS_DROPDOWN_LIST[AtlasOptions.AtlasZone];
		textSource = AtlasText;
	elseif ( AtlasOptions.AtlasType == 2 ) then
		zoneID = ATLAS_DROPDOWN_LIST_BG[AtlasOptions.AtlasZone];
		textSource = AtlasBG;
	elseif ( AtlasOptions.AtlasType == 3 ) then
		zoneID = ATLAS_DROPDOWN_LIST_FP[AtlasOptions.AtlasZone];
		textSource = AtlasFP;
	elseif ( AtlasOptions.AtlasType == 4 ) then
		zoneID = ATLAS_DROPDOWN_LIST_DL[AtlasOptions.AtlasZone];
		textSource = AtlasDL;
	elseif ( AtlasOptions.AtlasType == 5 ) then
		zoneID = ATLAS_DROPDOWN_LIST_RE[AtlasOptions.AtlasZone];
		textSource = AtlasRE;
	end
	local ZoneNameText = textSource[zoneID]["ZoneName"];
    Ueberschriftborder:SetText(ZoneNameText);
end

---------------------------------
--  Set the Buttontext and the buttons if availeable
--  and check whether its a other inst or not -> works fine
--  added: Check vor Questline arrows
--  Questline arrows are shown if InstXQuestYFQuest = "true"
--  QuestStart icon are shown if InstXQuestYPreQuest = "true"
---------------------------------
function AtlasQuestSetTextandButtons()
local AQQuestlevelf
local AQQuestfarbe
local AQQuestfarbe2
   if (AQINSTATM ~= AQINSTANZ) then
      HideUIPanel(AtlasQuestInsideFrame);
   end
   for i=1, 36 do
       if (Allianceorhorde == 1 and AQINSTANZ == i) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..i.."QAA") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..i.."QAA"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..i.."Quest"..b.."FQuest")) then
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."PreQuest")) then
                ShowUIPanel(getglobal("AQQuesstart_"..b));
             else
                HideUIPanel(getglobal("AQQuesstart_"..b));
             end
             AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..b.."_Level"));
             if (getglobal("Inst"..i.."Quest"..b) ~= nil) then
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   elseif ( AQQuestlevelf == 100) then
                     AQQuestfarbe = Blau;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..b));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
       if (Allianceorhorde == 2 and AQINSTANZ == i) then
           AQINSTATM = AQINSTANZ;
           if (getglobal("Inst"..i.."QAH") ~= nil) then
               AtlasQuestAnzahl:SetText(getglobal("Inst"..i.."QAH"));
           else
               AtlasQuestAnzahl:SetText("");
           end
           for b=1, 18 do
             if (getglobal("Inst"..i.."Quest"..b.."FQuest_HORDE")) then
                ShowUIPanel(getglobal("AQQuestlineArrow_"..b));
             else
                HideUIPanel(getglobal("AQQuestlineArrow_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."PreQuest_HORDE")) then
                ShowUIPanel(getglobal("AQQuesstart_"..b));
             else
                HideUIPanel(getglobal("AQQuesstart_"..b));
             end
             if (getglobal("Inst"..i.."Quest"..b.."_HORDE") ~= nil) then
                AQQuestlevelf = tonumber(getglobal("Inst"..i.."Quest"..b.."_HORDE_Level"));
                if ( AQQuestlevelf ~= nil or AQQuestlevelf ~= 0 or AQQuestlevelf ~= "") then
                   if ( AQQuestlevelf == UnitLevel("player") or AQQuestlevelf == UnitLevel("player") + 2 or AQQuestlevelf  == UnitLevel("player") - 2 or AQQuestlevelf == UnitLevel("player") + 1 or AQQuestlevelf  == UnitLevel("player") - 1) then
                     AQQuestfarbe = Gelb;
                   elseif ( AQQuestlevelf > UnitLevel("player") + 2 and AQQuestlevelf <= UnitLevel("player") + 4) then
                     AQQuestfarbe = Orange;
                   elseif ( AQQuestlevelf >= UnitLevel("player") + 5 and AQQuestlevelf ~= 100) then
                     AQQuestfarbe = Rot;
                   elseif ( AQQuestlevelf < UnitLevel("player") - 7) then
                     AQQuestfarbe = Grau;
                   elseif ( AQQuestlevelf >= UnitLevel("player") - 7 and AQQuestlevelf < UnitLevel("player") - 2) then
                     AQQuestfarbe = Gruen;
                   elseif ( AQQuestlevelf == 100) then
                     AQQuestfarbe = Blau;
                   end
                end
                getglobal("AQQuestbutton"..b):Enable();
                getglobal("AQBUTTONTEXT"..b):SetText(AQQuestfarbe..getglobal("Inst"..i.."Quest"..b.."_HORDE"));
             else
                getglobal("AQQuestbutton"..b):Disable();
                getglobal("AQBUTTONTEXT"..b):SetText();
             end
           end
       end
-------Special case: ZG
       if (AQINSTANZ == 28) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst28Caption1);
       end
-------Special case: BWl
       if (AQINSTANZ == 6) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst6Caption1);
         AQQuestbutton2:Enable();
         AQBUTTONTEXT2:SetText(AQQuestfarbe2..Inst6Caption2);
       end
-------Special case: DRAGONS
       if (AQINSTANZ == 30) then
         AQQuestfarbe2 = Blau;
         AQQuestbutton1:Enable();
         AQBUTTONTEXT1:SetText(AQQuestfarbe2..Inst30Caption1);
         AQQuestbutton2:Enable();
         AQBUTTONTEXT2:SetText(AQQuestfarbe2..Inst30Caption2);
         AQQuestbutton3:Enable();
         AQBUTTONTEXT3:SetText(AQQuestfarbe2..Inst30Caption3);
         AQQuestbutton4:Enable();
         AQBUTTONTEXT4:SetText(AQQuestfarbe2..Inst30Caption4);
       end
   end
end


------------------ Events: OnUpdate -> End

------------------ /////Events: Atlas_OnShow //////

---------------------------------
-- Shows the AQ panel with atlas (option adden!)
---------------------------------
function Atlas_OnShow()
    ShowUIPanel(AtlasQuestFrame);
    HideUIPanel(AtlasQuestInsideFrame);
end

------------------ Events: Atlas_OnShow -> End

------------------//// OnEnter/OnLeave ITEM ANZEIGEN ///////

---------------------------------
-- hide tooltip
---------------------------------
function AtlasQuestItem_OnLeave()
        if(GameTooltip:IsVisible()) then
            GameTooltip:Hide();
        end
        if(AtlasQuestTooltip:IsVisible()) then
            AtlasQuestTooltip:Hide();
        end
end

---------------------------------
-- show tooltip
-- update: function added to check whether there is a ID or not
-- update perhaps useless if hide function works -> but will stay
---------------------------------
function AtlasQuestItem_OnEnter()
        for i=1, 36 do
           if ( Allianceorhorde == 1) then
              if (AQINSTANZ == i) then
               if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                 SHOWNID = getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN);
                 if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN) ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                         AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN)..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
              end
           else
              if (AQINSTANZ == i) then
               if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                 SHOWNID = getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE");
                 if (getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE") ~= nil) then
                  if(GetItemInfo(getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")) ~= nil) then
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                         AtlasQuestTooltip:SetHyperlink("item:"..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ID"..AQTHISISSHOWN.."_HORDE")..":0:0:0");
                        AtlasQuestTooltip:Show();
                  else
                        AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                        AtlasQuestTooltip:ClearLines();
                        AtlasQuestTooltip:AddLine(RED..AQERRORNOTSHOWN);
                        AtlasQuestTooltip:AddLine(AQERRORASKSERVER);
                        AtlasQuestTooltip:Show();
                  end
                 end
               end
              end
           end
        end
end

---------------------------------
-- ask Server right-click
---------------------------------
function AtlasQuestItem_OnClick(arg1)
        if(arg1=="RightButton") then
          for i=1, 36 do
              if ( Allianceorhorde == 1) then
                if (AQINSTANZ == i) then
                   AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();                    DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN)..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN)..WHITE..AQSERVERASKInformation);
                end
              else
                if (AQINSTANZ == i) then
                   AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24);
                   AtlasQuestTooltip:SetHyperlink("item:"..SHOWNID..":0:0:0");
                   AtlasQuestTooltip:Show();                    DEFAULT_CHAT_FRAME:AddMessage(AQSERVERASK..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."ITC"..AQTHISISSHOWN.."_HORDE")..getglobal("Inst"..i.."Quest"..AQSHOWNQUEST.."name"..AQTHISISSHOWN.."_HORDE")..WHITE..AQSERVERASKInformation);
                end
               end
          end
        end
end

------------------ OnEnter/OnLeave ITEM ANZEIGEN -> END

-------------------------------------------------------------------------------------------------------------------

--|cffff0000 - Spieler 1 (Rot)
--|cff0000ff - Spieler 2 (Blau)
--|cff00ffff - Spieler 3 (Blaugrau)
--|cff6f2583 - Spieler 4 (Lila)
--|cffffff00 - Spieler 5 (Gelb)
--|cffd45e19 - Spieler 6 (Orange)
--|cff00ff00 - Spieler 7 (Grün)
--|cffff8080 - Spieler 8 (Rosa)
--|cff808080 - Spieler 9 (Grau)
--|cff8080ff - Spieler 10 (Hellblau)
--|cff008000 - Spieler 11 (Dunkelgrün)
--|cff4d2903 - Spieler 12 (Braun)




--Chatframe1:AddMessage("text") fügt eine nachricht ins allgemeine chatfenster ein
--message("Text") gibt eine fehelrmeldung mit dem text wieder