local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("zhCN", function() return {
	["NAME"] = "FuBar - 金钱",
	["DESCRIPTION"] = "监视当前金钱状态(当前及同服务器其他角色)。",
	["COMMANDS"] = {"/monfu", "/moneyfu"},
	["TEXT_TOTAL"] = "总计",
	["TEXT_SESSION_RESET"] = "重置本次会话统计",
	["TEXT_THIS_SESSION"] = "本次会话",
	["TEXT_GAINED"] = "收入",
	["TEXT_SPENT"] = "支出",
	["TEXT_AMOUNT"] = "总计",
	["TEXT_PER_HOUR"] = "每小时",

	["ARGUMENT_RESETSESSION"] = "resetSession",

	["MENU_RESET_SESSION"] = "重置本次会话统计",
	["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "仅显示本角色金钱状态",
	["MENU_PURGE"] = "清除",
	["MENU_SHOW_GRAPHICAL"] = "以硬币图标形式显示",
	["MENU_SHOW_FULL"] = "完整显示",
	["MENU_SHOW_SHORT"] = "简短显示",
	["MENU_SHOW_CONDENSED"] = "紧缩显示",
	["SIMPLIFIED_TOOLTIP"] = "精简提示",
	["SHOW_PER_HOUR_CASHFLOW"] = "显示每小时的现金流",

	["TEXT_SESSION_RESET"] = "重置本次会话统计",
	["TEXT_CHARACTERS"] = "角色",
	["TEXT_PROFIT"] = "盈利",
	["TEXT_LOSS"] = "亏损",

	["HINT"] = "点击提取金钱"
} end)
