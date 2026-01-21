--Chinese

if GetLocale() ~= "zhCN" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT101 = {name = "近战伤害", tooltipText = "显示你造成的近战伤害"};
SCT.LOCALS.OPTION_EVENT102 = {name = "周期性伤害", tooltipText = "显示你造成的周期性伤害"};
SCT.LOCALS.OPTION_EVENT103 = {name = "法术/技能伤害", tooltipText = "显示你造成的法术/技能伤害"};
SCT.LOCALS.OPTION_EVENT104 = {name = "宠物伤害", tooltipText = "显示你的宠物造成的伤害"};
SCT.LOCALS.OPTION_EVENT105 = {name = "彩色致命文字", tooltipText = "以彩色文字显示致命伤害"}; 

--Check Button option values
SCT.LOCALS.OPTION_CHECK101 = { name = "启用SCTD", tooltipText = "启用SCT - Damage"};
SCT.LOCALS.OPTION_CHECK102 = { name = "标记伤害信息", tooltipText = "在伤害信息两侧添加'*'标记"};
SCT.LOCALS.OPTION_CHECK103 = { name = "法术类型", tooltipText = "显示你造成的法术伤害的类型"};
SCT.LOCALS.OPTION_CHECK104 = { name = "法术名称", tooltipText = "显示你造成伤害的法术/技能的名字"};
SCT.LOCALS.OPTION_CHECK105 = { name = "抵抗", tooltipText = "显示你被敌人抵抗了的伤害"};
SCT.LOCALS.OPTION_CHECK106 = { name = "目标名字", tooltipText = "显示目标的名字"};
SCT.LOCALS.OPTION_CHECK107 = { name = "关闭WoW伤害显示", tooltipText = "关闭WoW内建的伤害显示。\n\n注意：此设置与游戏菜单“界面->高级”中的相关设置作用相同。那里的设置更为详细。"};
SCT.LOCALS.OPTION_CHECK108 = { name = "仅限目标", tooltipText = "只显示你对当前目标造成的伤害。AE效果不会显示，除非多个目标名字重复。"};
--109 skipped, old pvp flag.
SCT.LOCALS.OPTION_CHECK110 = { name = "使用SCT动画", tooltipText = "使用SCT动画显示，而非以静态信息风格显示"};
SCT.LOCALS.OPTION_CHECK111 = { name = "伤害致命效果", tooltipText = "以特效显示你造成的致命一击或极效治疗。关闭后，将以 +1236+ 的格式显示"};
SCT.LOCALS.OPTION_CHECK112 = { name = "法术颜色", tooltipText = "以不同的颜色显示不同类型的法术伤害（颜色不可自定义）"};
SCT.LOCALS.OPTION_CHECK113 = { name = "伤害文字向下滚动", tooltipText = "伤害信息向下滚动"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER101 = { name="中心横坐标", minText="-600", maxText="600", tooltipText = "调节文字的位置"};
SCT.LOCALS.OPTION_SLIDER102 = { name="中心纵坐标", minText="-400", maxText="400", tooltipText = "调节文字的位置"};
SCT.LOCALS.OPTION_SLIDER103 = { name="淡出速度", minText="快", maxText="慢", tooltipText = "调节静态信息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER104 = { name="字体大小", minText="小", maxText="大", tooltipText = "调节文字大小"};
SCT.LOCALS.OPTION_SLIDER105 = { name="透明度", minText="0%", maxText="100%", tooltipText = "调节文字透明度"};

--Misc option values
SCT.LOCALS.OPTION_MISC101 = {name="SCTD设置"..SCTD.Version};
SCT.LOCALS.OPTION_MISC102 = {name="关闭", tooltipText = "保存所有当前设置并关闭设置菜单"};
SCT.LOCALS.OPTION_MISC103 = {name="SCTD", tooltipText = "打开 SCTD 设置菜单"};
SCT.LOCALS.OPTION_MISC104 = {name="伤害事件", tooltipText = ""};
SCT.LOCALS.OPTION_MISC105 = {name="显示设置", tooltipText = ""};
SCT.LOCALS.OPTION_MISC106 = {name="框体设置", tooltipText = ""};

--Animation Types
SCT.LOCALS.OPTION_SELECTION101 = { name="伤害字体", tooltipText = "选择文字字体", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name,[5] = SCT.LOCALS.FONTS[5].name}};
SCT.LOCALS.OPTION_SELECTION102 = { name="伤害字体描边", tooltipText = "选择文字描边类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION103 = { name="伤害动画类型", tooltipText = "选择动画类型", table = {[1] = "垂直(默认)",[2] = "彩虹",[3] = "水平",[4] = "斜下",[5] = "斜上",[6] = "飘洒"}};
SCT.LOCALS.OPTION_SELECTION104 = { name="伤害弹出方式", tooltipText = "选择弹出方式", table = {[1] = "交错",[2] = "伤害向左",[3] = "伤害向右", [4] = "全部向左", [5] = "全部向右"}};