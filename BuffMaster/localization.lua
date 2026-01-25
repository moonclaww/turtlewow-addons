-- BuffMaster Localization
-- Supports English (enUS) and Simplified Chinese (zhCN)

BuffMaster_Locale = {}

-- English strings
BuffMaster_Locale["enUS"] = {
    TITLE = "BuffMaster",
    DESCRIPTION = "Shows buff timers for your character",
    TOOLTIP = "Click to open BuffMaster settings",
    ENABLE_BUFFMASTER = "Enable BuffMaster",
    SHOW_ITEMBUFF = "Show Item Buff Timers",
    SHOW_DEBUFF = "Show Debuff Timers",
    PATTERN_MIN = "(.+)%((%d+) min%)",
    PATTERN_SEC = "(.+)%((%d+) sec%)",
    PATTERN_CHARGE = "(.+)%((%d+) Charges%)",
    MIN = "min",
    SEC = "sec",
}

-- Simplified Chinese strings
BuffMaster_Locale["zhCN"] = {
    TITLE = "增益魔法",
    DESCRIPTION = "显示玩家身上的增益魔法剩余时间",
    TOOLTIP = "点击打开设置",
    ENABLE_BUFFMASTER = "开启增益魔法时间显示",
    SHOW_ITEMBUFF = "显示物品增益魔法",
    SHOW_DEBUFF = "显示减益魔法时间",
    PATTERN_MIN = "(.+)（(%d+)分钟）",
    PATTERN_SEC = "(.+)（(%d+)秒）",
    PATTERN_CHARGE = "(.+)%((%d+)次%)",
    MIN = "分钟",
    SEC = "秒",
}

-- Get the current client locale, default to enUS
local function GetClientLocale()
    local locale = GetLocale()
    if BuffMaster_Locale[locale] then
        return locale
    end
    return "enUS"
end

-- Get a localized string by key
function BuffMaster_GetLocale(key)
    local locale = GetClientLocale()
    local localeTable = BuffMaster_Locale[locale]
    if localeTable and localeTable[key] then
        return localeTable[key]
    end
    -- Fallback to English
    if BuffMaster_Locale["enUS"] and BuffMaster_Locale["enUS"][key] then
        return BuffMaster_Locale["enUS"][key]
    end
    return key
end
