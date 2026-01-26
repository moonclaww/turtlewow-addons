-- Default English Data for MetaMap

-- General
METAMAP_CATEGORY = "界面";
METAMAP_SUBTITLE = "世界地图模型";
METAMAP_DESC = "MetaMap 是对默认游戏地图的一款增强插件。";
METAMAP_OPTIONS_BUTTON = "选项";
METAMAP_STRING_LOCATION = "位置";
METAMAP_STRING_LEVELRANGE = "等级范围";
METAMAP_STRING_PLAYERLIMIT = "人数上限";
METAMAP_MAPLIST_INFO = "左键：追踪\n右键：编辑\nCTRL+左键：查看掉落物品";
METAMAP_BUTTON_TOOLTIP1 = "点击左键显示地图";
METAMAP_BUTTON_TOOLTIP2 = "点击右键显示选项菜单";
METAMAP_OPTIONS_TITLE = "MetaMap 选项";
METAMAP_KB_TEXT = "知识库"
METAMAP_HINT = "提示：点击左键打开MetaMap。\n点击右键显示选项菜单";
METAMAP_NOTES_SHOWN = "标记"
METAMAP_LINES_SHOWN = "标记线"
METAMAP_INFOLINE_HINT1 = "左键切换故事情节";
METAMAP_INFOLINE_HINT2 = "右键切换标记列表";
METAMAP_SEARCHTEXT = "搜索";

BINDING_HEADER_METAMAP_TITLE = "MetaMap";
BINDING_NAME_METAMAP_MAPTOGGLE = "切换世界地图";
BINDING_NAME_METAMAP_MAPTOGGLE1 = "世界地图模式 1";
BINDING_NAME_METAMAP_MAPTOGGLE2 = "世界地图模式 2";
BINDING_NAME_METAMAP_FSTOGGLE = "切换全屏模式";
BINDING_NAME_METAMAP_SAVESET = "切换地图模式";
BINDING_NAME_METAMAP_KB = "切换数据显示"
BINDING_NAME_METAMAP_KB_TARGET_UNIT = "获取目标信息";
BINDING_NAME_METAMAP_QST = "切换任务日志"
BINDING_NAME_METAMAP_QUICKNOTE = "设置快捷标记";

-- Commands
METAMAPNOTES_ENABLE_COMMANDS = { "/mapnote" }
METAMAPNOTES_ONENOTE_COMMANDS = { "/onenote", "/allowonenote", "/aon" }
METAMAPNOTES_MININOTE_COMMANDS = { "/nextmininote", "/nmn" }
METAMAPNOTES_MININOTEONLY_COMMANDS = { "/nextmininoteonly", "/nmno" }
METAMAPNOTES_MININOTEOFF_COMMANDS = { "/mininoteoff", "/mno" }
METAMAPNOTES_QUICKNOTE_COMMANDS = { "/quicknote", "/qnote", "/qtloc" }

-- Interface Configuration
METAMAP_MENU_MODE = "点击显示选项菜单";
METAMAP_OPTIONS_EXT = "增强选项";
METAMAP_OPTIONS_COORDS = "在大地图显示坐标";
METAMAP_OPTIONS_MINICOORDS = "在迷你地图显示坐标";
METAMAP_OPTIONS_SHOWAUTHOR = "显示标记创建者"
METAMAP_OPTIONS_SHOWNOTES = "标记过滤"
METAMAP_OPTIONS_FILTERON = "显示全部"
METAMAP_OPTIONS_FILTEROFF = "隐藏全部"
METAMAP_OPTIONS_SHOWBUT = "显示MetaMap按钮";
METAMAP_OPTIONS_AUTOSEL = "自动缩放提示信息框";
METAMAP_OPTIONS_BUTPOS = "MetaMap按钮位置";
METAMAP_OPTIONS_POI = "当进入新的地区时设置POI（Points Of Interest）";
METAMAP_OPTIONS_LISTCOLORS = "使用彩色列表";
METAMAP_OPTIONS_ZONEHEADER = "在世界地图顶部显示区域信息";
METAMAP_OPTIONS_MOZZ = "显示未探索";
METAMAP_OPTIONS_TRANS = "地图透明度";
METAMAP_OPTIONS_SHADER = "背景渐隐";
METAMAP_OPTIONS_SHADESET = "副本背景阴影";
METAMAP_OPTIONS_FWM = "显示未探索区域";
METAMAP_OPTIONS_DONE = "完成";
METAMAP_FLIGHTMAP_OPTIONS = "FlightMap 选项";
METAMAP_GATHERER_OPTIONS = "Gatherer 选项";
METAMAP_BWP_OPTIONS = "设置一个路点";
METAMAP_OPTIONS_SCALE = "地图尺寸";
METAMAP_OPTIONS_TTSCALE = "提示信息框尺寸";
METAMAP_OPTIONS_SAVESET = "地图显示模式";
METAMAP_OPTIONS_USEMAPMOD = "用MapMod创建标记";
METAMAP_ACTION_MODE = "地图动作模式";
METAMAPLIST_SORTED = "整理目录";
METAMAPLIST_UNSORTED = "未整理目录";
METAMAP_CLOSE_BUTTON ="关闭";

METAMAP_NOMODULE = "模块丢失或未启用!";
METAMAP_MODULETEXT = "在开始时总是加载下列模块";
METAMAP_QST_TEXT = "任务日志";
METAMAP_FWM_TEXT = "显示FWM选项";

METAMAP_LOADIMPORTS_BUTTON = "加载导入";
METAMAP_LOADEXPORTS_BUTTON = "导出用户文件";
METAMAP_IMPORTS_HEADER = "导入/导出模块";
METAMAP_RELOADUI_BUTTON = "重载插件";
METAMAP_IMPORT_BUTTON = "导入";
METAMAP_IMPORT_INSTANCE = "副本数据";
METAMAP_IMPORT_INSTANCE_INFO = "这将会导入所有为副本地图创建的标记，包括世界Boss和战场。需要'MetaMapCVT'文件夹内的'MetaMapData.lua'文件。";
METAMAP_IMPORT_NOTES = "地图标记";
METAMAP_IMPORT_NOTES_INFO = "这将为MetaMap导入由MapNotes或者MapMod创建的标记。必须把'SavedVariables'文件夹下的'MapNotes.lua'文件或者'CT_MapMod.lua'文件必须放到MetaMapCVT文件夹内。";
METAMAP_IMPORT_KB = "用户文件";
METAMAP_IMPORT_KB_INFO = "这将为MetaMap导入由用户创建的知识库标记。必须在MetaMapCVT文件夹下放入'MetaMapEXP.lua'文件。此文件由'导出用户文件'选项创建于'SavedVariables'文件夹下。";
METAMAP_IMPORT_BLT = "BLT数据";
METAMAP_IMPORT_BLT_INFO = "将会导入Boss掉落信息。需要'MetaMapCVT'文件夹内的'MetaMapBLTdata.lua'文件。如果在'MetaMapCVT'文件夹找到AtlasLoot的本地化文件，还会导入AtlasLoot的数据 。";
METAMAP_IMPORTS_INFO = "在导入后重载玩家的插件，可以确保所有导入的数据从内存清除。";

METAMAPEXP_KB_EXPORTED = "输出 |cffffffff%s|r 单独的 WKB 条目到 SavedVariables\\MetaMapEXP.lua";
METAMAPEXP_NOTES_EXPORTED = "输出 |cffffffff%s|r 单独的 Notes 条目到 SavedVariables\\MetaMapEXP.lua";
METAMAPEXP_QST_EXPORTED = "输出 |cffffffff%s|r 单独的 QST 条目到 SavedVariables\\MetaMapEXP.lua";

METAMAPFWM_RETAIN = "FWM 始终打开";
METAMAPFWM_USECOLOR = "上色未探索过的区域";
METAMAPFWM_SETCOLOR = "设置颜色";

METAKB_LOAD_MODULE = "加载模块";
METAMAP_NOKBDATA = "MetaMapWKB 模块未加载 - 知识库数据未处理";

METAMAPBLT_CONFIRM_IMPORT = "请选择希望导入的数据文件";
METAMAPBLT_CONFIRM_EXPORT = "请选择希望导出的数据文件";
METAMAPBLT_IMPORT_DONE = "MetaMapBLT 成功导入默认数据";
METAMAPBLT_IMPORT_FAIL = "所选数据未发现 - 没有数据导入";
METAMAPBLT_UPDATE_DONE = "MetaMapBLT 数据被覆盖";
METAMAPBLT_IMPORT_TIMEOUT = "超时 - 没有数据导入";
METAMAPBLT_HINT = "Shift+左键: 物品链接  -  CTRL+左键: 试衣间";
METAMAPBLT_NO_INFO = "无可用信息于此项目";
METAMAPBLT_NO_DATA = "无可用数据或者数据未导入";
METAMAPBLT_CLASS_SELECT = "在下方选择需要查询的职业";

METAMAPZSM_NEW_VERSION = "发现新的地区转换版本。请在下方选择正确的转换";
METAMAPZSM_NO_SHIFT = "地区转换已经升级。不需要转换";
METAMAPZSM_NO_DETECT = "未发现地区转换升级信息";
METAMAPZSM_UPDATE_DONE = "MetaMapZSM 地区转换升级到 |cFFFFD100%s|r 版本";
METAMAPZSM_SKIP_SHIFT = "如果已经转换则跳到下一地区转换";
METAMAPZSM_UPDATE_VERSION = "升级版本";
METAMAPZSM_UPDATE_INFO = "如果没有以上地区转换需要应用使用'升级版本'选项";

METAMAPBKP_BACKUP = "备份数据";
METAMAPBKP_RESTORE = "恢复数据";
METAMAPBKP_INFO = "备份将保存所有当前数据为一个单独文件。任何时候选择恢复用最后一次保存的数据替换当前数据 。";
METAMAPBKP_BACKUP_DONE = "已成功备份所有数据";
METAMAPBKP_RESTORE_DONE = "已成功恢复所有数据";
METAMAPBKP_NO_LOAD = "MetaMapBKP 模块丢失或未启用!";

METAMAPNOTES_WORLDMAP_HELP_1 = "右键缩小地图"
METAMAPNOTES_WORLDMAP_HELP_2 = "<Ctrl> + 左键创建标记"
METAMAPNOTES_CLICK_ON_SECOND_NOTE = "选择另一个标记 绘制/清除 标记线"
METAMAPNOTES_CLICK_ON_LOCATION = "左键在地图上确定新的标记位置"

METAMAPNOTES_NEW_NOTE = "创建标记"
METAMAPNOTES_MININOTE_OFF = "迷你地图移除"
METAMAPNOTES_OPTIONS_TEXT = "标记选项"
METAMAPNOTES_CANCEL = "取消"
METAMAPNOTES_EDIT_NOTE = "编辑标记"
METAMAPNOTES_MININOTE_ON = "迷你地图显示"
METAMAPNOTES_SEND_NOTE = "发送标记"
METAMAPNOTES_TOGGLELINE = "切换标记线"
METAMAPNOTES_MOVE_NOTE = "移动标记";
METAMAPNOTES_DELETE_NOTE = "删除标记"
METAMAPNOTES_SAVE_NOTE = "保存"
METAMAPNOTES_EDIT_TITLE = "标题 (必须)："
METAMAPNOTES_EDIT_INFO1 = "信息行1 (可选)："
METAMAPNOTES_EDIT_INFO2 = "信息行2 (可选)；"
METAMAPNOTES_EDIT_CREATOR = "创建者 (可选 - 留空隐藏)："

METAMAPNOTES_SEND_MENU = "发送标记"
METAMAPNOTES_SLASHCOMMAND = "更改模式"
METAMAPNOTES_SEND_TIP = "标记会被所有使用MetaMap的玩家接收"
METAMAPNOTES_SEND_PLAYER = "输入玩家名称："
METAMAPNOTES_SENDTOPLAYER = "发送到玩家"
METAMAPNOTES_SENDTOPARTY = "发送到队伍"
METAMAPNOTES_SHOWSEND = "更改模式"
METAMAPNOTES_SEND_SLASHTITLE = "命令行参数："
METAMAPNOTES_SEND_SLASHTIP = "高亮显示参数, 可使用 CTRL + C 复制到剪贴板\n(例如你可以把它粘贴到一个论坛)"
METAMAPNOTES_SEND_SLASHCOMMAND = "/Command:"
METAMAPNOTES_PARTYSENT = "队伍标记发送给全队成员。";
METAMAPNOTES_RAIDSENT = "队伍标记发送给全团成员。";
METAMAPNOTES_NOPARTY = "当前并未加入队伍或团队。";

METAMAPNOTES_OWNNOTES = "以当前角色名显示标记创建者"
METAMAPNOTES_OTHERNOTES = "显示从其他角色接收到的标记"
METAMAPNOTES_HIGHLIGHT_LASTCREATED = "用|cFFFF0000红色|r高亮显示最后创建的标记"
METAMAPNOTES_HIGHLIGHT_MININOTE = "用|cFF6666FF蓝色|r高亮显示选中的迷你地图标记"
METAMAPNOTES_ACCEPTINCOMING = "允许接收来自其他玩家的标记"
METAMAPNOTES_AUTOPARTYASMININOTE = "自动设置队伍标记为迷你地图标记。"
METAMAPNOTES_ZONESEARCH_TEXT = "删除 |cffffffff%s|r 上的标记且创建者为:"
METAMAPNOTES_ZONESEARCH_TEXTHINT = "提示: 打开世界地图选到希望进行删除的地区";
METAMAPNOTES_BATCHDELETE = "这将删除地图 |cFFFFD100%s|r 上所有创建者为 |cFFFFD100%s|r 的标记。";
METAMAPNOTES_DELETED_BY_NAME = "删除所有由 |cFFFFD100%s|r 创建的名为 |cFFFFD100%s|r 的标记。"
METAMAPNOTES_DELETED_BY_CREATOR = "删除所有由 |cFFFFD100%s|r 创建的标记。"
METAMAPNOTES_DELETED_BY_ZONE = "删除所有 |cFFFFD100%s|r 地图上由 |cFFFFD100%s|r 创建的标记。"

METAMAPNOTES_CREATEDBY = "创建者"
METAMAPNOTES_CHAT_COMMAND_ENABLE_INFO = "这个命令允许你插入从其他地方得到的标记比如一个网页。"
METAMAPNOTES_CHAT_COMMAND_ONENOTE_INFO = "忽略选项设置，使你可以接收下一个传入的标记。"
METAMAPNOTES_CHAT_COMMAND_MININOTE_INFO = "显示下一个传入的标记直接设置为小地图标记(同时在地图上插入标记)："
METAMAPNOTES_CHAT_COMMAND_MININOTEONLY_INFO = "显示下一个传入的标记仅设置为小地图标记(不在地图上插入标记)。"
METAMAPNOTES_CHAT_COMMAND_MININOTEOFF_INFO = "关闭迷你地图标记。"
METAMAPNOTES_CHAT_COMMAND_QUICKNOTE = "在地图上指定位置创建一个标记。"
METAMAPNOTES_MAPNOTEHELP = "该参数只能被用于插入标记"
METAMAPNOTES_ONENOTE_OFF = "允许单标记：关闭"
METAMAPNOTES_ONENOTE_ON = "允许单标记：打开"
METAMAPNOTES_MININOTE_SHOW_0 = "下一迷你地图标记：关闭"
METAMAPNOTES_MININOTE_SHOW_1 = "下一迷你地图标记：打开"
METAMAPNOTES_MININOTE_SHOW_2 = "下一迷你地图标记：仅迷你地图标记"
METAMAPNOTES_ACCEPT_NOTE = "标记添加至地图 |cFFFFD100%s|r 成功。"
METAMAPNOTES_DECLINE_NOTE = "添加标记失败，该标记离 |cFFFFD100%s|r 的 |cFFFFD100%q|r 太近。"
METAMAPNOTES_ACCEPT_MININOTE = "迷你地图标记设置于地图 |cFFFFD100%s|r.";
METAMAPNOTES_DECLINE_GET = "|cFFFFD100%s|r 尝试向你发送一个位于 |cFFFFD100%s|r 的标记，但是它离 |cFFFFD100%q|r 太近。"
METAMAPNOTES_DISABLED_GET = "不能从 |cFFFFD100%s|r 收到标记：在选项中关闭了接收。"
METAMAPNOTES_ACCEPT_GET = "你接收到来自 |cFFFFD100%s|r 的位于 |cFFFFD100%s|r 的标记。"
METAMAPNOTES_PARTY_GET = "|cFFFFD100%s|r 设置新的队伍标记在地图 |cFFFFD100%s|r。"
METAMAPNOTES_NOTE_SENT = "标记发送到 |cFFFFD100%s|r。"
METAMAPNOTES_QUICKNOTE_DEFAULTNAME = "快速标记"
METAMAPNOTES_MININOTE_DEFAULTNAME = "迷你地图标记"
METAMAPNOTES_VNOTE_DEFAULTNAME = "有效标记"
METAMAPNOTES_SETMININOTE = "设置标记为新的迷你地图标记"
METAMAPNOTES_PARTYNOTE = "队伍标记"
METAMAPNOTES_SETCOORDS = "坐标 (xx,yy)："
METAMAPNOTES_VNOTE = "有效"
METAMAPNOTES_VNOTE_INFO = "创建一个有效的标记。保存在选择绑定的地图。"
METAMAPNOTES_VNOTE_SET = "有效的标记已被创建在世界地图中。"
METAMAPNOTES_MININOTE_INFO = "仅在迷你地图上创建一个标记。"
METAMAPNOTES_INVALIDZONE = "不能创建 - 没有可用的玩家坐标在此区域。";

-- Buttons, Headers, Various Text

METAMAPNOTES_WARSONGGULCH = "战歌峡谷"
METAMAPNOTES_ALTERACVALLEY = "奥特兰克山谷"
METAMAPNOTES_ARATHIBASIN = "阿拉希盆地"

MetaMap_Data = {
	[1] = {
		["ZoneName"] = "黑暗深渊",
		["Location"] = "灰谷",
		["LevelRange"] = "24-32",
		["PlayerLimit"] = "10",
		["texture"] = "BlackfathomDeeps",
		["infoline"] = "位于灰谷佐拉姆海岸的黑暗深渊曾经是为供奉暗夜精灵月神艾露尼尔建造的。然而，在大爆炸中，神庙受到极大的冲击然后沉入了海中。它一直保持着原样——直到，其蕴含的古老的力量吸引来了纳迦和萨特。传说，古代怪兽阿库麦尔就居住在神庙遗迹中。作为古代之神最喜欢的宠物之一，阿库麦尔就一直生活在这个地区进行捕食。在阿库麦尔的吸引下，一群被称作幕光之锤的教徒也聚集在这里从事邪恶的勾当。",
	},
	[2] = {
		["ZoneName"] = "黑石深渊",
		["Location"] = "黑石山",
		["LevelRange"] = "52+",
		["PlayerLimit"] = "5",
		["texture"] = "BlackrockDepths",
		["infoline"] = "黑石深渊曾经是黑铁矮人的伟大都城，这个火山中的迷宫现在成为拉格纳罗斯火焰领主的王座所在地。拉格纳罗斯找到了使用石头和设计图来创造一支无敌石头人军对来帮助它征服黑石深渊。即使是需要打败奈法利安和他的龙子龙孙，拉格纳罗斯会不惜一切代价来达到最后的胜利。",
	},
	[3] = {
		["ZoneName"] = "黑石塔 (下)",
		["Location"] = "黑石山",
		["LevelRange"] = "55+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireLower",
		["infoline"] = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全被占为己有。",
	},
	[4] = {
		["ZoneName"] = "黑石塔 (上)",
		["Location"] = "黑石山",
		["LevelRange"] = "58+",
		["PlayerLimit"] = "10",
		["texture"] = "BlackrockSpireUpper",
		["infoline"] = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全被占为己有。",
	},
	[5] = {
		["ZoneName"] = "黑翼之巢",
		["Location"] = "黑石塔",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "BlackwingLair",
		["infoline"] = "奈法利安的圣地黑翼之巢可以在黑石尖塔的顶部找到其入口。正是在那里，在黑石山脉顶部最黑暗的地方，奈法利安酝酿着他的计划的最后阶段，他想要将拉格纳罗斯永远得摧毁并且领导他的军队横扫整个艾泽拉斯大陆的种族。奈法利安则发誓要毁灭拉格纳罗斯。因此他近期以来加速了扩张军队的步伐，就像他的父亲死亡之翼曾经尝试过的那样。虽然死亡之翼最终失败了，但看起来奈法利安很有希望获得成功。他对于权力的疯狂渴求甚至引起了红龙军团的警觉——他们一直是黑龙最强大的敌人。不过，即便奈法利安的目标非常明显，他所采用的手段却不为人知。但是据信他正在尝试杂交各种颜色的龙以制造出最强大的战士。",
	},
	[6] = {
		["ZoneName"] = "厄运之槌",
		["Location"] = "菲拉斯",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaul",
		["infoline"] = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。",
	},
	[7] = {
		["ZoneName"] = "厄运之槌 (东)",
		["Location"] = "菲拉斯",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulEast",
		["infoline"] = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。",
	},
	[8] = {
		["ZoneName"] = "厄运之槌 (北)",
		["Location"] = "菲拉斯",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulNorth",
		["infoline"] = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。",
	},
	[9] = {
		["ZoneName"] = "厄运之槌 (西)",
		["Location"] = "菲拉斯",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "DireMaulWest",
		["infoline"] = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。",
	},
	[10] = {
		["ZoneName"] = "诺莫瑞根",
		["Location"] = "丹莫罗",
		["LevelRange"] = "29-38",
		["PlayerLimit"] = "10",
		["texture"] = "Gnomeregan",
		["infoline"] = "位于丹莫罗的科技奇迹城市诺莫瑞根世代以来都是侏儒的主城。最近，一群邪恶的变异石腭怪侵入了包括侏儒主城在内的多处丹莫罗地区。为了做出殊死一搏来干掉入侵的石腭怪，大工匠梅卡托克命令打开城市中的紧急辐射水箱。侏儒在等待那些石腭怪死亡或者逃跑的同时也在寻找躲避辐射的方法。不幸的是，虽然石腭怪在经过辐射之后感染了毒性——但是它们的攻击没有停止，也没有丝毫的减弱。那些没有被辐射杀死的侏儒被迫逃离，他们在附近的矮人城市铁炉堡找到了安身之处。大工匠梅卡托克组建了一个智囊团来商议重新夺回他们挚爱的城市的计划。传说大工匠梅卡托克曾经最信任的顾问，麦克尼尔·瑟玛普拉格被判了他的人民并纵容了这次入侵的发生。现在，他的心智，麦克尼尔·瑟玛普拉格还留在诺莫瑞根中——他在继续筹划着自己黑暗的计划并成为这座城市新的科技领主。",
	},
	[11] = {
		["ZoneName"] = "玛拉顿",
		["Location"] = "凄凉之地",
		["LevelRange"] = "46-55",
		["PlayerLimit"] = "10",
		["texture"] = "Maraudon",
		["infoline"] = "玛拉顿被狂暴的玛拉顿半人马所保护，那是凄凉之地最神圣的地方。玛拉顿是扎尔塔的伟大神庙，扎尔塔是半神赛纳留斯不朽的儿子之一。传说扎尔塔和瑟莱德丝大地元素公主的私生子成为了半人马种族。据说半人马这个野蛮的种族在其出生了之后就开始转向他们的父亲并将其杀死。有些人则相信瑟莱德丝在悲伤中将扎尔塔的灵魂困了起来，并将其藏在洞中——利用它的能量来达到一些不可告人的目的。在玛拉顿错综复杂的地下通道中到处都是邪恶的半人马可汗灵魂和瑟莱德丝的元素爪牙。",
	},
	[12] = {
		["ZoneName"] = "熔火之心",
		["Location"] = "黑石深渊",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "MoltenCore",
		["infoline"] = "熔火之心位于黑石深渊的尽头。它是黑石山的心脏，以及很久以前为了不顾一切的扭转在矮人战争中的失败趋势，索瑞森大帝召唤了火焰领主——拉格纳罗斯，来到这个世界的场所。虽然火焰领主不能远离炽热核心，但是相信他的元素手下指挥着黑铁矮人，利用被赋予生命的岩石制造傀儡大军。拉格纳罗斯所沉睡的熔岩湖是一个能够连接到烈焰位面的裂口，使得邪恶的元素能够穿过。代理拉格纳罗斯领导权之一的管理者埃克索图斯是唯一有能力把火焰领主从其沉睡中唤醒的。",
	},
	[13] = {
		["ZoneName"] = "奥妮克希亚的巢穴",
		["Location"] = "尘泥沼泽",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "OnyxiasLair",
		["infoline"] = "奥妮克希亚是强大的黑龙死亡之翼的女儿，以及诡计多端的黑石塔统治者奈法利安的妹妹。据说奥妮克希亚乐于通过干涉凡人种族的政治事务来腐化他们。确信她利用各种各样的外表并使用她的魅力与力量来巧妙的影响不同种族之间的关系。一些人相信奥妮克希亚使用了一个曾经被他父亲使用过的化名——皇室头衔普瑞斯托。当并不干涉凡人的事务时，奥妮克希亚居住在一个炽热的洞穴位于尘泥沼泽的黑龙谷地下。在这里她被她的同族——剩余的黑龙军团所保卫。",
	},
	[14] = {
		["ZoneName"] = "怒焰裂谷",
		["Location"] = "奥格瑞玛",
		["LevelRange"] = "13-15",
		["PlayerLimit"] = "10",
		["texture"] = "RagefireChasm",
		["infoline"] = "怒焰裂谷是一个错综复杂的火焰洞穴，它位于兽人的新都城奥格瑞玛中。最近，有传言说一批崇拜恶魔阴影教的信徒占据了怒焰裂谷。这个被称为火刃的组织对杜隆塔尔的安全造成威胁。许多人认为兽人的酋长萨尔已经意识到了火刃的存在并不打算摧毁他们，因为萨尔希望能够将他引到阴影议会那里。不管怎么样，黑暗的力量从怒焰裂谷散发出来，它们可能毁了兽人所有的一切。",
	},
	[15] = {
		["ZoneName"] = "剃刀高地",
		["Location"] = "贫瘠之地",
		["LevelRange"] = "33-40",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenDowns",
		["infoline"] = "剃刀高地和剃刀沼泽一样由巨大的藤蔓组成，剃刀高地是野猪人的传统都城。在那错综复杂的荆棘迷宫中居住着大群忠诚的野猪人军队以及他们的高等牧师——亡首部族。然而最近，一股阴影力量笼罩了这个原始的洞穴。亡灵天灾的人在巫妖寒冰之王亚门纳尔的带领下控制了野猪部族并将荆棘迷宫变成了亡灵力量的堡垒。现在野猪人正奋力战斗来重新夺回他们的城市，并阻止亚门纳尔继续控制贫瘠之地。",
	},
	[16] = {
		["ZoneName"] = "剃刀沼泽",
		["Location"] = "贫瘠之地",
		["LevelRange"] = "25-30",
		["PlayerLimit"] = "10",
		["texture"] = "RazorfenKraul",
		["infoline"] = "在一万年前的古代战争中，万能的半神阿迦玛甘和燃烧军团进行了激战。虽然这头巨大的猪在战斗中倒下了，但是他的努力最终拯救了艾泽拉斯大陆免遭涂炭。虽然已经过去了很久，但是在它血液流淌的地方巨大的荆棘藤蔓生长出来。那些被认为是半神后代的野猪人占领了这些地区并将其奉为圣地。这些荆棘地的中心被称为剃刀岭。而巨大的剃刀沼泽则被一个老丑婆卡尔加·刺肋所占据。在她的统治下，信奉萨满教的野猪人和别的部族以及部落为敌。有些人甚至猜测卡尔加还在和亡灵天灾的有来往——她想要联合亡灵天灾来达到一些不可告人的险恶目的。",
	},
	[17] = {
		["ZoneName"] = "血色修道院",
		["Location"] = "提瑞斯法林地",
		["LevelRange"] = "34-45",
		["PlayerLimit"] = "10",
		["texture"] = "ScarletMonastery",
		["infoline"] = "血色修道院曾经是洛丹伦王国牧师的荣耀之地——那里是学习圣光知识和膜拜的中心。随着在第三次大战中亡灵天灾的崛起，宁静的修道院成为了疯狂的血色十字军的要塞。十字军对于所有非人类都有着偏激的态度，无论他们是自己的盟友还是对手。他们相信所有任何外来者都带着亡灵的瘟疫——他们必须被摧毁。有报告说所有进入修道院的冒险者都要面对血色十字军指挥官莫格莱尼——他控制了一群狂热的十字军战士。然而，修道院的真正主人是大检察官怀特迈恩——一个疯狂的牧师，她具有复活死去的战士来为其效劳的能力。",
	},
	[18] = {
		["ZoneName"] = "通灵学院",
		["Location"] = "西瘟疫之地",
		["LevelRange"] = "56-60",
		["PlayerLimit"] = "5",
		["texture"] = "Scholomance",
		["infoline"] = "通灵学院位于凯尔达隆废弃的城堡中的地下室中。那里曾经是高贵的巴罗夫家族的，但是在第二次大战中凯尔达隆变成了一块废墟。法师克尔苏加德经常向他的诅咒神教信徒承诺可以用对于巫妖王的效忠来换取永恒的生命。巴罗克家族受到克尔苏加德的魅惑而将城堡和其地下室献给了亡灵天灾。那些信徒然后将巴罗夫家族的人杀死并把地下室变成了通灵学院。虽然克尔苏加德不再住在这个地下室中，但是狂热的信徒和讲师都还留在那里。强大的巫妖，莱斯·霜语以亡灵天灾的名义控制了这里——而凡人亡灵巫师黑暗院长加丁则是这个学校邪恶的校长。",
	},
	[19] = {
		["ZoneName"] = "影牙城堡",
		["Location"] = "银松森林",
		["LevelRange"] = "22-30",
		["PlayerLimit"] = "10",
		["texture"] = "ShadowfangKeep",
		["infoline"] = "在第三次大战中，肯瑞托的法师和亡灵天灾进行了殊死的战斗。当达拉然的法师最终在战斗中战死之后，他们的意志转移到了复苏的亡灵天灾身上，然后重生了。由于对于缓慢的进展感到失望（并且对他的手下的建议不予理会）大法师阿鲁高选择召唤异次元空间的生物来壮大达拉然日渐消失的力量。阿鲁高的召唤将贪婪的狼人带到了艾泽拉斯大陆。这些狂暴的狼型生物不仅屠杀了亡灵天灾的人，而且迅速将目标转向那些法师。那些狼人开始围攻席瓦莱恩男爵的城堡。这座位于焚木村的城堡不久之后变成了黑暗势力的聚集地并从此荒废。因为对于自己罪过的愧疚，阿鲁高将那些狼人当作自己的孩子并隐居在“影牙城堡”中。据说他还住在那里，被他巨大的宠物芬鲁斯所保护着，另外，在城堡中还徘徊着席瓦莱恩男爵的那些复仇的幽灵。",
	},
	[20] = {
		["ZoneName"] = "斯坦索姆",
		["Location"] = "东瘟疫之地",
		["LevelRange"] = "55-60",
		["PlayerLimit"] = "5",
		["texture"] = "Stratholme",
		["infoline"] = "斯坦索姆曾经是洛丹伦北部一颗璀璨的明珠，但是就是在这座城市阿尔萨斯王子背叛了他的导师乌瑟尔，并屠杀了数百个被认为感染了可怕瘟疫的臣民。阿尔萨斯不久之后就向巫妖王臣服。这个破碎的城市也被巫妖克尔苏加德领导的亡灵天灾所占据。而一直由大十字军战士达索汉领导的血色十字军分遣队也占据了这个城市的一部分。这两方力量在城市中进行着激烈的战斗。而那些勇敢（亦或是愚蠢的）的冒险者在进入斯坦索姆之后将不得不面对两方的力量。据说整座城市由三座大型的通灵塔以及无数强大的亡灵巫师，女妖和憎恶所守卫着。据报告，邪恶的死亡骑士乘坐在一匹骷髅战马上——他会将怒火倾泻在任何胆敢进入亡灵天灾领域的人。",
	},
	[21] = {
		["ZoneName"] = "死亡矿井",
		["Location"] = "西部荒野",
		["LevelRange"] = "17-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheDeadmines",
		["infoline"] = "这里曾经是人类最主要的产金地，死亡矿井在部落第一次大战期间席卷暴风城的时候被废弃。现在迪菲亚兄弟会的人占据了那里并将这个黑暗的通道转变成他们的避难所。据说那些盗贼已经劝说了聪明的地精帮助他们在矿井的深处建造一些可怕的东西——但是没有人知道这是真的还是假的。有传言说，死亡矿井的入口在安宁的月溪镇中。",
	},
	[22] = {
		["ZoneName"] = "监狱",
		["Location"] = "暴风城",
		["LevelRange"] = "23-26",
		["PlayerLimit"] = "10",
		["texture"] = "TheStockades",
		["infoline"] = "监狱是位于暴风城运河区戒备森严的牢房。那里由典狱官塞尔沃特看守着，监狱是那些小偷，政治犯，谋杀者和许多最危险的罪犯的家园。最近，一场暴动导致了监狱的混乱——所有的守卫都被赶了出来，里面的罪犯可以自由的活动。典狱官塞尔沃特试图控制局面并召集勇敢的冒险者进入监狱杀死暴动的主脑——那个狡猾的巴吉尔·特雷德。",
	},
	[23] = {
		["ZoneName"] = "阿塔哈卡神庙",
		["Location"] = "悲伤沼泽",
		["LevelRange"] = "45-55",
		["PlayerLimit"] = "10",
		["texture"] = "TheSunkenTemple",
		["infoline"] = "在一千年之前，强大的古拉巴什王国被一次大型内部战争所毁灭。一部份被称为阿塔莱的巨魔牧师试图将古代血神哈卡灵魂掠夺者带回这个世界。虽然这些牧师被击败并最终被流放，这个伟大的王国变得四分五裂。流放的牧师逃到了北面，来到了悲伤沼泽。他们为哈卡建立了一座伟大的神庙——在那里他们期望能够把哈卡重新带回世间。伟大的守护神龙伊瑟拉了解了阿塔莱的计划并将神庙摧毁沉入沼泽之中。在今天，神庙沉没的遗迹被绿龙所守卫并阻止任何人进入或者出去。然而，有些阿塔莱巨魔从伊瑟拉的怒火中幸存下来并再次将自己奉献于复活哈卡的事业中。",
	},
	[24] = {
		["ZoneName"] = "奥达曼",
		["Location"] = "荒芜之地",
		["LevelRange"] = "35-47",
		["PlayerLimit"] = "10",
		["texture"] = "Uldaman",
		["infoline"] = "奥达曼是古代泰坦创世之时所留下的深埋于地下的城市。矮人探险队最近发掘到了这块被遗忘的城市，将泰坦一款失败的创造物：石腭怪唤醒了。传说泰坦是从石头中创造了石腭怪。当事实证明这次试验很失败的时候，泰坦把石腭怪锁了起来并进行了第二次的尝试——最终创造了矮人这个种族。矮人创造的秘密被记录在精密的白金圆盘中——那是位于古代城市最底部的大型泰坦遗迹。最近，黑铁矮人在奥达曼进行了一系列的侵入活动，希望为他们的火焰之主拉格纳罗斯获得圆盘。然而，在这个地下城市中，有一些巨大的石头守卫会攻击任何入侵者。而白金圆盘是由一名巨大的石头守卫阿扎达斯守护。有传言说矮人的一些石头皮肤的祖先，土灵还居住在城市的隐蔽之处。",
	},
	[25] = {
		["ZoneName"] = "哀嚎洞穴",
		["Location"] = "贫瘠之地",
		["LevelRange"] = "17-24",
		["PlayerLimit"] = "10",
		["texture"] = "WailingCaverns",
		["infoline"] = "最近一个名叫纳拉雷克斯的暗夜精灵德鲁伊在贫瘠之地中的地下发现了一个错综复杂的洞穴网。这个被称作“哀嚎洞穴”的地方有很多的蒸汽缝隙，所以当蒸气喷射的时候发出的声音就犹如哀嚎一般，其因此而得名。纳拉雷克斯可以利用洞穴中的温泉来恢复贫瘠之地的生态，让这里重新获得生机——但是这样做需要吸收传说中的翡翠梦境的能量。一旦和翡翠梦境相连接，德鲁伊的视线中就变成了一场噩梦。不久之后，哀嚎洞穴开始变化——洞中的水开始腐化——曾经温顺的生物开始变成狂暴，致命的捕食者。据说纳拉雷克斯自己还居住在这个迷宫的最深处，他被翡翠梦境的边缘所困扰着。即使他以前的随从也被他们的主人所经历的噩梦所腐化——他们都变成了邪恶的尖牙德鲁伊。",
	},
	[26] = {
		["ZoneName"] = "祖尔法拉克",
		["Location"] = "塔纳利斯",
		["LevelRange"] = "43-47",
		["PlayerLimit"] = "10",
		["texture"] = "ZulFarrak",
		["infoline"] = "日光暴晒下的这座城市是沙怒巨魔的家园，他们一向以来都以其无情和黑暗魔法而闻名。巨魔传说中有一把强大的名叫鞭笞者苏萨斯的武器能够让最弱小的人可以击败最强大的敌人。很久以前，这把武器被分成了两半。然而，有传言说这两半可以在祖尔法拉克任何地方找到。据说还有一批加基森派来的雇佣兵进入了城市并被困住。他们的命运还不得而知。但是也许最让人感到不安的是一头远古生物正沉睡在城市中心的一个神圣的水池中——它是一个半神，它会摧毁任何胆敢唤醒它的人。",
	},
	[27] = {
		["ZoneName"] = "祖尔格拉布",
		["Location"] = "荆棘谷",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "ZulGurub",
		["infoline"] = "在一千年之前强大的古拉巴什王国被一次大型内部战争所毁灭。一部份被称为阿塔莱的巨魔牧师试图将古代血神哈卡灵魂掠夺者带回这个世界。虽然这些牧师被击败并最终被流放，这个伟大的王国变得四分五裂。流放的牧师逃到了北面，来到了悲伤沼泽。他们为哈卡建立了一座伟大的神庙——在那里他们期望能够把哈卡重新带回世间。",
	},
	[28] = {
		["ZoneName"] = "安其拉神殿",
		["Location"] = "希利苏斯",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "TempleofAhnQiraj",
		["infoline"] = "在安其拉的坐落着一座远古的神庙。建于有历史记录之前，它既是用于纪念可怕的神也是一个巨大的其那军队繁殖地。自流沙之战结束一千年内，其拉帝国的双子皇帝被陷于他们的神庙，刚刚包含在由青铜龙阿纳克洛斯和暗夜精灵建立的魔法屏障之后 。现在流沙节杖将被重新组合而封印将被破坏，进入到安其拉神殿内部的路将被打开。穿过蜂房，在安其拉神殿之下，大批的其拉虫人准备着入侵。必须在他们再一次释放他们贪婪的虫人军队到卡利姆多之前不惜代价的制止他们，第二次流沙之战降临！",
	},
	[29] = {
		["ZoneName"] = "安其拉废墟",
		["Location"] = "希利苏斯",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "20",
		["texture"] = "RuinsofAhnQiraj",
		["infoline"] = "在流沙之战的最后时刻，暗夜精灵和四色飞龙军团合力把战斗推进到其拉帝国的心脏地带——安其拉的要塞城市。然而在城市大门，卡利姆多联军遭遇了集中的异种作战雄蝎，比他们之前见过的都更加强大。最后异种蝎和它们的其拉主人并未战胜，但是仅仅被囚禁在一个魔法屏障之中，战争也使得城市变为了废墟。自那以后已过了一千年，但是其拉势力并未空闲。一只新的可怕的军队已经在蜂房诞生，而安其拉废墟将再次布满成群结队的异种蝎和其拉虫人。这个威胁必须被消灭，或者整个艾泽拉斯将在新其拉军队可怕的力量前失落。",
	},
	[30] = {
		["ZoneName"] = "纳克萨玛斯",
		["Location"] = "东瘟疫之地",
		["LevelRange"] = "60+",
		["PlayerLimit"] = "40",
		["texture"] = "Naxxramas",
		["infoline"] = "飘浮在瘟疫之地上空的浮空要塞纳克萨玛斯是巫妖王最强大的副官——克尔苏加德的旗舰。巫妖王的仆从们在这座要塞中筹划着新的攻势，要给整个艾泽拉斯世界带来恐慌和灾难。天灾军团再一次开始了他们的征程……",
	},
	[31] = {
		["ZoneName"] = "热血熔炉",
		["Location"] = "地狱火堡垒",
		["LevelRange"] = "60-65",
		["PlayerLimit"] = "5",
		["texture"] = "HCBloodFurnaces",
		["infoline"] = "虽然德拉诺大部分都已经被邪恶的耐奥祖摧毁了，但地狱火堡垒依旧安然无恙。这里现在驻扎着许多皮肤赤红、野蛮狂暴的邪兽人。这个新的兽人族群从何而来依旧是个谜，不过最重要的一点是，他们的数量正在不断膨胀。\n\n尽管萨尔和格罗姆•地狱咆哮合力杀死玛诺洛斯，使得兽人部落最终摆脱了恶魔的腐蚀，但是有报告说，这些在地狱火堡垒中出现的兽人却找到了一种新的堕落能量源，以满足他们原始的嗜血欲望。\n\n这些兽人究竟为谁效命还不得而知，但可以肯定的是，他们的主人不是燃烧军团。\n\n也许从外域传来的最令人不安的消息，就是在地狱火堡垒地下的深处传来的某种雷霆一般响亮而野蛮的吼叫声。许多人猜想这与邪兽人的数量不断增加有直接的关系，但不幸的是，这些问题还没有确切的答案。\n\n至少现在如此。",
	},
	[32] = {
		["ZoneName"] = "碎裂大厅",
		["Location"] = "地狱火堡垒",
		["LevelRange"] = "70",
		["PlayerLimit"] = "5",
		["texture"] = "HCShatteredHalls",
		["infoline"] = "虽然德拉诺大部分都已经被邪恶的耐奥祖摧毁了，但地狱火堡垒依旧安然无恙。这里现在驻扎着许多皮肤赤红、野蛮狂暴的邪兽人。这个新的兽人族群从何而来依旧是个谜，不过最重要的一点是，他们的数量正在不断膨胀。\n\n尽管萨尔和格罗姆•地狱咆哮合力杀死玛诺洛斯，使得兽人部落最终摆脱了恶魔的腐蚀，但是有报告说，这些在地狱火堡垒中出现的兽人却找到了一种新的堕落能量源，以满足他们原始的嗜血欲望。\n\n这些兽人究竟为谁效命还不得而知，但可以肯定的是，他们的主人不是燃烧军团。\n\n也许从外域传来的最令人不安的消息，就是在地狱火堡垒地下的深处传来的某种雷霆一般响亮而野蛮的吼叫声。许多人猜想这与邪兽人的数量不断增加有直接的关系，但不幸的是，这些问题还没有确切的答案。\n\n至少现在如此。",
	},
};
