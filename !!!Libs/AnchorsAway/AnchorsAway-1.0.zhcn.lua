local L = AceLibrary("AceLocale-2.2"):new("AnchorsAway")

L:RegisterTranslations("zhCN", function()
	return {
		catGrowth = "行增长方向",
		catPosSelf = "锚点...",
		catPosTarget = "到...",
		catPosOffset = "框体偏移...",
				
		optPositioning = "布置",
		optLock = "锁定",
		optAnchor = "显示锚点",
		optPosVert = "垂直",
		optPosHoriz = "水平",
		optTimeout = "超时",
		optThreshold = "分堆界限",
		
		descPositioning = "Position and attachment of rows in the stack",
		descAnchor = "Show anchor for this stack",
		descPosVert = "Offset the row vertically from the point you choose to anchor it to by a specific amount",
		descPosHoriz = "Offset the row horizontally from the point you choose to anchor it to by a specific amount",
		descTimeout = "Time before each row fades. |cFFFF5522Setting this to 0 disables timed fading entirely",
		descDirection = "Direction stacks grow",
		descThreshold = "Maximum number of rows displayed at any given time",
		
		optPos = {
			TOPLEFT = "左上角",
			TOP = "上边",
			TOPRIGHT = "右上角",
			RIGHT = "右边",
			BOTTOMRIGHT = "右下角",
			BOTTOM = "下边",
			BOTTOMLEFT = "左下角",
			LEFT = "左边",
		},
	}
end)
