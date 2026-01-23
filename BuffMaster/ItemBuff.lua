-- ItemBuff - Shows temporary item enchant timers
-- De-obfuscated and WoWShell-independent version

-- Equipment slot definitions
local ITEM_SLOTS = {
    { name = "HeadSlot" },
    { name = "NeckSlot" },
    { name = "ShoulderSlot" },
    { name = "BackSlot" },
    { name = "ChestSlot" },
    { name = "ShirtSlot" },
    { name = "TabardSlot" },
    { name = "WristSlot" },
    { name = "HandsSlot" },
    { name = "WaistSlot" },
    { name = "LegsSlot" },
    { name = "FeetSlot" },
    { name = "Finger0Slot" },
    { name = "Finger1Slot" },
    { name = "Trinket0Slot" },
    { name = "Trinket1Slot" },
    { name = "MainHandSlot" },
    { name = "SecondaryHandSlot" },
    { name = "RangedSlot" },
}

-- Localized pattern strings (loaded on init)
local PATTERN_MIN
local PATTERN_SEC
local PATTERN_CHARGE
local TEXT_MIN
local TEXT_SEC

-- Initialize localization patterns
function ItemBuff_OnLoad()
    PATTERN_MIN = BuffMaster_GetLocale("PATTERN_MIN")
    PATTERN_SEC = BuffMaster_GetLocale("PATTERN_SEC")
    PATTERN_CHARGE = BuffMaster_GetLocale("PATTERN_CHARGE")
    TEXT_MIN = BuffMaster_GetLocale("MIN")
    TEXT_SEC = BuffMaster_GetLocale("SEC")
end

-- Check if an inventory slot has a temporary enchant
local function ItemBuff_HasTempEnchant(slotId)
    if not slotId then
        return nil
    end

    local hasItem = ItemTempTooltip:SetInventoryItem("player", slotId)
    if hasItem then
        for index = 1, 15, 1 do
            local textLine = getglobal("ItemTempTooltipTextLeft" .. index)
            if textLine and textLine:IsShown() then
                local text = textLine:GetText()
                if text and (string.find(text, PATTERN_MIN) or string.find(text, PATTERN_SEC)) then
                    return 1
                end
            end
        end
    end
    return nil
end

-- Update the display for a single item buff button
local function ItemBuff_UpdateButton(button)
    local label = getglobal(button:GetName() .. "Label")
    local durationLabel = getglobal(button:GetName() .. "Duration")
    local chargeLabel = getglobal(button:GetName() .. "Charge")

    if button.id then
        -- Don't update while merchant frame is open (causes tooltip issues)
        if MerchantFrame:IsVisible() then
            return
        end

        ItemTempTooltip:SetInventoryItem("player", button.id)

        for index = 1, 15, 1 do
            local textLine = getglobal("ItemTempTooltipTextLeft" .. index)
            if textLine and textLine:IsShown() then
                local text = textLine:GetText()
                if text then
                    local startPos, endPos, buffName, duration

                    -- Check for minutes pattern
                    startPos, endPos, buffName, duration = string.find(text, PATTERN_MIN)
                    if duration then
                        label:SetTextColor(0.0, 1.0, 0.0)
                        durationLabel:SetTextColor(0.0, 1.0, 0.0)

                        local durationText = "(" .. duration .. TEXT_MIN .. ")"

                        -- Check for charges
                        for _, charges in string.gfind(text, PATTERN_CHARGE) do
                            if charges then
                                chargeLabel:SetText(charges)
                            else
                                chargeLabel:SetText("")
                            end
                        end

                        label:SetText(buffName)
                        durationLabel:SetText(durationText)
                        return
                    end

                    -- Check for seconds pattern
                    startPos, endPos, buffName, duration = string.find(text, PATTERN_SEC)
                    if duration then
                        duration = duration + 0  -- Convert to number

                        -- Flash warning for low duration (15 seconds or less)
                        if button.flash and duration <= 15 then
                            label:SetTextColor(1.0, 0.0, 0.0)
                            durationLabel:SetTextColor(1.0, 0.0, 0.0)
                        else
                            label:SetTextColor(0.0, 1.0, 0.0)
                            durationLabel:SetTextColor(0.0, 1.0, 0.0)
                        end

                        local durationText = "(" .. duration .. TEXT_SEC .. ")"

                        -- Check for charges with seconds
                        for _, _, charges in string.gfind(text, PATTERN_SEC .. PATTERN_CHARGE) do
                            if charges then
                                chargeLabel:SetText(charges)
                            else
                                chargeLabel:SetText("")
                            end
                        end

                        label:SetText(buffName)
                        durationLabel:SetText(durationText)
                        return
                    end
                end
            end
        end
    end

    -- No buff found, clear labels
    label:SetText("")
    durationLabel:SetText("")
    chargeLabel:SetText("")
end

-- Show tooltip for item buff button
local function ItemBuff_ShowTooltip(button)
    if button.id then
        GameTooltip:SetOwner(button, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetInventoryItem("player", button.id)
    end
end

-- Clear an item buff button
local function ItemBuff_ClearButton(button)
    if button.id then
        button.texture = nil
        button.id = nil
        getglobal(button:GetName() .. "Icon"):SetTexture("")
        ItemBuff_UpdateButton(button)

        if GameTooltip:IsOwned(button) then
            button.tooltip = nil
            GameTooltip:Hide()
        end
    end
end

-- Set up an item buff button with an inventory slot
local function ItemBuff_SetButton(button, slotId)
    button.texture = GetInventoryItemTexture("player", slotId)
    button.id = slotId
    getglobal(button:GetName() .. "Icon"):SetTexture(button.texture)

    if button.tooltip then
        ItemBuff_ShowTooltip(button)
    end

    ItemBuff_UpdateButton(button)
end

-- OnShow handler for the item buff bar - initialize slot IDs
function ItemBuffBar_OnShow()
    for index = 1, getn(ITEM_SLOTS), 1 do
        ITEM_SLOTS[index].id = GetInventorySlotInfo(ITEM_SLOTS[index].name)
    end
    this:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

-- OnEvent handler for the item buff bar
function ItemBuffBar_OnEvent(event)
    if event == "UNIT_INVENTORY_CHANGED" then
        if arg1 == "player" then
            local buttonIndex = 1

            -- Check each equipment slot for temporary enchants
            for index = 1, getn(ITEM_SLOTS), 1 do
                if ItemBuff_HasTempEnchant(ITEM_SLOTS[index].id) then
                    local button = getglobal("ItemBuffButton" .. buttonIndex)
                    button:Show()
                    ItemBuff_SetButton(button, ITEM_SLOTS[index].id)
                    buttonIndex = buttonIndex + 1

                    -- Max 6 item buff buttons
                    if buttonIndex > 6 then
                        return
                    end
                end
            end

            -- Hide remaining buttons
            while buttonIndex <= 6 do
                local button = getglobal("ItemBuffButton" .. buttonIndex)
                button:Hide()
                ItemBuff_ClearButton(button)
                buttonIndex = buttonIndex + 1
            end
        end
    end
end

-- OnEnter handler for item buff buttons
function ItemBuffButton_OnEnter()
    this.tooltip = 1
    ItemBuff_ShowTooltip(this)
end

-- OnLeave handler for item buff buttons
function ItemBuffButton_OnLeave()
    if this.tooltip then
        this.tooltip = nil
        GameTooltip:Hide()
    end
end

-- OnLoad handler for item buff buttons
function ItemBuffButton_OnLoad()
    this.timer = 0
    this.flashTimer = 0
end

-- OnUpdate handler for item buff buttons
function ItemBuffButton_OnUpdate(elapsed)
    if elapsed then
        this.timer = this.timer + elapsed
        this.flashTimer = this.flashTimer + elapsed

        -- Toggle flash state every 0.5 seconds
        if this.flashTimer >= 0.50 then
            this.flashTimer = 0
            if this.flash then
                this.flash = nil
            else
                this.flash = 1
            end
        end

        -- Update button every 0.25 seconds
        if this.timer >= 0.25 then
            this.timer = 0
            ItemBuff_UpdateButton(this)
        end
    end
end
