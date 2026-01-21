--Chinese

if GetLocale() ~= "zhCN" then return end

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "伤害", tooltipText = "显示你受到的近战伤害与环境伤害（火焰、摔落等）"};
SCT.LOCALS.OPTION_EVENT2 = {name = "未击中", tooltipText = "显示敌人未击中你的近战攻击"};
SCT.LOCALS.OPTION_EVENT3 = {name = "躲闪", tooltipText = "显示敌人被你躲闪的近战攻击"};
SCT.LOCALS.OPTION_EVENT4 = {name = "招架", tooltipText = "显示敌人被你招架的近战攻击"};
SCT.LOCALS.OPTION_EVENT5 = {name = "格挡", tooltipText = "显示敌人被你格挡的近战攻击"};
SCT.LOCALS.OPTION_EVENT6 = {name = "法术伤害", tooltipText = "显示你受到的法术伤害"};
SCT.LOCALS.OPTION_EVENT7 = {name = "法术治疗", tooltipText = "显示你受到的法术治疗"};
SCT.LOCALS.OPTION_EVENT8 = {name = "法术抵抗", tooltipText = "显示敌人被你抵抗的法术"};
SCT.LOCALS.OPTION_EVENT9 = {name = "减益效果", tooltipText = "显示你受到的减益效果影响"};
SCT.LOCALS.OPTION_EVENT10 = {name = "吸收/杂项", tooltipText = "显示你对敌人伤害的吸收、反射、免疫等"};
SCT.LOCALS.OPTION_EVENT11 = {name = "生命过低", tooltipText = "显示生命值过低警告"};
SCT.LOCALS.OPTION_EVENT12 = {name = "法力过低", tooltipText = "显示法力值过低警告"};
SCT.LOCALS.OPTION_EVENT13 = {name = "能量获得", tooltipText = "显示你通过药水、物品、增益效果等获得的法力值、怒气、能量（非正常回复）"};
SCT.LOCALS.OPTION_EVENT14 = {name = "战斗标记", tooltipText = "显示进入、脱离战斗状态的提示"};
SCT.LOCALS.OPTION_EVENT15 = {name = "连击点", tooltipText = "显示你获得的连击点"};
SCT.LOCALS.OPTION_EVENT16 = {name = "荣誉获得", tooltipText = "显示你获得的荣誉点数"};
SCT.LOCALS.OPTION_EVENT17 = {name = "增益效果", tooltipText = "显示你获得的增益效果"};
SCT.LOCALS.OPTION_EVENT18 = {name = "增益消失", tooltipText = "显示从你身上消失的增益效果"};
SCT.LOCALS.OPTION_EVENT19 = {name = "激活技能", tooltipText = "显示进入激活状态的特定技能（斩杀、猫鼬撕咬、愤怒之锤等）"};
SCT.LOCALS.OPTION_EVENT20 = {name = "声望", tooltipText = "显示声望的提高或降低"};
SCT.LOCALS.OPTION_EVENT21 = {name = "你的治疗", tooltipText = "显示你对别人的治疗"};
SCT.LOCALS.OPTION_EVENT22 = {name = "技能点数", tooltipText = "显示你技能点数的提高"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "启用 SCT", tooltipText = "启用或禁用 SCT"};
SCT.LOCALS.OPTION_CHECK2 = { name = "标记战斗信息", tooltipText = "在战斗信息两侧添加'*'标记"};
SCT.LOCALS.OPTION_CHECK3 = { name = "显示治疗者", tooltipText = "显示治疗你的玩家或生物的名字"};
SCT.LOCALS.OPTION_CHECK4 = { name = "文字向下滚动", tooltipText = "战斗信息向下滚动"};
SCT.LOCALS.OPTION_CHECK5 = { name = "致命效果", tooltipText = "以特效显示受到的致命一击或极效治疗"};
SCT.LOCALS.OPTION_CHECK6 = { name = "法术伤害类型", tooltipText = "显示你受到的法术伤害的类型"};
SCT.LOCALS.OPTION_CHECK7 = { name = "对伤害启用字体设置", tooltipText = "以SCT使用的字体显示游戏默认的伤害数字。\n\n注意：此设置必须重新登陆才能生效。重新载入界面无效。"};
SCT.LOCALS.OPTION_CHECK8 = { name = "显示所有能量获得", tooltipText = "显示所有的能量获得，而不是仅显示战斗记录中出现的。 \n\n注意：必须先启用普通的“能量获得”事件。非常刷屏。且德鲁伊在切换回施法者形态时会有不正常的现象。"};
SCT.LOCALS.OPTION_CHECK9 = { name = "FPS独立模式", tooltipText = "切换动画速度是否与FPS同步。打开后动画速度会更稳定，且在机器卡的情况下能够极大地提高动画速度。"};
SCT.LOCALS.OPTION_CHECK10 = { name = "显示过量治疗", tooltipText = "显示你的过量治疗值，必须先启用“玩家治疗”事件。"};
SCT.LOCALS.OPTION_CHECK11 = { name = "警报声音", tooltipText = "当发出警告时播放声音。"};
SCT.LOCALS.OPTION_CHECK12 = { name = "法术伤害颜色", tooltipText = "以不同的颜色显示不同类型的法术伤害（颜色不可自定义）"};
SCT.LOCALS.OPTION_CHECK13 = { name = "启用自定义事件", tooltipText = "启用自定义事件。关闭后能节省大量内存占用。"};
SCT.LOCALS.OPTION_CHECK14 = { name = "启用低耗模式", tooltipText = "启用低耗模式。低耗模式使用WoW内建的事件来驱动大部分SCT事件，减少对战斗记录的监测分析。能够提高整体性能，但部分功能将不可用，包括自定义事件。\n\n请注意这些WoW事件反馈的信息不如战斗记录丰富，而且可能会出错。"};
SCT.LOCALS.OPTION_CHECK15 = { name = "闪光", tooltipText = "在显示窗口中让致命效果闪光."};
SCT.LOCALS.OPTION_CHECK16 = { name = "击碎/碾压", tooltipText = "启用显示击碎 ~150~ 和 碾压 ^150^ 效果"};
SCT.LOCALS.OPTION_CHECK17 = { name = "显示你的HOT", tooltipText = "启用你对其他人的持续治疗法术显示。注意：如果你施放了一些法术在对象身上可能会造成非常多的显示信息。"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="文字动画速度", minText="快", maxText="慢", tooltipText = "调节动态文字滚动速度"};
SCT.LOCALS.OPTION_SLIDER2 = { name="文字大小", minText="小", maxText="大", tooltipText = "调节动态文字大小"};
SCT.LOCALS.OPTION_SLIDER3 = { name="生命百分比", minText="10%", maxText="90%", tooltipText = "设置玩家生命值降低到什么百分比时发出警告"};
SCT.LOCALS.OPTION_SLIDER4 = { name="法力百分比",  minText="10%", maxText="90%", tooltipText = "设置玩家法力值降低到什么百分比时发出警告"};
SCT.LOCALS.OPTION_SLIDER5 = { name="文字透明度", minText="0%", maxText="100%", tooltipText = "调节动态文字透明度"};
SCT.LOCALS.OPTION_SLIDER6 = { name="文字移动距离", minText="小", maxText="大", tooltipText = "调节每条动态文字间的距离"};
SCT.LOCALS.OPTION_SLIDER7 = { name="文字中心横坐标", minText="-600", maxText="600", tooltipText = "调节动态文字的位置"};
SCT.LOCALS.OPTION_SLIDER8 = { name="文字中心纵坐标", minText="-400", maxText="400", tooltipText = "调节动态文字的位置"};
SCT.LOCALS.OPTION_SLIDER9 = { name="静态信息中心横坐标", minText="-600", maxText="600", tooltipText = "调节静态信息的位置"};
SCT.LOCALS.OPTION_SLIDER10 = { name="静态信息中心纵坐标", minText="-400", maxText="400", tooltipText = "调节静态信息的位置"};
SCT.LOCALS.OPTION_SLIDER11 = { name="静态信息淡出速度", minText="快", maxText="慢", tooltipText = "调节静态信息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER12 = { name="静态信息字体大小", minText="小", maxText="大", tooltipText = "调节静态信息的文字大小"};
SCT.LOCALS.OPTION_SLIDER13 = { name="治疗者过滤", minText="0", maxText="500", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc..."};
SCT.LOCALS.OPTION_SLIDER14 = { name="法力过滤", minText="0", maxText="500", tooltipText = "Controls the minimum amount a power gain needs to be to appear in SCT. Good for filtering out frequent small power gains like Totems, Blessings, etc..."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT 设置 "..SCT.Version, tooltipText = "左键点击拖动窗口"};
--SCT.LOCALS.OPTION_MISC2 = { }; -- old option will reuse later
--SCT.LOCALS.OPTION_MISC3 = { }; -- old option will reuse later
SCT.LOCALS.OPTION_MISC4 = {name="杂项设置"};
SCT.LOCALS.OPTION_MISC5 = {name="警告设置"};
SCT.LOCALS.OPTION_MISC6 = {name="动画设置"};
SCT.LOCALS.OPTION_MISC7 = {name="选择玩家配置"};
SCT.LOCALS.OPTION_MISC8 = {name="保存并关闭", tooltipText = "保存所有当前设置并关闭设置菜单"};
SCT.LOCALS.OPTION_MISC9 = {name="重置", tooltipText = "-警告-\n\n确定要恢复所有SCT设置为默认状态吗？"};
SCT.LOCALS.OPTION_MISC10 = {name="配置", tooltipText = "选择其他角色配置方案"};
SCT.LOCALS.OPTION_MISC11 = {name="载入", tooltipText = "载入其他角色配置方案到这个角色"};
SCT.LOCALS.OPTION_MISC12 = {name="删除", tooltipText = "删除一个角色配置方案"}; 
--SCT.LOCALS.OPTION_MISC13 = { }; -- old option will reuse later
SCT.LOCALS.OPTION_MISC14 = {name="动画框1"};
SCT.LOCALS.OPTION_MISC15 = {name="静态信息"};
SCT.LOCALS.OPTION_MISC16 = {name="动画信息"};
SCT.LOCALS.OPTION_MISC17 = {name="法术设置"};
SCT.LOCALS.OPTION_MISC18 = {name="动画框"};

SCT.LOCALS.OPTION_MISC19 = {name="法术"};
SCT.LOCALS.OPTION_MISC20 = {name="动画框2"};
SCT.LOCALS.OPTION_MISC21 = {name="事件"};
SCT.LOCALS.OPTION_MISC22 = {name="典型配置", tooltipText = "载入典型配置方案。 让SCT在默认的情况下非常紧凑的显示有用的信息"};
SCT.LOCALS.OPTION_MISC23 = {name="优化配置", tooltipText = "载入优化配置方案。 选择所有的参数优化SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="分割配置", tooltipText = "载入分割配置方案。 让受到的伤害和事件在右边显示，受到的治疗和增益效果在左边显示。"};
SCT.LOCALS.OPTION_MISC25 = {name="作者配置", tooltipText = "载入作者配置方案。 设置作者使用的配置方案到SCT。"};
SCT.LOCALS.OPTION_MISC26 = {name="内建配置", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="SCTD分割配置", tooltipText = "载入SCTD分割配置方案。如果你安装了SCTD，让你受到的伤害和事件在右边显示，输出的伤害和事件在左边显示，杂项事件在顶部显示。"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="动画类型", tooltipText = "选择动态文字动画类型", table = {[1] = "垂直(默认)",[2] = "彩虹",[3] = "水平",[4] = "斜下", [5] = "斜上", [6] = "飘洒"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="弹出方式", tooltipText = "选择动态文字弹出方式", table = {[1] = "交错",[2] = "伤害向左",[3] = "伤害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="字体", tooltipText = "选择动态文字字体", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name,[5] = SCT.LOCALS.FONTS[5].name}};
SCT.LOCALS.OPTION_SELECTION4 = { name="字体描边", tooltipText = "选择动态文字字体描边类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="静态信息字体", tooltipText = "选择静态信息字体", table = {[1] = SCT.LOCALS.FONTS[1].name,[2] = SCT.LOCALS.FONTS[2].name,[3] = SCT.LOCALS.FONTS[3].name,[4] = SCT.LOCALS.FONTS[4].name,[5] = SCT.LOCALS.FONTS[5].name}};
SCT.LOCALS.OPTION_SELECTION6 = { name="静态信息字体描边", tooltipText = "选择静态信息字体描边类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
