QuestieLocale = {}

QuestieLocale["enUS"] = {
    ["FINISHED_BY"] = "Finished by",
    ["STARTED_BY"] = "Started by",
    ["MIN_LEVEL"] = "Min Level",
    ["DESCRIPTION"] = "Description",
    ["SHIFT_CLICK_COMPLETE"] = "Shift+Click: Manually complete quest!",
    ["QUEST_NOT_FOUND"] = "Quest *Objective* not found in Questie Database!",
    ["BUG_REPORT"] = "Please file a bug report on our GitHub portal:)",
    ["REQUIRES_RELOAD"] = "Requires ReloadUI",
    ["TO_FINISH_QUEST"] = "To finish this quest...",
    ["AVAILABLE_QUEST"] = "Available Quest",
    ["QUEST_COMPLETE"] = "Quest Complete",
    ["QUEST_LEVEL"] = "Quest Level",
}

QuestieLocale["zhCN"] = {
    ["FINISHED_BY"] = "完成于",
    ["STARTED_BY"] = "接取于",
    ["MIN_LEVEL"] = "最低等级",
    ["DESCRIPTION"] = "描述",
    ["SHIFT_CLICK_COMPLETE"] = "Shift+点击: 手动完成任务!",
    ["QUEST_NOT_FOUND"] = "任务目标未在Questie数据库中找到!",
    ["BUG_REPORT"] = "请在GitHub上提交bug报告:)",
    ["REQUIRES_RELOAD"] = "需要重载界面",
    ["TO_FINISH_QUEST"] = "完成此任务需要...",
    ["AVAILABLE_QUEST"] = "可接任务",
    ["QUEST_COMPLETE"] = "任务完成",
    ["QUEST_LEVEL"] = "任务等级",
}

function QuestieGetLocaleString(key)
    local locale = QuestieLanguage or "enUS"
    if QuestieLocale[locale] and QuestieLocale[locale][key] then
        return QuestieLocale[locale][key]
    end
    return QuestieLocale["enUS"][key] or key
end

QL = QuestieGetLocaleString
