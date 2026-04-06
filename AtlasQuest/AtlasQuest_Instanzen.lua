local AQ_SUPPORTED_LOCALES = {
    enUS = true,
    zhCN = true,
}

AQ_ORIGINAL_ATLAS_ONSHOW = Atlas_OnShow

function AQ_GetLocaleKey()
    local locale = GetLocale()
    if AQ_SUPPORTED_LOCALES[locale] then
        return locale
    end
    return "enUS"
end

function AQ_GetLocalePayload(locale)
    locale = locale or AQ_GetLocaleKey()
    if AtlasQuestGeneratedLocales and AtlasQuestGeneratedLocales[locale] then
        return AtlasQuestGeneratedLocales[locale]
    end
    if AtlasQuestGeneratedLocales and AtlasQuestGeneratedLocales["enUS"] then
        return AtlasQuestGeneratedLocales["enUS"]
    end
    return nil
end

function AQ_GetUIStrings()
    local payload = AQ_GetLocalePayload()
    if payload and payload.ui then
        return payload.ui
    end
    return {}
end

local function AQ_NormalizePageID(pageID)
    if type(pageID) == "string" then
        local numericPageID = tonumber(pageID)
        if numericPageID then
            return numericPageID
        end
    end
    return pageID
end

local function AQ_GetDropdownListForType(atlasType)
    if atlasType == 1 then
        return ATLAS_DROPDOWN_LIST
    elseif atlasType == 2 then
        return ATLAS_DROPDOWN_LIST_BG
    elseif atlasType == 3 then
        return ATLAS_DROPDOWN_LIST_FP
    elseif atlasType == 4 then
        return ATLAS_DROPDOWN_LIST_DL
    elseif atlasType == 5 then
        return ATLAS_DROPDOWN_LIST_RE
    end
    return nil
end

function AQ_GetCurrentPageID()
    if not AtlasOptions then
        return nil
    end

    local atlasType = AtlasOptions.AtlasType or 1
    local dropList = AQ_GetDropdownListForType(atlasType)
    local pageID = AQ_NormalizePageID(AtlasOptions.AtlasMapID)

    if pageID and dropList then
        for index = 1, table.getn(dropList) do
            if dropList[index] == pageID then
                AtlasOptions.AtlasZone = index
                AtlasOptions.AtlasMapID = pageID
                return pageID
            end
        end
    end

    if AtlasOptions.AtlasZone and dropList and dropList[AtlasOptions.AtlasZone] then
        AtlasOptions.AtlasMapID = dropList[AtlasOptions.AtlasZone]
        return AtlasOptions.AtlasMapID
    end

    if pageID and AtlasGeneratedMaps and AtlasGeneratedMaps.defaults and AtlasGeneratedMaps.defaults[pageID] then
        AtlasOptions.AtlasMapID = AtlasGeneratedMaps.defaults[pageID]
        return AtlasOptions.AtlasMapID
    end

    if dropList and dropList[1] then
        AtlasOptions.AtlasZone = 1
        AtlasOptions.AtlasMapID = dropList[1]
        return AtlasOptions.AtlasMapID
    end

    return pageID
end

function AQ_GetPageData(pageID)
    pageID = AQ_NormalizePageID(pageID)
    if not pageID or not AtlasQuestGeneratedData or not AtlasQuestGeneratedData.pages then
        return nil
    end
    return AtlasQuestGeneratedData.pages[pageID]
end

function AQ_GetPageLocaleData(pageID, locale)
    pageID = AQ_NormalizePageID(pageID)
    local payload = AQ_GetLocalePayload(locale)
    if payload and payload.pages and payload.pages[pageID] then
        return payload.pages[pageID]
    end

    local fallback = AQ_GetLocalePayload("enUS")
    if fallback and fallback.pages then
        return fallback.pages[pageID]
    end
    return nil
end

function Atlas_OnShow()
    if AQ_ORIGINAL_ATLAS_ONSHOW then
        AQ_ORIGINAL_ATLAS_ONSHOW()
    end
    if AtlasQuest_OnAtlasShow then
        AtlasQuest_OnAtlasShow()
    end
end
