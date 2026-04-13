---------------------------------------------------------------------------------------------------
-- Name: QuestieUtils
-- Description: Utility Functions
---------------------------------------------------------------------------------------------------
--///////////////////////////////////////////////////////////////////////////////////////////////--
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end
-- Get numeric value from string
---------------------------------------------------------------------------------------------------
function GetNumberFromString(arg)
    if type(arg) == "string" then
        local n
        for x in string.gfind(arg, "%d+") do n = x; end
        n = tonumber(n);
        return n
    end
    return nil
end
---------------------------------------------------------------------------------------------------
-- Get a quest's required minimum level.
---------------------------------------------------------------------------------------------------
function QuestieGetQuestRequiredLevel(questMeta)
    if type(questMeta) ~= "table" then
        return 1
    end

    return tonumber(questMeta.level) or 1
end
---------------------------------------------------------------------------------------------------
-- Normalize a quest's level for UI filtering.
---------------------------------------------------------------------------------------------------
function QuestieGetQuestDisplayLevel(questMeta)
    if type(questMeta) ~= "table" then
        return 1
    end

    local requiredLevel = QuestieGetQuestRequiredLevel(questMeta)
    local recommendedLevel = GetNumberFromString(questMeta.questLevel)
    if not recommendedLevel then
        recommendedLevel = tonumber(questMeta.questLevel) or requiredLevel
    end

    if recommendedLevel < requiredLevel then
        return requiredLevel
    end

    return recommendedLevel
end
---------------------------------------------------------------------------------------------------
-- Simple Rounding Function
---------------------------------------------------------------------------------------------------
function round(x)
	return floor(x+0.5)
end
