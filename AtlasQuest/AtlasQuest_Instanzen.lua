function AtlasQuest_Instanzenchecken()
        AQATLASMAP = AtlasMap:GetTexture()
        ----Instanzen-------
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\TheDeadmines") then
           AQINSTANZ = 1;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\WailingCaverns") then
           AQINSTANZ = 2;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\RagefireChasm") then
           AQINSTANZ = 3;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Uldaman") then
           AQINSTANZ = 4;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\BlackrockDepths") then
           AQINSTANZ = 5;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\BlackwingLair") then
           AQINSTANZ = 6;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\BlackfathomDeeps") then
           AQINSTANZ = 7;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\BlackrockSpireLower") then
           AQINSTANZ = 8;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\BlackrockSpireUpper") then
           AQINSTANZ = 9;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\DireMaulEast") then
           AQINSTANZ = 10;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\DireMaulNorth") then
           AQINSTANZ = 11;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\DireMaulWest") then
           AQINSTANZ = 12;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Maraudon") then
           AQINSTANZ = 13;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\MoltenCore") then
           AQINSTANZ = 14;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Naxxramas") then
           AQINSTANZ = 15;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\OnyxiasLair") then
           AQINSTANZ = 16;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\RazorfenDowns") then
           AQINSTANZ = 17;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\RazorfenKraul") then
           AQINSTANZ = 18;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\ScarletMonastery") then
           AQINSTANZ = 19;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Scholomance") then
           AQINSTANZ = 20;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\ShadowfangKeep") then
           AQINSTANZ = 21;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Stratholme") then
           AQINSTANZ = 22;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\TheRuinsofAhnQiraj") then
           AQINSTANZ = 23;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\TheStockade") then
           AQINSTANZ = 24;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\TheSunkenTemple") then
           AQINSTANZ = 25;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\TheTempleofAhnQiraj") then
           AQINSTANZ = 26;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\ZulFarrak") then
           AQINSTANZ = 27;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\ZulGurub") then
           AQINSTANZ = 28;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Gnomeregan") then
           AQINSTANZ = 29;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\FourDragons") then
           AQINSTANZ = 30;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Azuregos") then
           AQINSTANZ = 31;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\Kazzak") then
           AQINSTANZ = 32;
        end
------------- PVP------------------------------------------------------------------------------------------
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\AlteracValleyNorth") then
           AQINSTANZ = 33;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\AlteracValleySouth") then
           AQINSTANZ = 33;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\ArathiBasin") then
           AQINSTANZ = 34;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\WarsongGulch") then
           AQINSTANZ = 35;
        end
------------- REST------------------------------------------------------------------------------------------
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\DLEast") then
           AQINSTANZ = 36;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\DLWest") then
           AQINSTANZ = 36;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\FPAllianceEast") then
           AQINSTANZ = 36;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\FPAllianceWest") then
           AQINSTANZ = 36;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\FPHordeEast") then
           AQINSTANZ = 36;
        end
        if (AQATLASMAP == "Interface\\AddOns\\Atlas\\Images\\FPHordeWest") then
           AQINSTANZ = 36;
        end
end

--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL
-- 18 = KRAL
-- 19 = KLOSTER
-- 20 = SCHOLO
