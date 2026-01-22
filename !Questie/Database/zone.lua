-- mapID, BCContinent, BCZone, VanillaC, VanillaZ, TurtleC, TurtleZ
-- TurtleWoW zone numbers verified from in-game GetMapZones() output
QuestieZones = {
    ["WorldMap"] = {1337, 1337, 0, 0, 0, 0, 0},
    ["Azeroth"] = {-1, -1, -1, 2, 0, 2, 0},
    ["Kalimdor"] = {-1, -1, -1, 1, 0, 1, 0},
    
    -- ==================== KALIMDOR (Continent 1) - 31 zones ====================
    -- Zone 1: GM岛 (GM Island) - TurtleWoW custom
    ["GMIsland"] = {-1, 1, -1, 1, -1, 1, 1},
    -- Zone 2: 冬泉谷 (Winterspring)
    ["Winterspring"] = {19, 1, 24, 1, 21, 1, 2},
    -- Zone 3: 冰点岩 - TurtleWoW custom
    ["Frostpoint"] = {-1, 1, -1, 1, -1, 1, 3},
    -- Zone 4: 凄凉之地 (Desolace)
    ["Desolace"] = {4, 1, 7, 1, 5, 1, 4},
    -- Zone 5: 千针石林 (Thousand Needles)
    ["ThousandNeedles"] = {14, 1, 21, 1, 18, 1, 5},
    -- Zone 6: 厄运之槌 (Dire Maul) - dungeon
    ["DireMaul"] = {-1, 1, -1, 1, -1, 1, 6},
    -- Zone 7: 哀嚎洞穴 (Wailing Caverns) - dungeon
    ["WailingCaverns"] = {-1, 1, -1, 1, -1, 1, 7},
    -- Zone 8: 塔纳利斯 (Tanaris)
    ["Tanaris"] = {8, 1, 17, 1, 15, 1, 8},
    -- Zone 9: 奥格瑞玛 (Orgrimmar)
    ["Ogrimmar"] = {1, 1, 14, 1, 12, 1, 9},
    -- Zone 10: 安其拉之门 (Gates of Ahn'Qiraj)
    ["GatesOfAhnQiraj"] = {-1, 1, -1, 1, -1, 1, 10},
    -- Zone 11: 安戈洛环形山 (Un'Goro Crater)
    ["UngoroCrater"] = {18, 1, 23, 1, 20, 1, 11},
    -- Zone 12: 尘泥沼泽 (Dustwallow Marsh)
    ["Dustwallow"] = {10, 1, 9, 1, 7, 1, 12},
    -- Zone 13: 希利苏斯 (Silithus)
    ["Silithus"] = {5, 1, 15, 1, 13, 1, 13},
    -- Zone 14: 时光之穴 (Caverns of Time)
    ["CavernsOfTime"] = {-1, 1, -1, 1, -1, 1, 14},
    -- Zone 15: 月光林地 (Moonglade)
    ["Moonglade"] = {20, 1, 12, 1, 10, 1, 15},
    -- Zone 16: 杜隆塔尔 (Durotar)
    ["Durotar"] = {7, 1, 8, 1, 6, 1, 16},
    -- Zone 17: 泰拉比姆 - TurtleWoW custom
    ["Telabim"] = {-1, 1, -1, 1, -1, 1, 17},
    -- Zone 18: 泰达希尔 (Teldrassil)
    ["Teldrassil"] = {24, 1, 18, 1, 16, 1, 18},
    -- Zone 19: 海加尔山 (Mount Hyjal)
    ["MountHyjal"] = {-1, 1, -1, 1, -1, 1, 19},
    -- Zone 20: 灰谷 (Ashenvale)
    ["Ashenvale"] = {2, 1, 1, 1, 1, 1, 20},
    -- Zone 21: 玛拉顿 (Maraudon) - dungeon
    ["Maraudon"] = {-1, 1, -1, 1, -1, 1, 21},
    -- Zone 22: 石爪山脉 (Stonetalon Mountains)
    ["StonetalonMountains"] = {6, 1, 16, 1, 14, 1, 22},
    -- Zone 23: 艾萨拉 (Azshara)
    ["Aszhara"] = {15, 1, 2, 1, 2, 1, 23},
    -- Zone 24: 莫高雷 (Mulgore)
    ["Mulgore"] = {22, 1, 13, 1, 11, 1, 24},
    -- Zone 25: 菲拉斯 (Feralas)
    ["Feralas"] = {17, 1, 11, 1, 9, 1, 25},
    -- Zone 26: 贫瘠之地 (The Barrens)
    ["Barrens"] = {11, 1, 19, 1, 17, 1, 26},
    -- Zone 27: 费伍德森林 (Felwood)
    ["Felwood"] = {13, 1, 10, 1, 8, 1, 27},
    -- Zone 28: 达纳苏斯 (Darnassus)
    ["Darnassis"] = {21, 1, 6, 1, 4, 1, 28},
    -- Zone 29: 雷霆崖 (Thunder Bluff)
    ["ThunderBluff"] = {23, 1, 22, 1, 19, 1, 29},
    -- Zone 30: 黑海岸 (Darkshore)
    ["Darkshore"] = {16, 1, 5, 1, 3, 1, 30},
    -- Zone 31: 黑石岛 - TurtleWoW custom
    ["BlackrockIsle"] = {-1, 1, -1, 1, -1, 1, 31},
    
    -- ==================== EASTERN KINGDOMS (Continent 2) - 39 zones ====================
    -- Zone 1: 东瘟疫之地 (Eastern Plaguelands)
    ["EasternPlaguelands"] = {34, 2, 9, 2, 9, 2, 1},
    -- Zone 2: 东瘟疫之地：血色领地 (Scarlet Enclave)
    ["ScarletEnclave"] = {-1, 2, -1, 2, -1, 2, 2},
    -- Zone 3: 丹莫罗 (Dun Morogh)
    ["DunMorogh"] = {28, 2, 7, 2, 7, 2, 3},
    -- Zone 4: 冷酷海岸 - TurtleWoW custom
    ["ColdCoast"] = {-1, 2, -1, 2, -1, 2, 4},
    -- Zone 5: 北风领 - TurtleWoW custom
    ["NorthwindCleft"] = {-1, 2, -1, 2, -1, 2, 5},
    -- Zone 6: 吉利吉姆之岛 (Gillijim's Isle)
    ["GillijimsIsle"] = {-1, 2, -1, 2, -1, 2, 6},
    -- Zone 7: 吉尔尼斯 (Gilneas)
    ["Gilneas"] = {-1, 2, -1, 2, -1, 2, 7},
    -- Zone 8: 奥特兰克山脉 (Alterac Mountains)
    ["Alterac"] = {26, 2, 1, 2, 1, 2, 8},
    -- Zone 9: 奥达曼 (Uldaman) - dungeon
    ["Uldaman"] = {-1, 2, -1, 2, -1, 2, 9},
    -- Zone 10: 巴洛 - TurtleWoW custom
    ["Balo"] = {-1, 2, -1, 2, -1, 2, 10},
    -- Zone 11: 希尔斯布莱德丘陵 (Hillsbrad Foothills)
    ["Hilsbrad"] = {48, 2, 13, 2, 11, 2, 11},
    -- Zone 12: 幽暗城 (Undercity)
    ["Undercity"] = {45, 2, 26, 2, 22, 2, 12},
    -- Zone 13: 悲伤沼泽 (Swamp of Sorrows)
    ["SwampOfSorrows"] = {46, 2, 23, 2, 19, 2, 13},
    -- Zone 14: 拉匹迪斯之岛 - TurtleWoW custom
    ["LapidisIsle"] = {-1, 2, -1, 2, -1, 2, 14},
    -- Zone 15: 提瑞斯法林地 (Tirisfal Glades)
    ["Tirisfal"] = {43, 2, 25, 2, 21, 2, 15},
    -- Zone 16: 暮色森林 (Duskwood)
    ["Duskwood"] = {31, 2, 8, 2, 8, 2, 16},
    -- Zone 17: 暴风城 (Stormwind City)
    ["Stormwind"] = {36, 2, 21, 2, 17, 2, 17},
    -- Zone 18: 死亡矿井 (Deadmines) - dungeon
    ["Deadmines"] = {-1, 2, -1, 2, -1, 2, 18},
    -- Zone 19: 洛克莫丹 (Loch Modan)
    ["LochModan"] = {29, 2, 16, 2, 13, 2, 19},
    -- Zone 20: 湿地 (Wetlands)
    ["Wetlands"] = {51, 2, 29, 2, 25, 2, 20},
    -- Zone 21: 灼热峡谷 (Searing Gorge)
    ["SearingGorge"] = {32, 2, 18, 2, 15, 2, 21},
    -- Zone 22: 燃烧平原 (Burning Steppes)
    ["BurningSteppes"] = {40, 2, 5, 2, 5, 2, 22},
    -- Zone 23: 艾尔文森林 (Elwynn Forest)
    ["Elwynn"] = {37, 2, 10, 2, 10, 2, 23},
    -- Zone 24: 荆棘谷 (Stranglethorn Vale)
    ["Stranglethorn"] = {38, 2, 22, 2, 18, 2, 24},
    -- Zone 25: 荒芜之地 (Badlands)
    ["Badlands"] = {27, 2, 3, 2, 3, 2, 25},
    -- Zone 26: 萨拉斯高地 - TurtleWoW custom (maybe Saldean's Farm area?)
    ["SalasHighlands"] = {-1, 2, -1, 2, -1, 2, 26},
    -- Zone 27: 血色修道院 (Scarlet Monastery) - dungeon
    ["ScarletMonastery"] = {-1, 2, -1, 2, -1, 2, 27},
    -- Zone 28: 西瘟疫之地 (Western Plaguelands)
    ["WesternPlaguelands"] = {50, 2, 27, 2, 23, 2, 28},
    -- Zone 29: 西部荒野 (Westfall)
    ["Westfall"] = {49, 2, 28, 2, 24, 2, 29},
    -- Zone 30: 诅咒之地 (Blasted Lands)
    ["BlastedLands"] = {33, 2, 4, 2, 4, 2, 30},
    -- Zone 31: 诺莫瑞根 (Gnomeregan) - dungeon
    ["Gnomeregan"] = {-1, 2, -1, 2, -1, 2, 31},
    -- Zone 32: 赤脊山 (Redridge Mountains)
    ["Redridge"] = {30, 2, 17, 2, 14, 2, 32},
    -- Zone 33: 辛特兰 (The Hinterlands)
    ["Hinterlands"] = {42, 2, 24, 2, 20, 2, 33},
    -- Zone 34: 逆风小径 (Deadwind Pass)
    ["DeadwindPass"] = {47, 2, 6, 2, 6, 2, 34},
    -- Zone 35: 铁炉堡 (Ironforge)
    ["Ironforge"] = {25, 2, 14, 2, 12, 2, 35},
    -- Zone 36: 银松森林 (Silverpine Forest)
    ["Silverpine"] = {35, 2, 20, 2, 16, 2, 36},
    -- Zone 37: 阿尔萨拉斯 - TurtleWoW custom
    ["Alsarath"] = {-1, 2, -1, 2, -1, 2, 37},
    -- Zone 38: 阿拉希高地 (Arathi Highlands)
    ["Arathi"] = {39, 2, 2, 2, 2, 2, 38},
    -- Zone 39: 黑石山 (Blackrock Mountain)
    ["BlackrockMountain"] = {-1, 2, -1, 2, -1, 2, 39},
}
QuestieZoneIDLookup = {};
for k,v in pairs(QuestieZones) do
    -- must be non-linear array
    QuestieZoneIDLookup[v[1]] = v;
end
QuestieCZLookup = {};
for k,v in pairs(QuestieZones) do
    QuestieCZLookup[v[2] * 100 + v[3]] = v[1];
end

-- Build vanilla zone → TurtleWoW zone conversion table
-- Format: QuestieVanillaToTurtleZone[continent][vanillaZone] = turtleZone
QuestieVanillaToTurtleZone = { [1] = {}, [2] = {} };
for k,v in pairs(QuestieZones) do
    local vanillaC, vanillaZ = v[4], v[5];
    local turtleC, turtleZ = v[6], v[7];
    if vanillaC and vanillaZ and turtleC and turtleZ and vanillaC > 0 and vanillaZ > 0 then
        if QuestieVanillaToTurtleZone[vanillaC] == nil then
            QuestieVanillaToTurtleZone[vanillaC] = {};
        end
        QuestieVanillaToTurtleZone[vanillaC][vanillaZ] = turtleZ;
    end
end

-- Function to convert vanilla zone to TurtleWoW zone
function QuestieConvertVanillaZone(continent, vanillaZone)
    if QuestieVanillaToTurtleZone[continent] and QuestieVanillaToTurtleZone[continent][vanillaZone] then
        return QuestieVanillaToTurtleZone[continent][vanillaZone];
    end
    return vanillaZone; -- Return as-is if no conversion found
end

---------------------------------------------------------------------------------------------------
-- TurtleWoW Detection and Zone Index Helper
---------------------------------------------------------------------------------------------------
-- Detect if we're on TurtleWoW by checking zone count (locale-independent)
-- TurtleWoW uses BC-style zone numbering with 24+ zones in Kalimdor
-- Vanilla only has ~21 zones in Kalimdor
function DetectTurtleWoW()
    local zoneNames = {GetMapZones(1)}; -- Get all zones in Kalimdor (continent 1)
    local numZones = table.getn(zoneNames);
    -- TurtleWoW/BC has 24+ zones in Kalimdor, vanilla has ~21
    -- Zone 18 = Teldrassil on TurtleWoW, but on vanilla Teldrassil is zone 16
    return numZones >= 24;
end

-- Cache the result
QuestieIsTurtleWoW = DetectTurtleWoW();

-- Helper function to get the correct zone index positions based on server
function QuestieGetZoneIndices()
    if QuestieIsTurtleWoW then
        return 6, 7; -- TurtleWoW uses positions 6 and 7 (to be added)
    else
        return 4, 5; -- Vanilla uses positions 4 and 5
    end
end

-- DEBUG: Print all zones for a continent
-- Usage: /script QuestiePrintZones(1) for Kalimdor, /script QuestiePrintZones(2) for Eastern Kingdoms
function QuestiePrintZones(continent)
    local contName = "Unknown"
    if continent == 1 then contName = "Kalimdor"
    elseif continent == 2 then contName = "Eastern Kingdoms" end
    
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00=== " .. contName .. " Zones (Continent " .. continent .. ") ===|r")
    local zoneNames = {GetMapZones(continent)}
    for i = 1, table.getn(zoneNames) do
        local name = zoneNames[i]
        if name and name ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage("  Zone " .. i .. ": " .. name)
        end
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00=== Total: " .. table.getn(zoneNames) .. " zones ===|r")
end
