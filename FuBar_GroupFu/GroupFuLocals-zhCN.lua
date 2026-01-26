local AceLocale = AceLibrary("AceLocale-2.1")
AceLocale:RegisterTranslation("GroupFu", "zhCN", function()
    return {
        ["Name"]          = "组队",
        ["Description"]   = "管理队伍分配和掷骰子(Roll)。",
        ["DefaultIcon"]   = "Interface\\Buttons\\UI-GroupLoot-Dice-Up",

        ["TextSolo"]      = "未组队",
        ["TextGroup"]     = "队伍分配",
        ["TextFFA"]       = "自由拾取",
        ["TextMaster"]    = "队长分配",
        ["TextMasterSrt"] = "ML",
        ["TextNBG"]       = "需求优先",
        ["TextRR"]        = "轮流拾取",
        ["TextNoRolls"]   = "无Roll",

        ["ItemPoor"]      = "劣质",
        ["ItemCommon"]    = "普通",
        ["ItemUncommon"]  = "优秀",
        ["ItemRare"]      = "稀有",
        ["ItemEpic"]      = "史诗",
        ["ItemLegendary"] = "传说",
        ["ItemArtifact"]  = "神器",
        
        ["RollEnding10"] = "Roll 10秒后结束",
        ["RollEnding5"]  = "Roll 5秒后结束",
        ["RollEnding4"]  = "Roll 4秒后结束",
        ["RollEnding3"]  = "Roll 3秒后结束",
        ["RollEnding2"]  = "Roll 2秒后结束",
        ["RollEnding1"]  = "RRoll 1秒后结束",
        ["RollOver"]     = "Roll结束并公告胜利者。",

        ["FormatAnnounceWin"]           = "胜利者: %s [%d] （总共 %d 个参与者）。",
        ["FormatTextRollCount"]         = "%s (%d/%d)",
        ["FormatTooltipRollCount"]      = "%d / %d 个Roll已记录",
    
        ["MenuMode"]                    = "文字模式",
        ["MenuModeGroupFu"]             = "GroupFu: 显示拾取模式, 如果一个Roll开始则显示胜利者",
        ["MenuModeRollsFu"]             = "RollFu: 显示\"无Roll\", 如果一个Roll开始则显示胜利者",
        ["MenuModeLootTyFu"]            = "LootTyFu: 只显示拾取模式",

        ["MenuLootDispOpts"]            = "拾取显示选项",
        ["MenuLootDispOptsShowMLName"]  = "显示拾取者(队长)名字",

        ["MenuRollOpts"]                = "Roll选项",
        ["MenuRollOptsPerformRoll"]     = "点击时Roll",
        ["MenuRollOptsShowRollCount"]   = "显示已Roll人数/总人数",
        ["MenuRollOptsUseRollCntdwn"]   = "显示Roll点倒计时并显示胜利者",
        ["MenuRollOptsStdRollsOnly"]    = "只接受标准的 roll(1-100)",
        ["MenuRollOptsIgnoreDupes"]     = "忽略重复的Roll点",
        ["MenuRollOptsAutoDelRolls"]    = "输出后自动删除Roll点记录",
        ["MenuRollOptsShowClassNLevel"] = "在信息提示中显示职业和等级",
    
        ["MenuRollOptsOutput"]          = "输出选项",
        ["MenuRollOptsOutputAuto"]      = "根据组队情况自动选择输出聊天频道",
        ["MenuRollOptsOutputLocal"]     = "输出结果显示在屏幕上",
        ["MenuRollOptsOutputSay"]       = "输出结果到/s频道",
        ["MenuRollOptsOutputParty"]     = "输出结果到/p频道",
        ["MenuRollOptsOutputRaid"]      = "输出结果到/ra频道",
        ["MenuRollOptsOutputGuild"]     = "输出结果到/g频道",
    
        ["MenuRollOptsClear"]           = "自动清除Roll记录",
        ["MenuRollOptsClearNever"]      = "从不",
        ["MenuRollOptsClear15Sec"]      = "15秒",
        ["MenuRollOptsClear30Sec"]      = "30秒",
        ["MenuRollOptsClear45Sec"]      = "45秒",
        ["MenuRollOptsClear60Sec"]      = "60秒",
    
        ["MenuRollOptsDetail"]          = "输出详细设置",
        ["MenuRollOptsDetailShort"]     = "只显示胜利者",
        ["MenuRollOptsDetailLong"]      = "显示标准(1-100)",
        ["MenuRollOptsDetailFull"]      = "显示所有",
        
        ["MenuGroup"]                   = "组队功能",
        ["MenuGroupLeave"]              = "离开队伍",
        ["MenuGroupConvRaid"]           = "转换成团队",
        ["MenuGroupLootMethod"]         = "改变分配模式",
        ["MenuGroupLootThreshold"]      = "改变拾取等级限制",
        ["MenuGroupResetInstance"]      = "重置副本",
        
        ["TooltipCatLooting"]           = "分配",
        ["TooltipCatRolls"]             = "Rolls",
        ["TooltipMethod"]               = "分配方式",
        ["TooltipHint"]                 = "点击进行Roll点, Ctrl-点击输出胜利者, Shift-点击清除列表",
        ["TooltipHintNoRolls"]          = "Ctrl-点击输出胜利者, Shift-点击清除列表",
    }
end)
