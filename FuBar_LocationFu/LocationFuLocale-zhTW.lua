local L = AceLibrary("AceLocale-2.2"):new("FuBar_LocationFu")

L:RegisterTranslations("zhTW", function() return {
	["Open world map"] = "打開世界地圖",
	["Open Atlas"] = "打開Atlas副本地圖",
	["Show coordinates"] = "顯示座標",
	["Toggle the coordinates in the text of this plugin"] = "開關顯示座標",
	["Show subzone name"] = "顯示子區域名稱",
	["Show zone name"] = "顯示地區名稱",
	["Toggle the zone name in the text of this plugin"] = "開關顯示地區名稱。",
	["Show level range"] = "顯示等級範圍",
	["Show minimap bar"] = "顯示小地圖條",
	["Show the bar above the minimap that tells the location and allows you to close minimap"] = "顯示小地圖條上的位置及允許你關掉小地圖。",
	["Show coordinates on map"] = "在世界地圖上顯示坐標",
	["Show the coordinates of your cursor and your player on the world map"] = "在世界地圖上顯示指標及玩家坐標。",
	["Show map overlay"] = "顯示等級範圍和副本訊息",
	["Show the overlay on the map which shows the level range and instances available"] = "在地圖上顯示等級範圍和副本訊息。",
	["Show recommended zones"] = "顯示推薦地區",
	["Show your recommended zones in the tooltip"] = "在提示裡顯示推薦的地區。",
	["Zone:"] = "地區:",
	["Subzone:"] = "子區:",
	["Arena"] = "競技場",
	["Friendly"] = "友好",
	["Contested"] = "中立",
	["Hostile"] = "敵對",
	["Status:"] = "狀態:",
	["Coordinates:"] = "座標:",
	["Level range:"] = "等級範圍:",
	["Instances"] = "副本",
	["Recommended zones"] = "推薦地區",
	["Recommended instances"] = "推薦副本",
	["Cursor:"] = "指標:",
	["Player:"] = "玩家:",
	["Continent:"] = "大陸:",

	["    Walk path from %s to %s:"] = "    行走路徑從%s到%s:",
	["    No path found"] = "    找不到路徑",

	["%d-man"] = "%d人副本", -- as in a 40-man raid
	
	["Atlas-hint"] = "點擊打開Atlas副本地圖",
	["Standard-hint"] = "點擊打開世界地圖",
	["Shift-hint"] = "Shift-點擊往聊天輸入框插入坐標",
	["Ctrl-hint"] = "Ctrl-點擊打開世界地圖",
	["Ctrl-Atlas-hint"] = "Ctrl-點擊打開Atlas副本地圖",
	
	["AceConsole-options"] = {"/locfu", "/locationfu"},
} end)
