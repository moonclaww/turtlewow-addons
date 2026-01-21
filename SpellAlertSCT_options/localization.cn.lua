if GetLocale() ~= "zhCN" then return end

SASCTOPTIONS_Toggle = "起用SpellAlertSCT"
SASCTOPTIONS_Crit = "显示为致命一击效果"
SASCTOPTIONS_TargetOnly = "只显示你所选择的目标信息"
SASCTOPTIONS_ReTarget = "猎人假死后重新选择为目标"
SASCTOPTIONS_Compact = "声音提醒效果(敌人 + 荆棘术)"
SASCTOPTIONS_Colorize = "法术上色效果(|cff68ccef敌人 |cffffffff获得了 |cffff0000荆棘术|cfffdd000) - 忽略其他的颜色设置"
SASCTOPTIONS_Emotes = "表情信息提醒"
SASCTOPTIONS_BossWarns = "首领警告提醒"
SASCTOPTIONS_TargetIndicator = "目标标记"

SASCTOPTIONS_MustHitEnter = "回车保存，ESC取消"


SASCTOPTIONS_Style = { name="动画效果", tooltipText = "使用哪种动画效果显示", table = {[1] = "垂直（默认）",[2] = "彩虹",[3] = "水平",[4] = "斜下", [5] = "斜上", [6] = "飘洒", [7] = "静态", [8] = "伤害"}};
SASCTOPTIONS_FrameSlider = { name="动画框", minValue = 1, maxValue = 2, valueStep = 1, minText="1", maxText="2", tooltipText = "输出到SCT的哪个动画框中"};
