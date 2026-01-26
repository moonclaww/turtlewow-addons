local L = AceLibrary("AceLocale-2.2"):new("MoneyFu")

L:RegisterTranslations("zhTW", function() return {
	["NAME"] = "FuBar - MoneyFu",
	["DESCRIPTION"] = "持續追縱目前的金錢狀況(目前角色及同伺服器其他角色)。",
	["COMMANDS"] = {"/monfu", "/moneyfu"},
	["TEXT_TOTAL"] = "總計",
	["TEXT_SESSION_RESET"] = "重置這個階段的統計",
	["TEXT_THIS_SESSION"] = "目前階段",
	["TEXT_GAINED"] = "收入",
	["TEXT_SPENT"] = "支出",
	["TEXT_AMOUNT"] = "總計",
	["TEXT_PER_HOUR"] = "每小時",

	["ARGUMENT_RESETSESSION"] = "resetSession",

	["MENU_RESET_SESSION"] = "重置這個階段的統計",
	["MENU_CHARACTER_SPECIFIC_CASHFLOW"] = "只顯示目前角色的金錢狀態",
	["MENU_PURGE"] = "清除",
	["MENU_SHOW_GRAPHICAL"] = "以錢幣圖示形式顯示",
	["MENU_SHOW_FULL"] = "完整顯示",
	["MENU_SHOW_SHORT"] = "簡短顯示",
	["MENU_SHOW_CONDENSED"] = "緊縮顯示",
	["SIMPLIFIED_TOOLTIP"] = "精簡提示",
	["SHOW_PER_HOUR_CASHFLOW"] = "顯示每小時金錢使用狀況",

	["TEXT_SESSION_RESET"] = "重置這個階段的統計。",
	["TEXT_CHARACTERS"] = "角色",
	["TEXT_PROFIT"] = "盈利",
	["TEXT_LOSS"] = "虧損",

	["HINT"] = "點擊拾取金錢"
} end)
