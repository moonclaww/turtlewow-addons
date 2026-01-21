if GetLocale() ~= "zhCN" then return end
--Version
SCTD.Version = "2.02";

SCTD.LOCALS = {};
SCTD.LOCALS.EXAMPLE = "SCTD";
SCTD.LOCALS.SelfFlag = "*";	

--Everything From here on would need to be translated and put
--into if statements for each specific language.

--***********
--Chinese
--***********

--Warnings
SCTD.LOCALS.Version_Warning = "载入的SCT版本错误。必须将SCT升级到4.13以上，SCTD才能正确工作";
SCTD.LOCALS.Load_Error = "|cff00ff00载入SCTD设置菜单时发生错误。设置模块可能被禁用了。|r 错误：";

--"Melee" ranged skills
SCTD.LOCALS.AUTO_SHOT = "自动射击";
SCTD.LOCALS.SHOOT = "射击";
SCTD.LOCALS.SHOOT_BOW = "弓射击";
SCTD.LOCALS.SHOOT_CROSSBOW = "弩射击";
SCTD.LOCALS.SHOOT_GUN = "枪械射击";

-- Cosmos button
SCTD.LOCALS.CB_NAME			= "SCT - Damage".." "..SCTD.Version;
SCTD.LOCALS.CB_SHORT_DESC	= "by Grayhoof";
SCTD.LOCALS.CB_LONG_DESC	= "添加你的伤害到 SCT!";
SCTD.LOCALS.CB_ICON			= "Interface\\Icons\\Ability_Warrior_BattleShout"