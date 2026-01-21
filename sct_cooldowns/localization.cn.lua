if GetLocale() ~= "zhCN" then return end 

SCTC_NAME			= "SCT Cooldowns";
SCTC_SHORTNAME		= "SCTC";
SCTC_VERSION			= "1.4.2";


SCTC_LOADMSG		= SCTC_NAME.." v"..SCTC_VERSION.." 已经加载. |c000064ff/sctc|r 显示帮助信息.";

SCTC_MSG 			= "|c000064ff"..SCTC_NAME..":|r ";
SCTC_TURNEDON		= SCTC_MSG.." |c0000ff00开启|r";
SCTC_ALREADYON		= SCTC_MSG.."已经开启.";
SCTC_TURNEDOFF		= SCTC_MSG.." |c00ff0000关闭|r.";
SCTC_ALREADYOFF		= SCTC_MSG.."已经关闭.";
SCTC_FORMATRESET		= SCTC_MSG.." |c00ff0000格式重置|r.";
SCTC_FORMATSET		= SCTC_MSG.." |c0000ff00格式设置|r: ";
SCTC_FORMATERROR		= SCTC_MSG.."|c00ff0000格式字符串中有错误.|r";
SCTC_COLORSET		= SCTC_MSG.." |c0000ff00颜色设置|r.";
SCTC_CRITTRUE			= SCTC_MSG.."这个信息现在将显示效果为 |c0000ff00致命一击|r.";
SCTC_CRITFALSE		= SCTC_MSG.."这个信息现在将显示效果为 |c00ff0000普通攻击|r.";
SCTC_DISABLED			= SCTC_MSG.."这个技能现在 |c00ff0000禁用|r.";
SCTC_ENABLED			= SCTC_MSG.."这个技能现在 |c0000ff00启用|r.";
SCTC_DISABLEDLIST		= SCTC_MSG.."已经禁用的技能:";
SCTC_WARNINGDISABLED	= SCTC_MSG.."提醒功能为 |c00ff0000禁用|r.";
SCTC_WARNINGENABLED	= SCTC_MSG.."设置提醒功能为: |c0000ff00";


SCTC_HELP = {
	[1] = SCTC_NAME.." v"..SCTC_VERSION.." by Bonecleaver (Burning Legion EU)\n",
	[2] = "/sctc or /sctcooldowns 显示帮助信息.\n",
	[3] = "/sctc [on/off] : 开启或关闭 SCTC .\n",
	[4] = "/sctc format [string/reset] : 更改或重置信息 (%s 是要被替换的技能名字).\n",
	[5] = "/sctc color [red(0.0-1.0)] [green(0.0-1.0)] [blue(0.0-1.0)] : 更改信息的颜色 (颜色值范围为 1.0 到 0.0).\n",
	[6] = "/sctc crit [true/false] : 显示信息效果为致命一击或普通攻击.\n",
	[7] = "/sctc disable [spell name] : 禁用这个技能信息. 再次输入将启用.\n",
	[8] = "/sctc list : 当前已经禁用的技能列表.\n",
	[9] = "/sctc warning [seconds] : 在技能冷却时间结束前几秒显示一个提醒信息 (0 为禁用).\n",
	[10] = "/sctc wformat [string/reset] : 更改或重置提示信息的格式 (%s 是要被替换的技能名字).",
};

SCTC_RENATAKI = "雷纳塔基的野兽护符";
SCTC_RENATAKI_SPELLS = {
	[1] = "瞄准射击",
	[2] = "多重射击",
	[3] = "奥术射击",
	[4] = "乱射",
};

SCTC_CS = "急速冷却";
SCTC_CS_SPELLS = {
	[1] = "冰霜新星",
	[2] = "寒冰护体",
	[3] = "冰锥术",
	[4] = "寒冰屏障",
	[5] = "防护冰霜结界",
};

SCTC_PREP = "预备";
SCTC_PREP_SPELLS = {
	[1] = "消失",
	[2] = "冷血",
	[3] = "疾跑",
	[4] = "预谋",
	[5] = "致盲",
	[6] = "闪避",
	[7] = "脚踢",
	[8] = "肾击",
	[9] = "鬼魅攻击",
	[10] = "扰乱",
	[11] = "佯攻",
};

SCTC_GROUPS = {
	["Arcane/Aimed Shot"] = {
		[1] = "奥术射击",
		[2] = "瞄准射击",
	},
	["Traps"] = {
		[1] = "冰冻陷阱",
		[2] = "献祭陷阱",
		[3] = "爆炸陷阱",
		[4] = "冰霜陷阱",
	},
	["Reta/SW/Reck"] = {
		[1] = "反击风暴",
		[2] = "盾墙",
		[3] = "鲁莽",
	},
	["Shocks"] = {
		[1] = "地震术",
		[2] = "烈焰震击",
		[3] = "冰霜震击",
	},
	["Wards"] = {
		[1] = "防护冰霜结界",
		[2] = "防护火焰结界",
	},
};