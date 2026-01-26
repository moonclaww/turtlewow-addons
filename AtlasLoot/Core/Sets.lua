function AtlasLoot_SetMenu(setname)
    if(setname=="AQ40SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ40Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ40Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ40Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ40Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ40Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ40Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ40Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ40Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ40Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ40SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ40_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="AQ20SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="AQ20Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="AQ20Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="AQ20Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="AQ20Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="AQ20Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="AQ20Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="AQ20Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="AQ20Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="AQ20Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="AQ20SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_AQ20_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="ZGSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="ZGDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="ZGHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="ZGMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="ZGPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="ZGPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="ZGRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="ZGShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="ZGWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="ZGWarrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="ZGSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_ZG_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T3SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T3Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T3Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T3Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T3Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T3Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T3Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T3Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T3Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T3Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T3SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER3_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T2SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T2Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T2Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T2Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T2Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T2Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T2Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T2Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T2Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T2Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T2SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER2_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T1SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T1Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T1Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T1Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T1Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T1Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T1Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T1Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T1Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T1Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T1SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER1_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="T0SET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="T0Druid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="T0Hunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="T0Mage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="T0Paladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="T0Priest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="T0Rogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="T0Shaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="T0Warlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="T0Warrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="T0SET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_TIER0_SETS);
        AtlasLootItemsFrame:Show();
    elseif(setname=="PVPSET") then
        getglobal("AtlasLootItemsFrame_Druid"):Show();
        getglobal("AtlasLootItemsFrame_Druid").lootpage="PVPDruid";
        getglobal("AtlasLootItemsFrame_Hunter"):Show();
        getglobal("AtlasLootItemsFrame_Hunter").lootpage="PVPHunter";
        getglobal("AtlasLootItemsFrame_Mage"):Show();
        getglobal("AtlasLootItemsFrame_Mage").lootpage="PVPMage";
        getglobal("AtlasLootItemsFrame_Paladin"):Show();
        getglobal("AtlasLootItemsFrame_Paladin").lootpage="PVPPaladin";
        getglobal("AtlasLootItemsFrame_Priest"):Show();
        getglobal("AtlasLootItemsFrame_Priest").lootpage="PVPPriest";
        getglobal("AtlasLootItemsFrame_Rogue"):Show();
        getglobal("AtlasLootItemsFrame_Rogue").lootpage="PVPRogue";
        getglobal("AtlasLootItemsFrame_Shaman"):Show();
        getglobal("AtlasLootItemsFrame_Shaman").lootpage="PVPShaman";
        getglobal("AtlasLootItemsFrame_Warlock"):Show();
        getglobal("AtlasLootItemsFrame_Warlock").lootpage="PVPWarlock";
        getglobal("AtlasLootItemsFrame_Warrior"):Show();
        getglobal("AtlasLootItemsFrame_Warrior").lootpage="PVPWarrior";
        getglobal("AtlasLootItemsFrame_Weapons"):Show();
        getglobal("AtlasLootItemsFrame_Weapons").lootpage="PVPWeapons1";
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        getglobal("AtlasLootItemsFrame_BACK"):Hide();
        getglobal("AtlasLootItemsFrame_BACK").setname="PVPSET";
        AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PVP_SET_PIECES_HEADER);
        AtlasLootItemsFrame:Show();
    end
    for i=1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
end

--------------------------------------------------------------------------------
-- Deal with items sets
--------------------------------------------------------------------------------
function AtlasLoot_Set(setname)
    if(setname~=nil) then
        AtlasLoot_SetMenu(setname);
    elseif(this:GetName()=="AtlasLootItemsFrame_BACK") then
        AtlasLoot_SetMenu(this.setname);
    elseif((this:GetName()=="AtlasLootItemsFrame_Weapons" and AtlasLoot_BossName:GetText()=="|cffFFFFFF"..ATLASLOOT_PVP_SET_PIECES_HEADER) or (this:GetName()=="AtlasLootItemsFrame_PREV" and AtlasLoot_BossName:GetText()==getglobal("AtlasLootItemsFrame_Weapons"):GetText())) then
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, getglobal("AtlasLootItemsFrame_Weapons"):GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="PVPWeapons2";
    elseif(this:GetName()=="AtlasLootItemsFrame_NEXT" and AtlasLoot_BossName:GetText()==getglobal("AtlasLootItemsFrame_Weapons"):GetText()) then
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, getglobal("AtlasLootItemsFrame_Weapons"):GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
        getglobal("AtlasLootItemsFrame_PREV"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="PVPWeapons1";
    elseif(this:GetName()=="AtlasLootItemsFrame_NEXT" or this:GetName()=="AtlasLootItemsFrame_PREV") then
        AtlasLoot_Rep(this.lootpage, AtlasLoot_BossName:GetText());
    else
        getglobal("AtlasLootItemsFrame_Druid"):Hide();
        getglobal("AtlasLootItemsFrame_Hunter"):Hide();
        getglobal("AtlasLootItemsFrame_Mage"):Hide();
        getglobal("AtlasLootItemsFrame_Paladin"):Hide();
        getglobal("AtlasLootItemsFrame_Priest"):Hide();
        getglobal("AtlasLootItemsFrame_Rogue"):Hide();
        getglobal("AtlasLootItemsFrame_Shaman"):Hide();
        getglobal("AtlasLootItemsFrame_Warlock"):Hide();
        getglobal("AtlasLootItemsFrame_Warrior"):Hide();
        getglobal("AtlasLootItemsFrame_Weapons"):Hide();
        getglobal("AtlasLootItemsFrame_NEXT"):Hide();
        getglobal("AtlasLootItemsFrame_PREV"):Hide();
        AtlasLoot_ShowItemsFrame(this.lootpage, AtlasLootSetItems, this:GetText(), AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_BACK"):Show();
    end
end

function AtlasLootSetButton_OnClick(setid)
    getglobal("AtlasLoot_Tier0Button"):Hide();
    getglobal("AtlasLoot_Tier1Button"):Hide();
    getglobal("AtlasLoot_Tier2Button"):Hide();
    getglobal("AtlasLoot_Tier3Button"):Hide();
    getglobal("AtlasLoot_ZGButton"):Hide();
    getglobal("AtlasLoot_AQ20Button"):Hide();
    getglobal("AtlasLoot_AQ40Button"):Hide();
    getglobal("AtlasLoot_PVPButton"):Hide();
    getglobal("AtlasLoot_LegendButton"):Hide();
    if (setid=="Legendaries") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootSetItems, ATLASLOOT_LEGENDARIES, AtlasLoot_AnchorFrame);
    else
        AtlasLoot_ShowItemsFrame(setid, AtlasLootSetItems, "Sets", AtlasLoot_AnchorFrame);
    end
end

function AtlasLootRepButton_OnClick(setid, text)
    getglobal("AtlasLoot_DarkmoonButton"):Hide();
    getglobal("AtlasLoot_TimbermawButton"):Hide();
    getglobal("AtlasLoot_ThoriumButton"):Hide();
    getglobal("AtlasLoot_ArgentButton"):Hide();
    getglobal("AtlasLoot_CenarionButton"):Hide();
    getglobal("AtlasLoot_BroodButton"):Hide();
    getglobal("AtlasLoot_ZandalarButton"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    if (setid=="Darkmoon" or setid=="Timbermaw") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, text, AtlasLoot_AnchorFrame);
    elseif (setid=="AQBroodRings") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootItems, ATLASLOOT_FACTION_BROOD, AtlasLoot_AnchorFrame);
    else
        AtlasLoot_Rep(setid, text);
    end
end

function AtlasLoot_Rep(setid, text)
    getglobal("AtlasLoot_DarkmoonButton"):Hide();
    getglobal("AtlasLoot_TimbermawButton"):Hide();
    getglobal("AtlasLoot_ThoriumButton"):Hide();
    getglobal("AtlasLoot_ArgentButton"):Hide();
    getglobal("AtlasLoot_CenarionButton"):Hide();
    getglobal("AtlasLoot_BroodButton"):Hide();
    getglobal("AtlasLoot_ZandalarButton"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    if(setid=="Thorium1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Thorium2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Thorium3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Thorium4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Thorium4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_THORIUM..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Thorium3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Cenarion2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Cenarion4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Cenarion4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_CENARION..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Cenarion3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Argent1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_FACTION_ARGENT_TOKEN, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Argent2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Argent2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_FRIENDLY.."/"..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Argent3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Argent1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Argent3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ARGENT..": "..ATLASLOOT_REVERED.."/"..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Argent2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar1") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_FRIENDLY, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar2";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
    elseif(setid=="Zandalar2") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_HONORED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar3";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar1";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar3") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_REVERED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_NEXT").lootpage="Zandalar4";
        getglobal("AtlasLootItemsFrame_NEXT"):Show();
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar2";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    elseif(setid=="Zandalar4") then
        AtlasLoot_ShowItemsFrame(setid, AtlasLootRepItems, ATLASLOOT_FACTION_ZANDALAR..": "..ATLASLOOT_EXALTED, AtlasLoot_AnchorFrame);
        getglobal("AtlasLootItemsFrame_PREV").lootpage="Zandalar3";
        getglobal("AtlasLootItemsFrame_PREV"):Show();
    end
end

function AtlasLootSetMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_Weapons"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    getglobal("AtlasLoot_Tier0Button"):Show();
    getglobal("AtlasLoot_Tier1Button"):Show();
    getglobal("AtlasLoot_Tier2Button"):Show();
    getglobal("AtlasLoot_Tier3Button"):Show();
    getglobal("AtlasLoot_ZGButton"):Show();
    getglobal("AtlasLoot_AQ20Button"):Show();
    getglobal("AtlasLoot_AQ40Button"):Show();
    getglobal("AtlasLoot_PVPButton"):Show();
    getglobal("AtlasLoot_LegendButton"):Show();
    getglobal("AtlasLoot_DarkmoonButton"):Hide();
    getglobal("AtlasLoot_TimbermawButton"):Hide();
    getglobal("AtlasLoot_ThoriumButton"):Hide();
    getglobal("AtlasLoot_ArgentButton"):Hide();
    getglobal("AtlasLoot_CenarionButton"):Hide();
    getglobal("AtlasLoot_BroodButton"):Hide();
    getglobal("AtlasLoot_ZandalarButton"):Hide();
    AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PANEL_BUTTON_SETS);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end

function AtlasLootRepMenu()
    for i = 1, 30, 1 do
        getglobal("AtlasLootItem_"..i):Hide();
    end
    getglobal("AtlasLootItemsFrame_BACK"):Hide();
    getglobal("AtlasLootItemsFrame_Druid"):Hide();
    getglobal("AtlasLootItemsFrame_Hunter"):Hide();
    getglobal("AtlasLootItemsFrame_Mage"):Hide();
    getglobal("AtlasLootItemsFrame_Paladin"):Hide();
    getglobal("AtlasLootItemsFrame_Priest"):Hide();
    getglobal("AtlasLootItemsFrame_Rogue"):Hide();
    getglobal("AtlasLootItemsFrame_Shaman"):Hide();
    getglobal("AtlasLootItemsFrame_Warlock"):Hide();
    getglobal("AtlasLootItemsFrame_Warrior"):Hide();
    getglobal("AtlasLootItemsFrame_Weapons"):Hide();
    getglobal("AtlasLootItemsFrame_NEXT"):Hide();
    getglobal("AtlasLootItemsFrame_PREV"):Hide();
    getglobal("AtlasLoot_Tier0Button"):Hide();
    getglobal("AtlasLoot_Tier1Button"):Hide();
    getglobal("AtlasLoot_Tier2Button"):Hide();
    getglobal("AtlasLoot_Tier3Button"):Hide();
    getglobal("AtlasLoot_ZGButton"):Hide();
    getglobal("AtlasLoot_AQ20Button"):Hide();
    getglobal("AtlasLoot_AQ40Button"):Hide();
    getglobal("AtlasLoot_PVPButton"):Hide();
    getglobal("AtlasLoot_LegendButton"):Hide();
    getglobal("AtlasLoot_DarkmoonButton"):Show();
    getglobal("AtlasLoot_TimbermawButton"):Show();
    getglobal("AtlasLoot_ThoriumButton"):Show();
    getglobal("AtlasLoot_ArgentButton"):Show();
    getglobal("AtlasLoot_CenarionButton"):Show();
    getglobal("AtlasLoot_BroodButton"):Show();
    getglobal("AtlasLoot_ZandalarButton"):Show();
    AtlasLoot_BossName:SetText("|cffFFFFFF"..ATLASLOOT_PANEL_BUTTON_REPUTATION);
    AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorFrame);
end
