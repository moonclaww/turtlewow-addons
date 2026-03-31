local GameVersion = AceLibrary("GameVersion-1.0")
local MapRegistry = AceLibrary("MapRegistry-1.0")

QuestieZones, QuestieZoneIDLookup, QuestieCZLookup = MapRegistry:BuildQuestieCompatTables()
QuestieIsTurtleWoW = GameVersion:IsTurtleWoW()

function QuestieConvertVanillaZone(continent, vanillaZone)
    local _, turtleZone = MapRegistry:GetClientZoneForVanillaZone(continent, vanillaZone)
    if turtleZone then
        return turtleZone
    end
    return vanillaZone
end

function QuestieGetZoneIndices()
    if QuestieIsTurtleWoW then
        return 6, 7
    end
    return 4, 5
end

function QuestiePrintZones(continent)
    local contName = "Unknown"
    if continent == 1 then
        contName = "Kalimdor"
    elseif continent == 2 then
        contName = "Eastern Kingdoms"
    end

    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00=== " .. contName .. " Zones (Continent " .. continent .. ") ===|r")
    local zoneNames = { GetMapZones(continent) }
    for i = 1, table.getn(zoneNames) do
        local name = zoneNames[i]
        if name and name ~= "" then
            DEFAULT_CHAT_FRAME:AddMessage("  Zone " .. i .. ": " .. name)
        end
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cFF00FF00=== Total: " .. table.getn(zoneNames) .. " zones ===|r")
end
