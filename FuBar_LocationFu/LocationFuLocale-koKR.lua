local L = AceLibrary("AceLocale-2.2"):new("FuBar_LocationFu")

L:RegisterTranslations("koKR", function() return {
	["Open world map"] = "지도 열기",
	["Open Atlas"] = "Atlas 열기",
	["Show coordinates"] = "좌표 표시",
	["Toggle the coordinates in the text of this plugin"] = "플러그인의 텍스트로 좌표값을 사용할지를 토글합니다",
	["Show subzone name"] = "세부지역명 표시",
	["Show zone name"] = "지역명 표시",
	["Toggle the zone name in the text of this plugin"] = "플러그인의 텍스트로 지역명을 사용할지를 토글합니다",
	["Show level range"] = "레벨 범위 표시",
	["Show minimap bar"] = "미니맵바 표시",
	["Show the bar above the minimap that tells the location and allows you to close minimap"] = "미니맵 상단에 지역명과 닫기 버튼을 포함하는 미니맵바를 표시합니다.",
	["Show coordinates on map"] = "지도에 좌표 표시",
	["Show the coordinates of your cursor and your player on the world map"] = "지도에 플레이어와 커서의 위치의 좌표를 표시합니다.",
	["Show map overlay"] = "지도 정보 표시",
	["Show the overlay on the map which shows the level range and instances available"] = "지도에 해당 지역의 레벨 범위와 사용가능한 인스턴스 던전의 정보를 표시 합니다",
	["Show recommended zones"] = "추천지역 표시",
	["Show your recommended zones in the tooltip"] = "툴팁에 현재 레벨에 맞는 추천지역을 표시합니다.",
	["Zone:"] = "지역명:",
	["Subzone:"] = "세부지역명:",
	["Arena"] = "자유전투지역",
	["Friendly"] = "우호지역",
	["Contested"] = "분쟁지역",
	["Hostile"] = "적대지역",
	["Status:"] = "분류:",
	["Coordinates:"] = "좌표:",
	["Level range:"] = "레벨 범위:",
	["Instances"] = "인스턴스던전",
	["Recommended zones"] = "추천 지역",
	["Recommended instances"] = "추천 인스턴스 던전",
	["Cursor:"] = "커서:",
	["Player:"] = "플레이어:",
	["Continent:"] = "대륙:",
	
	["    Walk path from %s to %s:"] = "    %s|1로;으로;부터 %s까지의 경로:",
	["    No path found"] = "    경로 찾기 실패",
	
	["%d-man"] = "%d인", -- as in a 40-man raid
	
	["Atlas-hint"] = "클릭 시 Atlas를 엽니다",
	["Standard-hint"] = "클릭시 지도를 엽니다",
	["Shift-hint"] = "Shift 클릭시 대화창에 위치 정보를 삽입합니다",
	["Ctrl-hint"] = "Ctrl 클릭시 지도를 엽니다",
	["Ctrl-Atlas-hint"] = "Ctrl 클릭시 Atlas를 엽니다",
	
	["AceConsole-options"] = {"/locfu", "/locationfu"},
} end)
