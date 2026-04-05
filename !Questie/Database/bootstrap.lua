-- Questie bootstrap: keeps generated addendum data separate from runtime lookup code.
local MapRegistry = AceLibrary("MapRegistry-1.0")
local QuestieVanillaUnitData = QuestieUnitData or {}
local QuestieVanillaObjectData = QuestieObjectData or {}
local QuestieVanillaItemData = QuestieItemData or {}
local QuestieVanillaQuestData = QuestieQuestData or {}
local QuestieVanillaUnitNames = QuestieUnitNames or {}
local QuestieVanillaObjectNames = QuestieObjectNames or {}
local QuestieVanillaItemNames = QuestieItemNames or {}
local QuestieVanillaQuestNames = QuestieQuestNames or {}
local QuestieTurtleUnitData = QuestieUnitDataTurtle
local QuestieTurtleObjectData = QuestieObjectDataTurtle
local QuestieTurtleItemData = QuestieItemDataTurtle
local QuestieTurtleQuestData = QuestieQuestDataTurtle
local QuestieTurtleUnitNames = QuestieUnitNamesTurtle
local QuestieTurtleObjectNames = QuestieObjectNamesTurtle
local QuestieTurtleItemNames = QuestieItemNamesTurtle
local QuestieTurtleQuestNames = QuestieQuestNamesTurtle
local QuestieVanillaUnitIdsByName = {}
local QuestieVanillaObjectIdsByName = {}
local QuestieVanillaItemIdsByName = {}
local QuestieTurtleUnitIdsByName = {}
local QuestieTurtleObjectIdsByName = {}
local QuestieTurtleItemIdsByName = {}

QuestieUnitIdsByName = {}
QuestieObjectIdsByName = {}
QuestieItemIdsByName = {}
QuestieQuestIdsByTitleAndObjectives = {}
QuestieQuestMetaById = {}
QuestieQuestGroupMembers = {}
QuestieQuestGroupIdByQuestId = {}
QuestieZoneLevelMap = {}

local function QuestieGetSortedNumericKeys(source)
    local keys = {}
    if not source then
        return keys
    end

    for key in pairs(source) do
        if type(key) == "number" then
            table.insert(keys, key)
        end
    end

    table.sort(keys)
    return keys
end

function QuestieSanitizeQuestTitle(title)
    if not title then
        return title
    end
    return string.gsub(title, " [(]?[Pp]art %d+[)]?", "")
end

local function QuestieAppendUniqueId(target, value)
    if not target or value == nil then
        return
    end

    for _, existing in ipairs(target) do
        if existing == value then
            return
        end
    end

    table.insert(target, value)
end

local function QuestieAppendUniqueIds(target, source)
    if not source then
        return
    end

    for _, value in ipairs(source) do
        QuestieAppendUniqueId(target, value)
    end
end

local function QuestieBuildReverseNameLookup(source)
    local lookup = {}

    for _, id in ipairs(QuestieGetSortedNumericKeys(source)) do
        local name = source[id]
        if name and name ~= "" then
            if lookup[name] == nil then
                lookup[name] = {}
            end
            table.insert(lookup[name], id)
        end
    end

    return lookup
end

local function QuestieBuildMergedReverseNameLookup(vanillaSource, turtleSource)
    local lookup = QuestieBuildReverseNameLookup(vanillaSource)

    if QuestieIsTurtleWoW and turtleSource then
        local turtleLookup = QuestieBuildReverseNameLookup(turtleSource)
        for name, ids in pairs(turtleLookup) do
            if lookup[name] == nil then
                lookup[name] = {}
            end
            QuestieAppendUniqueIds(lookup[name], ids)
            table.sort(lookup[name])
        end
    end

    return lookup
end

local function QuestieGetAllQuestIds()
    local questIds = QuestieGetSortedNumericKeys(QuestieVanillaQuestData)

    if QuestieIsTurtleWoW and QuestieTurtleQuestData then
        for _, questId in ipairs(QuestieGetSortedNumericKeys(QuestieTurtleQuestData)) do
            QuestieAppendUniqueId(questIds, questId)
        end
        table.sort(questIds)
    end

    return questIds
end

local function QuestieHasTurtleQuestOverride(questId)
    if not QuestieIsTurtleWoW or not questId then
        return false
    end

    return (QuestieTurtleQuestData and QuestieTurtleQuestData[questId] ~= nil)
        or (QuestieTurtleQuestNames and QuestieTurtleQuestNames[questId] ~= nil)
end

local function QuestieMergeOverlayEntry(baseEntry, overlayEntry)
    if overlayEntry == nil then
        return baseEntry
    end

    if baseEntry == nil then
        return overlayEntry
    end

    if type(baseEntry) ~= "table" or type(overlayEntry) ~= "table" then
        return overlayEntry
    end

    local merged = {}
    for key, value in pairs(baseEntry) do
        merged[key] = value
    end
    for key, value in pairs(overlayEntry) do
        merged[key] = value
    end

    return merged
end

local function QuestieGetQuestNameInfo(questId)
    if QuestieHasTurtleQuestOverride(questId) and QuestieTurtleQuestNames and QuestieTurtleQuestNames[questId] then
        return QuestieMergeOverlayEntry(QuestieVanillaQuestNames and QuestieVanillaQuestNames[questId], QuestieTurtleQuestNames[questId])
    end

    if QuestieVanillaQuestNames and QuestieVanillaQuestNames[questId] then
        return QuestieVanillaQuestNames[questId]
    end

    if QuestieIsTurtleWoW and QuestieTurtleQuestNames and QuestieTurtleQuestNames[questId] then
        return QuestieTurtleQuestNames[questId]
    end

    return nil
end

local function QuestieBuildQuestNameLookup()
    local lookup = {}

    local function addQuestLookupEntry(questId, info)
        local title = QuestieSanitizeQuestTitle(info and info.title)
        local objectives = info and info.objectives or ""

        if title and title ~= "" then
            if lookup[title] == nil then
                lookup[title] = {}
            end
            if lookup[title][objectives] == nil then
                lookup[title][objectives] = {}
            end
            QuestieAppendUniqueId(lookup[title][objectives], questId)
        end
    end

    for _, questId in ipairs(QuestieGetAllQuestIds()) do
        if QuestieVanillaQuestNames and QuestieVanillaQuestNames[questId] then
            addQuestLookupEntry(questId, QuestieVanillaQuestNames[questId])
        end

        if QuestieIsTurtleWoW and QuestieTurtleQuestNames and QuestieTurtleQuestNames[questId] then
            addQuestLookupEntry(questId, QuestieTurtleQuestNames[questId])
        end
    end

    return lookup
end

local function QuestieGetDomainEntry(vanillaTable, turtleTable, entryId, questId)
    local vanillaEntry = vanillaTable and vanillaTable[entryId] or nil
    local turtleEntry = turtleTable and turtleTable[entryId] or nil

    if QuestieHasTurtleQuestOverride(questId) and turtleEntry ~= nil then
        return QuestieMergeOverlayEntry(vanillaEntry, turtleEntry)
    end

    if vanillaEntry ~= nil then
        return vanillaEntry
    end

    if QuestieIsTurtleWoW and turtleEntry ~= nil then
        return turtleEntry
    end

    return nil
end

local function QuestieGetEntityIdsByName(vanillaLookup, turtleLookup, entityName, questId)
    local candidates = {}

    if not entityName or entityName == "" then
        return candidates
    end

    if QuestieHasTurtleQuestOverride(questId) then
        QuestieAppendUniqueIds(candidates, turtleLookup[entityName] or {})
        QuestieAppendUniqueIds(candidates, vanillaLookup[entityName] or {})
    elseif questId then
        QuestieAppendUniqueIds(candidates, vanillaLookup[entityName] or {})
    else
        QuestieAppendUniqueIds(candidates, vanillaLookup[entityName] or {})
        if QuestieIsTurtleWoW then
            QuestieAppendUniqueIds(candidates, turtleLookup[entityName] or {})
        end
    end

    table.sort(candidates)
    return candidates
end

local function QuestieGetDisplayName(vanillaNameTable, turtleNameTable, entityId, prefix, questId)
    local entityName = QuestieGetDomainEntry(vanillaNameTable, turtleNameTable, entityId, questId)
    if entityName then
        return entityName
    end

    if prefix == "Object" and entityId and QuestieNewObjects and QuestieNewObjects[entityId] and QuestieNewObjects[entityId].name then
        return QuestieNewObjects[entityId].name
    end

    if entityId then
        return prefix .. "_" .. entityId
    end

    return "unknown"
end

local function QuestieResolveStartInfo(questId, questData)
    if not questData then
        return "unknown", nil, "unknown"
    end

    if questData.startUnit then
        return "monster", questData.startUnit, QuestieGetDisplayName(QuestieVanillaUnitNames, QuestieTurtleUnitNames, questData.startUnit, "Unit", questId)
    end
    if questData.startObject then
        return "object", questData.startObject, QuestieGetDisplayName(QuestieVanillaObjectNames, QuestieTurtleObjectNames, questData.startObject, "Object", questId)
    end
    if questData.startItem then
        return "item", questData.startItem, QuestieGetDisplayName(QuestieVanillaItemNames, QuestieTurtleItemNames, questData.startItem, "Item", questId)
    end

    return "unknown", nil, "unknown"
end

local function QuestieResolveFinishInfo(questId, questData)
    if not questData then
        return "unknown", nil, "unknown"
    end

    if questData.endUnit then
        return "monster", questData.endUnit, QuestieGetDisplayName(QuestieVanillaUnitNames, QuestieTurtleUnitNames, questData.endUnit, "Unit", questId)
    end
    if questData.endObject then
        return "object", questData.endObject, QuestieGetDisplayName(QuestieVanillaObjectNames, QuestieTurtleObjectNames, questData.endObject, "Object", questId)
    end

    return "unknown", nil, "unknown"
end

function QuestieGetUnitById(unitId, questId)
    return QuestieGetDomainEntry(QuestieVanillaUnitData, QuestieTurtleUnitData, unitId, questId)
end

function QuestieGetUnitIdsByName(unitName, questId)
    return QuestieGetEntityIdsByName(QuestieVanillaUnitIdsByName, QuestieTurtleUnitIdsByName, unitName, questId)
end

function QuestieGetObjectById(objectId, questId)
    local objectData = QuestieGetDomainEntry(QuestieVanillaObjectData, QuestieTurtleObjectData, objectId, questId)
    if objectData then
        return objectData
    end
    if QuestieNewObjects and QuestieNewObjects[objectId] then
        return QuestieNewObjects[objectId]
    end
    return nil
end

function QuestieGetObjectIdsByName(objectName, questId)
    return QuestieGetEntityIdsByName(QuestieVanillaObjectIdsByName, QuestieTurtleObjectIdsByName, objectName, questId)
end

function QuestieGetItemById(itemId, questId)
    return QuestieGetDomainEntry(QuestieVanillaItemData, QuestieTurtleItemData, itemId, questId)
end

function QuestieGetItemIdsByName(itemName, questId)
    return QuestieGetEntityIdsByName(QuestieVanillaItemIdsByName, QuestieTurtleItemIdsByName, itemName, questId)
end

function QuestieGetQuestById(questId)
    local vanillaQuest = QuestieVanillaQuestData and QuestieVanillaQuestData[questId] or nil
    local turtleQuest = QuestieTurtleQuestData and QuestieTurtleQuestData[questId] or nil

    if QuestieHasTurtleQuestOverride(questId) and turtleQuest ~= nil then
        return QuestieMergeOverlayEntry(vanillaQuest, turtleQuest)
    end

    if vanillaQuest ~= nil then
        return vanillaQuest
    end

    if QuestieIsTurtleWoW and turtleQuest ~= nil then
        return turtleQuest
    end

    return nil
end

function QuestieGetQuestMetaById(questId)
    return QuestieQuestMetaById and QuestieQuestMetaById[questId] or nil
end

function QuestieGetQuestCandidateIdsByTitleAndObjectives(questTitle, questObjectives)
    local titleLookup = QuestieQuestIdsByTitleAndObjectives[QuestieSanitizeQuestTitle(questTitle)]
    local candidates = {}

    if not titleLookup then
        return candidates
    end

    if questObjectives and titleLookup[questObjectives] then
        QuestieAppendUniqueIds(candidates, titleLookup[questObjectives])
    end

    for objectives, questIds in pairs(titleLookup) do
        if (not questObjectives) or objectives == "" or questObjectives == "" or string.find(questObjectives, objectives, 1, true) or string.find(objectives, questObjectives, 1, true) then
            QuestieAppendUniqueIds(candidates, questIds)
        end
    end

    if table.getn(candidates) == 0 then
        for _, questIds in pairs(titleLookup) do
            QuestieAppendUniqueIds(candidates, questIds)
        end
    end

    table.sort(candidates)
    return candidates
end

function QuestieGetQuestGroupMembers(groupId)
    return QuestieQuestGroupMembers[groupId] or {}
end

function QuestieGetUnitLocationsById(unitId, questId)
    local unitData = QuestieGetUnitById(unitId, questId)
    if not unitData or not unitData.locations then
        return {}, {}
    end

    local locations = { ["locations"] = {} }
    local mapIds = {}

    for _, loc in ipairs(unitData.locations) do
        local reformattedLocation = MapRegistry:NormalizeLocationTuple(loc, "vanilla")
        if reformattedLocation then
            table.insert(locations["locations"], reformattedLocation)
            mapIds[reformattedLocation[1]] = true
        end
    end

    return locations, mapIds
end

function QuestieGetObjectLocationsById(objectId, questId)
    local objectData = QuestieGetObjectById(objectId, questId)
    if not objectData or not objectData.locations then
        return {}, {}
    end

    local locations = { ["locations"] = {} }
    local mapIds = {}

    for _, loc in ipairs(objectData.locations) do
        local reformattedLocation = MapRegistry:NormalizeLocationTuple(loc, "vanilla")
        if reformattedLocation then
            table.insert(locations["locations"], reformattedLocation)
            mapIds[reformattedLocation[1]] = true
        end
    end

    return locations, mapIds
end

local function QuestieMergeLocationResults(allLocations, allMapIds, locations, mapIds)
    if locations and locations["locations"] then
        for _, loc in ipairs(locations["locations"]) do
            table.insert(allLocations, loc)
        end
    end

    if mapIds then
        for mapId in pairs(mapIds) do
            allMapIds[mapId] = true
        end
    end
end

local function QuestieBuildSourceKey(entityType, entityId)
    return entityType .. ":" .. tostring(entityId)
end

local function QuestieAppendSourceNode(root, sourceType, entityType, entityId, displayName, locations, mapIds, allMapIds)
    if not locations or not locations["locations"] or table.getn(locations["locations"]) == 0 then
        return
    end

    if root[sourceType] == nil then
        root[sourceType] = {}
    end

    root[sourceType][QuestieBuildSourceKey(entityType, entityId)] = {
        ["displayName"] = displayName,
        ["entityType"] = entityType,
        ["entityId"] = entityId,
        ["locations"] = deepcopy(locations["locations"]),
    }

    if mapIds then
        for mapId in pairs(mapIds) do
            allMapIds[mapId] = true
        end
    end
end

function QuestieGetItemLocationsById(itemId, questId)
    local itemData = QuestieGetItemById(itemId, questId)
    if not itemData then
        return {}, {}
    end

    local sourceTree = {}
    local sourceMapIds = {}

    if itemData.dropUnits then
        for _, unitId in ipairs(itemData.dropUnits) do
            local locations, mapIds = QuestieGetUnitLocationsById(unitId, questId)
            QuestieAppendSourceNode(sourceTree, "drop", "monster", unitId, QuestieGetDisplayName(QuestieVanillaUnitNames, QuestieTurtleUnitNames, unitId, "Unit", questId), locations, mapIds, sourceMapIds)
        end
    end

    if itemData.containedObjects then
        for _, objectId in ipairs(itemData.containedObjects) do
            local locations, mapIds = QuestieGetObjectLocationsById(objectId, questId)
            QuestieAppendSourceNode(sourceTree, "contained", "object", objectId, QuestieGetDisplayName(QuestieVanillaObjectNames, QuestieTurtleObjectNames, objectId, "Object", questId), locations, mapIds, sourceMapIds)
        end
    end

    if next(sourceTree) then
        return sourceTree, sourceMapIds
    end

    local allLocations = {}
    local allMapIds = {}

    if itemData.vendorUnits then
        for _, unitId in ipairs(itemData.vendorUnits) do
            local locations, mapIds = QuestieGetUnitLocationsById(unitId, questId)
            QuestieMergeLocationResults(allLocations, allMapIds, locations, mapIds)
        end
    end

    return { ["locations"] = allLocations }, allMapIds
end

function QuestieGetQuestStartLocationsById(questId)
    local questData = QuestieGetQuestById(questId)
    if not questData then
        return {}, {}
    end

    if questData.startUnit then
        return QuestieGetUnitLocationsById(questData.startUnit, questId)
    end
    if questData.startObject then
        return QuestieGetObjectLocationsById(questData.startObject, questId)
    end
    if questData.startItem then
        return QuestieGetItemLocationsById(questData.startItem, questId)
    end

    return {}, {}
end

function QuestieGetQuestFinisherLocationsById(questId)
    local questData = QuestieGetQuestById(questId)
    if not questData then
        return {}, {}
    end

    if questData.endUnit then
        return QuestieGetUnitLocationsById(questData.endUnit, questId)
    end
    if questData.endObject then
        return QuestieGetObjectLocationsById(questData.endObject, questId)
    end

    return {}, {}
end

function QuestieGetQuestObjectiveCoords(questId, objectiveIndex)
    local questData = QuestieGetQuestById(questId)
    if not questData or not questData.objectiveCoords then
        return {}, {}
    end

    local coords = questData.objectiveCoords[objectiveIndex]
    if not coords then
        return {}, {}
    end

    local locations = {}
    local mapIds = {}

    for _, coord in ipairs(coords) do
        local reformattedLocation = MapRegistry:NormalizeLocationTuple(coord, "vanilla")
        if reformattedLocation then
            table.insert(locations, reformattedLocation)
            mapIds[reformattedLocation[1]] = true
        end
    end

    return { ["locations"] = locations }, mapIds
end

function QuestieGetAllQuestObjectiveCoords(questId)
    local questData = QuestieGetQuestById(questId)
    if not questData or not questData.objectiveCoords then
        return {}, {}
    end

    local allLocations = {}
    local allMapIds = {}

    for objectiveIndex in pairs(questData.objectiveCoords) do
        if objectiveIndex >= 0 then
            local locations, mapIds = QuestieGetQuestObjectiveCoords(questId, objectiveIndex)
            QuestieMergeLocationResults(allLocations, allMapIds, locations, mapIds)
        end
    end

    return { ["locations"] = allLocations }, allMapIds
end

local function QuestieBuildQuestGroupId(info)
    return tostring(QuestieSanitizeQuestTitle(info and info.title or "")) .. "\031" .. tostring(info and info.objectives or "")
end

local function QuestieBuildQuestMeta(questId, questData, info)
    local startType, startId, startDisplayName = QuestieResolveStartInfo(questId, questData)
    local finishType, finishId, finishDisplayName = QuestieResolveFinishInfo(questId, questData)

    return {
        ["questId"] = questId,
        ["groupId"] = QuestieBuildQuestGroupId(info),
        ["name"] = info.title,
        ["objectivesText"] = info.objectives or "",
        ["level"] = questData.minLevel or 1,
        ["questLevel"] = tostring(questData.level or 1),
        ["requiredRaceMask"] = questData.race or 0,
        ["requiredClassMask"] = questData.class or 0,
        ["requiredQuestId"] = questData.preQuests and questData.preQuests[1] or nil,
        ["requiredSkillId"] = questData.skill,
        ["startType"] = startType,
        ["startId"] = startId,
        ["startDisplayName"] = startDisplayName,
        ["finishType"] = finishType,
        ["finishId"] = finishId,
        ["finishDisplayName"] = finishDisplayName,
    }
end

local function addQuestToZoneLevelMap(mapId, questId, questMeta, locationMeta)
    local level = questMeta.level
    if QuestieZoneLevelMap[mapId] == nil then
        QuestieZoneLevelMap[mapId] = {}
    end
    if QuestieZoneLevelMap[mapId][level] == nil then
        QuestieZoneLevelMap[mapId][level] = {}
    end

    local clonedLocationMeta = deepcopy(locationMeta)
    clonedLocationMeta.questName = questMeta.name
    QuestieZoneLevelMap[mapId][level][questId] = clonedLocationMeta
end

local function QuestieBuildStructuredQuestTables()
    local buildStart = GetTime()

    QuestieVanillaUnitIdsByName = QuestieBuildReverseNameLookup(QuestieVanillaUnitNames)
    QuestieVanillaObjectIdsByName = QuestieBuildReverseNameLookup(QuestieVanillaObjectNames)
    QuestieVanillaItemIdsByName = QuestieBuildReverseNameLookup(QuestieVanillaItemNames)
    QuestieTurtleUnitIdsByName = QuestieBuildReverseNameLookup(QuestieTurtleUnitNames)
    QuestieTurtleObjectIdsByName = QuestieBuildReverseNameLookup(QuestieTurtleObjectNames)
    QuestieTurtleItemIdsByName = QuestieBuildReverseNameLookup(QuestieTurtleItemNames)
    QuestieUnitIdsByName = QuestieBuildMergedReverseNameLookup(QuestieVanillaUnitNames, QuestieTurtleUnitNames)
    QuestieObjectIdsByName = QuestieBuildMergedReverseNameLookup(QuestieVanillaObjectNames, QuestieTurtleObjectNames)
    QuestieItemIdsByName = QuestieBuildMergedReverseNameLookup(QuestieVanillaItemNames, QuestieTurtleItemNames)
    QuestieQuestIdsByTitleAndObjectives = QuestieBuildQuestNameLookup()

    if QuestieNewObjects then
        for objectId, objectData in pairs(QuestieNewObjects) do
            local objectName = objectData and objectData.name
            if objectName and objectName ~= "" then
                if QuestieVanillaObjectIdsByName[objectName] == nil then
                    QuestieVanillaObjectIdsByName[objectName] = {}
                end
                QuestieAppendUniqueId(QuestieVanillaObjectIdsByName[objectName], objectId)
                if QuestieObjectIdsByName[objectName] == nil then
                    QuestieObjectIdsByName[objectName] = {}
                end
                QuestieAppendUniqueId(QuestieObjectIdsByName[objectName], objectId)
            end
        end
    end

    QuestieQuestMetaById = {}
    QuestieQuestGroupMembers = {}
    QuestieQuestGroupIdByQuestId = {}
    QuestieZoneLevelMap = {}

    for _, questId in ipairs(QuestieGetAllQuestIds()) do
        local info = QuestieGetQuestNameInfo(questId)
        local questData = QuestieGetQuestById(questId)

        if info and info.title and info.title ~= "" and questData then
            local questMeta = QuestieBuildQuestMeta(questId, questData, info)
            local groupId = questMeta.groupId

            QuestieQuestMetaById[questId] = questMeta
            QuestieQuestGroupIdByQuestId[questId] = groupId

            if QuestieQuestGroupMembers[groupId] == nil then
                QuestieQuestGroupMembers[groupId] = {}
            end
            table.insert(QuestieQuestGroupMembers[groupId], questId)
        end
    end

    for _, questIds in pairs(QuestieQuestGroupMembers) do
        table.sort(questIds)
    end

    for questId, questMeta in pairs(QuestieQuestMetaById) do
        local locationMeta, mapIds = QuestieGetQuestStartLocationsById(questId)
        for mapId in pairs(mapIds) do
            addQuestToZoneLevelMap(mapId, questId, questMeta, locationMeta)
        end
    end

    if DEFAULT_CHAT_FRAME and DEFAULT_CHAT_FRAME.AddMessage then
        DEFAULT_CHAT_FRAME:AddMessage("Compiled AvailableQuests in " .. math.floor((GetTime() - buildStart) * 1000) .. "ms")
        DEFAULT_CHAT_FRAME:AddMessage("Questie questId lookup tables built.")
    end

    QuestieLegacyQuestTitleIndex = nil
    QuestieLegacyQuestMetaByHash = nil
end

function QuestieGetQuestIdByItemObjective(itemId)
    if not QuestieQuestMetaById then
        return nil
    end

    for questId in pairs(QuestieQuestMetaById) do
        local questData = QuestieGetQuestById(questId)
        if questData and questData.objectiveItems then
            for _, objectiveItemId in ipairs(questData.objectiveItems) do
                if objectiveItemId == itemId then
                    return questId
                end
            end
        end
    end

    return nil
end

QuestieBuildStructuredQuestTables()
