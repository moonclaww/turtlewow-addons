local MAJOR_VERSION = "MapRegistry-1.0"
local MINOR_VERSION = 3

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local GameVersion = AceLibrary("GameVersion-1.0")
local MapRegistry = {}

local manifest = MapRegistryTurtleManifest or { versions = {} }
local turtleVersions = MapRegistryTurtleVersions or {}

local warnedVersionMismatch = false
local activeTurtleVersion = nil
local exactVersionMatch = true
local mappingStale = false
local liveBindings = nil

local baseRecords = {
    ["WorldMap"] = { id = 1337, vanillaContinent = 0, vanillaZone = 0, turtleContinent = 0, turtleZone = 0 },
    ["Azeroth"] = { id = 1001, vanillaContinent = 2, vanillaZone = 0, turtleContinent = 2, turtleZone = 0 },
    ["Kalimdor"] = { id = 1002, vanillaContinent = 1, vanillaZone = 0, turtleContinent = 1, turtleZone = 0 },
    ["GMIsland"] = { id = 1003, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 1, astrolabeKey = "GMIsland" },
    ["Winterspring"] = { id = 19, vanillaContinent = 1, vanillaZone = 21, turtleContinent = 1, turtleZone = 2 },
    ["Frostpoint"] = { id = 1004, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 3, astrolabeKey = "Icepoint" },
    ["Desolace"] = { id = 4, vanillaContinent = 1, vanillaZone = 5, turtleContinent = 1, turtleZone = 4 },
    ["ThousandNeedles"] = { id = 14, vanillaContinent = 1, vanillaZone = 18, turtleContinent = 1, turtleZone = 5 },
    ["DireMaul"] = { id = 1005, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 6 },
    ["WailingCaverns"] = { id = 1006, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 7 },
    ["Tanaris"] = { id = 8, vanillaContinent = 1, vanillaZone = 15, turtleContinent = 1, turtleZone = 8 },
    ["Ogrimmar"] = { id = 1, vanillaContinent = 1, vanillaZone = 12, turtleContinent = 1, turtleZone = 9 },
    ["GatesOfAhnQiraj"] = { id = 1007, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 10 },
    ["UngoroCrater"] = { id = 18, vanillaContinent = 1, vanillaZone = 20, turtleContinent = 1, turtleZone = 11 },
    ["Dustwallow"] = { id = 10, vanillaContinent = 1, vanillaZone = 7, turtleContinent = 1, turtleZone = 12 },
    ["Silithus"] = { id = 5, vanillaContinent = 1, vanillaZone = 13, turtleContinent = 1, turtleZone = 13 },
    ["CavernsOfTime"] = { id = 1008, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 14 },
    ["Moonglade"] = { id = 20, vanillaContinent = 1, vanillaZone = 10, turtleContinent = 1, turtleZone = 15 },
    ["MoonsongCoast"] = { id = 1009, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 16 },
    ["TimbermawHoldFelwood"] = { id = 1010, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 17 },
    ["TimbermawHoldWinterspring"] = { id = 1011, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 18 },
    ["Durotar"] = { id = 7, vanillaContinent = 1, vanillaZone = 6, turtleContinent = 1, turtleZone = 19 },
    ["Telabim"] = { id = 1012, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 20, astrolabeKey = "TelAbim" },
    ["Teldrassil"] = { id = 24, vanillaContinent = 1, vanillaZone = 16, turtleContinent = 1, turtleZone = 21 },
    ["MountHyjal"] = { id = 1013, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 22 },
    ["Ashenvale"] = { id = 2, vanillaContinent = 1, vanillaZone = 1, turtleContinent = 1, turtleZone = 23 },
    ["Maraudon"] = { id = 1014, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 24 },
    ["StonetalonMountains"] = { id = 6, vanillaContinent = 1, vanillaZone = 14, turtleContinent = 1, turtleZone = 25 },
    ["Aszhara"] = { id = 15, vanillaContinent = 1, vanillaZone = 2, turtleContinent = 1, turtleZone = 26 },
    ["Mulgore"] = { id = 22, vanillaContinent = 1, vanillaZone = 11, turtleContinent = 1, turtleZone = 27 },
    ["Feralas"] = { id = 17, vanillaContinent = 1, vanillaZone = 9, turtleContinent = 1, turtleZone = 28 },
    ["Barrens"] = { id = 11, vanillaContinent = 1, vanillaZone = 17, turtleContinent = 1, turtleZone = 29 },
    ["Felwood"] = { id = 13, vanillaContinent = 1, vanillaZone = 8, turtleContinent = 1, turtleZone = 30 },
    ["Darnassis"] = { id = 21, vanillaContinent = 1, vanillaZone = 4, turtleContinent = 1, turtleZone = 31 },
    ["ThunderBluff"] = { id = 23, vanillaContinent = 1, vanillaZone = 19, turtleContinent = 1, turtleZone = 32 },
    ["WindhornCavern"] = { id = 1015, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 33 },
    ["Darkshore"] = { id = 16, vanillaContinent = 1, vanillaZone = 3, turtleContinent = 1, turtleZone = 34 },
    ["BlackrockIsle"] = { id = 1016, vanillaContinent = 1, vanillaZone = -1, turtleContinent = 1, turtleZone = 35, astrolabeKey = "BlackstoneIsland" },
    ["EasternPlaguelands"] = { id = 34, vanillaContinent = 2, vanillaZone = 9, turtleContinent = 2, turtleZone = 1 },
    ["DunMorogh"] = { id = 28, vanillaContinent = 2, vanillaZone = 7, turtleContinent = 2, turtleZone = 2 },
    ["ColdCoast"] = { id = 1017, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 3, astrolabeKey = "GrimReaches" },
    ["NorthwindCleft"] = { id = 1018, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 4, astrolabeKey = "Northwind" },
    ["GillijimsIsle"] = { id = 1019, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 5, astrolabeKey = "GillijimsIsle" },
    ["Gilneas"] = { id = 1020, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 6, astrolabeKey = "Gilneas" },
    ["Alterac"] = { id = 26, vanillaContinent = 2, vanillaZone = 1, turtleContinent = 2, turtleZone = 7 },
    ["Uldaman"] = { id = 1021, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 8 },
    ["Balo"] = { id = 1022, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 9, astrolabeKey = "Balor" },
    ["Hilsbrad"] = { id = 48, vanillaContinent = 2, vanillaZone = 11, turtleContinent = 2, turtleZone = 10 },
    ["Undercity"] = { id = 45, vanillaContinent = 2, vanillaZone = 22, turtleContinent = 2, turtleZone = 11 },
    ["SwampOfSorrows"] = { id = 46, vanillaContinent = 2, vanillaZone = 19, turtleContinent = 2, turtleZone = 12 },
    ["LapidisIsle"] = { id = 1023, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 13, astrolabeKey = "LapidisIsle" },
    ["Tirisfal"] = { id = 43, vanillaContinent = 2, vanillaZone = 21, turtleContinent = 2, turtleZone = 14 },
    ["Duskwood"] = { id = 31, vanillaContinent = 2, vanillaZone = 8, turtleContinent = 2, turtleZone = 15 },
    ["Stormwind"] = { id = 36, vanillaContinent = 2, vanillaZone = 17, turtleContinent = 2, turtleZone = 16 },
    ["Deadmines"] = { id = 1024, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 17 },
    ["LochModan"] = { id = 29, vanillaContinent = 2, vanillaZone = 13, turtleContinent = 2, turtleZone = 18 },
    ["Wetlands"] = { id = 51, vanillaContinent = 2, vanillaZone = 25, turtleContinent = 2, turtleZone = 19 },
    ["SearingGorge"] = { id = 32, vanillaContinent = 2, vanillaZone = 15, turtleContinent = 2, turtleZone = 20 },
    ["BurningSteppes"] = { id = 40, vanillaContinent = 2, vanillaZone = 5, turtleContinent = 2, turtleZone = 21 },
    ["Elwynn"] = { id = 37, vanillaContinent = 2, vanillaZone = 10, turtleContinent = 2, turtleZone = 22 },
    ["Stranglethorn"] = { id = 38, vanillaContinent = 2, vanillaZone = 18, turtleContinent = 2, turtleZone = 23 },
    ["Badlands"] = { id = 27, vanillaContinent = 2, vanillaZone = 3, turtleContinent = 2, turtleZone = 24 },
    ["SalasHighlands"] = { id = 1025, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 25, astrolabeKey = "ThalassianHighlands" },
    ["ScarletMonastery"] = { id = 1026, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 26 },
    ["ScarletEnclave"] = { id = 1027, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 27, astrolabeKey = "ScarletEnclave" },
    ["WesternPlaguelands"] = { id = 50, vanillaContinent = 2, vanillaZone = 23, turtleContinent = 2, turtleZone = 28 },
    ["Westfall"] = { id = 49, vanillaContinent = 2, vanillaZone = 24, turtleContinent = 2, turtleZone = 29 },
    ["BlastedLands"] = { id = 33, vanillaContinent = 2, vanillaZone = 4, turtleContinent = 2, turtleZone = 30 },
    ["Gnomeregan"] = { id = 1028, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 31 },
    ["Redridge"] = { id = 30, vanillaContinent = 2, vanillaZone = 14, turtleContinent = 2, turtleZone = 32 },
    ["Hinterlands"] = { id = 42, vanillaContinent = 2, vanillaZone = 20, turtleContinent = 2, turtleZone = 33 },
    ["DeadwindPass"] = { id = 47, vanillaContinent = 2, vanillaZone = 6, turtleContinent = 2, turtleZone = 34 },
    ["Ironforge"] = { id = 25, vanillaContinent = 2, vanillaZone = 12, turtleContinent = 2, turtleZone = 35 },
    ["Silverpine"] = { id = 35, vanillaContinent = 2, vanillaZone = 16, turtleContinent = 2, turtleZone = 36 },
    ["Alsarath"] = { id = 1029, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 37, astrolabeKey = "Alsarath" },
    ["Arathi"] = { id = 39, vanillaContinent = 2, vanillaZone = 2, turtleContinent = 2, turtleZone = 38 },
    ["BlackrockMountain"] = { id = 1030, vanillaContinent = 2, vanillaZone = -1, turtleContinent = 2, turtleZone = 39 },
    ["WinterVeilVale"] = { id = 1031, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 3, turtleZone = 0, astrolabeKey = "WinterVeilVale" },
    ["GilneasCity"] = { id = 1032, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 32, turtleZone = 0, astrolabeKey = "GilneasCity" },
    ["CrescentGrove"] = { id = 1033, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 34, turtleZone = 0, astrolabeKey = "CrescentGrove" },
    ["HateforgeQuarry"] = { id = 1034, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 35, turtleZone = 0, astrolabeKey = "HateforgeQuarry" },
    ["KarazhanCrypt"] = { id = 1035, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 36, turtleZone = 0, astrolabeKey = "KarazhanCrypt" },
    ["StormwindVault"] = { id = 1036, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 37, turtleZone = 0, astrolabeKey = "StormwindVault" },
    ["EmeraldSanctum"] = { id = 1037, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 38, turtleZone = 0, astrolabeKey = "EmeraldSanctum" },
    ["DragonmawRetreat"] = { id = 1038, vanillaContinent = -1, vanillaZone = -1, turtleContinent = 41, turtleZone = 0, astrolabeKey = "DragonmawRetreat" },
}

local mapFileAliases = {
    ["Icepoint"] = "Frostpoint",
    ["Frostpoint"] = "Frostpoint",
    ["TelAbim"] = "Telabim",
    ["Telabim"] = "Telabim",
    ["BlackstoneIsland"] = "BlackrockIsle",
    ["BlackrockIsle"] = "BlackrockIsle",
    ["Northwind"] = "NorthwindCleft",
    ["NorthwindCleft"] = "NorthwindCleft",
    ["Balor"] = "Balo",
    ["Balo"] = "Balo",
    ["ThalassianHighlands"] = "SalasHighlands",
    ["SalasHighlands"] = "SalasHighlands",
    ["GrimReaches"] = "ColdCoast",
    ["ColdCoast"] = "ColdCoast",
    ["Gillijim"] = "GillijimsIsle",
    ["GillijimsIsle"] = "GillijimsIsle",
    ["Lapidis"] = "LapidisIsle",
    ["LapidisIsle"] = "LapidisIsle",
    ["AlahThalas"] = "Alsarath",
    ["Alsarath"] = "Alsarath",
    ["Hyjal"] = "MountHyjal",
    ["MountHyjal"] = "MountHyjal",
    ["MaraudonEntrance"] = "Maraudon",
    ["Maraudon"] = "Maraudon",
    ["DireMaulEntrance"] = "DireMaul",
    ["DireMaul"] = "DireMaul",
    ["WailingCavernsEntrance"] = "WailingCaverns",
    ["WailingCaverns"] = "WailingCaverns",
    ["DeadminesEntrance"] = "Deadmines",
    ["Deadmines"] = "Deadmines",
    ["GnomereganEntrance"] = "Gnomeregan",
    ["Gnomeregan"] = "Gnomeregan",
    ["ScarletMonasteryEntrance"] = "ScarletMonastery",
    ["ScarletMonastery"] = "ScarletMonastery",
    ["Darnassus"] = "Darnassis",
    ["Darnassis"] = "Darnassis",
    ["Azeroth"] = "Azeroth",
    ["Kalimdor"] = "Kalimdor",
}

local legacyTurtleZones = {
    [1] = {
        [3] = 1004,
        [17] = 1012,
        [31] = 1016,
    },
    [2] = {
        [2] = 1027,
        [4] = 1017,
        [5] = 1018,
        [6] = 1019,
        [7] = 1020,
        [10] = 1022,
        [14] = 1023,
        [26] = 1025,
        [37] = 1029,
        [39] = 1030,
    },
}

local vanillaLookup = {}
local turtleLookup = {}
local recordLookup = {}

local function normalizeMapFile(mapFile)
    if not mapFile then
        return nil
    end
    return mapFileAliases[mapFile] or mapFile
end

local function buildLookups()
    for mapFile, record in pairs(baseRecords) do
        record.mapFile = mapFile
        if not record.astrolabeKey then
            record.astrolabeKey = mapFile
        end
        recordLookup[record.id] = record
        if record.vanillaContinent and record.vanillaContinent > 0 and record.vanillaZone and record.vanillaZone >= 0 then
            vanillaLookup[record.vanillaContinent * 100 + record.vanillaZone] = record.id
        end
        if record.turtleContinent and record.turtleContinent > 0 and record.turtleZone and record.turtleZone >= 0 then
            turtleLookup[record.turtleContinent * 100 + record.turtleZone] = record.id
        end
    end
end

buildLookups()

local function dottedVersionScore(version)
    if not version or version == "" then
        return nil
    end

    local _, _, major, minor, patch = string.find(version, "^(%d+)%.(%d+)%.?(%d*)")
    if not major then
        return nil
    end

    patch = tonumber(patch) or 0
    return tonumber(major) * 10000 + tonumber(minor) * 100 + patch
end

local function copyTable(source)
    local result = {}
    if not source then
        return result
    end
    for key, value in pairs(source) do
        if type(value) == "table" then
            result[key] = copyTable(value)
        else
            result[key] = value
        end
    end
    return result
end

local function ensureLiveBindings()
    if liveBindings then
        return
    end

    liveBindings = {
        byMapFile = {},
        byCanonicalId = {},
        byZoneKey = {},
    }

    local continents = { GetMapContinents() }
    for continent = 1, table.getn(continents) do
        local zones = { GetMapZones(continent) }
        for zone = 1, table.getn(zones) do
            SetMapZoom(continent, zone)
            local mapFile = normalizeMapFile(GetMapInfo())
            local record = baseRecords[mapFile]
            if record then
                local entry = { continent = continent, zone = zone, mapFile = mapFile }
                liveBindings.byMapFile[mapFile] = entry
                liveBindings.byCanonicalId[record.id] = entry
                liveBindings.byZoneKey[continent * 100 + zone] = record.id
            end
        end
    end
end

local function getAvailableTurtleVersions()
    local versions = {}
    if manifest.versions then
        for _, version in ipairs(manifest.versions) do
            table.insert(versions, version)
        end
    end
    table.sort(versions, function(left, right)
        local leftScore = dottedVersionScore(left) or 0
        local rightScore = dottedVersionScore(right) or 0
        return leftScore < rightScore
    end)
    return versions
end

local function warnVersionMismatch(runtimeVersion, chosenVersion)
    if warnedVersionMismatch or not GameVersion:IsTurtleWoW() then
        return
    end

    warnedVersionMismatch = true
    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("|cffff8040MapRegistry|r: TurtleWoW build " ..
            tostring(runtimeVersion or "unknown") ..
            " has no exact extracted mapping; using closest available version " ..
            tostring(chosenVersion or "unknown") .. ".")
    end
end

local function ensureActiveTurtleVersion()
    if activeTurtleVersion ~= nil or not GameVersion:IsTurtleWoW() then
        return
    end

    local runtimeVersion = GameVersion:GetBuildVersion()
    local runtimeScore = dottedVersionScore(runtimeVersion)
    local versions = getAvailableTurtleVersions()
    local bestVersion = nil
    local bestDistance = nil
    local bestScore = nil

    for _, version in ipairs(versions) do
        local score = dottedVersionScore(version)
        if version == runtimeVersion then
            activeTurtleVersion = version
            exactVersionMatch = true
            mappingStale = false
            return
        elseif runtimeScore and score then
            local distance = math.abs(runtimeScore - score)
            if not bestDistance or distance < bestDistance or (distance == bestDistance and score < bestScore) then
                bestVersion = version
                bestDistance = distance
                bestScore = score
            end
        end
    end

    activeTurtleVersion = bestVersion
    exactVersionMatch = false
    mappingStale = runtimeScore and bestScore and runtimeScore > bestScore or false
    warnVersionMismatch(runtimeVersion, activeTurtleVersion)
end

local function getActiveVersionData()
    ensureActiveTurtleVersion()
    if not GameVersion:IsTurtleWoW() then
        return nil
    end
    return turtleVersions[activeTurtleVersion or ""]
end

local function getTurtleVersionRecord(canonicalId)
    local versionData = getActiveVersionData()
    if not versionData or not versionData.records then
        return nil
    end
    return versionData.records[canonicalId]
end

function MapRegistry:GetTurtleBuildVersion()
    return GameVersion:GetBuildVersion()
end

function MapRegistry:GetAvailableTurtleVersions()
    return getAvailableTurtleVersions()
end

function MapRegistry:GetActiveTurtleVersion()
    ensureActiveTurtleVersion()
    return activeTurtleVersion
end

function MapRegistry:IsExactVersionMatch()
    ensureActiveTurtleVersion()
    return exactVersionMatch
end

function MapRegistry:IsMappingStale()
    ensureActiveTurtleVersion()
    return mappingStale
end

function MapRegistry:GetCanonicalMapIDFromLegacyTurtle(continent, zone)
    local continentData = legacyTurtleZones[continent]
    if not continentData then
        return nil
    end
    return continentData[zone]
end

function MapRegistry:GetCanonicalMapIDFromVanilla(continent, zone)
    return vanillaLookup[continent * 100 + zone]
end

function MapRegistry:GetCanonicalMapID(continent, zone)
    ensureLiveBindings()

    local canonicalId = liveBindings.byZoneKey[continent * 100 + zone]
    if canonicalId then
        return canonicalId
    end

    if GameVersion:IsTurtleWoW() then
        return turtleLookup[continent * 100 + zone]
    end

    return vanillaLookup[continent * 100 + zone]
end

function MapRegistry:GetCurrentMapID()
    local mapFile = normalizeMapFile(GetMapInfo())
    local record = baseRecords[mapFile]
    if record then
        return record.id
    end

    local continent = GetCurrentMapContinent()
    local zone = GetCurrentMapZone()
    if continent and zone then
        local canonicalId = self:GetCanonicalMapID(continent, zone)
        if canonicalId then
            return canonicalId
        end
    end

    return -1
end

function MapRegistry:GetClientZone(canonicalId)
    ensureLiveBindings()

    local liveData = liveBindings.byCanonicalId[canonicalId]
    if liveData then
        return liveData.continent, liveData.zone
    end

    local record = recordLookup[canonicalId]
    if not record then
        return nil, nil
    end

    if GameVersion:IsTurtleWoW() then
        return record.turtleContinent, record.turtleZone
    end

    return record.vanillaContinent, record.vanillaZone
end

function MapRegistry:GetMapRecord(canonicalId)
    local record = recordLookup[canonicalId]
    if not record then
        return nil
    end

    local result = copyTable(record)
    local versionRecord = getTurtleVersionRecord(canonicalId)
    if versionRecord then
        for key, value in pairs(versionRecord) do
            result[key] = value
        end
    end
    result.currentContinent, result.currentZone = self:GetClientZone(canonicalId)
    result.exactVersionMatch = self:IsExactVersionMatch()
    result.activeTurtleVersion = self:GetActiveTurtleVersion()
    return result
end

function MapRegistry:NormalizeLocationTuple(location, sourceType)
    if not location then
        return nil
    end

    local length = table.getn(location)
    if length == 3 then
        local canonicalId = tonumber(location[1])
        if canonicalId then
            return { canonicalId, location[2], location[3] }
        end
        return nil
    end

    if length >= 4 then
        local canonicalId = nil
        if sourceType == "client" then
            canonicalId = self:GetCanonicalMapID(location[1], location[2])
        elseif sourceType == "legacyTurtle" then
            canonicalId = self:GetCanonicalMapIDFromLegacyTurtle(location[1], location[2])
        else
            canonicalId = self:GetCanonicalMapIDFromVanilla(location[1], location[2])
            if not canonicalId and sourceType ~= "vanilla" then
                canonicalId = self:GetCanonicalMapID(location[1], location[2])
            end
            if not canonicalId and sourceType ~= "vanilla" then
                canonicalId = self:GetCanonicalMapIDFromLegacyTurtle(location[1], location[2])
            end
        end

        if canonicalId then
            return { canonicalId, location[3], location[4] }
        end
    end

    return nil
end

function MapRegistry:ResolveLocationTuple(location, sourceType)
    local normalized = self:NormalizeLocationTuple(location, sourceType)
    if not normalized then
        return nil
    end

    local continent, zone = self:GetClientZone(normalized[1])
    if continent and zone then
        return { continent, zone, normalized[2], normalized[3] }
    end

    return nil
end

function MapRegistry:GetClientZoneForVanillaZone(continent, zone)
    local canonicalId = self:GetCanonicalMapIDFromVanilla(continent, zone)
    if not canonicalId then
        return continent, zone
    end
    local clientContinent, clientZone = self:GetClientZone(canonicalId)
    return clientContinent or continent, clientZone or zone
end

function MapRegistry:BuildQuestieCompatTables()
    local zones = {}
    local zoneIdLookup = {}
    local czLookup = {}

    for mapFile, record in pairs(baseRecords) do
        local runtimeContinent, runtimeZone = self:GetClientZone(record.id)
        local compat = {
            record.id,
            runtimeContinent or 0,
            runtimeZone or 0,
            record.vanillaContinent or 0,
            record.vanillaZone or 0,
            runtimeContinent or record.turtleContinent or 0,
            runtimeZone or record.turtleZone or 0,
        }

        compat.mapFile = mapFile
        compat.astrolabeKey = record.astrolabeKey
        zones[mapFile] = compat
        zoneIdLookup[record.id] = compat

        if runtimeContinent and runtimeZone then
            czLookup[runtimeContinent * 100 + runtimeZone] = record.id
        end
    end

    return zones, zoneIdLookup, czLookup
end

function MapRegistry:ApplyAstrolabeOverrides(worldMapSize)
    if not worldMapSize or not GameVersion:IsTurtleWoW() then
        return
    end

    ensureActiveTurtleVersion()
    local versionData = turtleVersions[activeTurtleVersion or ""]
    if not versionData or not versionData.astrolabeOverrides then
        return
    end

    for continentId, continentData in pairs(versionData.astrolabeOverrides) do
        if not worldMapSize[continentId] then
            worldMapSize[continentId] = {}
        end

        local target = worldMapSize[continentId]
        for key, value in pairs(continentData) do
            if key == "zoneData" then
                if not target.zoneData then
                    target.zoneData = {}
                end
                for zoneKey, zoneData in pairs(value) do
                    target.zoneData[zoneKey] = copyTable(zoneData)
                end
            elseif target[key] == nil or key == "height" or key == "width" or key == "parentContinent" or key == "xOffset" or key == "yOffset" then
                target[key] = value
            end
        end
    end
end

_G.MapRegistry = MapRegistry

AceLibrary:Register(MapRegistry, MAJOR_VERSION, MINOR_VERSION)
