-- Chinese
if GetLocale() ~= "zhCN" then return end

-- Default Spells/Emotes that will be ignored
SA_SPELLS_IGNORE = 
{	
	["炸弹"] = 1; -- 11200-2
	["废毒术"] = 1;
	["瞄准射击"] = 1;
	["奥术智慧"] = 1;
	["奥术射击"] = 1;
	["银色黎明委任勋章"] = 1;
	["猎豹守护"] = 1;
	["雄鹰守护"] = 1;
	["灵猴守护"] = 1;
	["攻击"] = 1;
	["战斗怒吼"] = 1;
	["血性狂暴"] = 1;
	["血之狂热"] = 1;
	["血之契约"] = 1;
	["战斗怒吼"] = 1;
	["战斗姿态"] = 1;
	["狂暴姿态"] = 1;
	["刀刃速攻"] = 1;
	["闪现术"] = 1;
	["零施法消耗"] = 1;
	["冷血"] = 1; 
	["震荡射击"] = 1;
	["急奔"] = 1;
	["防御姿态"] = 1;
	["侦测陷阱"] = 1;
	["虔诚光环"] = 1;
	["狂怒"] = 1;
	["闪避"] = 1;
	["爆炸射击"] = 1;
	["渐隐术"] = 1;
	["火焰抗性光环"] = 1;
	["乱舞"] = 1;
	["专注施法"] = 1;
	["急速"] = 1;
	["神圣力量"] = 1;
	["激励"] = 1;
	["朱莉叶的祝福"] = 1;
	["气定神闲"] = 1;
	["冷酷攻击"] = 1;
	["毒蛇钉刺"] = 1;
	["驱散射击"] = 1;
	["盾牌格挡"] = 1;
	["救赎之魂"] = 1;
	["精神分流"] = 1;
	["疾跑"] = 1;
	["潜行"] = 1;
	["迅捷变形"] = 1;
	["旅行形态"] = 1;
	["强击光环"] = 1;
	["蝰蛇钉刺"] = 1;
};


SA_PTN_SPELL_BEGIN_CAST = "(.+)开始施放(.+)";
SA_PTN_SPELL_GAINS_X = "(.+)获得(%d+)(.+)";
SA_PTN_SPELL_GAINS = "(.+)获得了(.+)";
SA_PTN_SPELL_TOTEM = "(.+)施放了(.+)图腾";
SA_PTN_SPELL_FADE = "(.+)效果从(.+)身上消失了";
SA_PTN_SPELL_BEGIN_PERFORM = "(.+)开始运作(.+)";

SA_WOTF = "亡灵意志";
SA_BERSERKER_RAGE = "狂暴";
SA_AFFLICT_LIVINGBOMB = "你受到了活化炸弹效果的影响";
SA_EMOTE_DEEPBREATH = "%s 开始深呼吸...";
SASCT_NOSCTD = "SCTD没有安装，确认你有最新的版本。" -- 11200-3


SASCT_HUNTER = "猎人";
SASCT_FEIGNDEATH = "假死";
SASCT_ERRNOSTYLE = "你的显示效果没有设定错误。";
SASCT_ADDONTEST = "正在测试 SpellAlertSCT。";
SASCT_ONY = "奥妮克希亚";
SASCT_EMOTESPACE = " ";
SASCT_LOADPRINT = "  by BarryJ (Eugorym of Perenolde). /sasct 显示帮助信息";
SASCT_PROFILELOADED = "配置已载入。";

SASCT_BEGIN_CAST = "开始施放";
SASCT_GAINS = "获得";

SASCT_NOSCT = "你必须安装了SCT 5.0以上的版本才能使用SpellAlertSCT。"

SASCT_USAGE_HEADER_1 = "-- 用法/帮助 ";
SASCT_USAGE_HEADER_2 = " by BarryJ (Eugorym of Perenolde)";
SASCT_USAGE_CRIT = "是否把消息设置为致命一击的显示效果。[默认为 关闭]";
SASCT_USAGE_STATUS = "显示当前的配置信息。";
SASCT_USAGE_STYLE = "消息显示所使用的动画效果。[默认为 垂直]";
SASCT_USAGE_TARGETONLY = "是否只显示当前目标的信息。[默认为 关闭]";
SASCT_USAGE_TEST = "发送一条演示用的测试消息。";
SASCT_USAGE_TARGETINDICATOR = "在目标施法信息前后加上标记。[默认为 ' *** ']";
SASCT_USAGE_RETARGET = "猎人假死后再次选择为目标。[默认为 开启]";
SASCT_USAGE_BOSSWARNINGS = "深呼吸和炸弹人报警。  [默认为 开启]";
SASCT_USAGE_TOGGLE = "切换施法提醒。[默认为 开启]";
SASCT_USAGE_COLOR = "设置自定义颜色。"; -- 11000-9
SASCT_USAGE_EMOTES = "是否显示表情信息。[默认为 开启]"; -- 11000-9
SASCT_USAGE_COMPACT = "是否声音提醒。[默认为 关闭]"; -- 11000-10
SASCT_USAGE_REPEAT = "同样的消息间隔多少秒才能显示。[默认是 2 秒]"; -- 11100-1
SASCT_USAGE_IGNORE = "切换是否使用忽略列表。[默认为 开启]"; -- 11100-2
SASCT_USAGE_IADD = "增加一个法术到忽略列表"; -- 11100-2
SASCT_USAGE_IREM = "从忽略列表删除一个法术"; -- 11100-2
SASCT_USAGE_COLORIZE = "切换是否使用法术上色功能（覆盖颜色选择）。[默认为 开启]"; -- 11100-2
SASCT_USAGE_FRAME = "设置SpellAlertSCT输出动画框（不选择则为静态信息显示效果）。[默认是 1]"; -- 11100-3


SASCT_RETARGET_1 = "重新选择目标猎人  ";
SASCT_RETARGET_2 = " : ";

SASCT_STATUS_CRIT = "用致命一击的显示效果显示事件"
SASCT_STATUS_CRIT_2 = "动画显示效果";
SASCT_STATUS_NONCRIT = "用普通的显示效果显示事件"
SASCT_STATUS_TARGETONLY_ON = "只通知你所选择的目标事件。";
SASCT_STATUS_TARGETONLY_OFF = "通知来自周围所有的事件。";
SASCT_STATUS_EMOTES_ON = "表情通知功能 启用";
SASCT_STATUS_EMOTES_OFF = "表情通知功能 关闭";
SASCT_STATUS_COLOR = "自定义颜色(r/g/b) ";
SASCT_STATUS_COLOR_DEFAULT = "为默认颜色"; -- 11000-9
SASCT_STATUS_COLOR_TARGET = "为你的目标颜色"; -- 11000-9
SASCT_STATUS_COLOR_WARN = "为报警颜色"; -- 11000-9
SASCT_STATUS_COLOR_EMOTE = "为表情颜色"; -- 11000-10
SASCT_STATUS_TARGETINDICATOR = "目标指示：";
SASCT_STATUS_TOGGLE_ON = "施法通知功能 启用"; -- 11000-9
SASCT_STATUS_TOGGLE_OFF = "施法通知功能 禁用"; -- 11000-9
SASCT_STATUS_COMPACT_ON = "声音提醒功能 开启"; -- 11000-10
SASCT_STATUS_COMPACT_OFF = "声音提醒功能 关闭"; -- 11000-10
SASCT_STATUS_BOSSWARN_ON = "首领报警功能 开启"; -- 11000-11
SASCT_STATUS_BOSSWARN_OFF = "首领报警功能 关闭"; -- 11000-11
SASCT_STATUS_REPEAT = "消息重复延时：" -- 11100-1
SASCT_STATUS_IGNORE_ON = "忽略列表过滤功能 开启"; -- 11100-2
SASCT_STATUS_IGNORE_OFF = "忽略列表过滤功能 关闭"; -- 11100-2
SASCT_STATUS_COLORIZE_ON = "法术上色功能 开启"; -- 11100-2
SASCT_STATUS_COLORIZE_OFF = "法术上色功能 关闭"; -- 11100-2
SASCT_STATUS_FRAME = "输出到SCT动画框"; -- 11100-3

SASCT_OPT_CRIT_OFF = "显示为致命一击效果 - 关闭.";
SASCT_OPT_CRIT_ON = "显示为致命一击效果 - 开启.";
SASCT_OPT_STYLE_NOSTYLE = "你必须指定一个显示效果。";
SASCT_OPT_STYLE_MESSAGE = "显示为SCT的静态信息效果。";
SASCT_OPT_STYLE_VERTICAL = "显示为垂直动画效果。";
SASCT_OPT_STYLE_RAINBOW = "显示为彩虹动画效果。";
SASCT_OPT_STYLE_HORIZONTAL = "显示为水平动画效果。";
SASCT_OPT_STYLE_ANGLEDDOWN = "显示为斜下动画效果。";
SASCT_OPT_STYLE_ANGLEDUP = "显示为斜上动画效果。";
SASCT_OPT_STYLE_SPRINKLER = "显示为飘洒动画效果。";
SASCT_OPT_STYLE_DAMAGE = "使用SCTD显示。"; -- 11200-3
SASCT_OPT_STYLE_CHOICES = "你必须选择一个显示效果[静态/垂直/彩虹/水平/斜下/斜上/飘洒/伤害]。";
SASCT_OPT_TARGETONLY_OFF = "通知来自周围所有的事件。";
SASCT_OPT_TARGETONLY_ON = "只通知你所选择的目标事件。";
SASCT_OPT_EMOTES_OFF = "表情通知功能 禁用";
SASCT_OPT_EMOTES_ON = "表情通知功能 启用";
SASCT_OPT_COLOR_COICES = "你必须在0.0到1.0之间选择一个值";
SASCT_OPT_TARGETINDICATOR_BLANK = "目标指示设置：（空）";
SASCT_OPT_TARGETINDICATOR_SET = "目标指示设置：";
SASCT_OPT_RESET = "重置设置";
SASCT_OPT_RETARGET_ON = "猎人假死后重新选择为目标功能 开启";
SASCT_OPT_RETARGET_OFF = "猎人假死后重新选择为目标功能 关闭";
SASCT_OPT_BOSSWARNINGS_ON = "首领报警功能 开启";
SASCT_OPT_BOSSWARNINGS_OFF = "首领报警功能 关闭";
SASCT_OPT_COMPACT_ON = "声音提醒功能 开启";
SASCT_OPT_COMPACT_OFF = "声音提醒功能 关闭";
SASCT_OPT_REPEAT_SET = "消息重复时间："; -- 11100-1
SASCT_OPT_REPEAT_ERROR = "你必须输入一个数字。"; --11100-1
SASCT_OPT_IGNORE_ON = "忽略列表过滤功能 开启"; -- 11100-2
SASCT_OPT_IGNORE_OFF = "忽略列表过滤功能 关闭"; -- 11100-2
SASCT_OPT_NEEDSPELL = "你必须指定一个法术"; -- 11100-2
SASCT_OPT_IADD = "现在忽略 "; -- 11100-2
SASCT_OPT_IREM = "不再忽略 "; -- 11100-2
SASCT_OPT_ILIST = "忽略: "; --11200-2
SASCT_OPT_COLORIZE_ON = "法术上色功能 开启"; -- 11100-2
SASCT_OPT_COLORIZE_OFF = "法术上色功能 关闭"; -- 11100-2
SASCT_OPT_FRAME_SET = "现在输出到动画框 "; -- 11100-3
SASCT_OPT_FRAME_ERROR = "你必须选择一个输出动画框，选择（1 或 2）"; --11100-3
SASCT_OPT_LOAD_ERROR = "载入插件选项错误："

SASCT_OPT_TOGGLE_OFF = "禁用";
SASCT_OPT_TOGGLE_ON = "启用";
SASCT_OPT_COLOR_COLORS = "你可以自定义颜色[red/green/blue]。" -- 11000-9
SASCT_OPT_COLOR_TYPES = "你可以自定义你想要修改的对象颜色[default/target/warn/emote]" -- 11000-10
