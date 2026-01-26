local L = AceLibrary("AceLocale-2.2"):new("FuBar_ClockFu")

L:RegisterTranslations("zhTW", function() return {
	["24-hour format"] = "24小時制",
	["Toggle between 12-hour and 24-hour format"] = "切換12小時或24小時顯示模式",
	["Show seconds"] = "顯示秒",
	["Local time"] = "顯示本地時間",
	["Toggle between local time and server time"] = "切換顯示伺服器時間或本地時間",
	["Both times"] = "同時顯示2個時間",
	["Toggle between showing two times or just one"] = "切換同時顯示2個時間或只顯示1個時間",
	["Show day/night bubble"] = "顯示白天黑夜圖示",
	["Show the day/night bubble on the upper-right corner of the minimap"] = "顯示白天黑夜圖示在小地圖上",
	["Set the color of the text"] = "設定文字顯示顏色",
	
	["AceConsole-commands"] = { "/clockfu" },
	
	["Server time"] = "伺服器時間",
	["UTC"] = "格林威治時間"
} end)

