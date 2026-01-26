-- Version : English, Chinese ( by iWOW )
-- Last Update : 03/21/2005

--------------------------------------------------------------------------------------------------
-- Localizable strings
--------------------------------------------------------------------------------------------------

BINDING_HEADER_LOOTLINK = "物品库按钮";
BINDING_NAME_TOGGLELOOTLINK = "切换物品库显示";
LOOTLINK_TITLE = "物品库";
LOOTLINK_SHORTDESC = "浏览窗口";
LOOTLINK_DESC = "浏览你使用物品库以后看到过的所有物品";
LOOTLINK_SEARCH_TITLE = "物品库搜索";
LOOTLINK_TITLE_FORMAT_SINGULAR = "物品库 - 总计 1 个物品";
LOOTLINK_TITLE_FORMAT_PLURAL = "物品库 - 总计 %d 个物品";
LOOTLINK_TITLE_FORMAT_PARTIAL_SINGULAR = "物品库 - 找到 1 个物品";
LOOTLINK_TITLE_FORMAT_PARTIAL_PLURAL = "物品库 - 找到 %d 个物品";
LOOTLINK_SEARCH_LABEL = "搜索...";
LOOTLINK_REFRESH_LABEL = "刷新";
LOOTLINK_RESET_LABEL = "重置";
LOOTLINK_AUCTION_SCAN_START = "物品库: 扫描第 1 页...";
LOOTLINK_AUCTION_PAGE_N = "物品库: 扫描第 %d 页，共 %d 页...";
LOOTLINK_AUCTION_SCAN_DONE = "物品库: 拍卖行扫描完成";
LOOTLINK_SELL_PRICE = "售价:";
LOOTLINK_SELL_PRICE_N = "%d个售价:";
LOOTLINK_SELL_PRICE_EACH = "每个售价:";
LOOTLINK_SCHEDULED_AUCTION_SCAN = "物品库: 将在你下次与拍卖商对话时执行一次完全的拍卖行扫描.";

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

LOOTLINK_RESET_NEEDS_CONFIRM = "|cffff0000物品库: 警告!  将不可逆地删除所有物品库数据.  如果你确实希望这么做, 使用 /lootlink 或 /ll 后跟下列参数: "..LOOTLINK_RESET.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_RESET_ABORTED = "|cff00ff00物品库: 数据删除没有确认，操作不会执行.|r";
LOOTLINK_RESET_DONE = "|cffffff00物品库: 所有数据已删除.|r";
LOOTLINK_MAKEHOME_NEEDS_CONFIRM = "|cffff0000物品库: 警告!  将不可逆地把在其他服务器记录的物品库数据复制为本服务器数据.  如果你确实希望这么做, 使用 /lootlink 或 /ll 后跟下列参数: "..LOOTLINK_MAKEHOME.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_MAKEHOME_ABORTED = "|cff00ff00物品库: makehome操作没有确认，将不会被执行.|r";
LOOTLINK_MAKEHOME_DONE = "|cffffff00物品库: 现存的其他服务器物品库数据已复制为本服务器数据. 物品库目前完全支持多服务器.|r";
LOOTLINK_LIGHTMODE_NEEDS_CONFIRM = "|cffff0000物品库: 警告!  将禁止全文搜索, 丢失所有物品的已知文字信息, 以节约内存使用.  如果你确实希望这么做, 使用 /lootlink 或 /ll 后跟下列参数: "..LOOTLINK_LIGHTMODE.." "..LOOTLINK_CONFIRM.."|r";
LOOTLINK_LIGHTMODE_ABORTED = "|cff00ff00物品库: 轻量模式未被确认，操作不会执行.|r";
LOOTLINK_LIGHTMODE_DONE = "|cffffff00物品库: 轻量模式启用.  全文搜索已被禁止，物品的注释不再占用内存.|r";

LOOTLINK_STATUS_HEADER = "|cffffff00物品库 (版本 %.2f) 状态:|r";
LOOTLINK_DATA_VERSION = "物品库: %d个物品已知[%d个在服务器 %s], 数据版本 %.2f";
LOOTLINK_INFO_HIDDEN = "物品库: 额外的提示信息已隐藏";
LOOTLINK_INFO_SHOWN = "物品库: 额外的提示信息已显示";
LOOTLINK_FULL_MODE = "物品库: 完全模式; 全文搜索启用";
LOOTLINK_LIGHT_MODE = "物品库: 轻量模式; 全文搜索禁用";

LOOTLINK_HELP_TEXT0 = " ";
LOOTLINK_HELP_TEXT1 = "|cffffff00物品库命令帮助:|r";
LOOTLINK_HELP_TEXT2 = "|cff00ff00使用 |r|cffffffff/lootlink|r|cff00ff00 或 |r|cffffffff/ll|r|cff00ff00 不带任何参数切换物品库浏览窗口的开关.|r";
LOOTLINK_HELP_TEXT3 = "|cff00ff00使用 |r|cffffffff/lootlink <command>|r|cff00ff00 或 |r|cffffffff/ll <command>|r|cff00ff00 执行下列命令:|r";
LOOTLINK_HELP_TEXT4 = "|cffffffff"..LOOTLINK_HELP.."|r|cff00ff00: 显示本信息.|r";
LOOTLINK_HELP_TEXT5 = "|cffffffff"..LOOTLINK_STATUS.."|r|cff00ff00: 显示当前数据和设置的信息.|r";
LOOTLINK_HELP_TEXT6 = "|cffffffff"..LOOTLINK_AUCTION.."|r|cff00ff00 or |r|cffffffff"..LOOTLINK_SCAN.."|r|cff00ff00: 开始或设定一个自动的操作，扫描拍卖行中的所有物品.|r";
LOOTLINK_HELP_TEXT7 = "|cffffffff"..LOOTLINK_SHOWINFO.."|r|cff00ff00: 在所有提示框中显示额外的信息，包括已知的售出价格.|r";
LOOTLINK_HELP_TEXT8 = "|cffffffff"..LOOTLINK_HIDEINFO.."|r|cff00ff00: 停止在提示框中显示额外信息.|r";
LOOTLINK_HELP_TEXT9 = "|cffffffff"..LOOTLINK_FULLMODE.."|r|cff00ff00: 启用全文搜索. 这是物品库的缺省模式..|r";
LOOTLINK_HELP_TEXT10 = "|cffffffff"..LOOTLINK_LIGHTMODE.."|r|cff00ff00: 禁用全文搜索, 使用较少的内存.|r";
LOOTLINK_HELP_TEXT11 = " ";
LOOTLINK_HELP_TEXT12 = "|cff00ff00例如: |r|cffffffff/lootlink scan|r|cff00ff00 将在拍卖窗口开启时开始一次拍卖行扫描.|r";

LOOTLINK_DATA_UPGRADE_HELP_TEXT0 = "|cffffff00物品库需要你的操作以便升级为完全的多服务器支持.  使用以下命令中的一个来完成:|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT1 = "|cffffffff"..LOOTLINK_MAKEHOME.."|r|cff00ff00: 把在其他服务器记录的物品库数据复制为本服务器数据..|r";
LOOTLINK_DATA_UPGRADE_HELP_TEXT2 = "|cffffffff"..LOOTLINK_RESET.."|r|cff00ff00: 删除所有物品库数据.  如果你此前在多个服务器上使用过较早版本的物品库, 这个是最安全的方式.|r";

LOOTLINK_DATA_UPGRADE_HELP = {
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT0, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT1, },
	{ version = 110, text = LOOTLINK_DATA_UPGRADE_HELP_TEXT2, },
};

LLS_TEXT = "所有文本:";
LLS_NAME = "名字:";
LLS_RARITY = "稀有程度:";
LLS_BINDS = "绑定:";
LLS_UNIQUE = "是否唯一?";
LLS_USABLE = "可否使用?";
LLS_LOCATION = "装备位置:";
LLS_MINIMUM_LEVEL = "最小级别:";
LLS_MAXIMUM_LEVEL = "最大级别:";
LLS_TYPE = "类型:";
LLS_SUBTYPE_ARMOR = "护甲子类型:";
LLS_SUBTYPE_WEAPON = "武器子类型:";
LLS_SUBTYPE_SHIELD = "盾牌子类型:";
LLS_SUBTYPE_RECIPE = "配方子类型:";
LLS_MINIMUM_DAMAGE = "最低伤害:";
LLS_MAXIMUM_DAMAGE = "最高伤害:";
LLS_MAXIMUM_SPEED = "最大速度:";
LLS_MINIMUM_DPS = "最小DPS:";
LLS_MINIMUM_ARMOR = "最小装甲:";
LLS_MINIMUM_BLOCK = "最小格档:";
LLS_MINIMUM_SLOTS = "最少空位:";
LLS_MINIMUM_SKILL = "最低技能:";
LLS_MAXIMUM_SKILL = "最高技能:";
LLS_TEXT_DISABLED = "(全文搜索已禁用)";

ANY = "所有";
POOR = "粗糙";
COMMON = "普通";
UNCOMMON = "优秀";
RARE = "精良";
EPIC = "史诗";
LEGENDARY = "传说";
DOES_NOT = "无";
ON_EQUIP = "装备后";
ON_PICKUP = "拾取后";
ON_USE = "使用后";
--ARMOR = "Armor"; -- already in globalstrings
WEAPON = "武器";
SHIELD = "盾牌";
CONTAINER = "容器";
OTHER = "其它";
RECIPE = "配方";
CLOTH = "布甲";
LEATHER = "皮甲";
MAIL = "锁甲";
PLATE = "板甲";
AXE = "斧";
BOW = "弓";
DAGGER = "匕首";
MACE = "锤";
STAFF = "法杖";
SWORD = "剑";
GUN = "枪械";
WAND = "魔杖";
POLEARM = "长柄武器";
FIST_WEAPON = "拳套";
CROSSBOW = "弩";
THROWN = "投掷武器";
BUCKLER = "圆盾";
ALCHEMY = "炼金术";
BLACKSMITHING = "锻造";
COOKING = "烹饪";
ENCHANTING = "附魔";
ENGINEERING = "工程学";
LEATHERWORKING = "制皮";
TAILORING = "裁缝";
FIRST_AID = "急救";
FISHING = "钓鱼";

LOOTLINK_2H_AXE = "双手斧";
LOOTLINK_1H_MACE = "单手锤";
LOOTLINK_2H_MACE = "双手锤";
LOOTLINK_1H_SWORD = "单手剑";

LOOTLINK_FILTER_BIND = "(.+)后绑定";
LOOTLINK_FILTER_EQUIP = "装备";
LOOTLINK_FILTER_PICKUP = "拾取";
LOOTLINK_FILTER_USE = "使用";
LOOTLINK_FILTER_DAMAGE = "(%d+) %- (%d+)伤害";
LOOTLINK_FILTER_SPEED = "速度 (.+)";
LOOTLINK_FILTER_DPS = "（每秒伤害(.+)）";
LOOTLINK_FILTER_ARMOR = "(%d+)点护甲";
LOOTLINK_FILTER_BLOCK = "(%d+)格挡";
LOOTLINK_FILTER_CONTAINER = "(%d+)格容器";
LOOTLINK_FILTER_REQUIRE = "需要(.+)";
LOOTLINK_FILTER_LEVEL = "等级 (%d+)";
LOOTLINK_FILTER_SKILL = "(.+)（(%d+)）";
LOOTLINK_FILTER_REQUIRELEVEL = "需要等级 .*";
LOOTLINK_FILTER_REQUIRESPILIT = "：";

LOOTLINK_TOOLTIP_INFO = "|cff40ffc0<由物品信息库通过保存的信息生成>|r";
LOOTLINK_TOOLTIP_CONTAINER = "%d格容器";

-- For sorting
SORT_NAME = "名字";
SORT_RARITY = "稀有程度";
SORT_BINDS = "绑定";
SORT_UNIQUE = "唯一";
SORT_LOCATION = "位置";
SORT_TYPE = "类型";
SORT_SUBTYPE = "子类型";
SORT_MINDAMAGE = "最低伤害";
SORT_MAXDAMAGE = "最高伤害";
SORT_SPEED = "速度";
SORT_DPS = "每秒伤害输出";
SORT_ARMOR = "护甲";
SORT_BLOCK = "格挡";
SORT_SLOTS = "空位";
SORT_LEVEL = "等级";
SORT_SKILL = "技能级别";
LOOTLINK_BUTTON_SCAN = "扫描";
LOOTLINK_BUTTON_SCAN_TOOLTIP = "为物品库进行一次自动操作，\n扫描拍卖行中的所有物品.";
