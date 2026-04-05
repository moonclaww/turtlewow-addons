-- BuffMaster - Buff Timer Display Addon
-- De-obfuscated and WoWShell-independent version

-- Register the config frame with the UI panel system
UIPanelWindows["BuffMasterConfigFrame"] = { area = "left", pushable = 1 }

-- Default settings
local BuffMaster_Defaults = {
    BuffMaster_Enable = "1",
    ItemBuff_Enable = "1",
    Debuff_Enable = "1"
}

-- Maximum number of buff/debuff buttons to track
local BUFF_BUTTON_COUNT = 32
local DEBUFF_BUTTON_COUNT = 16
local BUFFS_PER_ROW = 8
local DEBUFF_BUTTON_START = 32

-- Visual spacing for the player's aura rows
local BUFF_ROW2_BASE_OFFSET = -5
local BUFF_ROW3_BASE_OFFSET = -70
local TIMER_ROW_CLEARANCE = 7
local DEBUFF_ROW_CLEARANCE = 5
local TIMER_LABEL_OFFSET_Y = 0
local TIMER_LABEL_WIDTH_PADDING = 8
local TIMER_LABEL_HEIGHT = 12
local BUFF_WARNING_THRESHOLD = BUFF_WARNING_TIME or 30

local BuffMaster_AuraConfigs = {
    Buff = {
        frameName = "BuffMasterFrame",
        buttonPrefix = "BuffButton",
        buttonStart = 0,
        count = BUFF_BUTTON_COUNT,
        filter = "HELPFUL",
        permanentColor = {0.0, 1.0, 0.0},
        warningColor = {1.0, 0.0, 0.0},
        normalColor = {0.0, 1.0, 0.0}
    },
    Debuff = {
        frameName = "BuffMasterDebuffFrame",
        buttonPrefix = "BuffButton",
        buttonStart = DEBUFF_BUTTON_START,
        count = DEBUFF_BUTTON_COUNT,
        filter = "HARMFUL",
        permanentColor = {1.0, 0.5, 0.0},
        warningColor = {1.0, 1.0, 0.0},
        normalColor = {1.0, 0.0, 0.0}
    }
}

-- Saved settings (loaded from SavedVariables)
BuffMaster_SavedSettings = nil

local BuffMaster_AuraTooltip
local BuffMaster_AuraTooltipLines = {}
local BuffMaster_PatternMin
local BuffMaster_PatternSec

local function BuffMaster_GetAuraTooltip()
    if BuffMaster_AuraTooltip then
        return BuffMaster_AuraTooltip
    end

    local tooltip = CreateFrame("GameTooltip", "BuffMasterAuraTooltip", WorldFrame)
    tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

    for index = 1, 8, 1 do
        local left = tooltip:CreateFontString("BuffMasterAuraTooltipTextLeft" .. index, nil, "GameFontNormal")
        local right = tooltip:CreateFontString("BuffMasterAuraTooltipTextRight" .. index, nil, "GameFontNormal")
        tooltip:AddFontStrings(left, right)
        BuffMaster_AuraTooltipLines[index] = left
    end

    BuffMaster_AuraTooltip = tooltip
    return tooltip
end

local function BuffMaster_ParseTooltipTimeLeft(auraIndex)
    if not auraIndex or auraIndex == -1 then
        return nil
    end

    if not BuffMaster_PatternMin then
        BuffMaster_PatternMin = BuffMaster_GetLocale("PATTERN_MIN")
        BuffMaster_PatternSec = BuffMaster_GetLocale("PATTERN_SEC")
    end

    local tooltip = BuffMaster_GetAuraTooltip()
    tooltip:ClearLines()
    tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
    tooltip:SetPlayerBuff(auraIndex)

    for index = 1, 8, 1 do
        local line = BuffMaster_AuraTooltipLines[index]
        local text = line and line:GetText()
        if text then
            local _, _, _, minutes = string.find(text, BuffMaster_PatternMin)
            if minutes then
                return tonumber(minutes) * 60
            end

            local _, _, _, seconds = string.find(text, BuffMaster_PatternSec)
            if seconds then
                return tonumber(seconds)
            end
        end
    end
end

local function BuffMaster_GetAuraLabel(config, index, button)
    if button and button.BuffMasterLabel then
        return button.BuffMasterLabel
    end

    local parent = button or getglobal(config.frameName)
    if not parent then
        return nil
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    label:SetJustifyH("CENTER")
    label:SetHeight(TIMER_LABEL_HEIGHT)
    label:Hide()

    if button then
        button.BuffMasterLabel = label
    end

    return label
end

local function BuffMaster_AnchorAuraLabel(label, button)
    if label.anchorButton ~= button then
        label:ClearAllPoints()
        label:SetPoint("TOP", button, "BOTTOM", 0, TIMER_LABEL_OFFSET_Y)
        label.anchorButton = button
    end

    label:SetWidth(button:GetWidth() + TIMER_LABEL_WIDTH_PADDING)
end

local function BuffMaster_GetAuraButtonByIndex(prefix, index)
    return getglobal(prefix .. index)
end

local function BuffMaster_GetAuraButton(config, slotIndex)
    local buttonIndex = (config.buttonStart or 0) + slotIndex
    return BuffMaster_GetAuraButtonByIndex(config.buttonPrefix, buttonIndex), buttonIndex
end

local function BuffMaster_GetAuraTimeLeftFromIndex(config, auraIndex)
    if auraIndex == nil or auraIndex == -1 then
        return nil
    end

    local timeLeft = GetPlayerBuffTimeLeft(auraIndex)
    if (timeLeft == nil or timeLeft == 0) and config.filter == "HARMFUL" then
        local tooltipTime = BuffMaster_ParseTooltipTimeLeft(auraIndex)
        if tooltipTime ~= nil then
            return tooltipTime
        end
    end

    return timeLeft
end

local function BuffMaster_GetAuraTimeLeft(config, button, slotIndex, buttonIndex)
    local timeLeft = BuffMaster_GetAuraTimeLeftFromIndex(config, button.buffIndex)
    if timeLeft ~= nil then
        return timeLeft
    end

    local auraIndex = GetPlayerBuff(slotIndex, config.filter)
    timeLeft = BuffMaster_GetAuraTimeLeftFromIndex(config, auraIndex)
    if timeLeft ~= nil then
        return timeLeft
    end

    local buttonId = button.GetID and button:GetID()
    if buttonId and buttonIndex ~= nil then
        local baseIndex = buttonIndex - slotIndex
        local slotFromId = buttonId - baseIndex
        if slotFromId ~= slotIndex then
            auraIndex = GetPlayerBuff(slotFromId, config.filter)
            timeLeft = BuffMaster_GetAuraTimeLeftFromIndex(config, auraIndex)
            if timeLeft ~= nil then
                return timeLeft
            end
        end
    end
end

local function BuffMaster_SetLabelColor(label, color)
    label:SetTextColor(color[1], color[2], color[3])
end

local function BuffMaster_HideAuraLabels(config)
    for slotIndex = 0, config.count - 1, 1 do
        local button = BuffMaster_GetAuraButton(config, slotIndex)
        local label = button and button.BuffMasterLabel
        if label then
            label:Hide()
        end
    end
end

local function BuffMaster_UpdateAuraTimers(config)
    for slotIndex = 0, config.count - 1, 1 do
        local button, buttonIndex = BuffMaster_GetAuraButton(config, slotIndex)
        local label = BuffMaster_GetAuraLabel(config, slotIndex, button)

        if label and button and button:IsVisible() then
            local timeLeft = BuffMaster_GetAuraTimeLeft(config, button, slotIndex, buttonIndex)

            if timeLeft ~= nil then
                BuffMaster_AnchorAuraLabel(label, button)
                label:SetAlpha(button:GetAlpha())
                label:Show()

                if timeLeft == 0 then
                    BuffMaster_SetLabelColor(label, config.permanentColor)
                    label:SetText("N/A")
                elseif timeLeft < BUFF_WARNING_THRESHOLD then
                    BuffMaster_SetLabelColor(label, config.warningColor)
                    label:SetText(BuffMaster_FormatTime(timeLeft))
                else
                    BuffMaster_SetLabelColor(label, config.normalColor)
                    label:SetText(BuffMaster_FormatTime(timeLeft))
                end
            else
                label:Hide()
            end
        elseif label then
            label:Hide()
        end
    end
end

local function BuffMaster_SetAuraRowPosition(frameName, point, relativeTo, relativePoint, xOffset, yOffset)
    local frame = getglobal(frameName)
    local relativeFrame = getglobal(relativeTo)

    if frame and relativeFrame then
        frame:ClearAllPoints()
        frame:SetPoint(point, relativeFrame, relativePoint, xOffset, yOffset)
    end
end

local function BuffMaster_FindLastVisibleBuffRowAnchor()
    for slotIndex = BuffMaster_AuraConfigs.Buff.count - 1, 0, -1 do
        local button, buttonIndex = BuffMaster_GetAuraButton(BuffMaster_AuraConfigs.Buff, slotIndex)
        if button and button:IsVisible() then
            local rowStartIndex = buttonIndex - math.mod(buttonIndex, BUFFS_PER_ROW)
            return BuffMaster_GetAuraButtonByIndex("BuffButton", rowStartIndex)
        end
    end

    local tempEnchant = getglobal("TempEnchant1")
    if tempEnchant and tempEnchant:IsVisible() then
        return tempEnchant
    end

    local tempEnchantFrame = getglobal("TemporaryEnchantFrame")
    if tempEnchantFrame and tempEnchantFrame:IsVisible() then
        return tempEnchantFrame
    end
end

local function BuffMaster_UpdateDebuffPositions()
    local firstDebuffButton
    for slotIndex = 0, DEBUFF_BUTTON_COUNT - 1, 1 do
        local button = BuffMaster_GetAuraButton(BuffMaster_AuraConfigs.Debuff, slotIndex)
        if button and button:IsVisible() then
            firstDebuffButton = button
            break
        end
    end

    if not firstDebuffButton then
        return
    end

    local anchorButton = BuffMaster_FindLastVisibleBuffRowAnchor()
    if not anchorButton then
        return
    end

    firstDebuffButton:ClearAllPoints()
    local yOffset = -DEBUFF_ROW_CLEARANCE
    local anchorLabel = anchorButton.BuffMasterLabel
    if anchorLabel and anchorLabel:IsShown() then
        yOffset = -(TIMER_LABEL_HEIGHT + DEBUFF_ROW_CLEARANCE)
    end
    firstDebuffButton:SetPoint("TOPRIGHT", anchorButton, "BOTTOMRIGHT", 0, yOffset)
end

-- OnLoad handler for the config frame
function BuffMasterConfigFrame_OnLoad()
    this:RegisterEvent("VARIABLES_LOADED")
end

-- OnEvent handler for the config frame
function BuffMasterConfigFrame_OnEvent(event)
    if event == "VARIABLES_LOADED" then
        -- Load saved settings or use defaults
        if BuffMaster_SavedSettings then
            -- Merge with defaults for any missing keys
            for key, value in pairs(BuffMaster_Defaults) do
                if BuffMaster_SavedSettings[key] == nil then
                    BuffMaster_SavedSettings[key] = value
                end
            end
        else
            BuffMaster_SavedSettings = {}
            for key, value in pairs(BuffMaster_Defaults) do
                BuffMaster_SavedSettings[key] = value
            end
        end

        -- Apply settings - show/hide buff timer frame
        if BuffMaster_SavedSettings.BuffMaster_Enable == "1" then
            BuffMasterFrame:Show()
        else
            BuffMasterFrame:Hide()
            BuffMaster_HideAuraLabels(BuffMaster_AuraConfigs.Buff)
        end

        -- Apply settings - show/hide item buff bar
        if BuffMaster_SavedSettings.ItemBuff_Enable == "1" then
            ItemBuffBar:Show()
        else
            ItemBuffBar:Hide()
        end

        -- Apply settings - show/hide debuff timer frame
        if BuffMaster_SavedSettings.Debuff_Enable == "1" then
            BuffMasterDebuffFrame:Show()
        else
            BuffMasterDebuffFrame:Hide()
            BuffMaster_HideAuraLabels(BuffMaster_AuraConfigs.Debuff)
        end
    end

    BuffButtons_UpdatePositions()
end

-- OnShow handler for the config frame - initializes UI elements
function BuffMasterConfigFrame_OnShow()
    local titleText = getglobal(this:GetName() .. "TitleText")
    titleText:SetText(BuffMaster_GetLocale("TITLE"))

    local iconTexture = getglobal(this:GetName() .. "IconTexture")
    iconTexture:SetTexture("Interface\\QuestFrame\\UI-QuestLog-BookIcon")

    -- Setup checkbox 1 - Enable BuffMaster
    local checkButton1 = getglobal(this:GetName() .. "CheckButton1")
    checkButton1:Show()
    local checkButton1Text = getglobal(this:GetName() .. "CheckButton1Text")
    checkButton1Text:SetText(BuffMaster_GetLocale("ENABLE_BUFFMASTER"))

    -- Setup checkbox 2 - Show Item Buffs
    local checkButton2 = getglobal(this:GetName() .. "CheckButton2")
    checkButton2:Show()
    local checkButton2Text = getglobal(this:GetName() .. "CheckButton2Text")
    checkButton2Text:SetText(BuffMaster_GetLocale("SHOW_ITEMBUFF"))

    -- Setup checkbox 3 - Show Debuff Timers
    local checkButton3 = getglobal(this:GetName() .. "CheckButton3")
    checkButton3:Show()
    local checkButton3Text = getglobal(this:GetName() .. "CheckButton3Text")
    checkButton3Text:SetText(BuffMaster_GetLocale("SHOW_DEBUFF"))

    -- Set checkbox states based on saved settings
    if BuffMaster_SavedSettings.BuffMaster_Enable == "1" then
        checkButton1:SetChecked(1)
    else
        checkButton1:SetChecked(nil)
    end

    if BuffMaster_SavedSettings.ItemBuff_Enable == "1" then
        checkButton2:SetChecked(1)
    else
        checkButton2:SetChecked(nil)
    end

    if BuffMaster_SavedSettings.Debuff_Enable == "1" then
        checkButton3:SetChecked(1)
    else
        checkButton3:SetChecked(nil)
    end
end

-- Defaults button click handler - resets checkboxes to default state
function BuffMasterConfigFrame_Defaults()
    local parent = this:GetParent()
    local checkButton1 = getglobal(parent:GetName() .. "CheckButton1")
    local checkButton2 = getglobal(parent:GetName() .. "CheckButton2")
    local checkButton3 = getglobal(parent:GetName() .. "CheckButton3")
    checkButton1:SetChecked(1)
    checkButton2:SetChecked(1)
    checkButton3:SetChecked(1)
end

-- Okay button click handler - saves settings and closes config
function BuffMasterConfigFrame_Okay()
    local parent = this:GetParent()
    local checkButton1 = getglobal(parent:GetName() .. "CheckButton1")
    local checkButton2 = getglobal(parent:GetName() .. "CheckButton2")
    local checkButton3 = getglobal(parent:GetName() .. "CheckButton3")

    -- Save BuffMaster enable state
    if checkButton1:GetChecked() then
        BuffMaster_SavedSettings.BuffMaster_Enable = "1"
        BuffMasterFrame:Show()
    else
        BuffMaster_SavedSettings.BuffMaster_Enable = "0"
        BuffMasterFrame:Hide()
        BuffMaster_HideAuraLabels(BuffMaster_AuraConfigs.Buff)
    end

    -- Save ItemBuff enable state
    if checkButton2:GetChecked() then
        BuffMaster_SavedSettings.ItemBuff_Enable = "1"
        ItemBuffBar:Show()
    else
        BuffMaster_SavedSettings.ItemBuff_Enable = "0"
        ItemBuffBar:Hide()
    end

    -- Save Debuff enable state
    if checkButton3:GetChecked() then
        BuffMaster_SavedSettings.Debuff_Enable = "1"
        BuffMasterDebuffFrame:Show()
    else
        BuffMaster_SavedSettings.Debuff_Enable = "0"
        BuffMasterDebuffFrame:Hide()
        BuffMaster_HideAuraLabels(BuffMaster_AuraConfigs.Debuff)
    end

    HideUIPanel(parent)
    BuffButtons_UpdatePositions()
end

-- Update buff timer labels on each frame update
function BuffMaster_UpdateTimers()
    BuffMaster_UpdateAuraTimers(BuffMaster_AuraConfigs.Buff)

    if BuffMaster_SavedSettings and BuffMaster_SavedSettings.Debuff_Enable == "1" then
        BuffMaster_UpdateDebuffPositions()
        BuffMaster_UpdateAuraTimers(BuffMaster_AuraConfigs.Debuff)
    end
end

-- Update debuff timer labels on each frame update
function BuffMaster_UpdateDebuffTimers()
    if not BuffMaster_SavedSettings or BuffMaster_SavedSettings.BuffMaster_Enable ~= "1" then
        BuffMaster_UpdateDebuffPositions()
        BuffMaster_UpdateAuraTimers(BuffMaster_AuraConfigs.Debuff)
    end
end

-- Update buff button positions based on whether timers are shown
function BuffButtons_UpdatePositions()
    local showTimers = SHOW_BUFF_DURATIONS == "1" or
        (BuffMaster_SavedSettings and
         BuffMaster_SavedSettings.BuffMaster_Enable and
         BuffMaster_SavedSettings.BuffMaster_Enable == "1")

    local timerClearance = showTimers and TIMER_ROW_CLEARANCE or 0

    BuffMaster_SetAuraRowPosition("BuffButton8", "TOP", "TempEnchant1", "BOTTOM", 0, BUFF_ROW2_BASE_OFFSET - timerClearance)
    BuffMaster_SetAuraRowPosition("BuffButton16", "TOPRIGHT", "TemporaryEnchantFrame", "TOPRIGHT", 0, BUFF_ROW3_BASE_OFFSET - (timerClearance * 2))
    if not BuffMaster_SavedSettings or BuffMaster_SavedSettings.Debuff_Enable == "1" then
        BuffMaster_UpdateDebuffPositions()
    end
end

-- Format time in minutes:seconds
function BuffMaster_FormatTime(timeLeft)
    local min = math.floor(timeLeft / 60)
    local sec = math.floor(timeLeft - min * 60)
    return string.format("%d:%02d", min, sec)
end

-- Slash command handler
SLASH_BUFFMASTER1 = "/buffmaster"
SLASH_BUFFMASTER2 = "/bm"
SlashCmdList["BUFFMASTER"] = function()
    ShowUIPanel(BuffMasterConfigFrame)
end

-- Print a message when the addon loads
DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00BuffMaster|r loaded. Type |cff00ffff/buffmaster|r or |cff00ffff/bm|r to open settings.")
