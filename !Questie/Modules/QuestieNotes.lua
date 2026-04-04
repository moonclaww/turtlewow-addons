---------------------------------------------------------------------------------------------------
-- Name: QuestieNotes
-- Description: Handles all the quest map notes
---------------------------------------------------------------------------------------------------
--///////////////////////////////////////////////////////////////////////////////////////////////--
---------------------------------------------------------------------------------------------------
-- Local Vars
---------------------------------------------------------------------------------------------------
local AllFrames = {};
local FramePool = {};
local Cluster = {};
local LastContinent = nil;
local LastZone = nil;
local Dewdrop = AceLibrary("Dewdrop-2.0");
local specialSources = { ["openedby"] = 1, };
local QGet_QuestLogTitle = GetQuestLogTitle;
local QGet_NumQuestLeaderBoards = GetNumQuestLeaderBoards;
local QGet_NumQuestLogEntries = GetNumQuestLogEntries;
local QSelect_QuestLogEntry = SelectQuestLogEntry;
local QGet_QuestLogLeaderBoard = GetQuestLogLeaderBoard;
local QGet_QuestLogQuestText = GetQuestLogQuestText;
local QGet_TitleText = GetTitleText;
local QGet_QuestLogSelection = GetQuestLogSelection;
local QuestieMapRegistry = AceLibrary("MapRegistry-1.0");
local questiePathSourceTypes = {
    ["drop"] = 1,
    ["rewardedby"] = 1,
    ["contained"] = 1,
    ["contained_id"] = 1,
    ["created"] = 1,
    ["containedi"] = 1,
    ["openedby"] = 1,
    ["transforms"] = 1,
    ["transformedby"] = 1,
};

local function QuestieIsPathSourceType(sourceType)
    return questiePathSourceTypes[sourceType] == 1
end

local function QuestieBuildEntityIdSet(entityIds)
    local entityIdSet = {}
    if entityIds then
        for _, entityId in ipairs(entityIds) do
            entityIdSet[entityId] = true
        end
    end
    return entityIdSet
end

local function QuestieEscapeLuaPattern(text)
    if not text then
        return text
    end

    return string.gsub(text, "([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
end

local function QuestieGetSourceDisplayName(sourceKey, sourcePath)
    if sourcePath and sourcePath.displayName and sourcePath.displayName ~= "" then
        return sourcePath.displayName
    end

    return sourceKey
end

local function QuestiePathMatchesEntity(path, entityType, entityIdSet)
    if not path or not entityType or not entityIdSet or not next(entityIdSet) then
        return false
    end

    if path.entityType == entityType and path.entityId and entityIdSet[path.entityId] then
        return true
    end

    for sourceType, sources in pairs(path) do
        if QuestieIsPathSourceType(sourceType) then
            for _, sourcePath in pairs(sources) do
                if QuestiePathMatchesEntity(sourcePath, entityType, entityIdSet) then
                    return true
                end
            end
        end
    end

    return false
end

local function QuestieObjectiveMatchesEntity(objectiveInfo, hoverInfo)
    if not objectiveInfo or not hoverInfo then
        return false
    end

    if objectiveInfo.entityType == hoverInfo.entityType then
        for _, entityId in ipairs(objectiveInfo.entityIds or {}) do
            if hoverInfo.entityIds[entityId] then
                return true
            end
        end
    end

    return QuestiePathMatchesEntity(objectiveInfo.path, hoverInfo.entityType, hoverInfo.entityIds)
end

local function QuestieBuildTooltipHoverTargets(monsterName, tooltipName)
    local hoverTargets = {}

    if monsterName then
        local entityIds = QuestieBuildEntityIdSet(QuestieGetUnitIdsByName(monsterName))
        if next(entityIds) then
            table.insert(hoverTargets, {
                ["entityType"] = "monster",
                ["entityIds"] = entityIds,
                ["label"] = monsterName,
            })
        end
    end

    if tooltipName then
        local objectIds = QuestieBuildEntityIdSet(QuestieGetObjectIdsByName(tooltipName))
        if next(objectIds) then
            table.insert(hoverTargets, {
                ["entityType"] = "object",
                ["entityIds"] = objectIds,
                ["label"] = tooltipName,
            })
        end
        local itemIds = QuestieBuildEntityIdSet(QuestieGetItemIdsByName(tooltipName))
        if next(itemIds) then
            table.insert(hoverTargets, {
                ["entityType"] = "item",
                ["entityIds"] = itemIds,
                ["label"] = tooltipName,
            })
        end
    end

    return hoverTargets
end

local function QuestieNotesHasValidQuestLogId(questLogId)
    local numEntries = QGet_NumQuestLogEntries()
    return type(questLogId) == "number" and questLogId > 0 and questLogId <= numEntries
end

local function QuestieGetCurrentMapId()
    if QuestieMapRegistry and QuestieMapRegistry.GetCurrentMapID then
        return QuestieMapRegistry:GetCurrentMapID()
    end
    return nil
end

local function QuestieGetClientZoneForMapId(mapId)
    if QuestieMapRegistry and QuestieMapRegistry.GetClientZone then
        return QuestieMapRegistry:GetClientZone(mapId)
    end
    return nil, nil
end

local function QuestieNormalizeLocationTuple(location)
    if not location then
        return nil
    end

    local normalized = nil
    if QuestieMapRegistry and QuestieMapRegistry.NormalizeLocationTuple then
        normalized = QuestieMapRegistry:NormalizeLocationTuple(location, "vanilla")
    end

    if normalized then
        return normalized
    end

    if location[1] and location[2] and location[3] and table.getn(location) == 3 then
        return { location[1], location[2], location[3] }
    end

    return nil
end
---------------------------------------------------------------------------------------------------
-- Global Vars
---------------------------------------------------------------------------------------------------
QUESTIE_NOTES_MAP_ICON_SCALE = 1.2;
QUESTIE_NOTES_WORLD_MAP_ICON_SCALE = 0.75;
QUESTIE_NOTES_CONTINENT_ICON_SCALE = 1;
QUESTIE_NOTES_MINIMAP_ICON_SCALE = 1.0;
QuestieMapNotes = {};
QuestieUsedNoteFrames = {};
QuestieHandledQuests = {};
QuestieAvailableMapNotes = {};
QuestieCachedMonstersAndObjects = {};
Questie_LastTooltip = GetTime();
QUESTIE_DEBUG_TOOLTIP = nil;
Questie_TooltipCache = {};
CREATED_NOTE_FRAMES = 1;
INIT_POOL_SIZE = 11;
Cluster.__index = Cluster;
__TT_LineCache = {};
UIOpen = false;
QuestieNotes = AceLibrary("AceAddon-2.0"):new("AceHook-2.1")
---------------------------------------------------------------------------------------------------
--Setup Hooks
---------------------------------------------------------------------------------------------------
function QuestieNotes:OnInitialize()
    self:Hook(WorldMapFrame, "Show", "WorldMapFrame_Show", true)
    self:Hook(WorldMapFrame, "SetAlpha", "WorldMapFrame_SetAlpha", true)
end
---------------------------------------------------------------------------------------------------
-- Refreshes Quest Notes
---------------------------------------------------------------------------------------------------
function Questie:RefreshQuestNotes()
    QUESTIE_UPDATE_EVENT = 1;
    if (GetTime() - QUESTIE_LAST_SYNCLOG > 0.1) then
        Questie:AddEvent("SYNCLOG", 0);
        QUESTIE_LAST_SYNCLOG = GetTime();
    else
        QUESTIE_LAST_SYNCLOG = GetTime();
    end
    if (GetTime() - QUESTIE_LAST_DRAWNOTES > 0.1) then
        Questie:AddEvent("DRAWNOTES", 0.2);
        QUESTIE_LAST_DRAWNOTES = GetTime();
    else
        QUESTIE_LAST_DRAWNOTES = GetTime();
    end
    if (GetTime() - QUESTIE_LAST_TRACKER > 0.1) then
        Questie:AddEvent("TRACKER", 0.4);
        QUESTIE_LAST_TRACKER = GetTime();
    else
        QUESTIE_LAST_TRACKER = GetTime();
    end
end
---------------------------------------------------------------------------------------------------
-- Adds quest notes to map
---------------------------------------------------------------------------------------------------
function Questie:AddQuestToMap(questId, redraw)
    if(IsQuestieActive == false) then return; end
    if questId == -1 then return; end
    --Questie:debug_Print("Notes:AddQuestToMap --> Adding Quest to Map [QuestId: "..questId.."]");
    local c, z = GetCurrentMapContinent(), GetCurrentMapZone();
    Questie:RemoveQuestFromMap(questId);
    local objectives = Questie:GetQuestObjectivePaths(questId)
    --Cache code
    local ques = {};
    ques["noteHandles"] = {};
    UsedContinents = {};
    UsedZones = {};
    local Quest = Questie:IsQuestFinished(questId);
    if not (Quest) then
        Questie:debug_Print("Notes:AddQuestToMap --> Display Objective Icons: [QuestId: "..questId.."]");
        for objectiveid, objective in pairs(objectives) do
            if not objective.done then
                local typeToIcon = {
                    ["item"] = "loot",
                    ["event"] = "event",
                    ["monster"] = "slay",
                    ["object"] = "object",
                };
                local defaultIcon = typeToIcon[objective.type];
                local iconMeta = {
                    ["defaultIcon"] = defaultIcon
                };
                Questie:RecursiveCreateNotes(c, z, questId, objective.path, iconMeta, objectiveid);
            end
        end
    else
        --Questie:debug_Print("Notes:AddQuestToMap --> Display Finished Quest Icon: [QuestId: "..questId.."]");
        local addedNote = false
        local questInfo = QuestieQuestMetaById[questId];
        if questInfo ~= nil then
            local finishPath = QuestieGetQuestFinisherLocationsById(questId);
            if(finishPath) then
                local locations = Questie:RecursiveGetPathLocations(finishPath);
                if next(locations) then
                    for i, location in pairs(locations) do
                        local mapId, x, y = location[1], location[2], location[3];
                        Questie:AddNoteToMap(mapId, x, y, "complete", questId, 0);
                        addedNote = true
                    end
                end
            end
        end
        if addedNote == false then
            Questie:debug_Print("AddQuestToMap: ERROR Quest broken! ", Quest["name"], questId, "report on github!")
        end
    end
    --Cache code
    ques["objectives"] = objectives;
    QuestieHandledQuests[questId] = ques;
    if (redraw) then
        Questie:debug_Print("Notes:AddQuestToMap: redraw VAR true --> Questie:RefreshQuestStatus();");
        Questie:RefreshQuestNotes();
    end
end
---------------------------------------------------------------------------------------------------
-- Checks for a quest note in QuestieMapNotes
---------------------------------------------------------------------------------------------------
function Questie:CheckQuestNote(questId)
    for mapId, notes in pairs(QuestieMapNotes) do
        for i, note in pairs(notes) do
            if (note.questId == questId) then
                return true
            end
        end
    end
    return false
end
---------------------------------------------------------------------------------------------------
-- Updates quest notes on map
---------------------------------------------------------------------------------------------------
function Questie:UpdateQuestNotes(questId, redraw)
    if not QuestieHandledQuests[questId] then
        --Questie:debug_Print("UpdateQuestNotes: ERROR! Tried updating a quest not handled. Hash: ", questId);
        return;
    end
    local prevQuestLogSelection = QGet_QuestLogSelection()
    local QuestLogID = Questie:GetQuestLogIndexById(questId);
    if not QuestieNotesHasValidQuestLogId(QuestLogID) then
        QSelect_QuestLogEntry(prevQuestLogSelection)
        Questie:RemoveQuestFromMap(questId, redraw)
        return;
    end
    QSelect_QuestLogEntry(QuestLogID);
    local q, level, questTag, isHeader, isCollapsed, isComplete = QGet_QuestLogTitle(QuestLogID);
    local count =  QGet_NumQuestLeaderBoards();
    local questText, objectiveText = QGet_QuestLogQuestText();
    for k, noteInfo in pairs(QuestieHandledQuests[questId]["noteHandles"]) do
        local noteHeap = noteInfo.mapId and QuestieMapNotes[noteInfo.mapId]
        if noteHeap then
            for id, note in pairs(noteHeap) do
                if(note.questId == questId) then
                    local desc, typ, done = QGet_QuestLogLeaderBoard(note.objectiveid);
                    --Questie:debug_Print("UpdateQuestNotes: Desc: "..tostring(desc).." Type: "..tostring(typ).." Done: "..tostring(done));
                end
            end
        end
    end
    QSelect_QuestLogEntry(prevQuestLogSelection)
    if(redraw) then
        Questie:debug_Print("Notes:UpdateQuestNotes: redraw VAR true --> Questie:RefreshQuestStatus();");
        Questie:RefreshQuestNotes();
    end
end
---------------------------------------------------------------------------------------------------
-- Remove quest note from map
---------------------------------------------------------------------------------------------------
function Questie:RemoveQuestFromMap(questId, redraw)
    local removed = false;
    for mapId, notes in pairs(QuestieMapNotes) do
        for index, note in pairs(notes) do
            if(note.questId == questId) then
                QuestieMapNotes[mapId][index] = nil;
                removed = true;
            end
        end
    end
    if(redraw) then
        Questie:debug_Print("Notes:RemoveQuestFromMap: redraw VAR true --> Questie:RefreshQuestStatus();");
        Questie:RefreshQuestNotes();
    end
    if(QuestieHandledQuests[questId]) then
        QuestieHandledQuests[questId] = nil;
    end
end
---------------------------------------------------------------------------------------------------
function Questie:GetMapInfoFromID(id)
    return QuestieZoneIDLookup[id];
end
---------------------------------------------------------------------------------------------------
-- Add quest note to map
---------------------------------------------------------------------------------------------------
function Questie:AddNoteToMap(mapId, posx, posy, type, questId, objectiveid, path)
    if (not type == "complete") then
        return;
    end
    if(QuestieMapNotes[mapId] == nil) then
        QuestieMapNotes[mapId] = {};
    end
    Note = {};
    Note.x = posx;
    Note.y = posy;
    Note.mapId = mapId;
    Note.icontype = type;
    Note.questId = questId;
    Note.objectiveid = objectiveid;
    Note.path = path
    table.insert(QuestieMapNotes[mapId], Note);
end
---------------------------------------------------------------------------------------------------
-- Add available quest note to map
---------------------------------------------------------------------------------------------------
function Questie:AddAvailableNoteToMap(mapId, posx, posy, type, questId, objectiveid, path)
    --This is to set up the variables
    if(QuestieAvailableMapNotes[mapId] == nil) then
        QuestieAvailableMapNotes[mapId] = {};
    end
    --Sets values that i want to use for the notes THIS IS WIP MORE INFO MAY BE NEDED BOTH IN PARAMETERS AND NOTES!!!
    Note = {};
    Note.x = posx;
    Note.y = posy;
    Note.mapId = mapId;
    Note.icontype = type;
    Note.questId = questId;
    Note.objectiveid = objectiveid;
    Note.path = path
    --Inserts it into the right zone and continent for later use.
    table.insert(QuestieAvailableMapNotes[mapId], Note);
end
---------------------------------------------------------------------------------------------------
-- Gets a blank frame either from Pool or creates a new one!
---------------------------------------------------------------------------------------------------
function Questie:GetBlankNoteFrame(frame)
    if(table.getn(FramePool)==0) then
        Questie:CreateBlankFrameNote(frame);
    end
    f = FramePool[1];
    table.remove(FramePool, 1);
    return f;
end
---------------------------------------------------------------------------------------------------
-- Hook World Map Events
---------------------------------------------------------------------------------------------------
function QuestieNotes:SetAllNoteFramesAlpha()
    for i,v in ipairs({WorldMapFrame:GetChildren()}) do
        if v:GetName() and string.find(v:GetName(), "^QuestieNoteFrame") then
            v:SetAlpha(1)
        end
    end
end

function QuestieNotes:WorldMapFrame_Show(this)
	self.hooks[this].Show(this)
	QuestieNotes:SetAllNoteFramesAlpha()
end

function QuestieNotes:WorldMapFrame_SetAlpha(this, alpha)
	self.hooks[this].SetAlpha(this, alpha)
    QuestieNotes:SetAllNoteFramesAlpha()
end
---------------------------------------------------------------------------------------------------
-- Hook Tooltip
---------------------------------------------------------------------------------------------------
function Questie:hookTooltip()
    local f = GameTooltip:GetScript("OnShow");
    --Proper tooltip hooking!
    if not f then
        GameTooltip:SetScript("OnShow", function(self)
            Questie:Tooltip(self, true);
        end)
    end
    local Blizz_GameTooltip_Show = GameTooltip.Show;
    GameTooltip.Show = function(self)
        Questie:Tooltip(self);
        Blizz_GameTooltip_Show(self);
    end
    local Bliz_GameTooltip_SetLootItem = GameTooltip.SetLootItem;
    GameTooltip.SetLootItem = function(self, slot)
        Bliz_GameTooltip_SetLootItem(self, slot);
        Questie:Tooltip(self, true);
    end
    local index = self:GetID();
    local Bliz_GameTooltip_SetQuestLogItem = GameTooltip.SetQuestLogItem;
    GameTooltip.SetQuestLogItem = function(self, type, index)
        local link = GetQuestLogItemLink(type, index);
        if link then
            Bliz_GameTooltip_SetQuestLogItem(self, type, index);
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Tooltip code for quest objects
---------------------------------------------------------------------------------------------------
function Questie:hookTooltipLineCheck()
    local oh = GameTooltip:GetScript("OnHide");
    GameTooltip:SetScript("OnHide", function(self, arg)
        if oh then
            oh(self, arg);
    end
        __TT_LineCache = {};
    end)
    GameTooltip.AddLine_orig = GameTooltip.AddLine;
    GameTooltip.AddLine = function(self, line, r, g, b, wrap, lineNumber)
        GameTooltip:AddLine_orig(line, r, g, b, wrap);
        if (line) then
            if lineNumber == nil then lineNumber = 1; end
            __TT_LineCache[lineNumber] = {};
            __TT_LineCache[lineNumber][line] = true;
        end
    end
end
---------------------------------------------------------------------------------------------------
function Questie:Tooltip(this, forceShow, bag, slot)
    if (QuestieConfig.showToolTips == false) then return end

    -- Don't show detailed tooltip for questie minimap icons
    local owner = GameTooltip.owner
    if owner and owner.type == "MiniMapNote" then return end

    local monster = UnitName("mouseover")
    local objective = GameTooltipTextLeft1:GetText()
    local cacheKey = ""-- .. monster .. objective
    local validKey = false
    if(monster) then
        cacheKey = cacheKey .. monster
        validKey = true
    end
    if(objective) then
        cacheKey = cacheKey .. objective
        validKey = true
    end
    if not validKey then
        return
    end
    local reaction = UnitReaction("mouseover", "player")
    local unitColorRGB = Questie:GetReactionColor(reaction)
    local unitColor = "ff"..fRGBToHex(unitColorRGB.r, unitColorRGB.g, unitColorRGB.b)
    local hoverTargets = QuestieBuildTooltipHoverTargets(monster, objective)
    if (Questie_TooltipCache[cacheKey] == nil) or (QUESTIE_LAST_UPDATE_FINISHED - Questie_TooltipCache[cacheKey]['updateTime']) > 0 then
        -- Create or Update Tooltip Cache
        Questie_TooltipCache[cacheKey] = {}
        Questie_TooltipCache[cacheKey]['lines'] = {}
        Questie_TooltipCache[cacheKey]['lineCount'] = 1
        Questie_TooltipCache[cacheKey]['updateTime'] = GetTime()
        local prevQuestLogSelection = QGet_QuestLogSelection()
        for questId, quest in pairs(QuestieHandledQuests) do
            local QuestLogID = Questie:GetQuestLogIndexById(questId)
            if QuestieNotesHasValidQuestLogId(QuestLogID) then
                QSelect_QuestLogEntry(QuestLogID)
                local drawnQuestTitle = false
                for objectiveid, objectiveInfo in pairs(quest.objectives) do
                    local matchedHover = nil
                    for _, hoverInfo in ipairs(hoverTargets) do
                        if QuestieObjectiveMatchesEntity(objectiveInfo, hoverInfo) then
                            matchedHover = hoverInfo
                            break
                        end
                    end

                    if matchedHover then
                        local highlightInfo = {
                            ["color"] = unitColor,
                            ["entityType"] = matchedHover.entityType,
                            ["entityIds"] = matchedHover.entityIds,
                        }
                        local lineIndex = Questie_TooltipCache[cacheKey]['lineCount']
                        if drawnQuestTitle == false then
                            local questInfo = QuestieQuestMetaById[questId]
                            local colorString = "|c" .. QuestieTracker:GetDifficultyColor(questInfo.questLevel)
                            local title = colorString
                            title = title .. "[" .. questInfo.questLevel .. "] "
                            -- Use localized quest name instead of English name
                            local localizedName = Questie:GetLocalizedQuestName(questId) or questInfo.name
                            title = title .. localizedName .. "|r"
                            Questie_TooltipCache[cacheKey]['lines'][lineIndex] = {
                                ['color'] = {1,1,1},
                                ['data'] = " "
                            }
                            lineIndex = lineIndex + 1
                            Questie_TooltipCache[cacheKey]['lines'][lineIndex] = {
                                ['color'] = {1,1,1},
                                ['data'] = title,
                                ['wrap'] = false
                            }
                            lineIndex = lineIndex + 1
                            drawnQuestTitle = true
                        end
                        local desc = objectiveInfo.desc
                        local done = objectiveInfo.done
                        if type(objectiveid) == "number" then
                            local liveDesc, _, liveDone = QGet_QuestLogLeaderBoard(objectiveid)
                            if liveDesc then
                                desc = liveDesc
                            end
                            if liveDone ~= nil then
                                done = liveDone
                            end
                        end
                        if done then
                            Questie_TooltipCache[cacheKey]['lines'][lineIndex] = {
                                ['color'] = {0.2,1,0.3},
                                ['data'] = desc,
                                ['wrap'] = false
                            }
                            lineIndex = lineIndex + 1
                            Questie_TooltipCache[cacheKey]['lineCount'] = lineIndex
                        else
                            local objectivePath = deepcopy(objectiveInfo.path)
                            Questie:PostProcessIconPath(objectivePath)
                            local lines = Questie:GetTooltipLines(objectivePath, 1, highlightInfo)
                            local highlightName = matchedHover.label
                            if highlightName and desc then
                                desc = string.gsub(desc, QuestieEscapeLuaPattern(highlightName), "|c"..unitColor..highlightName.."|r")
                            end
                            Questie_TooltipCache[cacheKey]['lines'][lineIndex] = {
                                ['color'] = {1,1,1},
                                ['data'] = desc,
                                ['wrap'] = false
                            }
                            lineIndex = lineIndex + 1
                            for i, line in pairs(lines) do
                                Questie_TooltipCache[cacheKey]['lines'][lineIndex] = {
                                    ['color'] = {1,1,1},
                                    ['data'] = line
                                }
                                lineIndex = lineIndex + 1
                            end
                            Questie_TooltipCache[cacheKey]['lineCount'] = lineIndex
                        end
                    end
                end
            end
        end
        QSelect_QuestLogEntry(prevQuestLogSelection)
    end
    for k, v in pairs(Questie_TooltipCache[cacheKey]['lines']) do
        if (not __TT_LineCache[k]) or (not __TT_LineCache[k][v['data']]) then
            local wrap = v['wrap']
            if wrap == nil then wrap = true end
            GameTooltip:AddLine(v['data'], v['color'][1], v['color'][2], v['color'][3], wrap, k)
        end
    end
    if(QUESTIE_DEBUG_TOOLTIP) then
        GameTooltip:AddLine("--Questie hook--")
    end
    if(forceShow) then
        GameTooltip:Show()
    end
    GameTooltip.QuestieDone = true
    Questie_LastTooltip = GetTime()
    --Questie_TooltipCache = {}
    mi = nil
end
---------------------------------------------------------------------------------------------------
-- Tooltip code for quest starters and finishers
---------------------------------------------------------------------------------------------------
function Questie:GetTooltipLines(path, indent, highlightInfo, lines)
    if not path then
        return lines or {}
    end
    if lines == nil then lines = {} end
    local indentString = "";
    for i=1,indent,1 do
        indentString = indentString.." ";
    end
    for sourceType, sources in pairs(path) do
        if sourceType ~= "contained" or not path["contained_id"] then
            local prefix;
            if sourceType == "drop" then
                prefix = "Dropped by";
            elseif sourceType == "rewardedby" then
                prefix = "Awarded by";
            elseif sourceType == "contained" then
                prefix = "Contained in";
            elseif sourceType == "contained_id" then
                prefix = "Contained in";
            elseif sourceType == "containedi" then
                prefix = "Opened in";
            elseif sourceType == "created" then
                prefix = "Created by";
            elseif sourceType == "openedby" then
                prefix = "Opened by";
            elseif sourceType == "transforms" then
                prefix = "Used on";
            elseif sourceType == "transformedby" then
                prefix = "Created by";
            end
            if prefix then
                for sourceName, sourcePath in pairs(sources) do
                    local displayName = QuestieGetSourceDisplayName(sourceName, sourcePath)
                    local highlightedName = displayName
                    if highlightInfo and sourcePath and sourcePath.entityType == highlightInfo.entityType and sourcePath.entityId and highlightInfo.entityIds[sourcePath.entityId] then
                        highlightedName = "|r|c"..highlightInfo.color..displayName.."|r|cFFa6a6a6"
                    end
                    table.insert(lines, indentString..prefix..": |cFFa6a6a6"..highlightedName.."|r");
                    Questie:GetTooltipLines(sourcePath, indent+1, highlightInfo, lines);
                end
            end
        end
    end
    return lines
end
---------------------------------------------------------------------------------------------------
function Questie:AddPathToTooltip(Tooltip, path, indent)
    local lines = Questie:GetTooltipLines(path, indent);
    for i, line in pairs(lines) do
        Tooltip:AddLine(line,1,1,1,true);
    end
end
---------------------------------------------------------------------------------------------------
function Questie_Tooltip_OnEnter()
    if(this.data.questId) then
        local Tooltip = GameTooltip;
        if(this.type == "WorldMapNote") then
            Tooltip = WorldMapTooltip;
        else
            Tooltip = GameTooltip;
        end
        Tooltip:SetOwner(this, this);
        Tooltip.owner = this
        local count = 0;
        local canManualComplete = 0;
        local orderedQuests = {};
        for questId, questMeta in pairs(this.quests) do
            orderedQuests[questMeta['sortOrder']] = questMeta;
        end
        local prevQuestLogSelection = QGet_QuestLogSelection();
        for i, questMeta in pairs(orderedQuests) do
            local data = questMeta['quest'];
            count = count + 1;
            if (count > 1) then
                Tooltip:AddLine(" ");
            end
            if(data.icontype ~= "available" and data.icontype ~= "availablesoon") then
                local Quest = Questie:IsQuestFinished(data.questId);
                if not Quest then
                    local QuestLogID = Questie:GetQuestLogIndexById(data.questId);
                    if QuestieNotesHasValidQuestLogId(QuestLogID) then
                        QSelect_QuestLogEntry(QuestLogID);
                        local q, level, questTag, isHeader, isCollapsed, isComplete = QGet_QuestLogTitle(QuestLogID);
                        Tooltip:AddLine(q);
                        for objectiveid, objectivePath in pairs(questMeta['objectives']) do
                            local objectiveName;
                            if type(objectiveid) == "string" then
                                objectiveName = objectiveid;
                            else
                                local desc, typ, done = QGet_QuestLogLeaderBoard(objectiveid);
                                objectiveName = desc;
                            end
                            Tooltip:AddLine(objectiveName,1,1,1);
                            Questie:AddPathToTooltip(Tooltip, objectivePath, 1);
                        end
                    else
                        Questie:RemoveQuestFromMap(data.questId, true);
                    end
                else
                    Tooltip:AddLine("["..QuestieQuestMetaById[data.questId].questLevel.."] "..Quest["name"].." |cFF33FF00(complete)|r");
                    Tooltip:AddLine(QL("FINISHED_BY")..": |cFFa6a6a6"..(QuestieQuestMetaById[data.questId].finishDisplayName or "unknown").."|r",1,1,1);
                end
            else
                local questOb = QuestieQuestMetaById[data.questId].objectivesText;
                -- Use localized quest name
                local localizedName = Questie:GetLocalizedQuestName(data.questId) or QuestieQuestMetaById[data.questId].name;
                local questLine = "["..QuestieQuestMetaById[data.questId].questLevel.."] "..localizedName;
                if data.icontype == "available" then
                    questLine = questLine.." |cFF33FF00(available)|r";
                elseif data.icontype == "availablesoon" then
                    questLine = questLine.." |cFFa6a6a6(not available)|r";
                end
                Tooltip:AddLine(questLine);
                Tooltip:AddLine(QL("MIN_LEVEL")..": |cFFa6a6a6"..QuestieQuestMetaById[data.questId].level.."|r",1,1,1);
                Tooltip:AddLine(QL("STARTED_BY")..": |cFFa6a6a6"..Questie:RemoveUniqueSuffix(QuestieQuestMetaById[data.questId].startDisplayName or "unknown").."|r",1,1,1);
                Questie:AddPathToTooltip(Tooltip, questMeta['path'], 1);
                if questOb ~= nil and questOb ~= "" then
                    Tooltip:AddLine(QL("DESCRIPTION")..": |cFFa6a6a6"..Questie:RemoveUniqueSuffix(questOb).."|r",1,1,1,true);
                end
                canManualComplete = 1;
            end
        end
        QSelect_QuestLogEntry(prevQuestLogSelection);
        if canManualComplete > 0 then
            if count > 1 then
                Tooltip:AddLine(" ");
            end
            Tooltip:AddLine(QL("SHIFT_CLICK_COMPLETE"),1,1,1);
        end
        if(NOTES_DEBUG and IsAltKeyDown()) then
            Tooltip:AddLine("!DEBUG!", 1, 0, 0);
            Tooltip:AddLine("QuestID: "..this.data.questId, 1, 0, 0);
        end
        Tooltip:SetFrameStrata("TOOLTIP");
        Tooltip:Show();
    end
end
---------------------------------------------------------------------------------------------------
-- Force a quest to be finished via the Minimap or Worldmap (Shift-Click icon - NO confirmation)
---------------------------------------------------------------------------------------------------
function Questie_AvailableQuestClick()
    if this.type == "WorldMapNote" then
        local c, z = GetCurrentMapContinent(), GetCurrentMapZone();
        local newC, newZ = c, z;
        local noteC, noteZ = QuestieGetClientZoneForMapId(this.data.mapId);
        if arg1 == "LeftButton" then
            if c == 0 and noteC then
                newC = noteC;
            elseif z == 0 and noteZ and noteZ > 0 then
                newZ = noteZ;
            end
        end
        if arg1 == "RightButton" or arg1 == "MiddleButton" then
            if z == 0 then
                newC = 0;
            else
                newZ = 0;
            end
        end
        if newC ~= c or newZ ~= z then
            SetMapZoom(newC, newZ);
            return;
        end
    end
    local Tooltip = GameTooltip;
    if(this.type == "WorldMapNote") then
        Tooltip = WorldMapTooltip;
    else
        Tooltip = GameTooltip;
    end
    if (QuestieConfig.arrowEnabled == true) and (arg1 == "LeftButton") and (not IsControlKeyDown()) and (not IsShiftKeyDown()) then
        SetArrowFromIcon(this);
    end
    if ((this.data.icontype == "available" or this.data.icontype == "availablesoon" or this.data.icontype == "complete") and IsShiftKeyDown() and Tooltip ) then
        local finishQuest = function(quest)
            if (quest.icontype == "available" or quest.icontype == "availablesoon") then
                local hash = quest.questId;
                local questName = "["..QuestieQuestMetaById[hash].questLevel.."] "..QuestieQuestMetaById[hash]['name'];
                Questie:finishAndRecurse(hash);
                DEFAULT_CHAT_FRAME:AddMessage("Completing quest |cFF00FF00\"" .. questName .. "\"|r ("..hash..") and parent quests.");
                --Questie:debug_Print("Notes:Questie_AvailableQuestClick --> Refreshing QuestNPC Icons: [AddEvent:DRAWNOTES]");
                Questie:AddEvent("DRAWNOTES", 0.1);
            end
        end
        local count = 0;
        local firstQuest;
        for questId, questMeta in pairs(this.quests) do
            count = count + 1;
            if not firstQuest then
                firstQuest = questMeta['quest'];
            end
        end
        if (count < 2) then
            -- Finish first quest in list
            finishQuest(firstQuest);
        else
            -- Open Dewdrop to select which quest to finish
            local closeFunc = function()
                Dewdrop:Close();
            end
            local registerDewdrop = function(frame, quests, k1, v1, k2, v2)
                Dewdrop:Register(frame,
                    'children', function()
                        for questId, questMeta in pairs(quests) do
                            local quest = questMeta.quest;
                            local hash = questId;
                            local questName = "["..QuestieQuestMetaById[hash].questLevel.."] "..QuestieQuestMetaById[hash]['name']
                            local finishFunc = function(quest)
                                finishQuest(quest);
                                Dewdrop:Close();
                            end
                            Dewdrop:AddLine(
                                'text', questName,
                                'notClickable', quest.icontype ~= "available" and quest.icontype ~= "availablesoon",
                                'icon', QuestieIcons[quest.icontype].path,
                                'iconCoordLeft', 0,
                                'iconCoordRight', 1,
                                'iconCoordTop', 0,
                                'iconCoordBottom', 1,
                                'func', finishFunc,
                                'arg1', quest
                            );
                        end
                        Dewdrop:AddLine(
                            'text', "",
                            'notClickable', true
                        );
                        Dewdrop:AddLine(
                            'text', "Cancel",
                            'func', closeFunc
                        );
                    end,
                    'dontHook', true,
                    k1, v1,
                    k2, v2
                );
                Dewdrop:Open(frame);
                Dewdrop:Unregister(frame);
            end
            if (IsAddOnLoaded("Cartographer")) or (IsAddOnLoaded("MetaMap")) or (QuestieConfig.resizeWorldmap == true) then
                registerDewdrop(WorldMapFrame, this.quests, 'cursorX', true, 'cursorY', true);
            elseif (not IsAddOnLoaded("Cartographer")) or (not IsAddOnLoaded("MetaMap")) and (QuestieConfig.resizeWorldmap == false) then
                registerDewdrop(this, this.quests, 'point', "TOPLEFT", 'relativePoint', "BOTTOMRIGHT");
            elseif (IsAddOnLoaded("Cartographer")) and (CartographerDB["disabledModules"]["Default"]["Look 'n' Feel"] == true) then
                registerDewdrop(this, this.quests, 'point', "TOPLEFT", 'relativePoint', "BOTTOMRIGHT");
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Creates a blank frame for use within the map system
---------------------------------------------------------------------------------------------------
function Questie:CreateBlankFrameNote(frame)
    local f = CreateFrame("Button","QuestieNoteFrame"..CREATED_NOTE_FRAMES,frame);
    local t = f:CreateTexture(nil,"BACKGROUND");
    f.texture = t;
    f:SetScript("OnEnter", Questie_Tooltip_OnEnter);
    f:SetScript("OnLeave", function()
        if(WorldMapTooltip) then
            WorldMapTooltip:Hide();
        end
        if(GameTooltip) then
            GameTooltip:Hide();
            GameTooltip.owner = nil
        end
    end)
    f:SetScript("OnClick", Questie_AvailableQuestClick);
    f:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown");
    CREATED_NOTE_FRAMES = CREATED_NOTE_FRAMES+1;
    table.insert(FramePool, f);
    table.insert(AllFrames, f);
end
---------------------------------------------------------------------------------------------------
function Questie:GetFrameNote(data, parentFrame, frameLevel, type, scale)
    if(table.getn(FramePool)==0) then
        Questie:CreateFrameNote(data, parentFrame, frameLevel, type, scale);
    end
    f = FramePool[1];
    table.remove(FramePool, 1);
    return f;
end
---------------------------------------------------------------------------------------------------
function Questie:SetFrameNoteData(f, data, parentFrame, frameLevel, type, scale)
    f.data = data;
    f.quests = {};
    Questie:AddFrameNoteData(f, data);
    f:SetParent(parentFrame);
    f:SetFrameLevel(frameLevel);
    f:SetPoint("CENTER",0,0);
    f.type = type;
    f:SetWidth(16*scale);
    f:SetHeight(16*scale);
    f.texture:SetTexture(QuestieIcons[data.icontype].path);
    f.texture:SetAllPoints(f);
end
---------------------------------------------------------------------------------------------------
function Questie:AddFrameNoteData(icon, data)
    if icon then
        if (icon.averageX == nil or icon.averageY == nil or icon.countForAverage == nil) then
            icon.averageX = 0;
            icon.averageY = 0;
            icon.countForAverage = 0;
        end
        local numQuests = 0;
        for k, v in pairs(icon.quests) do
            numQuests = numQuests + 1;
        end
        local newAverageX = (icon.averageX * icon.countForAverage + data.x) / (icon.countForAverage + 1);
        local newAverageY = (icon.averageY * icon.countForAverage + data.y) / (icon.countForAverage + 1);
        icon.averageX = newAverageX;
        icon.averageY = newAverageY;
        icon.countForAverage = icon.countForAverage + 1;
        if icon.quests[data.questId] then
            -- Add cumulative quest data
            if icon.quests[data.questId]['objectives'][data.objectiveid] == nil then
                icon.quests[data.questId]['objectives'][data.objectiveid] = {};
            end
            if data.path then
                Questie:JoinPathTables(icon.quests[data.questId]['path'], data.path);
            end
            if data.objectiveid and data.path then
                Questie:JoinPathTables(icon.quests[data.questId]['objectives'][data.objectiveid], data.path);
            end
        else
            icon.quests[data.questId] = {};
            icon.quests[data.questId]['quest'] = data;
            icon.quests[data.questId]['sortOrder'] = numQuests + 1;
            icon.quests[data.questId]['objectives'] = {};
            icon.quests[data.questId]['path'] = {};
            if data.objectiveid then
                icon.quests[data.questId]['objectives'][data.objectiveid] = {};
                if data.path then
                    icon.quests[data.questId]['objectives'][data.objectiveid] = deepcopy(data.path);
                end
            end
            if data.path then
                icon.quests[data.questId]['path'] = deepcopy(data.path);
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
function Questie:JoinPathTables(path1, path2)
    for k, v in pairs(path2) do
        if type(v) == "table" then
            if k == "locations" then
                if path1[k] == nil then
                    path1[k] = {};
                end
                for _, location in ipairs(v) do
                    table.insert(path1[k], deepcopy(location));
                end
            elseif type(path1[k]) == "table" then
                Questie:JoinPathTables(path1[k], path2[k]);
            else
                path1[k] = deepcopy(v);
            end
        else
            if path1[k] == nil then
                path1[k] = v;
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
function Questie:PathsAreIdentical(path1, path2)
    if not next(path1) and not next(path2) then
        return true;
    end
    for sourceType1, sources1 in pairs(path1) do
        for sourceType2, sources2 in pairs(path2) do
            if path1[sourceType2] == nil or path2[sourceType1] == nil then
                return false;
            end
        end
        for sourceName, sourcePath in pairs(path1[sourceType1]) do
            for otherSourceName, otherSourcePath in pairs(path2[sourceType1]) do
                if path1[sourceType1][otherSourceName] == nil or path2[sourceType1][sourceName] == nil then
                    return false;
                end
            end
        end
    end
    return true;
end
---------------------------------------------------------------------------------------------------
function Questie:PostProcessIconPath(path)
    if not path then
        return;
    end
    for sourceType, sources in pairs(path) do
        if QuestieIsPathSourceType(sourceType) then
            for sourceName, sourcePath in pairs(sources) do
                if sourcePath.displayName == nil then
                    sourcePath.displayName = QuestieGetSourceDisplayName(sourceName, sourcePath);
                end
                Questie:PostProcessIconPath(sourcePath);
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
function Questie:RecursiveGetSourceNamesFromRawPath(path, sourceNames)
    if sourceNames == nil then sourceNames = {} end
    for sourceType, sources in pairs(path) do
        if QuestieIsPathSourceType(sourceType) then
            for sourceName, sourcePath in pairs(sources) do
                local displayName = QuestieGetSourceDisplayName(sourceName, sourcePath)
                sourceNames[displayName] = true
                Questie:RecursiveGetSourceNamesFromRawPath(sourcePath, sourceNames)
            end
        end
    end
    return sourceNames
end
---------------------------------------------------------------------------------------------------
function Questie:RecursiveFindAndCombineObjectiveName(pathToSearch, objectiveName, pathToAdd)
    local found = false;
    for sourceType, sources in pairs(pathToSearch) do
        if QuestieIsPathSourceType(sourceType) then
            for sourceName, sourcePath in pairs(sources) do
                if sourceName == objectiveName then
                    sources[sourceName] = pathToAdd;
                    found = true;
                else
                    if Questie:RecursiveFindAndCombineObjectiveName(sourcePath, objectiveName, pathToAdd) then
                        found = true;
                    end
                end
            end
        end
    end
    return found;
end
---------------------------------------------------------------------------------------------------
function Questie:FindAndCombineObjectiveName(objectives, objectiveName, pathToAdd)
    for objectiveid, objectivePath in pairs(objectives) do
        if type(objectiveid) ~= "string" then
            if Questie:RecursiveFindAndCombineObjectiveName(objectivePath, objectiveName, pathToAdd) then
                objectives[objectiveName] = nil;
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
function Questie:PostProcessIconPaths(icon)
    for questId, questMeta in pairs(icon.quests) do
        Questie:PostProcessIconPath(questMeta.path);
        for objectiveid, objectivePath in pairs(questMeta.objectives) do
            Questie:PostProcessIconPath(objectivePath);
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Updates notes for current zone only
---------------------------------------------------------------------------------------------------
function Questie:NOTES_ON_UPDATE(elapsed)
    if GameLoadingComplete == false then return; end
    local c, z = GetCurrentMapContinent(), GetCurrentMapZone();
    if(c ~= LastContinent or LastZone ~= z) then
        --Questie:debug_Print("Notes:NOTES_ON_UPDATE: [AddEvent:DRAWNOTES]");
        Questie:SetAvailableQuests();
        Questie:RedrawNotes();
        LastContinent = c;
        LastZone = z;
    end
    if(WorldMapFrame:IsVisible() and UIOpen == false) then
        --Questie:debug_Print("NOTES_ON_UPDATE: Created Frames: "..CREATED_NOTE_FRAMES, "Used Frames: "..table.getn(QuestieUsedNoteFrames), "Free Frames: "..table.getn(FramePool));
        UIOpen = true;
    elseif(WorldMapFrame:IsVisible() == nil and UIOpen == true) then
        UIOpen = false;
    end
end
---------------------------------------------------------------------------------------------------
-- Inital pool size (Not tested how much you can do before it lags like shit, from experiance 11
-- is good)
---------------------------------------------------------------------------------------------------
function Questie:NOTES_LOADED()
    --Questie:debug_Print("NOTES_LOADED: Loading QuestieNotes");
    if(table.getn(FramePool) < 10) then
        for i = 1, INIT_POOL_SIZE do
            Questie:CreateBlankFrameNote();
        end
    end
    --Questie:debug_Print("NOTES_LOADED: Done Loading QuestieNotes");
end
---------------------------------------------------------------------------------------------------
function Questie:RecursiveGetPathLocations(path, locations)
    if locations == nil then locations = {}; end
    for sourceType, sources in pairs(path) do
        if sourceType == "locations" and next(sources) then
            for i, location in pairs(sources) do
                local normalizedLocation = QuestieNormalizeLocationTuple(location);
                if normalizedLocation then
                    table.insert(locations, normalizedLocation);
                end
            end
        elseif QuestieIsPathSourceType(sourceType) then
            for sourceName, sourcePath in pairs(sources) do
                Questie:RecursiveGetPathLocations(sourcePath, locations);
            end
        end
    end
    return locations;
end
---------------------------------------------------------------------------------------------------
function Questie:RecursiveCreateNotes(c, z, v, locationMeta, iconMeta, objectiveid, path, pathKeys)
    if path == nil then path = {}; end
    if pathKeys == nil then pathKeys = {}; end
    for sourceType, sources in pairs(locationMeta) do
        if sourceType == "locations" and next(sources) then
            for specialSource, b in pairs(specialSources) do
                if locationMeta[specialSource] ~= nil and next(locationMeta[specialSource]) then
                    local pathToAppend = path;
                    for i, pathKey in pairs(pathKeys) do
                        pathToAppend = pathToAppend[pathKey];
                    end
                    pathToAppend[specialSource] = {};
                    for sourceName, sourcePath in pairs(locationMeta[specialSource]) do
                        pathToAppend[specialSource][sourceName] = {
                            ["displayName"] = sourcePath.displayName,
                            ["entityType"] = sourcePath.entityType,
                            ["entityId"] = sourcePath.entityId,
                        };
                    end
                end
            end
            for i, location in pairs(sources) do
                local normalizedLocation = QuestieNormalizeLocationTuple(location);
                if normalizedLocation ~= nil then
                    local resolvedMapId = normalizedLocation[1];
                    local resolvedX = normalizedLocation[2];
                    local resolvedY = normalizedLocation[3];
                    local icontype = iconMeta.selectedIcon;
                    if icontype == nil then icontype = iconMeta.defaultIcon; end
                    if icontype == "available" or icontype == "availablesoon" then
                        Questie:AddAvailableNoteToMap(resolvedMapId, resolvedX, resolvedY, icontype, v, -1, deepcopy(path));
                    else
                        Questie:AddNoteToMap(resolvedMapId, resolvedX, resolvedY, icontype, v, objectiveid, deepcopy(path));
                    end
                end
            end
        elseif QuestieIsPathSourceType(sourceType) then
            for sourceName, sourceLocationMeta in pairs(sources) do
                local newPath = deepcopy(path);
                local editPath = newPath;
                for i, pathKey in pairs(pathKeys) do
                    editPath = editPath[pathKey];
                end
                editPath[sourceType] = {};
                editPath[sourceType][sourceName] = {
                    ["displayName"] = sourceLocationMeta.displayName,
                    ["entityType"] = sourceLocationMeta.entityType,
                    ["entityId"] = sourceLocationMeta.entityId,
                };
                local newPathKeys = deepcopy(pathKeys);
                table.insert(newPathKeys, sourceType);
                table.insert(newPathKeys, sourceName);
                local newIconMeta = deepcopy(iconMeta);
                if newIconMeta.selectedIcon == nil then
                    local typeToIcon = {
                        ["drop"] = "loot",
                        ["rewardedby"] = "slay",
                        ["contained"] = "object",
                        ["contained_id"] = "object",
                        ["created"] = "event",
                        ["containedi"] = "object",
                        ["openedby"] = "object",
                        ["transforms"] = "event",
                        ["transformedby"] = "loot",
                    };
                    newIconMeta.selectedIcon = typeToIcon[sourceType];
                end
                local newObjectiveId = objectiveid;
                if specialSources[sourceType] then
                    newPath = {};
                    newPathKeys = {};
                    newObjectiveId = sourceLocationMeta.displayName or sourceName;
                    newIconMeta.selectedIcon = nil;
                end
                Questie:RecursiveCreateNotes(c, z, v, sourceLocationMeta, newIconMeta, newObjectiveId, newPath, newPathKeys);
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Sets up all available quests
---------------------------------------------------------------------------------------------------
function Questie:SetAvailableQuests(customLevel)
    QuestieAvailableMapNotes = {};
    local saqtime = GetTime();
    local level = customLevel or UnitLevel("player");
    local c, z = GetCurrentMapContinent(), GetCurrentMapZone();
    local quests = nil;
    local minLevel = 0;
    local maxLevel = 100;
    if QuestieConfig.minLevelFilter then
        minLevel = level - QuestieConfig.minShowLevel;
    end
    if QuestieConfig.maxLevelFilter then
        maxLevel = level + QuestieConfig.maxShowLevel;
    end
    quests = Questie:GetAvailableQuestIds(minLevel, maxLevel);
    if quests then
        local count = 0;
        for k, v in pairs(quests) do
            count = count + 1;
            local icontype = "available";
            if QuestieQuestMetaById[k].level > level then icontype = "availablesoon"; end
            Questie:RecursiveCreateNotes(c, z, k, v, {["selectedIcon"] = icontype});
        end
        --Questie:debug_Print("SetAvailableQuests: Adding "..count.." available quests took "..tostring((GetTime()- saqtime)*1000).."ms");
        saqtime = nil;
    end
end
---------------------------------------------------------------------------------------------------
-- Reason this exists is to be able to call both clearnotes and drawnotes without doing 2 function
-- calls, and to be able to force a redraw
---------------------------------------------------------------------------------------------------
function Questie:RedrawNotes()
    Questie:CLEAR_ALL_NOTES();
    Questie:DRAW_NOTES();
end
---------------------------------------------------------------------------------------------------
function Questie:Clear_Note(v)
    v:SetParent(nil);
    v:Hide();
    v:SetAlpha(1);
    v:SetFrameLevel(9);
    v:SetHighlightTexture(nil, "ADD");
    v.questId = nil;
    v.objId = nil;
    v.data = nil;
    v.quests = nil;
    v.averageX = nil;
    v.averageY = nil;
    v.countForAverage = nil;
    table.insert(FramePool, v);
end
---------------------------------------------------------------------------------------------------
-- Clears the notes, goes through the usednoteframes and clears them. Then sets the
-- QuestieUsedNotesFrame to new table;
---------------------------------------------------------------------------------------------------
function Questie:CLEAR_ALL_NOTES()
    --Questie:debug_Print("CLEAR_ALL_NOTES");
    Astrolabe:RemoveAllMinimapIcons();
    clustersByFrame = nil;
    for k, v in pairs(QuestieUsedNoteFrames) do
        Questie:Clear_Note(v);
    end
    QuestieUsedNoteFrames = {};
end
---------------------------------------------------------------------------------------------------
-- Logic for clusters
---------------------------------------------------------------------------------------------------
function Cluster.new(points)
    local self = setmetatable({}, Cluster);
    self.points = points;
    return self;
end
---------------------------------------------------------------------------------------------------
function Cluster:CountPoints()
    local count = 0;
    local counted = {};
    for i, q in pairs(self.points) do
        if not counted[q.questId] then
            count = count + 1;
            counted[q.questId] = true;
        end
    end
    return count;
end
---------------------------------------------------------------------------------------------------
function Cluster.CalculateDistance(x1, y1, x2, y2)
    local deltaX = x1 - x2;
    local deltaY = y1 - y2;
    return sqrt(deltaX*deltaX + deltaY*deltaY);
end
---------------------------------------------------------------------------------------------------
function Cluster.CalculateLinkageDistance(cluster1, cluster2)
    local total = 0;
    for i, pi in cluster1 do
        for j, pj in cluster2 do
            if pi.mapId ~= pj.mapId then return -1; end
            local distance = Cluster.CalculateDistance(pi.x, pi.y, pj.x, pj.y);
            total = total + distance;
        end
    end
    return total / (table.getn(cluster1) * table.getn(cluster2));
end
---------------------------------------------------------------------------------------------------
function Cluster:CalculateClusters(clusters, distanceThreshold, maxClusterSize)
    while table.getn(clusters) > 1 do
        local nearest1;
        local nearest2;
        local nearestDistance;
        for i, cluster in pairs(clusters) do
            for j, otherCluster in pairs(clusters) do
                if cluster ~= otherCluster then
                    local distance = Cluster.CalculateLinkageDistance(cluster.points, otherCluster.points);
                    if distance >= 0 and (distance == 0 or ((nearestDistance == nil or distance < nearestDistance) and (cluster:CountPoints() + otherCluster:CountPoints() <= maxClusterSize))) then
                        nearestDistance = distance;
                        nearest1 = cluster;
                        nearest2 = otherCluster;
                    end
                end
                if nearestDistance == 0 then break; end
            end
            if nearestDistance == 0 then break; end
        end
        if nearestDistance == nil or nearestDistance > distanceThreshold then break; end
        local index1 = indexOf(clusters, nearest1);
        table.remove(clusters, index1);
        local index2 = indexOf(clusters, nearest2);
        table.remove(clusters, index2);
        local points = nearest1.points;
        for i, point in pairs(nearest2.points) do
            table.insert(points, point);
        end
        local newCluster = Cluster.new(points);
        table.insert(clusters, newCluster);
    end
end
---------------------------------------------------------------------------------------------------
-- splits the specified text into an array on the specified separator
-- todo make a QuestieUtils.lua file for things like this
---------------------------------------------------------------------------------------------------
function Questie:SplitString( text, separator, limit )
    local parts, position, length, last, jump, count = {}, 1, string.len( text ), nil, string.len( separator ), 0;
    while true do
        last = string.find( text, separator, position, true );
        if last and ( not limit or count < limit ) then
            table.insert( parts, string.sub( text, position, last - 1 ) );
            position, count = last + jump, count + 1;
        else
            table.insert( parts, string.sub( text, position ) );
            break;
        end
    end
    return parts;
end
---------------------------------------------------------------------------------------------------
function Questie:RoundCoordinate(coord, factor)
    if factor == nil then factor = 1; end
    return tonumber(string.format("%.2f", coord/factor)) * factor;
end
---------------------------------------------------------------------------------------------------
function Questie:GetReactionColor(reaction)
    if reaction == nil or reaction < 1 or reaction > 8 then reaction = 4; end
    return FACTION_BAR_COLORS[reaction];
end
---------------------------------------------------------------------------------------------------
function Questie:AddClusterFromNote(frame, identifier, v)
    if clustersByFrame == nil then
        clustersByFrame = {};
    end
    if clustersByFrame[frame] == nil then
        clustersByFrame[frame] = {};
    end
    if clustersByFrame[frame][identifier] == nil then
        clustersByFrame[frame][identifier] = {};
    end
    if clustersByFrame[frame][identifier][v.mapId] == nil then
        clustersByFrame[frame][identifier][v.mapId] = {};
    end
    local roundedX = v.x;
    local roundedY = v.y;
    if QuestieConfig.clusterQuests and frame == "WorldMapNote" and identifier == "Objectives" then
        roundedX = Questie:RoundCoordinate(v.x, 5);
        roundedY = Questie:RoundCoordinate(v.y, 5);
    end
    if clustersByFrame[frame][identifier][v.mapId][roundedX] == nil then
        clustersByFrame[frame][identifier][v.mapId][roundedX] = {};
    end
    if clustersByFrame[frame][identifier][v.mapId][roundedX][roundedY] == nil then
        local points = { v };
        local cluster = Cluster.new(points);
        clustersByFrame[frame][identifier][v.mapId][roundedX][roundedY] = cluster;
    else
        table.insert(clustersByFrame[frame][identifier][v.mapId][roundedX][roundedY].points, v);
    end
end
---------------------------------------------------------------------------------------------------
function Questie:GetClustersByFrame(frame, identifier)
    if clustersByFrame == nil then
        clustersByFrame = {};
    end
    if clustersByFrame[frame] == nil then
        clustersByFrame[frame] = {};
    end
    if clustersByFrame[frame][identifier] == nil then
        clustersByFrame[frame][identifier] = {};
    end
    local clusters = {};
    for mapId, v in pairs(clustersByFrame[frame][identifier]) do
        for x, v in pairs(clustersByFrame[frame][identifier][mapId]) do
            for y, v in pairs(clustersByFrame[frame][identifier][mapId][x]) do
                table.insert(clusters, clustersByFrame[frame][identifier][mapId][x][y]);
            end
        end
    end
    return clusters;
end
---------------------------------------------------------------------------------------------------
-- Finds the index of an item in a table. Not sure if a function already exists somewhere.
---------------------------------------------------------------------------------------------------
function indexOf(table, item)
    for k, v in pairs(table) do
        if v == item then return k; end
    end
    return nil;
end
---------------------------------------------------------------------------------------------------
-- Checks first if there are any notes for the current zone, then draws the desired icon
---------------------------------------------------------------------------------------------------
function Questie:DRAW_NOTES()
    --Questie:debug_Print("DRAW_NOTES");
    local c, z = GetCurrentMapContinent(), GetCurrentMapZone();
    local playerMapId = Astrolabe:GetCurrentPlayerPosition();
    local currentMapId = QuestieGetCurrentMapId();
    if (not QuestieConfig.hideMinimapIcons) then
        -- Draw minimap objective markers
        if (playerMapId and QuestieMapNotes[playerMapId]) then
            for k, v in pairs(QuestieMapNotes[playerMapId]) do
                --If an available quest isn't in the zone or we aren't tracking a quest on the QuestTracker or the user wants to hide all objectives then hide the objectives from the minimap
                local show = QuestieConfig.alwaysShowObjectives or ((MMLastX ~= 0) and (MMLastY ~= 0)) and (QuestieQuestRuntimeById[v.questId] ~= nil) and (QuestieQuestRuntimeById[v.questId]["tracked"] ~= false);
                if show then
                    if (v.icontype == "complete") then
                        Questie:AddClusterFromNote("MiniMapNote", "Quests", v);
                    else
                        if QuestieConfig.hideObjectives == false then
                            Questie:AddClusterFromNote("MiniMapNote", "Objectives", v);
                        end
                    end
                end
            end
        end
    end
    -- Draw world map objective markers
    for mapId, noteHeap in pairs(QuestieMapNotes) do
        for k, v in pairs(noteHeap) do
            if true then
                --If we aren't tracking a quest on the QuestTracker or the user wants to hide all objectives then hide the objectives from the worldmap
                if (((QuestieQuestRuntimeById[v.questId] ~= nil) and (QuestieQuestRuntimeById[v.questId]["tracked"] ~= false)) or (v.icontype == "complete")) and (QuestieConfig.alwaysShowObjectives == false) then
                    if (v.icontype == "complete") then
                        Questie:AddClusterFromNote("WorldMapNote", "Quests", v);
                    else
                        if QuestieConfig.hideObjectives == false then
                            Questie:AddClusterFromNote("WorldMapNote", "Objectives", v);
                        end
                    end
                elseif (QuestieConfig.alwaysShowObjectives == true) then
                    if (v.icontype == "complete") then
                        Questie:AddClusterFromNote("WorldMapNote", "Quests", v);
                    else
                        if QuestieConfig.hideObjectives == false then
                            Questie:AddClusterFromNote("WorldMapNote", "Objectives", v);
                        end
                    end
                end
            end
        end
    end
    -- Draw available quest markers.
    if (currentMapId and QuestieAvailableMapNotes[currentMapId] and IsQuestieActive == true) then
        for k, v in pairs(QuestieAvailableMapNotes[currentMapId]) do
            Questie:AddClusterFromNote("WorldMapNote", "Quests", v);
        end
    end
    if (not QuestieConfig.hideMinimapIcons) and playerMapId and QuestieAvailableMapNotes[playerMapId] and IsQuestieActive == true then
        for k, v in pairs(QuestieAvailableMapNotes[playerMapId]) do
            Questie:AddClusterFromNote("MiniMapNote", "Quests", v);
        end
    end
    local minimapObjectiveClusters = Questie:GetClustersByFrame("MiniMapNote", "Objectives");
    local worldMapObjectiveClusters = Questie:GetClustersByFrame("WorldMapNote", "Objectives");
    local minimapClusters = Questie:GetClustersByFrame("MiniMapNote", "Quests");
    local worldMapClusters = Questie:GetClustersByFrame("WorldMapNote", "Quests");
    if QuestieConfig.clusterQuests then
        Cluster:CalculateClusters(worldMapClusters, 0.025, 5);
    end
    local scale = QUESTIE_NOTES_MAP_ICON_SCALE;
    if (z == 0 and c == 0) then--Both continents
        scale = QUESTIE_NOTES_WORLD_MAP_ICON_SCALE;
    elseif (z == 0) then--Single continent
        scale = QUESTIE_NOTES_CONTINENT_ICON_SCALE;
    end
    Questie:DrawClusters(worldMapObjectiveClusters, "WorldMapNote", scale, WorldMapFrame, WorldMapButton);
    Questie:DrawClusters(worldMapClusters, "WorldMapNote", scale, WorldMapFrame, WorldMapButton);
    Questie:DrawClusters(minimapObjectiveClusters, "MiniMapNote", QUESTIE_NOTES_MINIMAP_ICON_SCALE, Minimap);
    Questie:DrawClusters(minimapClusters, "MiniMapNote", QUESTIE_NOTES_MINIMAP_ICON_SCALE, Minimap);
end
---------------------------------------------------------------------------------------------------
function Questie:DrawClusters(clusters, frameName, scale, frame, button)
    local frameLevel = 9;
    if frameName == "MiniMapNote" then
        frameLevel = 7;
    end
    for i, cluster in pairs(clusters) do
        table.sort(cluster.points, function(a, b)
            if QuestieIcons[a.icontype].priority ~= QuestieIcons[b.icontype].priority then return QuestieIcons[a.icontype].priority < QuestieIcons[b.icontype].priority end
            if a.questId == b.questId then return tostring(a) < tostring(b) end
            local questA = QuestieQuestMetaById[a.questId]
            local questB = QuestieQuestMetaById[b.questId]
            if not questA or not questB then return questA ~= nil end
            if questA and questB then
                if questA.level ~= questB.level then return questA.level < questB.level end
                local questLevelA = GetNumberFromString(questA.questLevel)
                local questLevelB = GetNumberFromString(questB.questLevel)
                if questLevelA ~= questLevelB then return questLevelA < questLevelB end
            end
            return a.questId < b.questId
        end)
        local Icon = Questie:GetBlankNoteFrame(frame);
        for j, v in pairs(cluster.points) do
            if j == 1 then
                local finalFrameLevel = frameLevel;
                if v.icontype == "complete" then finalFrameLevel = finalFrameLevel + 1; end
                Questie:SetFrameNoteData(Icon, v, frame, finalFrameLevel, frameName, scale);
            else
                Questie:AddFrameNoteData(Icon, v);
            end
        end
        Questie:PostProcessIconPaths(Icon);
        if frameName == "MiniMapNote" then
            Icon:SetHighlightTexture(QuestieIcons[Icon.data.icontype].path, "ADD");
            Astrolabe:PlaceIconOnMinimap(Icon, Icon.data.mapId, Icon.averageX, Icon.averageY);
            table.insert(QuestieUsedNoteFrames, Icon);
        else
            Icon:Show();
            xx, yy = Astrolabe:PlaceIconOnWorldMap(button, Icon, Icon.data.mapId, Icon.averageX, Icon.averageY);
            if(xx and yy and xx > 0 and xx < 1 and yy > 0 and yy < 1) then
                table.insert(QuestieUsedNoteFrames, Icon);
            else
                Questie:Clear_Note(Icon);
            end
        end
    end
end
---------------------------------------------------------------------------------------------------
-- Debug print function
---------------------------------------------------------------------------------------------------
function Questie:debug_Print(...)
    local debugWin = 0;
    local name, shown;
    for i=1, NUM_CHAT_WINDOWS do
        name,_,_,_,_,_,shown = GetChatWindowInfo(i);
        if (string.lower(name) == "questiedebug") then debugWin = i; break; end
    end
    if (debugWin == 0) then return; end
    local out = "";
    for i = 1, arg.n, 1 do
        if (i > 1) then out = out .. ", "; end
        local t = type(arg[i]);
        if (t == "string") then
            out = out .. '"'..arg[i]..'"';
        elseif (t == "number") then
            out = out .. arg[i];
        else
            out = out .. dump(arg[i]);
        end
    end
    getglobal("ChatFrame"..debugWin):AddMessage(out, 1.0, 1.0, 0.3);
end
---------------------------------------------------------------------------------------------------
-- Sets the icon type
---------------------------------------------------------------------------------------------------
QuestieIcons = {
    ["complete"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\complete",
        priority = 1
    },
    ["available"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\available",
        priority = 2
    },
    ["availablesoon"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\availablesoon",
        priority = 2
    },
    ["loot"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\loot",
        priority = 3
    },
    ["item"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\loot",
        priority = 3
    },
    ["event"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\event",
        priority = 3
    },
    ["object"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\object",
        priority = 3
    },
    ["slay"] = {
        text = "Complete",
        path = "Interface\\AddOns\\!Questie\\Icons\\slay",
        priority = 3
    }
};
