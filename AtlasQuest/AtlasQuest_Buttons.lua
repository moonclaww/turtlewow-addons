function AQOPTION1_OnClick()
end

function AQCLOSE_OnClick()
    AQ_ToggleMainFrame()
end

function AQCLOSE1_OnClick()
    AQ_HideAllFrames()
end

function AQCLOSE2_OnClick()
    AQ_HideDetailFrame()
end

function Alliance_OnClick()
    AQ_SetFaction("alliance")
end

function Horde_OnClick()
    AQ_SetFaction("horde")
end

function AQHideAL()
    if AtlasLootItemsFrame ~= nil then
        AtlasLootItemsFrame:Hide()
    end
end

function AQSTORY1_OnClick()
    AQHideAL()
    AQ_ToggleStoryView()
end

function Quest_OnClick()
    AQHideAL()
    AQ_ToggleEntryByButtonIndex(AQSHOWNQUEST)
end

function AQQUESTIE_OnClick()
    AQ_QuestieAction()
end

function AtlasQuestItem_OnLeave()
    AQ_HandleRewardLeave()
end

function AtlasQuestItem_OnEnter()
    AQ_HandleRewardEnter(AQTHISISSHOWN)
end

function AtlasQuestItem_OnClick(arg1)
    AQ_HandleRewardClick(AQTHISISSHOWN, arg1)
end