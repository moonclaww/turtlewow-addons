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
local BUFF_BUTTON_COUNT = 24
local DEBUFF_BUTTON_COUNT = 16

-- Saved settings (loaded from SavedVariables)
BuffMaster_SavedSettings = nil

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
    end

    HideUIPanel(parent)
    BuffButtons_UpdatePositions()
end

-- Update buff timer labels on each frame update
function BuffMaster_UpdateTimers()
    for index = 0, BUFF_BUTTON_COUNT - 1, 1 do
        local buffButton = getglobal("BuffButton" .. index)
        local buffLabel = getglobal("BuffLabel" .. index)

        if buffButton:IsVisible() then
            buffLabel:Show()
            local buffIndex = buffButton.buffIndex
            local timeLeft = GetPlayerBuffTimeLeft(buffIndex)

            if timeLeft == 0 then
                -- No duration (permanent buff or unknown)
                buffLabel:SetTextColor(0.0, 1.0, 0.0)
                buffLabel:SetText("N/A")
            elseif timeLeft < BUFF_WARNING_TIME then
                -- Warning - buff about to expire (red)
                buffLabel:SetTextColor(1.0, 0.0, 0.0)
                buffLabel:SetText(BuffMaster_FormatTime(timeLeft))
                buffLabel:SetAlpha(buffButton:GetAlpha())
            else
                -- Normal duration (green)
                buffLabel:SetTextColor(0.0, 1.0, 0.0)
                buffLabel:SetText(BuffMaster_FormatTime(timeLeft))
            end
        else
            buffLabel:Hide()
        end
    end
end

-- Update debuff timer labels on each frame update
function BuffMaster_UpdateDebuffTimers()
    for index = 0, DEBUFF_BUTTON_COUNT - 1, 1 do
        local debuffButton = getglobal("DebuffButton" .. index)
        local debuffLabel = getglobal("DebuffLabel" .. index)

        if debuffButton and debuffButton:IsVisible() then
            debuffLabel:Show()
            local buffIndex = debuffButton.buffIndex
            local timeLeft = GetPlayerBuffTimeLeft(buffIndex)

            if timeLeft == 0 then
                -- No duration (permanent debuff or unknown)
                debuffLabel:SetTextColor(1.0, 0.5, 0.0)
                debuffLabel:SetText("N/A")
            elseif timeLeft < BUFF_WARNING_TIME then
                -- Debuff about to expire (yellow - good news!)
                debuffLabel:SetTextColor(1.0, 1.0, 0.0)
                debuffLabel:SetText(BuffMaster_FormatTime(timeLeft))
                debuffLabel:SetAlpha(debuffButton:GetAlpha())
            else
                -- Normal duration (red for debuffs)
                debuffLabel:SetTextColor(1.0, 0.0, 0.0)
                debuffLabel:SetText(BuffMaster_FormatTime(timeLeft))
            end
        else
            if debuffLabel then
                debuffLabel:Hide()
            end
        end
    end
end

-- Update buff button positions based on whether timers are shown
function BuffButtons_UpdatePositions()
    local showTimers = SHOW_BUFF_DURATIONS == "1" or 
        (BuffMaster_SavedSettings and 
         BuffMaster_SavedSettings.BuffMaster_Enable and 
         BuffMaster_SavedSettings.BuffMaster_Enable == "1")

    if showTimers then
        getglobal("BuffButton8"):SetPoint("TOP", "TempEnchant1", "BOTTOM", 0, -15)
        getglobal("BuffButton16"):SetPoint("TOPRIGHT", "TemporaryEnchantFrame", "TOPRIGHT", 0, -90)
    else
        getglobal("BuffButton8"):SetPoint("TOP", "TempEnchant1", "BOTTOM", 0, -5)
        getglobal("BuffButton16"):SetPoint("TOPRIGHT", "TemporaryEnchantFrame", "TOPRIGHT", 0, -70)
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
SlashCmdList["BUFFMASTER"] = function(msg)
    ShowUIPanel(BuffMasterConfigFrame)
end

-- Print a message when the addon loads
DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00BuffMaster|r loaded. Type |cff00ffff/buffmaster|r or |cff00ffff/bm|r to open settings.")
