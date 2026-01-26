local L = AceLibrary("AceLocale-2.2"):new("FuBar_LocationFu")

L:RegisterTranslations("zhCN", function() return {
	["Open world map"] = "打开世界地图",
	["Open Atlas"] = "打开Atlas副本地图",
	["Show coordinates"] = "显示坐标",
	["Toggle the coordinates in the text of this plugin"] = "开关显示坐标",
	["Show subzone name"] = "显示子区域名称",
	["Show zone name"] = "显示地区名称",
	["Toggle the zone name in the text of this plugin"] = "开关显示地区名称。",
	["Show level range"] = "显示等级范围",
	["Show minimap bar"] = "显示小地图条",
	["Show the bar above the minimap that tells the location and allows you to close minimap"] = "显示小地图条上的位置及允许你关掉小地图。",
	["Show coordinates on map"] = "在世界地图上显示坐标",
	["Show the coordinates of your cursor and your player on the world map"] = "在世界地图上显示指针及玩家坐标。",
	["Show map overlay"] = "显示等级范围和副本信息",
	["Show the overlay on the map which shows the level range and instances available"] = "在地图上显示等级范围和副本信息。",
	["Show recommended zones"] = "显示推荐地区",
	["Show your recommended zones in the tooltip"] = "在提示里显示推荐的地区。",
	["Zone:"] = "地区:",
	["Subzone:"] = "子区:",
	["Arena"] = "竞技场",
	["Friendly"] = "友好",
	["Contested"] = "争夺",
	["Hostile"] = "敌对",
	["Status:"] = "状态:",
	["Coordinates:"] = "坐标:",
	["Level range:"] = "等级范围:",
	["Instances"] = "副本",
	["Recommended zones"] = "推荐地区",
	["Recommended instances"] = "推荐副本",
	["Cursor:"] = "指针:",
	["Player:"] = "玩家:",
	["Continent:"] = "大陆:",
	
	["    Walk path from %s to %s:"] = "    从 %s 到 %s 的路径:",
	["    No path found"] = "    未发现路径",
	
	["%d-man"] = "%d人", -- as in a 40-man raid
	
	["Atlas-hint"] = "点击打开Atlas副本地图",
	["Standard-hint"] = "点击打开世界地图",
	["Shift-hint"] = "Shift-点击往聊天输入框插入坐标",
	["Ctrl-hint"] = "Ctrl-点击打开世界地图",
	["Ctrl-Atlas-hint"] = "Ctrl-点击打开Atlas副本地图",
	
	["AceConsole-options"] = {"/locfu", "/locationfu"},
} end)