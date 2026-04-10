---------------------------------------------------------------------------------------------------
-- Name: QuestieQuest
-- Description: Handles quest-log resolution, quest runtime state, and objective path building.
---------------------------------------------------------------------------------------------------

local QGet_TitleText = GetTitleText;
local QGet_QuestLogTitle = GetQuestLogTitle;
local QGet_NumQuestLeaderBoards = GetNumQuestLeaderBoards;
local QGet_QuestLogLeaderBoard = GetQuestLogLeaderBoard;
local QGet_QuestLogQuestText = GetQuestLogQuestText;
local QGet_NumQuestLogEntries = GetNumQuestLogEntries;
local QGet_QuestLogSelection = GetQuestLogSelection;
local QSelect_QuestLogEntry = SelectQuestLogEntry;

local QuestieQuestLogIndexById = {};
local LastQuestLogQuestIds = nil;
local LastQuestLogCount = 0;

QuestieObjectiveSnapshotsByQuestId = nil;
QuestAbandonOnAccept = nil;
QuestAbandonWithItemsOnAccept = nil;
QuestRewardCompleteButton = nil;
QuestProgressCompleteButton = nil;
QuestDetailAcceptButton = nil;
Questie.lastCollapsedCount = 0;
Questie.collapsedThisRun = false;
QUESTIE_LAST_UPDATECACHE = GetTime();

local QuestieDeformat = AceLibrary and AceLibrary:HasInstance("Deformat-2.0") and AceLibrary("Deformat-2.0") or nil;

local function QuestieIsValidQuestLogId(questLogId)
    local numEntries = QGet_NumQuestLogEntries()
    return type(questLogId) == "number" and questLogId > 0 and questLogId <= numEntries
end

local function QuestieGetQuestIdByRuntimeName(questName)
    for questId, runtime in pairs(QuestieQuestRuntimeById) do
        if runtime.questName == questName then
            return questId
        end
    end

    return nil
end

local function QuestieClearQuestRuntime(questId)
    QuestieQuestRuntimeById[questId] = nil
    if QuestieHandledQuests then
        QuestieHandledQuests[questId] = nil
    end
    if QuestieObjectiveSnapshotsByQuestId then
        QuestieObjectiveSnapshotsByQuestId[questId] = nil
    end
end

local function QuestiePathHasData(path)
    return path and next(path) ~= nil
end

local function QuestieMergePathTables(target, source)
    for key, value in pairs(source) do
        if key == "locations" then
            if target.locations == nil then
                target.locations = {}
            end
            for _, location in ipairs(value) do
                table.insert(target.locations, location)
            end
        elseif type(value) == "table" then
            if target[key] == nil then
                target[key] = deepcopy(value)
            else
                QuestieMergePathTables(target[key], value)
            end
        else
            target[key] = value
        end
    end
end

local function QuestieBuildEntityPathByIds(entityType, entityIds, questId)
    local path = {}

    for _, entityId in ipairs(entityIds) do
        local locations = nil
        if entityType == "monster" then
            locations = QuestieGetUnitLocationsById(entityId, questId)
        elseif entityType == "object" then
            locations = QuestieGetObjectLocationsById(entityId, questId)
        end

        if locations and QuestiePathHasData(locations) then
            QuestieMergePathTables(path, locations)
        end
    end

    return path
end

local function QuestieGetObjectiveItemRequirementPath(itemIds, questId)
    local questData = questId and QuestieGetQuestById and QuestieGetQuestById(questId) or nil
    if not questData or not questData.objectiveItemRequirements then
        return {}
    end

    local path = {}
    for _, itemId in ipairs(itemIds or {}) do
        local requirement = questData.objectiveItemRequirements[itemId]
        if requirement then
            if requirement.units then
                local unitPath = QuestieBuildEntityPathByIds("monster", requirement.units, questId)
                if QuestiePathHasData(unitPath) then
                    QuestieMergePathTables(path, unitPath)
                end
            end

            if requirement.objects then
                local objectPath = QuestieBuildEntityPathByIds("object", requirement.objects, questId)
                if QuestiePathHasData(objectPath) then
                    QuestieMergePathTables(path, objectPath)
                end
            end
        end
    end

    return path
end

local function QuestieGetQuestObjectiveIds(questId, objectiveType)
    local questData = questId and QuestieGetQuestById and QuestieGetQuestById(questId) or nil
    if not questData then
        return nil
    end

    if objectiveType == "monster" then
        return questData.objectiveUnits
    elseif objectiveType == "object" then
        return questData.objectiveObjects
    elseif objectiveType == "item" then
        return questData.objectiveItems
    end

    return nil
end

local function QuestieFilterObjectiveEntityIds(entityIds, questObjectiveIds)
    if not questObjectiveIds or table.getn(questObjectiveIds) == 0 then
        return entityIds
    end

    local allowedIds = {}
    for _, entityId in ipairs(questObjectiveIds) do
        allowedIds[entityId] = true
    end

    local filteredIds = {}
    for _, entityId in ipairs(entityIds or {}) do
        if allowedIds[entityId] then
            table.insert(filteredIds, entityId)
        end
    end

    if table.getn(filteredIds) > 0 then
        return filteredIds
    end

    if table.getn(entityIds or {}) == 0 and table.getn(questObjectiveIds) == 1 then
        return { questObjectiveIds[1] }
    end

    return entityIds
end

local function QuestieGetObjectiveEntityData(objectiveName, objectiveType, questId)
    local questObjectiveIds = QuestieGetQuestObjectiveIds(questId, objectiveType)

    if objectiveType == "monster" then
        return "monster", QuestieFilterObjectiveEntityIds(QuestieGetUnitIdsByName(objectiveName, questId), questObjectiveIds)
    elseif objectiveType == "object" then
        return "object", QuestieFilterObjectiveEntityIds(QuestieGetObjectIdsByName(objectiveName, questId), questObjectiveIds)
    elseif objectiveType == "item" then
        return "item", QuestieFilterObjectiveEntityIds(QuestieGetItemIdsByName(objectiveName, questId), questObjectiveIds)
    end

    return nil, {}
end

local function QuestieTrimText(text)
    return string.gsub(text or "", "^%s*(.-)%s*$", "%1")
end

local function QuestieAppendUniqueText(target, value)
    value = QuestieTrimText(value)
    if value == "" then
        return
    end

    for _, existing in ipairs(target) do
        if existing == value then
            return
        end
    end

    table.insert(target, value)
end

local function QuestieBuildObjectiveTextContexts(objectiveText, objectiveName)
    local contexts = {}
    if not objectiveText or objectiveText == "" then
        return contexts
    end

    if objectiveName and objectiveName ~= "" then
        local objectiveNames = { objectiveName }
        if string.sub(objectiveName, -1) == "]" then
            local strlen = string.len(objectiveName)
            QuestieAppendUniqueText(objectiveNames, string.sub(objectiveName, 1, strlen - 4))
        end

        for _, name in ipairs(objectiveNames) do
            local startPos, endPos = string.find(objectiveText, name, 1, true)
            if startPos then
                local contextEnd = math.min(string.len(objectiveText), endPos + 160)
                QuestieAppendUniqueText(contexts, string.sub(objectiveText, math.max(1, startPos - 48), contextEnd))
                QuestieAppendUniqueText(contexts, string.sub(objectiveText, math.max(1, startPos - 96), contextEnd))
            end
        end
    end

    QuestieAppendUniqueText(contexts, objectiveText)
    return contexts
end

local function QuestieBuildSourceNameCandidates(sourceName)
    local candidates = {}
    local trimmed = QuestieTrimText(sourceName)
    if trimmed == "" then
        return candidates
    end

    QuestieAppendUniqueText(candidates, trimmed)
    QuestieAppendUniqueText(candidates, string.gsub(trimmed, "^[Tt]he%s+", ""))
    QuestieAppendUniqueText(candidates, string.gsub(trimmed, "'s$", ""))
    QuestieAppendUniqueText(candidates, string.gsub(string.gsub(trimmed, "^[Tt]he%s+", ""), "'s$", ""))
    local _, _, chinesePossessive = string.find(trimmed, ".*的(.*)")
    QuestieAppendUniqueText(candidates, chinesePossessive)

    local singular = string.gsub(trimmed, "s$", "")
    if singular ~= trimmed then
        QuestieAppendUniqueText(candidates, singular)
    end

    return candidates
end

local function QuestieGetObjectivePathFromQuestText(objectiveName, questId)
    local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
    local contexts = QuestieBuildObjectiveTextContexts(questMeta and questMeta.objectivesText or nil, objectiveName)
    local patterns = {
        "from%s+(.-)%s+at%s+",
        "from%s+(.-)%s+in%s+",
        "from%s+(.-)%s+near%s+",
        "from%s+(.-)%s+inside%s+",
        "from%s+(.-)%s+within%s+",
        "from%s+(.-)%s+for%s+",
        "from%s+(.-)[,%.;\n]",
        "从(.-)那里",
        "从(.-)处",
        "从(.-)获取",
        "从(.-)获得",
        "与(.-)交谈",
        "和(.-)交谈",
        "同(.-)交谈",
        "向(.-)索取",
    }

    for _, context in ipairs(contexts) do
        for _, pattern in ipairs(patterns) do
            local _, _, sourceName = string.find(context, pattern)
            if sourceName and sourceName ~= "" then
                for _, candidate in ipairs(QuestieBuildSourceNameCandidates(sourceName)) do
                    local unitIds = QuestieGetUnitIdsByName(candidate, questId)
                    if table.getn(unitIds) > 0 then
                        local path = QuestieBuildEntityPathByIds("monster", unitIds, questId)
                        if QuestiePathHasData(path) then
                            return path, "monster", unitIds
                        end
                    end

                    local objectIds = QuestieGetObjectIdsByName(candidate, questId)
                    if table.getn(objectIds) > 0 then
                        local path = QuestieBuildEntityPathByIds("object", objectIds, questId)
                        if QuestiePathHasData(path) then
                            return path, "object", objectIds
                        end
                    end
                end
            end
        end
    end

    return nil, nil, nil
end

local function QuestieGetObjectivePath(objectiveName, objectiveType, questId, objectiveIndex)
    local entityType, entityIds = QuestieGetObjectiveEntityData(objectiveName, objectiveType, questId)
    local path = {}

    if objectiveType == "monster" or objectiveType == "object" then
        path = QuestieBuildEntityPathByIds(entityType, entityIds, questId)
    elseif objectiveType == "item" then
        local hintedPath, hintedEntityType, hintedEntityIds = nil, nil, nil
        if questId then
            hintedPath, hintedEntityType, hintedEntityIds = QuestieGetObjectivePathFromQuestText(objectiveName, questId)
        end

        if hintedPath and QuestiePathHasData(hintedPath) then
            path = hintedPath
            entityType = hintedEntityType
            entityIds = hintedEntityIds
        else
            for _, itemId in ipairs(entityIds) do
                local itemPath = QuestieGetItemLocationsById(itemId, questId)
                if itemPath and QuestiePathHasData(itemPath) then
                    QuestieMergePathTables(path, itemPath)
                end
            end

            if not QuestiePathHasData(path) and questId then
                local requirementPath = QuestieGetObjectiveItemRequirementPath(entityIds, questId)
                if QuestiePathHasData(requirementPath) then
                    path = requirementPath
                end
            end

            if not QuestiePathHasData(path) and questId and objectiveIndex and QuestieGetQuestObjectiveCoords then
                path = QuestieGetQuestObjectiveCoords(questId, objectiveIndex) or {}
            end
        end
    elseif objectiveType == "event" then
        if questId and objectiveIndex and QuestieGetQuestObjectiveCoords then
            path = QuestieGetQuestObjectiveCoords(questId, objectiveIndex) or {}
        end
    end

    return path, entityType, entityIds
end

function Questie:ParseObjectiveName(desc, objType)
    if QuestieDeformat then
        local name;
        local have;
        local need;

        if objType == "monster" then
            name, have, need = QuestieDeformat(desc, QUEST_MONSTERS_KILLED);
            if not name then
                name, have, need = QuestieDeformat(desc, QUEST_OBJECTS_FOUND);
            end
        elseif objType == "item" or objType == "object" then
            name, have, need = QuestieDeformat(desc, QUEST_OBJECTS_FOUND);
        end

        if name then
            return name;
        end
    end

    local splitIndex = findLast(desc, ":");
    if splitIndex then
        local objectiveName = string.sub(desc, 1, splitIndex - 1);
        if string.find(objectiveName, " slain") then
            objectiveName = string.sub(objectiveName, 1, string.len(objectiveName) - 6);
        end
        return objectiveName;
    end

    return desc;
end

function Questie:RemoveUniqueSuffix(text)
    if not text then
        return text
    end

    if string.sub(text, -1) == "]" then
        local strlen = string.len(text)
        text = string.sub(text, 1, strlen - 4)
    end

    return text
end

function Questie:GetQuestTooltipObjectiveText(questId, removeUniqueSuffix)
    local questMeta = questId and QuestieQuestMetaById and QuestieQuestMetaById[questId] or nil
    local objectiveText = questMeta and questMeta.objectivesText or nil
    if not objectiveText or objectiveText == "" then
        return nil
    end

    if removeUniqueSuffix then
        objectiveText = Questie:RemoveUniqueSuffix(objectiveText)
    end

    return objectiveText
end

function Questie:GetUnfinishedQuestObjectiveDescriptions(questId, runtimeQuest)
    local lines = {}
    local quest = runtimeQuest or (questId and QuestieQuestRuntimeById and QuestieQuestRuntimeById[questId]) or nil
    if not quest or not quest.objectives then
        return lines
    end

    for _, objective in ipairs(quest.objectives) do
        if objective and not objective.done and objective.desc and objective.desc ~= "" then
            QuestieAppendUniqueText(lines, objective.desc)
        end
    end

    return lines
end

function Questie:AddMissingTooltipFallback(Tooltip)
    Tooltip:AddLine(QL("QUEST_NOT_FOUND"), 1, .8, .8);
    Tooltip:AddLine(QL("BUG_REPORT"), 1, .8, .8);
    Tooltip:AddLine("https://github.com/AeroScripts/QuestieDev/issues", 1, .8, .8);
end

function Questie:ResolveQuestIdFromLogEntryData(questName, objectiveText, level)
    local candidates = QuestieGetQuestCandidateIdsByTitleAndObjectives and QuestieGetQuestCandidateIdsByTitleAndObjectives(questName, objectiveText) or {}
    local playerClass = UnitClass("Player")
    local playerRace = UnitRace("Player")
    local bestQuestId = nil
    local bestScore = nil

    for _, questId in ipairs(candidates) do
        local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
        if questMeta then
            local score = 0

            if questMeta.objectivesText == (objectiveText or "") then
                score = score + 1000
            elseif objectiveText and questMeta.objectivesText and (string.find(objectiveText, questMeta.objectivesText, 1, true) or string.find(questMeta.objectivesText, objectiveText, 1, true)) then
                score = score + 500
            end

            if tostring(questMeta.questLevel) == tostring(level or "") then
                score = score + 250
            end

            if QuestieCheckRequirements(playerClass, playerRace, questMeta.requiredClassMask, questMeta.requiredRaceMask) then
                score = score + 100
            else
                score = score - 100
            end

            if (not questMeta.requiredQuestId) or QuestieQuestStatusById[questMeta.requiredQuestId] == 1 then
                score = score + 25
            end

            if bestScore == nil or score > bestScore or (score == bestScore and (bestQuestId == nil or questId < bestQuestId)) then
                bestQuestId = questId
                bestScore = score
            end
        end
    end

    return bestQuestId
end

function Questie:RefreshQuestLogIndexCache()
    local activeQuests = {}
    local nextQuestLogIndexById = {}
    local prevQuestLogSelection = QGet_QuestLogSelection()
    local id = 1
    local qc = 0
    local numEntries, numQuests = QGet_NumQuestLogEntries()

    while qc < numQuests do
        local questName, level, questTag, isHeader, isCollapsed, isComplete = QGet_QuestLogTitle(id);
        if not isHeader then
            QSelect_QuestLogEntry(id);
            local questText, objectiveText = QGet_QuestLogQuestText();
            local questId = Questie:ResolveQuestIdFromLogEntryData(questName, objectiveText, level)
            if questId then
                nextQuestLogIndexById[questId] = id
                activeQuests[questId] = {
                    ["questId"] = questId,
                    ["logId"] = id,
                    ["questName"] = questName,
                    ["level"] = level,
                    ["questTag"] = questTag,
                    ["isComplete"] = isComplete,
                    ["objectiveText"] = objectiveText,
                }
            end
            qc = qc + 1;
        end
        id = id + 1;
    end

    QSelect_QuestLogEntry(prevQuestLogSelection);
    QuestieQuestLogIndexById = nextQuestLogIndexById
    LastQuestLogCount = numQuests

    return activeQuests, numQuests
end

function Questie:GetQuestLogIndexById(questId)
    local questLogId = QuestieQuestLogIndexById[questId]
    local numEntries, numQuests = QGet_NumQuestLogEntries()

    if QUESTIE_UPDATE_EVENT or numQuests ~= LastQuestLogCount or not QuestieIsValidQuestLogId(questLogId) then
        QUESTIE_UPDATE_EVENT = 0
        Questie:RefreshQuestLogIndexCache()
        questLogId = QuestieQuestLogIndexById[questId]
    end

    return questLogId
end

function Questie:BuildQuestRuntimeEntry(questId, logId)
    local runtime = QuestieQuestRuntimeById[questId] or {}
    local questName, level, questTag, isHeader, isCollapsed, isComplete = QGet_QuestLogTitle(logId);

    runtime.questId = questId
    runtime.questName = questName
    runtime.level = level
    runtime.questTag = questTag
    runtime.logId = logId
    runtime.isComplete = isComplete
    runtime.objectiveCount = QGet_NumQuestLeaderBoards(logId)
    runtime.objectives = {}
    runtime.tracked = runtime.tracked == true

    for index = 1, runtime.objectiveCount do
        local desc, objectiveType, done = QGet_QuestLogLeaderBoard(index, logId);
        runtime.objectives[index] = {
            ["desc"] = desc,
            ["type"] = objectiveType,
            ["done"] = done,
            ["notes"] = {},
        }
    end

    QuestieQuestRuntimeById[questId] = runtime
    return runtime
end

QuestAbandonOnAccept = StaticPopupDialogs["ABANDON_QUEST"].OnAccept;
StaticPopupDialogs["ABANDON_QUEST"].OnAccept = function()
    local questId = QuestieGetQuestIdByRuntimeName(GetAbandonQuestName())
    if questId then
        QuestieQuestStatusById[questId] = -1
        QuestieClearQuestRuntime(questId)
        RemoveCrazyArrow(questId)
    end
    QuestAbandonOnAccept()
end

QuestAbandonWithItemsOnAccept = StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept;
StaticPopupDialogs["ABANDON_QUEST_WITH_ITEMS"].OnAccept = function()
    local questId = QuestieGetQuestIdByRuntimeName(GetAbandonQuestName())
    if questId then
        QuestieQuestStatusById[questId] = -1
        QuestieClearQuestRuntime(questId)
        RemoveCrazyArrow(questId)
    end
    QuestAbandonWithItemsOnAccept()
end

function Questie:OnQuestProgress()
    local questTitle = QGet_TitleText();
    local _, _, _, questName = string.find(questTitle, "%[(.+)%] (.+)");
    if questName == nil then
        questName = QGet_TitleText();
    end

    local questId = QuestieGetQuestIdByRuntimeName(questName)
    if questId and QuestieQuestRuntimeById[questId] then
        QuestieQuestRuntimeById[questId].numQuestItems = GetNumQuestItems()
    end
end

function Questie:CheckPlayerInventory()
    local totalSlots = 0;
    local usedSlots = 0;

    for bag = 0, 4 do
        local size = GetContainerNumSlots(bag);
        if size and size > 0 then
            totalSlots = totalSlots + size;
            for slot = 1, size do
                if GetContainerItemInfo(bag, slot) then
                    usedSlots = usedSlots + 1;
                end
            end
        end
    end

    return totalSlots - usedSlots
end

function Questie:MarkQuestAsFinished()
    local rewards = GetNumQuestRewards();
    local choices = GetNumQuestChoices();

    if QuestFrameRewardPanel.itemChoice == 0 and choices > 0 then
        return false;
    end

    if choices > 0 then
        rewards = rewards + 1;
    end

    local questTitle = QGet_TitleText();
    local _, _, _, questName = string.find(questTitle, "%[(.+)%] (.+)");
    if questName == nil then
        questName = QGet_TitleText();
    end

    local questId = QuestieGetQuestIdByRuntimeName(questName)
    if not questId then
        return false
    end

    local runtime = QuestieQuestRuntimeById[questId]
    if runtime and rewards > 0 and Questie:CheckPlayerInventory() < (rewards - (runtime.numQuestItems or 0)) then
        return false
    end

    QuestieQuestStatusById[questId] = 1
    QuestieCompletedQuestMessages[questName] = 1
    QuestieClearQuestRuntime(questId)
    RemoveCrazyArrow(questId)
    return true
end

QGetQuestReward = GetQuestReward;
GetQuestReward = function(choice)
    Questie:MarkQuestAsFinished();
    QGetQuestReward(choice);
end

QuestRewardCompleteButton = QuestRewardCompleteButton_OnClick;
QuestRewardCompleteButton_OnClick = function()
    Questie:MarkQuestAsFinished();
    QuestRewardCompleteButton();
end

QuestDetailAcceptButton = QuestDetailAcceptButton_OnClick;
function QuestDetailAcceptButton_OnClick()
    Questie:CheckQuestLogStatus();
    QuestDetailAcceptButton();
end

function Questie:DetectQuestItem(itemName)
    for _, runtime in pairs(QuestieQuestRuntimeById) do
        for _, objective in ipairs(runtime.objectives or {}) do
            if objective.desc then
                local _, _, questItem, itemHave, itemNeed = string.find(objective.desc, "(.+)%: (%d+)/(%d+)");
                if itemName == questItem and itemHave ~= itemNeed then
                    return true
                end
            end
        end
    end

    return false
end

function Questie:ParseQuestLoot(arg1)
    local msg, item, loot
    if string.find(arg1, "(You receive loot%:) (.+)") then
        _, _, msg, item = string.find(arg1, "(You receive loot%:) (.+)");
    elseif string.find(arg1, "(Received item%:) (.+)") then
        _, _, msg, item = string.find(arg1, "(Received item%:) (.+)");
    elseif string.find(arg1, "(You receive item%:) (.+)") then
        _, _, msg, item = string.find(arg1, "(You receive item%:) (.+)");
    end

    if item then
        _, _, loot = string.find(item, "%[(.+)%].+");
        if Questie:DetectQuestItem(loot) then
            Questie:CheckQuestLogStatus();
        end
    end
end

function Questie:finishAndRecurse(questId)
    if not questId then
        return
    end

    if QuestieQuestStatusById[questId] ~= 1 then
        QuestieQuestStatusById[questId] = 1
    end

    QuestieClearQuestRuntime(questId)
    RemoveCrazyArrow(questId)

    local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
    if questMeta and questMeta.requiredQuestId and QuestieQuestStatusById[questMeta.requiredQuestId] ~= 1 then
        Questie:finishAndRecurse(questMeta.requiredQuestId)
    end
end

function Questie:UpdateGameClientCache(force)
    if IsQuestieActive == false then
        return
    end

    local activeQuests = Questie:RefreshQuestLogIndexCache()
    for questId, questInfo in pairs(activeQuests) do
        QuestieQuestStatusById[questId] = 0
        local shouldRefresh = force or QuestieQuestRuntimeById[questId] == nil or (QuestieHandledQuests and QuestieHandledQuests[questId] == nil)
        if shouldRefresh then
            Questie:BuildQuestRuntimeEntry(questId, questInfo.logId)
            Questie:AddQuestToMap(questId, force and true or nil)
            QuestieTracker:addQuestToTrackerCache(questId, questInfo.logId, questInfo.level)
        end
    end
end

function Questie:CheckQuestLog()
    local activeQuests = Questie:RefreshQuestLogIndexCache()
    local changed = false

    if not LastQuestLogQuestIds then
        for questId, questInfo in pairs(activeQuests) do
            QuestieQuestStatusById[questId] = 0
            if QuestieQuestRuntimeById[questId] == nil or (QuestieHandledQuests and QuestieHandledQuests[questId] == nil) then
                Questie:BuildQuestRuntimeEntry(questId, questInfo.logId)
                Questie:AddQuestToMap(questId)
                QuestieTracker:addQuestToTrackerCache(questId, questInfo.logId, questInfo.level)
            end
        end

        LastQuestLogQuestIds = activeQuests
        QUESTIE_LAST_UPDATE_FINISHED = GetTime()
        return
    end

    for questId, questInfo in pairs(activeQuests) do
        QuestieQuestStatusById[questId] = 0
        if LastQuestLogQuestIds[questId] == nil then
            Questie:BuildQuestRuntimeEntry(questId, questInfo.logId)
            Questie:AddQuestToMap(questId)
            QuestieTracker:addQuestToTrackerCache(questId, questInfo.logId, questInfo.level)
            if AUTO_QUEST_WATCH == "1" then
                AddQuestWatch(questInfo.logId)
            end
            changed = true
        end
    end

    for questId in pairs(LastQuestLogQuestIds) do
        if activeQuests[questId] == nil then
            Questie:RemoveQuestFromMap(questId)
            QuestieTracker:removeQuestFromTracker(questId)
            if QuestieQuestStatusById[questId] ~= 1 then
                QuestieQuestStatusById[questId] = nil
            end
            QuestieClearQuestRuntime(questId)
            changed = true
        end
    end

    LastQuestLogQuestIds = activeQuests
    if changed then
        Questie:RefreshQuestStatus()
    else
        Questie:AddEvent("SYNCLOG", 0.2);
        Questie:AddEvent("DRAWNOTES", 0.4);
        Questie:AddEvent("TRACKER", 0.6);
    end

    QUESTIE_LAST_UPDATE_FINISHED = GetTime()
end

function Questie:UpdateQuests(force)
    if QuestieObjectiveSnapshotsByQuestId == nil then
        QuestieObjectiveSnapshotsByQuestId = {}
    end

    local foundChange = nil
    local activeQuests = Questie:RefreshQuestLogIndexCache()
    local prevQuestLogSelection = QGet_QuestLogSelection()

    for questId, questInfo in pairs(activeQuests) do
        QSelect_QuestLogEntry(questInfo.logId)
        local objectiveCount = QGet_NumQuestLeaderBoards(questInfo.logId)
        local snapshot = QuestieObjectiveSnapshotsByQuestId[questId] or {}
        local changed = force and true or false

        for objectiveIndex = 1, objectiveCount do
            local desc, objectiveType, done = QGet_QuestLogLeaderBoard(objectiveIndex)
            local previous = snapshot[objectiveIndex]
            if not previous or previous.desc ~= desc or previous.objectiveType ~= objectiveType or previous.done ~= done then
                changed = true
            end
            snapshot[objectiveIndex] = {
                ["desc"] = desc,
                ["objectiveType"] = objectiveType,
                ["done"] = done,
            }
        end

        for objectiveIndex = objectiveCount + 1, table.getn(snapshot) do
            snapshot[objectiveIndex] = nil
            changed = true
        end

        QuestieObjectiveSnapshotsByQuestId[questId] = snapshot
        if changed then
            foundChange = true
            Questie:BuildQuestRuntimeEntry(questId, questInfo.logId)
            Questie:AddQuestToMap(questId, true)
            QuestieTracker:updateTrackerCache(questId, questInfo.logId, questInfo.level)
        end
    end

    QSelect_QuestLogEntry(prevQuestLogSelection)
    return foundChange
end

function Questie:GetQuestObjectivePaths(questId, questLogId)
    local objectivePaths = {}
    local prevQuestLogSelection = QGet_QuestLogSelection()
    local logId = questLogId or Questie:GetQuestLogIndexById(questId)

    if not QuestieIsValidQuestLogId(logId) then
        return objectivePaths
    end

    QSelect_QuestLogEntry(logId)
    local objectiveCount = QGet_NumQuestLeaderBoards(logId)

    for objectiveIndex = 1, objectiveCount do
        local desc, objectiveType, done = QGet_QuestLogLeaderBoard(objectiveIndex)
        if objectiveType then
            local objectiveName = Questie:ParseObjectiveName(desc, objectiveType)
            local path, entityType, entityIds = QuestieGetObjectivePath(objectiveName, objectiveType, questId, objectiveIndex)
            objectivePaths[objectiveIndex] = {
                ["path"] = path,
                ["done"] = done,
                ["type"] = objectiveType,
                ["name"] = objectiveName,
                ["desc"] = desc,
                ["entityType"] = entityType,
                ["entityIds"] = entityIds,
            }
        end
    end

    QSelect_QuestLogEntry(prevQuestLogSelection)
    return objectivePaths
end

function Questie:GetLocalizedQuestName(questId)
    if QuestieQuestRuntimeById[questId] and QuestieQuestRuntimeById[questId].questName then
        return QuestieQuestRuntimeById[questId].questName
    end

    local questLogId = Questie:GetQuestLogIndexById(questId)
    if QuestieIsValidQuestLogId(questLogId) then
        local questName = QGet_QuestLogTitle(questLogId)
        if questName then
            return questName
        end
    end

    local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
    return questMeta and questMeta.name or nil
end

function Questie:IsQuestFinished(questId)
    local logId = Questie:GetQuestLogIndexById(questId)
    if not QuestieIsValidQuestLogId(logId) then
        return false
    end

    local prevQuestLogSelection = QGet_QuestLogSelection()
    local questName, level, questTag, isHeader, isCollapsed, isComplete = QGet_QuestLogTitle(logId)
    if not questName or isHeader then
        return false
    end

    QSelect_QuestLogEntry(logId)
    local objectiveCount = QGet_NumQuestLeaderBoards()
    local done = true
    for objectiveIndex = 1, objectiveCount do
        local desc, objectiveType, objectiveDone = QGet_QuestLogLeaderBoard(objectiveIndex)
        if not objectiveDone then
            done = nil
        end
    end
    QSelect_QuestLogEntry(prevQuestLogSelection)

    if done then
        return {
            ["questId"] = questId,
            ["name"] = questName,
            ["level"] = level,
        }
    end

    return nil
end

RaceBitIndexTable = {
    ['human'] = 1,
    ['orc'] = 2,
    ['dwarf'] = 3,
    ['nightelf'] = 4,
    ['night elf'] = 4,
    ['scourge'] = 5,
    ['undead'] = 5,
    ['tauren'] = 6,
    ['gnome'] = 7,
    ['troll'] = 8,
    ['goblin'] = 9
};

ClassBitIndexTable = {
    ['warrior'] = 1,
    ['paladin'] = 2,
    ['hunter'] = 3,
    ['rogue'] = 4,
    ['priest'] = 5,
    ['shaman'] = 7,
    ['mage'] = 8,
    ['warlock'] = 9,
    ['druid'] = 11
};

function unpackBinary(val)
    local ret = {};
    for q = 0, 16 do
        if bit.band(bit.rshift(val, q), 1) == 1 then
            table.insert(ret, true);
        else
            table.insert(ret, false);
        end
    end
    return ret;
end

function QuestieCheckRequirements(class, race, dbClass, dbRace)
    local valid = true;
    if race and dbRace and not (dbRace == 0) then
        local racemap = unpackBinary(dbRace);
        valid = racemap[RaceBitIndexTable[strlower(race)]];
    end
    if class and dbClass and valid and not (dbRace == 0) then
        local classmap = unpackBinary(dbClass);
        valid = classmap[ClassBitIndexTable[strlower(class)]];
    end
    return valid;
end

local function QuestieScoreAvailableQuest(questId)
    local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
    if not questMeta then
        return -1
    end

    local score = 0
    if questMeta.requiredClassMask and questMeta.requiredClassMask ~= 0 then
        score = score + 20
    end
    if questMeta.requiredRaceMask and questMeta.requiredRaceMask ~= 0 then
        score = score + 20
    end
    if questMeta.requiredQuestId then
        score = score + 10
    end

    return score
end

local function QuestieIsEventQuest(questMeta)
    return questMeta ~= nil and questMeta.eventId ~= nil
end

local function QuestieIsQuestAvailableToPlayer(questId, levelFrom, levelTo)
    local questMeta = QuestieQuestMetaById and QuestieQuestMetaById[questId]
    local playerClass = UnitClass("Player")
    local playerRace = UnitRace("Player")
    if not questMeta then
        return false
    end

    local recommendedLevel = QuestieGetQuestDisplayLevel(questMeta)
    if QuestieConfig.minLevelFilter and recommendedLevel < levelFrom then
        return false
    end
    if QuestieConfig.maxLevelFilter and recommendedLevel > levelTo then
        return false
    end
    if not QuestieCheckRequirements(playerClass, playerRace, questMeta.requiredClassMask, questMeta.requiredRaceMask) then
        return false
    end
    if (not QuestieConfig.showEventQuests) and QuestieIsEventQuest(questMeta) then
        return false
    end
    if questMeta.requiredSkillId and not QuestieConfig.showProfessionQuests then
        return false
    end
    if QuestieQuestStatusById[questId] ~= nil then
        return false
    end
    if QuestieQuestRuntimeById[questId] ~= nil then
        return false
    end
    if questMeta.requiredQuestId and QuestieQuestStatusById[questMeta.requiredQuestId] ~= 1 then
        return false
    end

    return true
end

function Questie:GetAvailableQuestIds(levelFrom, levelTo)
    local mapId = GetCurrentMapID();
    local availableByGroup = {};

    for level = 0, 100 do
        if QuestieZoneLevelMap[mapId] and QuestieZoneLevelMap[mapId][level] then
            for questId, locationMeta in pairs(QuestieZoneLevelMap[mapId][level]) do
                if QuestieIsQuestAvailableToPlayer(questId, levelFrom, levelTo) then
                    local groupId = QuestieQuestGroupIdByQuestId[questId] or tostring(questId)
                    local score = QuestieScoreAvailableQuest(questId)
                    local current = availableByGroup[groupId]
                    if not current or score > current.score or (score == current.score and questId < current.questId) then
                        availableByGroup[groupId] = {
                            ["questId"] = questId,
                            ["locationMeta"] = locationMeta,
                            ["score"] = score,
                        }
                    end
                end
            end
        end
    end

    local quests = {}
    for _, entry in pairs(availableByGroup) do
        quests[entry.questId] = entry.locationMeta
    end

    return quests
end
