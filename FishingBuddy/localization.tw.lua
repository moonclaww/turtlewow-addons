-- Chinese Traditional


FishingTranslations["zhTW"] = {
   NAME = "釣魚伙伴",
   DESCRIPTION1 = "記錄你所釣到的魚",
   DESCRIPTION2 = "以及管理你的釣魚套裝。",
   DESCRIPTION = "#DESCRIPTION1# #DESCRIPTION2#",

   ID = "FishingBuddy",

   WINDOW_TITLE = "#NAME# v#VERSION#",
   FISHINGTEXTURE = "Interface\\Icons\\Trade_Fishing",

   -- Tab labels and tooltips
   LOCATIONS_INFO = "顯示釣魚的地區信息",
   LOCATIONS_TAB = "本地",
   OUTFITS_INFO = "挑選釣魚時穿的裝備",
   OUTFITS_TAB = "裝備",
   OPTIONS_INFO = "設置#NAME#選項",
   OPTIONS_TAB = "選項",
   TRACKING_INFO = "顯示#NAME#周期性魚類信息",
   TRACKING_TAB = "追蹤",

   POINT = "點",
   POINTS = "分",

   RAW = "新鮮的",
   FISH = "魚",

   BOBBER_NAME = "魚漂",
   FISHINGSKILL = "釣魚",
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

   NOREALM = "未知領域",

   WATCHER = "watcher",
   WATCHER_LOCK = "lock",
   WATCHER_UNLOCK = "unlock",

   UNKNOWN = "未知的",
   WEEKLY = "每周的",
   HOURLY = "每小時的",

   OFFSET_LABEL_TEXT = "Offset:";

   KEYS_LABEL_TEXT = "修改鍵:",
   KEYS_NONE_TEXT = "無",
   KEYS_SHIFT_TEXT = "Shift",
   KEYS_CTRL_TEXT = "Ctrl",
   KEYS_ALT_TEXT = "Alt",

   SHOWFISHIES = "顯示魚類",
   SHOWFISHIES_INFO = "按魚的种類分組顯示釣魚歷史記錄。",

   SHOWLOCATIONS = "地域信息",
   SHOWLOCATIONS_INFO = "按所釣魚的地域分組顯示釣魚歷史記錄。",

   SWITCHOUTFIT = "切換裝備",
   SWITCHOUTFIT_INFO = "切換釣魚裝備和當前裝備。",

   -- Option names and tooltips
   CONFIG_SHOWNEWFISHIES_ONOFF   = "顯示新魚類",
   CONFIG_SHOWNEWFISHIES_INFO    = "當一條新魚類在當前位置被釣到時顯示一條消息在聊天區。",
   CONFIG_FISHWATCH_ONOFF        = "釣魚監視器",
   CONFIG_FISHWATCH_INFO	 	 = "在當前位置顯示一個釣魚消息。",
   CONFIG_FISHWATCHONLY_ONOFF    = "僅當釣魚時顯示",
   CONFIG_FISHWATCHONLY_INFO	 = "僅在你拋出釣線且捕捉到魚以后才開始統計并顯示你的釣魚信息",
   CONFIG_FISHWATCHSKILL_ONOFF   = "顯示當前技能",
   CONFIG_FISHWATCHSKILL_INFO	 = "在釣魚監視器區顯示你當前釣魚技能和變化。",
   CONFIG_FISHWATCHZONE_ONOFF    = "顯示當前的區域",
   CONFIG_FISHWATCHZONE_INFO	 = "在釣魚監視器區顯示當前的地區。",
   CONFIG_FISHWATCHPERCENT_ONOFF = "顯示捕魚百分比",
   CONFIG_FISHWATCHPERCENT_INFO	 = "在監視器上顯示各种魚類的百分比",
   CONFIG_SUITUPFIRST_ONOFF      = "穿衣成功",
   CONFIG_SUITUPFIRST_INFO       = "當快捷鍵按下時如果你沒有穿著釣魚裝備將穿上你的釣魚裝備",
   CONFIG_EASYCAST_ONOFF	 = "自動甩竿",
   CONFIG_EASYCAST_INFO		 = "如果開啟，當你裝備一個魚竿且點擊右鍵時，將會自動甩線。",
   CONFIG_EASYLURES_ONOFF		 = "自動上餌",
   CONFIG_EASYLURES_INFO		 = "如果開啟，在你開始釣魚前將自動安裝一個魚餌，你必須要有一個魚餌。",
   CONFIG_ONLYMINE_ONOFF		 = "只裝備竿",
   CONFIG_ONLYMINE_INFO		     = "如果開啟，自動甩竿將只檢查你的魚竿是否裝備（i.e. 它不會搜索所有的魚竿進行匹配）。",
   CONFIG_MOUSEFISHING_ONOFF	 = "鼠標釣魚",
   CONFIG_MOUSEFISHING_INFO	     = "如果開啟，點擊左鍵拋你的魚線點擊右鍵拾取魚漂",
   CONFIG_SHOWLOCATIONZONES_ONOFF	= "顯示區域",
   CONFIG_SHOWLOCATIONZONES_INFO	= "顯示區域和子區域。",
   CONFIG_SORTBYPERCENT_ONOFF	= "按捕魚數量排序",
   CONFIG_SORTBYPERCENT_INFO	= "順序顯示捕魚數量代替魚類的名字。",
   CONFIG_STVTIMER_ONOFF		= "釣魚大賽計時器",
   CONFIG_STVTIMER_INFO		= "如果開啟，將會顯示一個釣魚大賽開始倒計時和一個大賽用時計時器",
   CONFIG_STVPOOLSONLY_ONOFF	= "僅在魚塘甩竿",
   CONFIG_STVPOOLSONLY_INFO	= "如果開啟，如果指針越過一個釣魚區自動甩竿將被開啟 。",
   CONFIG_USEBUTTONHOLE_ONOFF	= "使用 ButtonHole",
   CONFIG_USEBUTTONHOLE_INFO	= "如果開啟，ButtonHole插件將控制迷你地圖按鈕。在下一次登陸時生效。",
   CONFIG_USEGATHERER_ONOFF	= "使用 Gatherer",
   CONFIG_USEGATHERER_INFO	= "如果開啟，#NAME#將把關于釣魚區報告Gatherer插件。",

   CONFIG_SKILL_INFO		= "統計裝備增加的技能值。",
   CONFIG_SKILL_TEXT		= "釣魚 ",
   CONFIG_STYLISH_INFO		= "根据Draznar's的釣魚指南所制定的一個模仿漁夫真實程度所得分數。",
   CONFIG_STYLISH_TEXT		= "風格：",

   CONFIG_OUTFITTER_TEXT      = "裝備獎勵點數：%s\r\nDraznar's風格得分：%d ",

   CLICKTOSWITCH_ONOFF	= "點擊切換",
   CLICKTOSWITCH_INFO	= "如果開啟，一個左鍵點擊切換裝備，否則呼出釣魚伙伴窗口。",

   LEFTCLICKTODRAG = "點擊左鍵拖曳",
   RIGHTCLICKFORMENU = "右鍵打開菜單",
   WATCHERCLICKHELP = "#LEFTCLICKTODRAG#\n#RIGHTCLICKFORMENU#",

   MINIMAPBUTTONPLACEMENT = "放置按鈕",
   MINIMAPBUTTONPLACEMENTTOOLTIP = "允許你移動#NAME#圖標在迷你地圖周圍",
   CONFIG_MINIMAPBUTTON_ONOFF	= "顯示迷你地圖圖標",
   CONFIG_MINIMAPBUTTON_INFO	= "顯示一個#NAME#圖標在迷你地圖上。",

   CONFIG_ENHANCESOUNDS_ONOFF      = "增強釣魚聲音",
   CONFIG_ENHANCESOUNDS_INFO       = "最大化音效音量和最小化環境音量產生魚漂噪音更值得注意在釣魚的時候。",

   TRACKINGFRAME = "追蹤框",
   TRACKINGFRAME_RIGHTCLICK = "點擊右鍵來拖曳魚類線圖",
   TRACKINGFRAME_LEFTCLICK = "點擊左鍵用來選擇追蹤的魚類",
-- TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#\r#TRACKINGFRAME_LEFTCLICK#",
   TRACKINGFRAME_CLICKS = "#TRACKINGFRAME_RIGHTCLICK#",

   TRACKFISHHOURLY = "每小時一次追蹤這個魚類",
   TRACKFISHWEEKLY = "每周一次追蹤這個魚類",
   HIDEINWATCHER = "在監視器中顯示這個魚類",

   -- messages
   COMPATIBLE_SWITCHER = "不兼容裝備切換查找。",
   TOOMANYFISHERMEN = "你安裝了多個自動甩竿模型。",
   FAILEDINIT = "無法正确地初始化。",
   IMPORTMSG = "導入'%s'數据庫。",
   NOIMPORTMSG = "未找到 Impp、DataFish 或 FishInfo2 數据庫。",
   ADDFISHIEMSG = "添加%s到本地%s。",
   ADDSCHOOLMSG = "添加'%s'到本地%s。",
   CURSORBUSYMSG = "不能切換因為鼠標正忙！",
   NOOUTFITDEFINED = "在你的釣魚裝備中你不能有任何物品。",
   NODATAMSG = "沒有可用的釣魚數据。",
   TRACKINGMSG = "追蹤'%s' %s。",
   NOTRACKERRMSG = "無法刪除默認的周期性魚類。",
   NOTRACKMSG = "已刪除周期性魚類'%s'。",
   POLEALREADYEQUIPPED = "你已經裝備了釣魚裝備。",
   CANTSWITCHBACK = "你已經移除了你的釣魚裝備。",
   CLEANUP_NONEMSG = "沒有舊的設置保留。",
   CLEANUP_WILLMSG = "舊的設置正在保留|c#RED#%s|r：%s。",
   CLEANUP_DONEMSG = "舊的設置被移除|c#RED#%s|r：%s。",
   CLEANUP_NOOLDMSG = "沒有舊的設置對于玩家|c#GREEN#%s|r。",
   NONEAVAILABLE_MSG = "無效",
   UPDATEDB_MSG = "已更新%d魚類名稱。",

   MINIMUMSKILL = "最低技能：%d",
   NOTLINKABLE = "<物品不是可聯編的>",
   CAUGHTTHISMANY = "捕獲%d",
   CAUGHTTHISTOTAL = "合計%d",
   FISHTYPES = "魚類類型：%d",

   DASH = " -- ",
   FISHCAUGHT = "%d %s",
   TIMETOGO = "釣魚大賽開始在%d:%02d",
   TIMELEFT = "釣魚大賽結束在%d:%02d",
   FATLADYSINGS = "|c#RED#大賽結束|r (%d:%02d 离開)",
   RIGGLE_BASSBAIT = "^Riggle Bassbait .*: .*! (.*) .*!$",

   STVZONENAME = "荊棘谷",

   TOOLTIP_HINT = "提示：",
   TOOLTIP_HINTSWITCH = "點擊切換裝備",
   TOOLTIP_HINTTOGGLE = "點擊顯示#NAME#窗口。",

   -- months for Tracking frame
   ABBREV_JANUARY = "Jan",
   ABBREV_APRIL = "Apr",
   ABBREV_JULY = "Jul",
   ABBREV_OCTOBER = "Oct",
   ABBREV_DECEMBER = "Dec",

   -- Key binding support
   BINDING_HEADER_FISHINGBUDDY_BINDINGS = "#NAME#",
   BINDING_NAME_FISHINGBUDDY_TOGGLE = "切換#NAME#窗口",
   BINDING_NAME_FISHINGBUDDY_SWITCH = "切換釣魚裝備",
   BINDING_NAME_FISHINGBUDDY_GOFISHING = "穿上釣魚裝備去釣魚",

   BINDING_NAME_TOGGLEFISHINGBUDDY_LOC = "切換#NAME#本地面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OUT = "切換#NAME#裝備面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_TRK = "切換#NAME#追蹤面",
   BINDING_NAME_TOGGLEFISHINGBUDDY_OPT = "切換#NAME#選項面",
};

FishingTranslations["zhTW"].IMPORT_HELP = {
      "|c#GREEN#/fb #IMPORT#|r",
      "    導入 Impp's fishinfo 或 FishInfo2 數据。",
};
FishingTranslations["zhTW"].SWITCH_HELP = {
      "|c#GREEN#/fb #SWITCH#|r",
      "    切換裝備（如果裝備顯示框架是可用的）",
};
FishingTranslations["zhTW"].WATCHER_HELP = {
      "|c#GREEN#/fb #WATCHER#|r [|c#GREEN##WATCHER_LOCK#|r 或 |c#GREEN##WATCHER_UNLOCK#|r 或 |c#GREEN##RESET#|r]",
      "    解鎖監視器可以移動窗口，",
      "    鎖定停止移動，重置",
};
FishingTranslations["zhTW"].CURRENT_HELP = {
   "|c#GREEN#/fb #CURRENT# #RESET#|r",
   "    重置在當前任務所釣到的魚的种類。",
};
FishingTranslations["zhTW"].UPDATEDB_HELP = {
   "|c#GREEN#/fb #UPDATEDB# [#FORCE#]|r",
   "    嘗試尋找所有我不知道的魚類名稱。",
   "    嘗試跳過 '稀有' 魚類可能會使你斷開",
   "    從服務器中 -- 使用 '#FORCE#' 選項來忽略檢測。",
};
FishingTranslations["zhTW"].CLEANUP_HELP = {
      "|c#GREEN#/fb #CLEANUP#|r [|c#GREEN#f#CHECK#|r 或 |c#GREEN##NOW#|r]",
      "    清理舊的設置。 |c#GREEN##CHECK#|r 列表的",
      "    設置將被移除由 |c#GREEN##NOW#|r.",
};
FishingTranslations["zhTW"].TRACKING_HELP = {
      "|c#GREEN#/fb #TRACK#|r [|c#GREEN##HOURLY#|r 或 |c#GREEN##WEEKLY#|r] |c#PURPLE#<fish link>|r",
      "    記錄特定种類的魚捕捉次數（SHIFT鍵點擊連接）",
      "|c#GREEN#/fb #NOTRACK#|r |c#PURPLE#<fish link>|r",
      "    從追蹤器中移除特定种類的魚（SHIFT鍵點擊連接）",
      "|c#GREEN#/fb #TRACKING#|r",
      "    顯示被追蹤魚類的記錄信息這個顯示方式很不方便查看",
};

FishingTranslations["zhTW"].PRE_HELP = {
      "你可以通過|c#GREEN#/fishingbuddy|r 或 |c#GREEN#/fb|r使用全部命令",
      "|c#GREEN#/fb|r：自動，切換釣魚伙伴窗口",
      "|c#GREEN#/fb #HELP#|r：顯示以下信息",
};
FishingTranslations["zhTW"].POST_HELP = {
      "你可以為綁定窗口切換和裝備",
      " 切換命令設置快捷鍵在\"按鍵設置\" 窗口。",
};

FishingTranslations["zhTW"].HELPMSG = {
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

