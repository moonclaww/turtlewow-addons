-- Chinese Simplified 


FishingTranslations["zhCN"] = {
   NAME = "钓鱼伙伴",
   DESCRIPTION1 = "记录你所钓到的鱼",
   DESCRIPTION2 = "以及管理你的钓鱼套装。",
   DESCRIPTION = "#DESCRIPTION1# #DESCRIPTION2#",

   ID = "FishingBuddy",

   WINDOW_TITLE = "#NAME# v#VERSION#",
   FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing",

   -- Tab labels and tooltips
   LOCATIONS_INFO = "显示钓鱼的地区信息",
   LOCATIONS_TAB = "本地",
   OUTFITS_INFO = "挑选钓鱼时穿的装备",
   OUTFITS_TAB = "装备",
   OPTIONS_INFO = "设置#NAME#选项",
   OPTIONS_TAB = "选项",
   TRACKING_INFO = "显示#NAME#周期性鱼类信息",
   TRACKING_TAB = "追踪",

   POINT = "点",
   POINTS = "分",

   RAW = "新鲜的",
   FISH = "鱼",

   BOBBER_NAME = "鱼漂",
   FISHINGSKILL = "钓鱼",
   HELP = "help",
   SWITCH = "switch",
   IMPORT = "import",
   TRACK = "track",
   NOTRACK = "notrack",
   TRACKING = "tracking",
   UPDATEDB = "updatedb",
   FORCE = "force",

   SCHOOL = "School",  -- e.g. 'Oily Blackmouth School'
   FLOATING_WRECKAGE = "Floating Wreckage",
   FLOATING_DEBRIS = "Floating Debris",
   ELEM_WATER = "Elemental Water",
   OIL_SPILL = "Oil Spill",

   ADD = "add",
   REPLACE = "replace",
   UPDATE = "update",
   CURRENT = "current",
   RESET = "reset",
   CLEANUP = "cleanup",
   CHECK = "check",
   NOW = "now",

   NOREALM = "未知领域",

   WATCHER = "watcher",
   WATCHER_LOCK = "lock",
   WATCHER_UNLOCK = "unlock",

   UNKNOWN = "未知的",
   WEEKLY = "每周的",
   HOURLY = "每小时的",

   OFFSET_LABEL_TEXT = "Offset:";

   KEYS_LABEL_TEXT = "修改键:",
   KEYS_NONE_TEXT = "无",
   KEYS_SHIFT_TEXT = "Shift",
   KEYS_CTRL_TEXT = "Ctrl",
   KEYS_ALT_TEXT = "Alt",

   SHOWFISHIES = "显示鱼类",
   SHOWFISHIES_INFO = "按鱼的种类分组显示钓鱼历史记录。",

   SHOWLOCATIONS = "地域信息",
   SHOWLOCATIONS_INFO = "按所钓鱼的地域分组显示钓鱼历史记录。",

   SWITCHOUTFIT = "切换装备",
   SWITCHOUTFIT_INFO = "切换钓鱼装备和当前装备。",

   -- Option names and tooltips
   CONFIG_SHOWNEWFISHIES_ONOFF   = "显示新鱼类",
   CONFIG_SHOWNEWFISHIES_INFO    = "当一条新鱼类在当前位置被钓到时显示一条消息在聊天区。",
   CONFIG_FISHWATCH_ONOFF        = "钓鱼监视器",
   CONFIG_FISHWATCH_INFO	 	 = "在当前位置显示一个钓鱼消息。",
   CONFIG_FISHWATCHONLY_ONOFF    = "仅当钓鱼时显示",
   CONFIG_FISHWATCHONLY_INFO	 = "仅在你抛出钓线且捕捉到鱼以后才开始统计并显示你的钓鱼信息",
   CONFIG_FISHWATCHSKILL_ONOFF   = "显示当前技能",
   CONFIG_FISHWATCHSKILL_INFO	 = "在钓鱼监视器区显示你当前钓鱼技能和变化。",
   CONFIG_FISHWATCHZONE_ONOFF    = "显示当前的区域",
   CONFIG_FISHWATCHZONE_INFO	 = "在钓鱼监视器区显示当前的地区。",
   CONFIG_FISHWATCHPERCENT_ONOFF = "显示捕鱼百分比",
   CONFIG_FISHWATCHPERCENT_INFO	 = "在监视器上显示各种鱼类的百分比",
   CONFIG_SUITUPFIRST_ONOFF      = "穿衣成功",
   CONFIG_SUITUPFIRST_INFO       = "当快捷键按下时如果你没有穿着钓鱼装备将穿上你的钓鱼装备",
   CONFIG_EASYCAST_ONOFF	 = "自动甩竿",
   CONFIG_EASYCAST_INFO		 = "如果开启，当你装备一个鱼竿且点击右键时，将会自动甩线。",
   CONFIG_EASYLURES_ONOFF		 = "自动上饵",
   CONFIG_EASYLURES_INFO		 = "如果开启，在你开始钓鱼前将自动安装一个鱼饵，你必须要有一个鱼饵。",
   CONFIG_ONLYMINE_ONOFF		 = "只装备竿",
   CONFIG_ONLYMINE_INFO		     = "如果开启，自动甩竿将只检查你的鱼竿是否装备（i.e. 它不会搜索所有的鱼竿进行匹配）。",
   CONFIG_MOUSEFISHING_ONOFF	 = "鼠标钓鱼",
   CONFIG_MOUSEFISHING_INFO	     = "如果开启，点击左键抛你的鱼线点击右键拾取鱼漂",
   CONFIG_SHOWLOCATIONZONES_ONOFF	= "显示区域",
   CONFIG_SHOWLOCATIONZONES_INFO	= "显示区域和子区域。",
   CONFIG_SORTBYPERCENT_ONOFF	= "按捕鱼数量排序",
   CONFIG_SORTBYPERCENT_INFO	= "顺序显示捕鱼数量代替鱼类的名字。",
   CONFIG_STVTIMER_ONOFF		= "钓鱼大赛计时器",
   CONFIG_STVTIMER_INFO		= "如果开启，将会显示一个钓鱼大赛开始倒计时和一个大赛用时计时器",
   CONFIG_STVPOOLSONLY_ONOFF	= "仅在鱼塘甩竿",
   CONFIG_STVPOOLSONLY_INFO	= "如果开启，如果指针越过一个钓鱼区自动甩竿将被开启 。",
   CONFIG_USEBUTTONHOLE_ONOFF	= "使用 ButtonHole",
   CONFIG_USEBUTTONHOLE_INFO	= "如果开启，ButtonHole插件将控制迷你地图按钮。在下一次登陆时生效。",
   CONFIG_USEGATHERER_ONOFF	= "使用 Gatherer",
   CONFIG_USEGATHERER_INFO	= "如果开启，#NAME#将把关于钓鱼区报告Gatherer插件。",

   CONFIG_SKILL_INFO		= "统计装备增加的技能值。",
   CONFIG_SKILL_TEXT		= "钓鱼 ",
   CONFIG_STYLISH_INFO		= "根据Draznar's的钓鱼指南所制定的一个模仿渔夫真实程度所得分数。",
   CONFIG_STYLISH_TEXT		= "风格：",

   CONFIG_OUTFITTER_TEXT      = "装备奖励点数：%s\r\nDraznar's风格得分：%d ",

   CLICKTOSWITCH_ONOFF	= "点击切换",
   CLICKTOSWITCH_INFO	= "如果开启，一个左键点击切换装备，否则呼出钓鱼伙伴窗口。",

   LEFTCLICKTODRAG = "点击左键拖曳",
   RIGHTCLICKFORMENU = "右键打开菜单",
   WATCHERCLICKHELP = "#LEFTCLICKTODRAG#\n#RIGHTCLICKFORMENU#",

   MINIMAPBUTTONPLACEMENT = "放置按钮",
   MINIMAPBUTTONPLACEMENTTOOLTIP = "允许你移动#NAME#图标在迷你地图周围",
   CONFIG_MINIMAPBUTTON_ONOFF	= "显示迷你地图图标",
   CONFIG_MINIMAPBUTTON_INFO	= "显示一个#NAME#图标在迷你地图上。",

   CONFIG_ENHANCESOUNDS_ONOFF      = "增强钓鱼声音",
   CONFIG_ENHANCESOUNDS_INFO       = "最大化音效音量和最小化环境音量产生鱼漂噪音更值得注意在钓鱼的时候。",

   TRACKINGFRAME = "追踪框",
   TRACKINGFRAME_RIGHTCLICK = "点击右键来拖曳鱼类线图",
   TRACKINGFRAME_LEFTCLICK = "点击左键用来选择追踪的鱼类",
-- TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
   TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#",

   TRACKFISHHOURLY = "每小时一次追踪这个鱼类",
   TRACKFISHWEEKLY = "每周一次追踪这个鱼类",
   HIDEINWATCHER = "在监视器中显示这个鱼类",

   -- messages
   COMPATIBLE_SWITCHER = "不兼容装备切换查找。",
   TOOMANYFISHERMEN = "你安装了多个自动甩竿模型。",
   FAILEDINIT = "无法正确地初始化。",
   IMPORTMSG = "导入'%s'数据库。",
   NOIMPORTMSG = "未找到 Impp、DataFish 或 FishInfo2 数据库。",
   ADDFISHIEMSG = "添加%s到本地%s。",
   ADDSCHOOLMSG = "添加'%s'到本地%s。",
   CURSORBUSYMSG = "不能切换因为鼠标正忙！",
   NOOUTFITDEFINED = "在你的钓鱼装备中你不能有任何物品。",
   NODATAMSG = "没有可用的钓鱼数据。",
   TRACKINGMSG = "追踪'%s' %s。",
   NOTRACKERRMSG = "无法删除默认的周期性鱼类。",
   NOTRACKMSG = "已删除周期性鱼类'%s'。",
   POLEALREADYEQUIPPED = "你已经装备了钓鱼装备。",
   CANTSWITCHBACK = "你已经移除了你的钓鱼装备。",
   CLEANUP_NONEMSG = "没有旧的设置保留。",
   CLEANUP_WILLMSG = "旧的设置正在保留|c#RED#%s|r：%s。",
   CLEANUP_DONEMSG = "旧的设置被移除|c#RED#%s|r：%s。",
   CLEANUP_NOOLDMSG = "没有旧的设置对于玩家|c#GREEN#%s|r。",
   NONEAVAILABLE_MSG = "无效",
   UPDATEDB_MSG = "已更新%d鱼类名称。",

   MINIMUMSKILL = "最低技能：%d",
   NOTLINKABLE = "<物品不是可联编的>",
   CAUGHTTHISMANY = "捕获%d",
   CAUGHTTHISTOTAL = "合计%d",
   FISHTYPES = "鱼类类型：%d",

   DASH = " -- ",
   FISHCAUGHT = "%d %s",
   TIMETOGO = "钓鱼大赛开始在%d:%02d",
   TIMELEFT = "钓鱼大赛结束在%d:%02d",
   FATLADYSINGS = "|c#RED#大赛结束|r (%d:%02d 离开)",
   RIGGLE_BASSBAIT = "^Riggle Bassbait .*: .*! (.*) .*!$",

   STVZONENAME = "荆棘谷",

   TOOLTIP_HINT = "提示：",
   TOOLTIP_HINTSWITCH = "点击切换装备",
   TOOLTIP_HINTTOGGLE = "点击显示#NAME#窗口。",

   -- months for Tracking frame
   ABBREV_JANUARY = "Jan",
   ABBREV_APRIL = "Apr",
   ABBREV_JULY = "Jul",
   ABBREV_OCTOBER = "Oct",
   ABBREV_DECEMBER = "Dec",

   -- Key binding support
   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "切换#NAME#窗口",
   BINDING_NAME_FISHINGBUDDY_SWITCH = "切换钓鱼装备",
   BINDING_NAME_FISHINGBUDDY_GOFISHING = "穿上钓鱼装备去钓鱼",

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "切换#NAME#本地面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "切换#NAME#装备面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "切换#NAME#追踪面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "切换#NAME#选项面",
};

FishingTranslations["zhCN"].IMPORT_HELP = {
      "|c#GREEN#/fb #IMPORT#|r",
      "    导入 Impp's fishinfo 或 FishInfo2 数据。",
};
FishingTranslations["zhCN"].SWITCH_HELP = {
      "|c#GREEN#/fb #SWITCH#|r",
      "    切换装备（如果装备显示框架是可用的）",
};
FishingTranslations["zhCN"].WATCHER_HELP = {
      "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r 或 |c#GREEN##WATCHER_UNLOCK#|r 或 |c#GREEN##RESET#|r]",
      "    解锁监视器可以移动窗口，",
      "    锁定停止移动，重置",
};
FishingTranslations["zhCN"].CURRENT_HELP = {
   "|c#GREEN#/fb #CURRENT# #RESET#|r",
   "    重置在当前任务所钓到的鱼的种类。",
};
FishingTranslations["zhCN"].UPDATEDB_HELP = {
   "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r",
   "    尝试寻找所有我不知道的鱼类名称。",
   "    尝试跳过 '稀有' 鱼类可能会使你断开",
   "    从服务器中 -- 使用 '#FORCE#' 选项来忽略检测。",

};
FishingTranslations["zhCN"].CLEANUP_HELP = {
      "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN#f#CHECK#|r 或 |c#GREEN##NOW#|r]",
      "    清理旧的设置。 |c#GREEN##CHECK#|r 列表的",
      "    设置将被移除由 |c#GREEN##NOW#|r.",
};
FishingTranslations["zhCN"].TRACKING_HELP = {
      "|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r 或 |c#GREEN##WEEKLY#|r] |c#PURPLE#<fish link>|r",
      "    记录特定种类的鱼捕捉次数（SHIFT键点击连接）",
      "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
      "    从追踪器中移除特定种类的鱼（SHIFT键点击连接）",
      "|c#GREEN#/fb #TRACKING#|r",
      "    显示被追踪鱼类的记录信息这个显示方式很不方便查看",
};

FishingTranslations["zhCN"].PRE_HELP = {
      "你可以通过|c#GREEN#/fishingbuddy|r 或 |c#GREEN#/fb|r使用全部命令",
      "|c#GREEN#/fb|r：自动，切换钓鱼伙伴窗口",
      "|c#GREEN#/fb #HELP#|r：显示以下信息",
};
FishingTranslations["zhCN"].POST_HELP = {
      "你可以为绑定窗口切换和装备",
      " 切换命令设置快捷键在\"按键设置\" 窗口。",
};

FishingTranslations["zhCN"].HELPMSG = {
      "@PRE_HELP",
      "@SWITCH_HELP",
      "@WATCHER_HELP",
      "@CURRENT_HELP",
      "@CLEANUP_HELP",
      "@IMPORT_HELP",
      "@TRACKING_HELP",
      "@UPDATEDB_HELP",
      " ",
      "@POST_HELP",
};

