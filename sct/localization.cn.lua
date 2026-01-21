if GetLocale() ~= "zhCN" then return end 
--Version
SCT.Version = "5.11";

--Locals
SCT.LOCALS = {}
SCT.LOCALS.EXAMPLE = "SCT";
SCT.LOCALS.EXAMPLE2 = "SCT2";
SCT.LOCALS.MSG_EXAMPLE = "SCT 信息";

--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--Chinese
--***********

-- Static Messages
SCT.LOCALS.LowHP= "生命值过低！";					-- Message to be displayed when HP is low
SCT.LOCALS.LowMana= "魔法值过低！";					-- Message to be displayed when Mana is Low
SCT.LOCALS.SelfFlag = "*";								-- Icon to show self hits
SCT.LOCALS.Crushchar = "^";
SCT.LOCALS.Glancechar = "~";
SCT.LOCALS.Combat = "进入战斗";						-- Message to be displayed when entering combat
SCT.LOCALS.NoCombat = "脱离战斗";					-- Message to be displayed when leaving combat
SCT.LOCALS.ComboPoint = "连击点";			  		-- Message to be displayed when gaining a combo point
SCT.LOCALS.FiveCPMessage = "连击点已满！"; -- Message to be displayed when you have 5 combo points
SCT.LOCALS.ExtraAttack = "获得1次额外攻击！"; -- Message to be displayed when time to execute

--Option messages
SCT.LOCALS.STARTUP = "SCT "..SCT.Version.."插件已经载入，输入 /sct 显示参数";
SCT.LOCALS.Option_Crit_Tip = "将此事件以致命一击效果显示";
SCT.LOCALS.Option_Msg_Tip = "将此事件以静态消息显示，覆盖致命一击效果";
SCT.LOCALS.Frame1_Tip = "在动画框体1中显示此事件";
SCT.LOCALS.Frame2_Tip = "在动画框体2中显示此事件";

--Warnings
SCT.LOCALS.Version_Warning= "|cff00ff00SCT警告|r\n\n你当前的存档是旧版本SCT的设置。如果遇到错误或不正常现象，请点击“重置”按钮或输入/sctreset恢复默认设置。";
SCT.LOCALS.Load_Error = "|cff00ff00载入SCT设置菜单时发生错误。设置模块可能被禁用了。|r 错误：";

--nouns
SCT.LOCALS.TARGET = "目标 ";
SCT.LOCALS.PROFILE = "SCT 配置导入: |cff00ff00";
SCT.LOCALS.PROFILE_DELETE = "SCT 配置删除: |cff00ff00";
SCT.LOCALS.PROFILE_NEW = "新建 SCT 配置: |cff00ff00";
SCT.LOCALS.WARRIOR = "战士";
SCT.LOCALS.ROGUE = "盗贼";
SCT.LOCALS.HUNTER = "猎人";
SCT.LOCALS.MAGE = "法师";
SCT.LOCALS.WARLOCK = "术士";
SCT.LOCALS.DRUID = "德鲁伊";
SCT.LOCALS.PRIEST = "牧师";
SCT.LOCALS.SHAMAN = "萨满祭司";
SCT.LOCALS.PALADIN = "圣骑士";

--Useage
SCT.LOCALS.DISPLAY_USEAGE = "用法： \n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '信息' (白色文字)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "/sctdisplay '信息' 红(0-10) 绿(0-10) 蓝(0-10)\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "例如： /sctdisplay '治疗我' 10 0 0\n这样就用红色文字显示‘治疗我’这个信息\n";
SCT.LOCALS.DISPLAY_USEAGE = SCT.LOCALS.DISPLAY_USEAGE .. "一些颜色值: 红 = 10 0 0, 绿 = 0 10 0, 蓝 = 0 0 10,\n黄 = 10 10 0, 紫 = 10 0 10, 青 = 0 10 10";

--Fonts
SCT.LOCALS.FONTS = { 
	[1] = { name="剪纸", path="Fonts\\FZJZJW.TTF"},
	[2] = { name="北魏", path="Fonts\\FZBWJW.TTF"},
	[3] = { name="隶变", path="Fonts\\FZLBJW.TTF"},
	[4] = { name="细黑", path="Fonts\\FZLBJW.TTF"},
	[5] = { name="细黑", path="Fonts\\FZLBJW.TTF"},
}

-- Cosmos button
SCT.LOCALS.CB_NAME			= "SCT".." "..SCT.Version;
SCT.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCT.LOCALS.CB_LONG_DESC	= "单击打开SCT设置菜单";
SCT.LOCALS.CB_ICON			= "Interface\\Icons\\Spell_Shadow_EvilEye"; -- "Interface\\Icons\\Spell_Shadow_FarSight"