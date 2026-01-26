if (GetLocale()=="zhTW") then

-- Version : English, Chinese ( by iWOW )
-- Last Update : 03/21/2005

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------

BINDING_HEADER_LOOTLINK = "物品庫按鈕";
BINDING_NAME_TOGGLELOOTLINK = "切換物品庫顯示";
LOOTLINK_TITLE = "物品庫";
LOOTLINK_SHORTDESC = "瀏覽窗口";
LOOTLINK_DESC = "瀏覽你使用物品庫以後看到過的所有物品";
LOOTLINK_SEARCH_TITLE = "物品庫搜索";
LOOTLINK_TITLE_FORMAT_SINGULAR = "物品庫 - 總計 1 個物品";
LOOTLINK_TITLE_FORMAT_PLURAL = "物品庫 - 總計 %d 個物品";
LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR = "物品庫 - 找到 1 個物品";
LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL = "物品庫 - 找到 %d 個物品";
LOOTLINK_SEARCH_LABEL = "搜索...";
LOOTLINK_REFRESH_LABEL = "刷新";
LOOTLINK_RESET_LABEL = "重置";
LOOTLINK_AUCTION_SCAN_START = "物品庫: 掃描第 1 頁...";
LOOTLINK_AUCTION_PAGE_N = "物品庫: 掃描第 %d 頁，共 %d 頁...";
LOOTLINK_AUCTION_SCAN_DONE = "物品庫: 拍賣行掃描完成";
LOOTLINK_SELL_PRICE = "售價:";
LOOTLINK_SELL_PRICE_N = "%d個售價:";
LOOTLINK_SELL_PRICE_EACH = "每個售價:";
LOOTLINK_SCHEDULED_AUCTION_SCAN = "物品庫: 將在你下次與拍賣商對話時執行一次完全的拍賣行掃描.";

LOOTLINK_HELP = "help";			-- must be lowercase; command to display help
LOOTLINK_STATUS = "status";		-- must be lowercase; command to display status
LOOTLINK_AUCTION = "auction";	-- must be lowercase; command to scan auctions
LOOTLINK_SCAN = "scan";			-- must be lowercase; alias for command to scan auctions
LOOTLINK_SHOWINFO = "showinfo";	-- must be lowercase; command to show extra info on tooltips
LOOTLINK_HIDEINFO = "hideinfo";	-- must be lowercase; command to hide extra info on tooltips
LOOTLINK_MAKEHOME = "makehome";	-- must be lowercase; command to make the current server your home
LOOTLINK_RESET = "reset";		-- must be lowercase; command to reset the database
LOOTLINK_LIGHTMODE = "light";	-- must be lowercase; command to disable full-text search, using less memory
LOOTLINK_FULLMODE = "full";		-- must be lowercase; command to enable full-text search, using more memory
LOOTLINK_CONFIRM = "confirm";	-- must be lowercase; confirmation of MAKEHOME, RESET, or LIGHT

LOOTLINK_RESET_NEEDS_CONFIRM = "|cffff0000物品庫: 警告!  將不可逆地刪除所有物品庫數據.  如果你確實希望這麼做, 使用 /lootlink 或 /ll 後跟下列參數: "..LOOTLINK_RESET.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_RESET_ABORTED = "|cff00ff00物品庫: 數據刪除沒有確認，操作不會執行.|r";
LOOTLINK_RESET_DONE = "|cffffff00物品庫: 所有數據已刪除.|r";
LOOTLINK_MAKEHOME_NEEDS_CONFIRM = "|cffff0000物品庫: 警告!  將不可逆地把在其他服務器記錄的物品庫數據復制為本服務器數據.  如果你確實希望這麼做, 使用 /lootlink 或 /ll 後跟下列參數: "..LOOTLINK_MAKEHOME.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_MAKEHOME_ABORTED = "|cff00ff00物品庫: makehome操作沒有確認，將不會被執行.|r";
LOOTLINK_MAKEHOME_DONE = "|cffffff00物品庫: 現存的其他服務器物品庫數據已復制為本服務器數據. 物品庫目前完全支持多服務器.|r";
LOOTLINK_LIGHTMODE_NEEDS_CONFIRM = "|cffff0000物品庫: 警告!  將禁止全文搜索, 丟失所有物品的已知文字信息, 以節約內存使用.  如果你確實希望這麼做, 使用 /lootlink 或 /ll 後跟下列參數: "..LOOTLINK_LIGHTMODE.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_LIGHTMODE_ABORTED = "|cff00ff00物品庫: 輕量模式未被確認，操作不會執行.|r";
LOOTLINK_LIGHTMODE_DONE = "|cffffff00物品庫: 輕量模式啟用.  全文搜索已被禁止，物品的注釋不再占用內存.|r";

LOOTLINK_STATUS_HEADER = "|cffffff00物品庫 (版本 %.2f) 狀態:|r";
LOOTLINK_DATA_VERSION = "物品庫: %d個物品已知[%d個在服務器 %s], 數據版本 %.2f";
LOOTLINK_INFO_HIDDEN = "物品庫: 額外的提示信息已隱藏";
LOOTLINK_INFO_SHOWN = "物品庫: 額外的提示信息已顯示";
LOOTLINK_FULL_MODE = "物品庫: 完全模式; 全文搜索啟用";
LOOTLINK_LIGHT_MODE = "物品庫: 輕量模式; 全文搜索禁用";

LOOTLINK_HELP_TEXT0 = " ";
LOOTLINK_HELP_TEXT1 = "|cffffff00物品庫命令幫助:|r";
LOOTLINK_HELP_TEXT2 = "|cff00ff00使用 |r|cffffffff/lootlink|r|cff00ff00 或 |r|cffffffff/ll|r|cff00ff00 不帶任何參數切換物品庫瀏覽窗口的開關.|r";
LOOTLINK_HELP_TEXT3 = "|cff00ff00使用 |r|cffffffff/lootlink <command>|r|cff00ff00 或 |r|cffffffff/ll <command>|r|cff00ff00 執行下列命令:|r";
LOOTLINK_HELP_TEXT4 = "|cffffffff"..LOOTLINK_HELP.."|r|cff00ff00: 顯示本信息.|r";
LOOTLINK_HELP_TEXT5 = "|cffffffff"..LOOTLINK_STATUS.."|r|cff00ff00: 顯示當前數據和設置的信息.|r";
LOOTLINK_HELP_TEXT6 = "|cffffffff"..LOOTLINK_AUCTION.."|r|cff00ff00 or |r|cffffffff"..LOOTLINK_SCAN.."|r|cff00ff00: 開始或設定一個自動的操作，掃描拍賣行中的所有物品.|r";
LOOTLINK_HELP_TEXT7 = "|cffffffff"..LOOTLINK_SHOWINFO.."|r|cff00ff00: 在所有提示框中顯示額外的信息，包括已知的售出價格.|r";
LOOTLINK_HELP_TEXT8 = "|cffffffff"..LOOTLINK_HIDEINFO.."|r|cff00ff00: 停止在提示框中顯示額外信息.|r";
LOOTLINK_HELP_TEXT9 = "|cffffffff"..LOOTLINK_FULLMODE.."|r|cff00ff00: 啟用全文搜索. 這是物品庫的缺省模式..|r";
LOOTLINK_HELP_TEXT10 = "|cffffffff"..LOOTLINK_LIGHTMODE.."|r|cff00ff00: 禁用全文搜索, 使用較少的內存.|r";
LOOTLINK_HELP_TEXT11 = " ";
LOOTLINK_HELP_TEXT12 = "|cff00ff00例如: |r|cffffffff/lootlink scan|r|cff00ff00 將在拍賣窗口開啟時開始一次拍賣行掃描.|r";

LOOTLINK_DATA_UPGRADE_HELP_TEXT0 = "|cffffff00物品庫需要你的操作以便升級為完全的多服務器支持.  使用以下命令中的一個來完成:|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT1 = "|cffffffff"..LOOTLINK_MAKEHOME.."|r|cff00ff00: 把在其他服務器記錄的物品庫數據復制為本服務器數據..|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT2 = "|cffffffff"..LOOTLINK_RESET.."|r|cff00ff00: 刪除所有物品庫數據.  如果你此前在多個服務器上使用過較早版本的物品庫, 這個是最安全的方式.|r";

LOOTLINK_DATA_UPGRADE_HELP = {
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT0, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT1, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT2, },
};

LLS_TEXT = "所有文本:";
LLS_NAME = "名字:";
LLS_RARITY = "稀有程度:";
LLS_BINDS = "綁定:";
LLS_UNIQUE = "是否唯一?";
LLS_USABLE = "可否使用?";
LLS_LOCATION = "裝備位置:";
LLS_MINIMUM_LEVEL = "最小級別:";
LLS_MAXIMUM_LEVEL = "最大級別:";
LLS_TYPE = "類型:";
LLS_SUBTYPE_ARMOR = "護甲子類型:";
LLS_SUBTYPE_WEAPON = "武器子類型:";
LLS_SUBTYPE_SHIELD = "盾牌子類型:";
LLS_SUBTYPE_RECIPE = "配方子類型:";
LLS_MINIMUM_DAMAGE = "最低傷害:";
LLS_MAXIMUM_DAMAGE = "最高傷害:";
LLS_MAXIMUM_SPEED = "最大速度:";
LLS_MINIMUM_DPS = "最小DPS:";
LLS_MINIMUM_ARMOR = "最小裝甲:";
LLS_MINIMUM_BLOCK = "最小格檔:";
LLS_MINIMUM_SLOTS = "最少空位:";
LLS_MINIMUM_SKILL = "最低技能:";
LLS_MAXIMUM_SKILL = "最高技能:";
LLS_TEXT_DISABLED = "(全文搜索已禁用)";

ANY = "所有";
POOR = "粗糙";
COMMON = "普通";
UNCOMMON = "優秀";
RARE = "精良";
EPIC = "史詩";
LEGENDARY = "傳說";
DOES_NOT = "無";
ON_EQUIP = "裝備後";
ON_PICKUP = "拾取後";
ON_USE = "使用後";
--ARMOR = "Armor"; -- already in globalstrings
WEAPON = "武器";
SHIELD = "盾牌";
CONTAINER = "容器";
OTHER = "其它";
RECIPE = "配方";
CLOTH = "布甲";
LEATHER = "皮甲";
MAIL = "鎖甲";
PLATE = "板甲";
AXE = "斧";
BOW = "弓";
DAGGER = "匕首";
MACE = "錘";
STAFF = "法杖";
SWORD = "劍";
GUN = "槍械";
WAND = "魔杖";
POLEARM = "長柄武器";
FIST_WEAPON = "拳套";
CROSSBOW = "弩";
THROWN = "投擲武器";
BUCKLER = "圓盾";
ALCHEMY = "煉金術";
BLACKSMITHING = "鍛造";
COOKING = "烹飪";
ENCHANTING = "附魔";
ENGINEERING = "工程學";
LEATHERWORKING = "制皮";
TAILORING = "裁縫";
FIRST_AID = "急救";
FISHING = "釣魚";

LOOTLINK_2H_AXE = "雙手斧";
LOOTLINK_1H_MACE = "單手錘";
LOOTLINK_2H_MACE = "雙手錘";
LOOTLINK_1H_SWORD = "單手劍";

LOOTLINK_FILTER_BIND = "(.+)後綁定";
LOOTLINK_FILTER_EQUIP = "裝備";
LOOTLINK_FILTER_PICKUP = "拾取";
LOOTLINK_FILTER_USE = "使用";
LOOTLINK_FILTER_DAMAGE = "(%d+) %- (%d+)傷害";
LOOTLINK_FILTER_SPEED = "速度 (.+)";
LOOTLINK_FILTER_DPS = "（每秒傷害(.+)）";
LOOTLINK_FILTER_ARMOR = "(%d+)點護甲";
LOOTLINK_FILTER_BLOCK = "(%d+)格擋";
LOOTLINK_FILTER_CONTAINER = "(%d+)格容器";
LOOTLINK_FILTER_REQUIRE = "需要(.+)";
LOOTLINK_FILTER_LEVEL = "等級 (%d+)";
LOOTLINK_FILTER_SKILL = "(.+)（(%d+)）";
LOOTLINK_FILTER_REQUIRELEVEL = "需要等級 .*";
LOOTLINK_FILTER_REQUIRESPILIT = "：";

LOOTLINK_TOOLTIP_INFO = "|cff40ffc0<由物品信息庫通過保存的信息生成>|r";
LOOTLINK_TOOLTIP_CONTAINER = "%d格容器";

-- For sorting
SORT_NAME = "名字";
SORT_RARITY = "稀有程度";
SORT_BINDS = "綁定";
SORT_UNIQUE = "唯一";
SORT_LOCATION = "位置";
SORT_TYPE = "類型";
SORT_SUBTYPE = "子類型";
SORT_MINDAMAGE = "最低傷害";
SORT_MAXDAMAGE = "最高傷害";
SORT_SPEED = "速度";
SORT_DPS = "每秒傷害輸出";
SORT_ARMOR = "護甲";
SORT_BLOCK = "格擋";
SORT_SLOTS = "空位";
SORT_LEVEL = "等級";
SORT_SKILL = "技能級別";
LOOTLINK_BUTTON_SCAN = "掃描";
LOOTLINK_BUTTON_SCAN_TOOLTIP = "為物品庫進行一次自動操作，\n掃描拍賣行中的所有物品.";

end