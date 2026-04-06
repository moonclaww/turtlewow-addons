local VERSION_CORE = "|cffff00003"
local VERSION_INSTANZEN = "14"
local VERSION_REST = "28|r"
ATLASQUEST_VERSION = "|cff1eff00AtlasQuest Version: |r" .. VERSION_CORE .. "." .. VERSION_INSTANZEN .. "." .. VERSION_REST

local RED = "|cffff0000"
local WHITE = "|cffFFFFFF"
local GREEN = "|cff1eff00"
local GREY = "|cff9F3FFF"
local BLUE = "|cff0070dd"
local ORANGE = "|cffff6090"
local YELLOW = "|cffffff00"
local DARKGREEN = "|cff008000"
local BLUB = "|cffd45e19"

local Grau = "|cff9d9d9d"
local Gruen = "|cff1eff00"
local Orange = "|cffFF8000"
local Rot = "|cffFF0000"
local Gelb = "|cffFFd200"
local Blau = "|cff0070dd"

Allianceorhorde = 1
AQSHOWNQUEST = 0
AQTHISISSHOWN = 0
SHOWNID = nil

local AQ_ACTIVE_PAGE_ID = nil
local AQ_ACTIVE_PAGE = nil
local AQ_ACTIVE_PAGE_LOCALE = nil
local AQ_ACTIVE_FACTION = nil
local AQ_VISIBLE_ENTRIES = {}
local AQ_PANEL_MODE = nil
local AQ_SELECTED_ENTRY_KEY = nil

local function AQ_AddChatMessage(message)
    if message and DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage(message)
    end
end

local function AQ_GetSelectedFaction()
    if Allianceorhorde == 2 then
        return "horde"
    end
    return "alliance"
end

local function AQ_GetZoneSource()
    if not AtlasOptions then
        return nil
    end
    if AtlasOptions.AtlasType == 1 then
        return AtlasText
    elseif AtlasOptions.AtlasType == 2 then
        return AtlasBG
    elseif AtlasOptions.AtlasType == 3 then
        return AtlasFP
    elseif AtlasOptions.AtlasType == 4 then
        return AtlasDL
    elseif AtlasOptions.AtlasType == 5 then
        return AtlasRE
    end
    return nil
end

local function AQ_GetCurrentZoneName()
    local pageID = AQ_ACTIVE_PAGE_ID or AQ_GetCurrentPageID()
    local textSource = AQ_GetZoneSource()
    if textSource and pageID and textSource[pageID] and textSource[pageID]["ZoneName"] then
        return textSource[pageID]["ZoneName"]
    end
    if AQ_ACTIVE_PAGE and AQ_ACTIVE_PAGE.sourceKey then
        return AQ_ACTIVE_PAGE.sourceKey
    end
    return ""
end

local function AQ_GetVisibleEntries(pageData)
    local entries = {}
    if not pageData or type(pageData.entries) ~= "table" then
        return entries
    end

    local faction = AQ_GetSelectedFaction()
    for _, entry in ipairs(pageData.entries) do
        if entry.faction == "neutral" or entry.faction == faction then
            table.insert(entries, entry)
        end
    end
    return entries
end

local function AQ_GetCountText()
    local ui = AQ_GetUIStrings()
    local count = table.getn(AQ_VISIBLE_ENTRIES)
    if count <= 0 then
        return ui.noQuests or "No Quests"
    end
    return tostring(count) .. (ui.questCountSuffix or " Quests")
end

local function AQ_FormatPlainText(value, defaultValue)
    if value and value ~= "" then
        return value
    end
    return defaultValue
end

local function AQ_FormatLevelValue(value)
    if value ~= nil then
        return tostring(value)
    end
    return "?"
end

local function AQ_GetDifficultyColor(questLevel)
    if questLevel == nil then
        return WHITE
    end
    if questLevel == 100 then
        return Blau
    end

    local playerLevel = UnitLevel("player")
    if questLevel >= playerLevel + 5 then
        return Rot
    elseif questLevel > playerLevel + 2 then
        return Orange
    elseif questLevel >= playerLevel - 2 then
        return Gelb
    elseif questLevel >= playerLevel - 7 then
        return Gruen
    end
    return Grau
end

local function AQ_HideTexture(name)
    local texture = getglobal(name)
    if texture then
        texture:Hide()
    end
end

local function AQ_SetTextureShown(name, shouldShow)
    local texture = getglobal(name)
    if not texture then
        return
    end
    if shouldShow then
        texture:Show()
    else
        texture:Hide()
    end
end

local function AQ_GetLocalizedEntry(entryKey)
    if AQ_ACTIVE_PAGE_LOCALE and AQ_ACTIVE_PAGE_LOCALE.entries then
        return AQ_ACTIVE_PAGE_LOCALE.entries[entryKey]
    end
    return nil
end

local function AQ_FindVisibleEntryByKey(entryKey)
    for _, entry in ipairs(AQ_VISIBLE_ENTRIES) do
        if entry.entryKey == entryKey then
            return entry
        end
    end
    return nil
end

local function AQ_ClearRewards()
    for index = 1, 6 do
        local icon = getglobal("AtlasQuestItemframe" .. index .. "_Icon")
        local name = getglobal("AtlasQuestItemframe" .. index .. "_Name")
        local extra = getglobal("AtlasQuestItemframe" .. index .. "_Extra")
        local button = getglobal("AtlasQuestItemframe" .. index)
        if icon then
            icon:SetTexture(nil)
        end
        if name then
            name:SetText("")
        end
        if extra then
            extra:SetText("")
        end
        if button then
            button:Disable()
        end
    end
end

local function AQ_ClearDetail()
    StoryTEXT:SetText("")
    Questueberschrift:SetText("")
    QuestLeveltext:SetText("")
    QuestAttainLeveltext:SetText("")
    Prequesttext:SetText("")
    REWARDstext:SetText("")
    AQ_ClearRewards()
    if AQQuestieButton then
        AQQuestieButton:Hide()
        AQQuestieButton:Disable()
    end
end

local function AQ_SetRewardSlot(slotIndex, rewardBase, rewardLocale)
    local button = getglobal("AtlasQuestItemframe" .. slotIndex)
    local iconTexture = getglobal("AtlasQuestItemframe" .. slotIndex .. "_Icon")
    local nameLabel = getglobal("AtlasQuestItemframe" .. slotIndex .. "_Name")
    local extraLabel = getglobal("AtlasQuestItemframe" .. slotIndex .. "_Extra")
    if not button or not iconTexture or not nameLabel or not extraLabel then
        return
    end

    local itemId = rewardBase and rewardBase.itemId or nil
    local icon = rewardBase and rewardBase.icon or nil
    local name = rewardLocale and rewardLocale.name or nil
    local extraText = rewardLocale and rewardLocale.extraText or nil
    if itemId and (not name or name == "") then
        name = GetItemInfo(itemId)
    end

    if icon and icon ~= "" then
        iconTexture:SetTexture("Interface\\Icons\\" .. icon)
    else
        iconTexture:SetTexture(nil)
    end
    nameLabel:SetText(name or "")
    extraLabel:SetText(extraText or "")

    if itemId or name or extraText or icon then
        button:Enable()
    else
        button:Disable()
    end
end

local function AQ_IsQuestieLoaded()
    return Questie ~= nil and QuestieGetQuestById ~= nil and SetArrowFromData ~= nil
end

local function AQ_GetQuestiePoint(locationPayload)
    if type(locationPayload) ~= "table" or type(locationPayload.locations) ~= "table" then
        return nil
    end
    local first = locationPayload.locations[1]
    if type(first) ~= "table" then
        return nil
    end
    if first[1] == nil or first[2] == nil or first[3] == nil then
        return nil
    end
    return {
        mapId = first[1],
        x = first[2],
        y = first[3],
    }
end

local function AQ_UpdateQuestieButton(baseEntry)
    if not AQQuestieButton then
        return
    end

    local ui = AQ_GetUIStrings()
    AQQuestieButton:SetText(ui.questieButton or "Questie")

    if not baseEntry or baseEntry.kind ~= "quest" or not baseEntry.questId then
        AQQuestieButton:Hide()
        AQQuestieButton:Disable()
        return
    end

    if not AQ_IsQuestieLoaded() then
        AQQuestieButton:Hide()
        AQQuestieButton:Disable()
        return
    end

    AQQuestieButton:Show()
    if QuestieGetQuestById(baseEntry.questId) then
        AQQuestieButton:Enable()
    else
        AQQuestieButton:Disable()
    end
end

local function AQ_RenderInfoLikeView(title, body)
    AQ_ClearDetail()
    Questueberschrift:SetText(BLUE .. (title or AQ_GetCurrentZoneName()))
    StoryTEXT:SetText(WHITE .. (body or ""))
    AQ_UpdateQuestieButton(nil)
    AtlasQuestInsideFrame:Show()
end

local function AQ_RenderEmptyView()
    local ui = AQ_GetUIStrings()
    AQ_PANEL_MODE = "empty"
    AQ_SELECTED_ENTRY_KEY = nil
    AQ_RenderInfoLikeView(ui.noDataTitle or "No AtlasQuest Data", ui.noDataMessage or "This Atlas page does not have AtlasQuest data yet.")
end

local function AQ_RenderStoryView()
    local ui = AQ_GetUIStrings()
    AQ_PANEL_MODE = "story"
    AQ_SELECTED_ENTRY_KEY = nil
    local body = nil
    if AQ_ACTIVE_PAGE_LOCALE then
        body = AQ_ACTIVE_PAGE_LOCALE.story
    end
    body = AQ_FormatPlainText(body, ui.noStoryMessage or "No story is available for this page.")
    AQ_RenderInfoLikeView(AQ_GetCurrentZoneName(), body)
end

local function AQ_RenderSelectedEntry()
    local ui = AQ_GetUIStrings()
    local baseEntry = AQ_FindVisibleEntryByKey(AQ_SELECTED_ENTRY_KEY)
    if not baseEntry then
        AQ_HideDetailFrame()
        return
    end

    local localeEntry = AQ_GetLocalizedEntry(baseEntry.entryKey) or {}
    if baseEntry.kind == "info" then
        AQ_PANEL_MODE = "entry"
        AQ_RenderInfoLikeView(localeEntry.title or AQ_GetCurrentZoneName(), localeEntry.detailText or "")
        return
    end

    AQ_PANEL_MODE = "entry"
    AQ_ClearDetail()
    StoryTEXT:SetText("")

    local color = AQ_GetDifficultyColor(baseEntry.questLevel)
    local noneText = ui.noneText or "No"
    Questueberschrift:SetText(color .. (localeEntry.title or AQ_GetCurrentZoneName()))
    QuestLeveltext:SetText(GREEN .. (ui.levelLabel or "Level: ") .. WHITE .. AQ_FormatLevelValue(baseEntry.questLevel))
    QuestAttainLeveltext:SetText(DARKGREEN .. (ui.attainLabel or "Attain: ") .. WHITE .. AQ_FormatLevelValue(baseEntry.requiredLevel))
    Prequesttext:SetText(
        RED .. (ui.prequestLabel or "Prequest: ") .. WHITE .. AQ_FormatPlainText(localeEntry.prerequisiteText, noneText)
        .. "\n \n" .. BLUB .. (ui.followupLabel or "Leads to: ") .. WHITE .. AQ_FormatPlainText(localeEntry.followupText, noneText)
        .. "\n \n" .. BLUE .. (ui.startLabel or "Starts at: \n") .. WHITE .. AQ_FormatPlainText(localeEntry.startText, noneText)
        .. "\n \n" .. ORANGE .. (ui.objectiveLabel or "Object: \n") .. WHITE .. AQ_FormatPlainText(localeEntry.objectiveText, noneText)
        .. "\n \n" .. GREY .. (ui.noteLabel or "Note: \n") .. WHITE .. AQ_FormatPlainText(localeEntry.noteText, noneText)
    )

    local rewardCount = 0
    local localizedRewards = localeEntry.rewards or {}
    for index = 1, 6 do
        local rewardBase = baseEntry.rewards and baseEntry.rewards[index] or nil
        local rewardLocale = localizedRewards and localizedRewards[index] or nil
        if rewardBase then
            rewardCount = rewardCount + 1
        end
        AQ_SetRewardSlot(index, rewardBase, rewardLocale)
    end

    if rewardCount > 0 then
        REWARDstext:SetText(GREEN .. (ui.rewardsLabel or "Rewards"))
    else
        REWARDstext:SetText(RED .. (ui.noRewardsLabel or "No Rewards"))
    end

    AQ_UpdateQuestieButton(baseEntry)
    AtlasQuestInsideFrame:Show()
end

local function AQ_RenderList()
    AQ_SetCaption()
    if AQ_ACTIVE_PAGE then
        AtlasQuestAnzahl:SetText(AQ_GetCountText())
    else
        AtlasQuestAnzahl:SetText("")
    end

    for index = 1, 18 do
        local entry = AQ_VISIBLE_ENTRIES[index]
        local button = getglobal("AQQuestbutton" .. index)
        local text = getglobal("AQBUTTONTEXT" .. index)
        local localeEntry = entry and AQ_GetLocalizedEntry(entry.entryKey) or nil
        if button and text then
            if entry then
                local color = entry.kind == "info" and BLUE or AQ_GetDifficultyColor(entry.questLevel)
                local title = localeEntry and localeEntry.title or AQ_GetCurrentZoneName()
                if entry.kind == "quest" then
                    title = tostring(entry.order) .. ". " .. (title or "")
                end
                button:Enable()
                text:SetText(color .. (title or ""))
            else
                button:Disable()
                text:SetText("")
            end
        end
        AQ_SetTextureShown("AQQuesstart_" .. index, entry and entry.hasPrerequisiteMarker)
        AQ_SetTextureShown("AQQuestlineArrow_" .. index, entry and entry.hasFollowupMarker)
    end
end

function AQ_SetCaption()
    Ueberschriftborder:SetText(AQ_GetCurrentZoneName())
end

local function AQ_PositionMainFrame()
    if not AtlasQuestFrame or not AtlasFrame then
        return
    end

    local frameWidth = AtlasQuestFrame:GetWidth() or 198
    local atlasLeft = AtlasFrame:GetLeft() or 0
    local atlasRight = AtlasFrame:GetRight() or 0
    local screenWidth = GetScreenWidth() or 1024

    AtlasQuestFrame:ClearAllPoints()
    if (screenWidth - atlasRight) >= (frameWidth + 16) then
        AtlasQuestFrame:SetPoint("TOPLEFT", AtlasFrame, "TOPRIGHT", 8, -80)
    elseif atlasLeft >= (frameWidth + 16) then
        AtlasQuestFrame:SetPoint("TOPRIGHT", AtlasFrame, "TOPLEFT", -8, -80)
    else
        AtlasQuestFrame:SetPoint("TOPRIGHT", AtlasFrame, "TOPRIGHT", -8, -80)
    end
end

local function AQ_SyncState(forceResetDetail)
    local pageID = AQ_GetCurrentPageID()
    local faction = AQ_GetSelectedFaction()
    local changed = forceResetDetail or AQ_ACTIVE_PAGE_ID ~= pageID or AQ_ACTIVE_FACTION ~= faction

    AQ_ACTIVE_PAGE_ID = pageID
    AQ_ACTIVE_FACTION = faction
    AQ_ACTIVE_PAGE = AQ_GetPageData(pageID)
    AQ_ACTIVE_PAGE_LOCALE = AQ_GetPageLocaleData(pageID)
    AQ_VISIBLE_ENTRIES = AQ_GetVisibleEntries(AQ_ACTIVE_PAGE)
    AQ_RenderList()

    if changed then
        AQ_PANEL_MODE = nil
        AQ_SELECTED_ENTRY_KEY = nil
        if AtlasQuestInsideFrame then
            AtlasQuestInsideFrame:Hide()
        end
    end
end

function AQ_HideDetailFrame()
    AQ_PANEL_MODE = nil
    AQ_SELECTED_ENTRY_KEY = nil
    if AtlasQuestInsideFrame then
        AtlasQuestInsideFrame:Hide()
    end
end

function AQ_HideAllFrames()
    AQ_HideDetailFrame()
    if AtlasQuestFrame then
        AtlasQuestFrame:Hide()
    end
end

function AQ_ToggleMainFrame()
    AQ_SyncState(false)
    AQ_PositionMainFrame()
    if AtlasQuestFrame:IsVisible() then
        AQ_HideAllFrames()
        return
    end
    AtlasQuestFrame:Show()

    if not AQ_ACTIVE_PAGE then
        AQ_RenderEmptyView()
        return
    end

    if table.getn(AQ_VISIBLE_ENTRIES) == 0 and (not AQ_ACTIVE_PAGE_LOCALE or not AQ_ACTIVE_PAGE_LOCALE.story) then
        AQ_RenderEmptyView()
    end
end

function AQ_ToggleStoryView()
    AQ_SyncState(false)
    if AQ_PANEL_MODE == "story" and AtlasQuestInsideFrame:IsVisible() then
        AQ_HideDetailFrame()
        return
    end
    if not AQ_ACTIVE_PAGE then
        AQ_RenderEmptyView()
        return
    end
    AQ_RenderStoryView()
end

function AQ_ToggleEntryByButtonIndex(buttonIndex)
    AQ_SyncState(false)
    local entry = AQ_VISIBLE_ENTRIES[buttonIndex]
    if not entry then
        return
    end
    if AQ_PANEL_MODE == "entry" and AQ_SELECTED_ENTRY_KEY == entry.entryKey and AtlasQuestInsideFrame:IsVisible() then
        AQ_HideDetailFrame()
        return
    end
    AQ_SELECTED_ENTRY_KEY = entry.entryKey
    AQ_RenderSelectedEntry()
end

function AQ_SetFaction(faction)
    if faction == "horde" then
        Allianceorhorde = 2
        AQHCB:SetChecked(true)
        AQACB:SetChecked(false)
    else
        Allianceorhorde = 1
        AQHCB:SetChecked(false)
        AQACB:SetChecked(true)
    end
    AQ_SyncState(true)
end

function AQ_HandleRewardLeave()
    if GameTooltip and GameTooltip:IsVisible() then
        GameTooltip:Hide()
    end
    if AtlasQuestTooltip and AtlasQuestTooltip:IsVisible() then
        AtlasQuestTooltip:Hide()
    end
end

local function AQ_GetSelectedReward(slotIndex)
    local baseEntry = AQ_FindVisibleEntryByKey(AQ_SELECTED_ENTRY_KEY)
    local localeEntry = baseEntry and AQ_GetLocalizedEntry(baseEntry.entryKey) or nil
    local baseReward = baseEntry and baseEntry.rewards and baseEntry.rewards[slotIndex] or nil
    local localeReward = localeEntry and localeEntry.rewards and localeEntry.rewards[slotIndex] or nil
    return baseReward, localeReward
end

function AQ_HandleRewardEnter(slotIndex)
    local ui = AQ_GetUIStrings()
    local baseReward = nil
    local localeReward = nil
    baseReward, localeReward = AQ_GetSelectedReward(slotIndex)
    if not baseReward or not baseReward.itemId then
        return
    end

    SHOWNID = baseReward.itemId
    AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
    if GetItemInfo(baseReward.itemId) then
        AtlasQuestTooltip:SetHyperlink("item:" .. baseReward.itemId .. ":0:0:0")
    else
        AtlasQuestTooltip:ClearLines()
        AtlasQuestTooltip:AddLine(RED .. (ui.itemNotCached or "This item is not cached yet."))
        AtlasQuestTooltip:AddLine(ui.itemQueryWarning or "Right-click to query the item from the server. You may disconnect.")
    end
    AtlasQuestTooltip:Show()
end

function AQ_HandleRewardClick(slotIndex, button)
    if button ~= "RightButton" then
        return
    end

    local ui = AQ_GetUIStrings()
    local baseReward, localeReward = AQ_GetSelectedReward(slotIndex)
    if not baseReward or not baseReward.itemId then
        return
    end

    SHOWNID = baseReward.itemId
    AtlasQuestTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
    AtlasQuestTooltip:SetHyperlink("item:" .. baseReward.itemId .. ":0:0:0")
    AtlasQuestTooltip:Show()
    AQ_AddChatMessage((ui.itemQueryPrefix or "Query the server for: ") .. (localeReward and localeReward.name or tostring(baseReward.itemId)) .. WHITE .. (ui.itemQuerySuffix or " Please right-click until the item loads."))
end

function AQ_QuestieAction()
    local ui = AQ_GetUIStrings()
    local baseEntry = AQ_FindVisibleEntryByKey(AQ_SELECTED_ENTRY_KEY)
    local localeEntry = baseEntry and AQ_GetLocalizedEntry(baseEntry.entryKey) or nil
    if not baseEntry or baseEntry.kind ~= "quest" or not baseEntry.questId then
        return
    end
    if not AQ_IsQuestieLoaded() or not QuestieGetQuestById(baseEntry.questId) then
        AQ_AddChatMessage(ui.questieUnavailable or "Questie data is unavailable for this quest.")
        return
    end

    local questName = localeEntry and localeEntry.title or tostring(baseEntry.questId)
    local questLevel = baseEntry.questLevel or 0
    local logId = Questie:GetQuestLogIndexById(baseEntry.questId)
    if logId then
        local runtime = Questie:BuildQuestRuntimeEntry(baseEntry.questId, logId)
        Questie:AddQuestToMap(baseEntry.questId, true)
        if QuestieTracker and QuestieTracker.addQuestToTrackerCache then
            QuestieTracker:addQuestToTrackerCache(baseEntry.questId, logId, runtime and runtime.level or questLevel)
        end
        if QuestieTracker and QuestieTracker.addQuestToTracker then
            QuestieTracker:addQuestToTracker(baseEntry.questId)
        end
        if runtime and runtime.isComplete and QuestieGetQuestFinisherLocationsById then
            local finishLocations = QuestieGetQuestFinisherLocationsById(baseEntry.questId)
            local point = AQ_GetQuestiePoint(finishLocations)
            if point then
                SetArrowFromData({ point = point, questName = questName, questLevel = questLevel })
            end
            AQ_AddChatMessage(ui.questieMappedFinish or "Questie pointed to the quest finisher.")
        elseif SetArrowObjective then
            SetArrowObjective(baseEntry.questId)
            AQ_AddChatMessage(ui.questieMappedObjectives or "Questie mapped this quest's objectives.")
        end
        return
    end

    if QuestieGetQuestStartLocationsById then
        local startLocations = QuestieGetQuestStartLocationsById(baseEntry.questId)
        local point = AQ_GetQuestiePoint(startLocations)
        if point then
            SetArrowFromData({ point = point, questName = questName, questLevel = questLevel })
            AQ_AddChatMessage(ui.questieMappedStart or "Questie pointed to the quest start.")
            return
        end
    end

    AQ_AddChatMessage(ui.questieUnavailable or "Questie data is unavailable for this quest.")
end

function AQ_OnLoad()
    local ui = AQ_GetUIStrings()
    AtlasQuestUeberschrift:SetText(ATLASQUEST_VERSION)
    if STORYbutton then
        STORYbutton:SetText(ui.storyButton or "Story")
    end
    if OPTIONbutton then
        OPTIONbutton:Hide()
        OPTIONbutton:Disable()
    end
    AQFraktionCheck()
    AQTEXTonload()
    AtlasQuestFrame:Hide()
    AtlasQuestInsideFrame:Hide()
    AtlasQuestFrame:SetFrameStrata("DIALOG")
    AtlasQuestInsideFrame:SetFrameStrata("DIALOG")
    AQSlashCommandfunction()
    AQ_SyncState(true)
end

function AQSlashCommandfunction()
    SlashCmdList["ATLASQ"] = atlasquest_command
    SLASH_ATLASQ1 = "/aq"
    SLASH_ATLASQ2 = "/atlasquest"
end

function AQFraktionCheck()
    local _, englishFaction = UnitFactionGroup("player")
    if englishFaction == "Horde" then
        Allianceorhorde = 2
        AQHCB:SetChecked(true)
        AQACB:SetChecked(false)
    else
        Allianceorhorde = 1
        AQHCB:SetChecked(false)
        AQACB:SetChecked(true)
    end
end

function AQTEXTonload()
    local ui = AQ_GetUIStrings()
    AQ_AddChatMessage(ATLASQUEST_VERSION .. (ui.loadedMessage or " = loaded, by ASURN"))
    AQ_AddChatMessage(ui.usageMessage or "type /aq or /atlasquest to show/hide the panel and show the version number")
end

function atlasquest_command(param)
    local ui = AQ_GetUIStrings()
    if param == "help" then
        AQ_AddChatMessage(RED .. (ui.helpMessage or "Help text will be here soon"))
    end
    AQ_AddChatMessage(ATLASQUEST_VERSION)
    AQ_AddChatMessage((ui.atlasVersionPrefix or "Atlasversion: ") .. (ATLAS_VERSION or ""))
end

function AQ_OnUpdate(arg1)
    if AtlasQuestFrame:IsVisible() or AtlasQuestInsideFrame:IsVisible() then
        AQ_SyncState(false)
    end
end

function AQ_OnEvent(event)
end

function AtlasQuest_OnAtlasShow()
    AQ_SyncState(true)
    if AtlasQuestFrame and AtlasQuestFrame:IsVisible() then
        AQ_PositionMainFrame()
    end
end
