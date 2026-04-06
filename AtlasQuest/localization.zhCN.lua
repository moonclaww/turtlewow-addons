if ( GetLocale() == "zhCN" ) then
------------ TEXT VARIABLEN

--Color
local GREY = "|cff999999";
local RED = "|cffff0000";
local REDA = "|cffcc6666";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";
local YELLOW = "|cffffff00";

AQSERVERASKInformation = " 请持续右键，直到看到物品信息。"
AQSERVERASK = "向服务器查询："
AQOptionB = "选项"
AQStoryB = "背景"
AQNoReward = "没有奖励"
AQERRORNOTSHOWN = "该物品尚未缓存！"
AQERRORASKSERVER = "右键尝试向服务器查询\n该物品信息。你可能会断开连接。"
AQDiscription_OR = "|cffff0000 或 "..WHITE..""
AQDiscription_AND = "|cff008000 和 "..WHITE..""
AQDiscription_REWARD = "奖励："
AQDiscription_ATTAIN = "可接等级："
AQDiscription_LEVEL = "等级："
AQDiscription_START = "开始于：\n"
AQDiscription_AIM = "目标：\n"
AQDiscription_NOTE = "说明：\n"
AQDiscription_PREQUEST = "前置任务："
AQDiscription_FOLGEQUEST = "后续任务："
ATLAS_VERSIONWARNINGTEXT = "你的 Atlas 版本过旧！请更新它。 (最新版本是 1.8.1)"

-- ITEM TRANSLATION
AQITEM_DAGGER = "匕首"
AQITEM_SWORD = "剑"
AQITEM_AXE = "斧"
AQITEM_WAND = "魔杖"
AQITEM_STAFF = "法杖"
AQITEM_MACE = "锤"
AQITEM_SHIELD = "盾"
AQITEM_MACE = "锤"
AQITEM_GUN = "枪"

AQITEM_WAIST = "腰带，"
AQITEM_SHOULDER = "肩部，"
AQITEM_CHEST = "胸部，"
AQITEM_LEGS = "腿部，"
AQITEM_HANDS = "手部，"
AQITEM_FEET = "脚部，"
AQITEM_WRIST = "护腕，"
AQITEM_HEAD = "头部，"
AQITEM_BACK = "背部"

AQITEM_CLOTH = "布甲"
AQITEM_LEATHER = "皮甲"
AQITEM_MAIL = "锁甲"
AQITEM_PLATE = "板甲"

AQITEM_OFFHAND = "副手物品"
AQITEM_MAINHAND = "主手，"
AQITEM_ONEHAND = "单手，"
AQITEM_TWOHAND = "双手，"

AQITEM_TRINKET = "饰品"
AQITEM_POTION = "药水"
AQITEM_OFFHAND = "副手物品"
AQITEM_NECK = "项链"
AQITEM_PATTERN = "图样"
AQITEM_BAG = "背包"
AQITEM_RING = "戒指"
AQITEM_KEY = "钥匙"

local NORMAL = YELLOW;
local MAGE = "|cff69ccf0";
local PALADIN = "|cfff58cba";
local WARRIOR = "|cffc79c6e";
local ROGUE = "|cfffff569";
local DRUID = "|cffff7d0a";
local HUNTER = "|cffabd473";
local SHAMAN = "|cff0070de";
local WARLOCK = "|cff9482c9";
AQLoadedMessage = " = 已加载，作者 ASURN"
AQUsageMessage = "输入 /aq 或 /atlasquest 来显示或隐藏面板，并查看版本号"
AQHelpMessage = "帮助文本即将提供"
AQAtlasVersionMessagePrefix = "Atlas 版本: "
--------------DEADMINES/Inst1 ( 5 Quests)------------
Inst1Story = "这里曾经是人类最主要的产金地，希望矿井在部落第一次大战期间席卷暴风城的时候被废弃。现在迪菲亚兄弟会的人占据了那里并将这个黑暗的通道转变成他们的避难所。据说那些盗贼已经劝说了聪明的地精帮助他们在矿井的深处建造一些可怕的东西——但是没有人知道这是真的还是假的。有传言说，死亡矿井的入口在安宁的月溪镇中。"
Inst1Caption = "死亡矿井"
Inst1QAA = "5 个任务"
Inst1QAH = "没有任务"

testid = "19135"
--QUEST1 Allianz

Inst1Quest1 = "红色丝质面罩"
Inst1Quest1_Level = "17"
Inst1Quest1_Attain = "12"
Inst1Quest1_Aim = "给哨兵岭哨塔的哨兵瑞尔带回10条红色丝质面罩。"
Inst1Quest1_Location = "哨兵瑞尔（西部荒野 - 哨兵岭; "..NORMAL.."[56 / 47]"..WHITE.."）"
Inst1Quest1_Note = "你可以在副本内外的矿工身上找到红色丝质面罩。当你完成护送迪菲亚叛徒任务后才能接到这个任务。"
Inst1Quest1_Prequest = "有，（请见注释）"
Inst1Quest1_Folgequest = "无"
--
Inst1Quest1name1 = "Solid Shortblade"
Inst1Quest1name2 = "Scrimshaw Dagger"
Inst1Quest1name3 = "Piercing Axe"

--Quest 2 allianz

Inst1Quest2 = "收集记忆"
Inst1Quest2_Level = "18"
Inst1Quest2_Attain = "?"
Inst1Quest2_Aim = "给暴风城的维尔德·蓟草带回4张矿业工会会员卡。"
Inst1Quest2_Location = "维尔德·蓟草（暴风城 - 矮人区; "..NORMAL.."[65 / 21]"..WHITE.."）"
Inst1Quest2_Note = "就在你刚要进入副本之前的亡灵"..NORMAL.."副本入口地图[3]"..WHITE.."掉落矿工工会会员卡。"
Inst1Quest2_Prequest = "无"
Inst1Quest2_Folgequest = "无"
--
Inst1Quest2name1 = "Tunneler's Boots"
Inst1Quest2name2 = "Dusty Mining Gloves"
--Quest 3 allianz

Inst1Quest3 = "我的兄弟……"
Inst1Quest3_Level = "20"
Inst1Quest3_Attain = "?"
Inst1Quest3_Aim = "将工头希斯耐特的探险者协会徽章交给暴风城的维尔德·蓟草。"
Inst1Quest3_Location = "维尔德·蓟草（暴风城 - 矮人区; "..NORMAL.."[65 / 21]"..WHITE.."）"
Inst1Quest3_Note = "就在你刚要进入副本之前的工头希斯奈特"..NORMAL.."副本入口地图[3]"..WHITE.."掉落矿探险者协会徽章。"
Inst1Quest3_Prequest = "无"
Inst1Quest3_Folgequest = "无"
--
Inst1Quest3name1 = "Miner's Revenge"

--Quest 4 allianz

Inst1Quest4 = "地底突袭"
Inst1Quest4_Level = "20"
Inst1Quest4_Attain = "15"
Inst1Quest4_Aim = "从死亡矿井中带回小型高能发动机，将其带给暴风城矮人区中的沉默的舒尼。"
Inst1Quest4_Location = "沉默的舒尼（暴风城 - 矮人区; "..NORMAL.."[55 / 12]"..WHITE.."）"
Inst1Quest4_Note = "你可以直接接到这个任务，你也可以从诺恩那里接到此任务的引导任务（铁炉堡 - 侏儒区; "..NORMAL.."[69 / 50]"..WHITE.."）。\n斯尼德的伐木机掉落小型高能发动机，位置在"..NORMAL.."[3]"..WHITE.."。"
Inst1Quest4_Prequest = "有，沉默的舒尼"
Inst1Quest4_Folgequest = "无"
Inst1Quest4PreQuest = "true"
--
Inst1Quest4name1 = "Polar Gauntlets"
Inst1Quest4name2 = "Sable Wand"

--Quest 5 allianz

Inst1Quest5 = "迪菲亚兄弟会（系列任务）"
Inst1Quest5_Level = "22"
Inst1Quest5_Attain = "14"
Inst1Quest5_Aim = "杀死艾德温·范克里夫，把他的头交给格里安·斯托曼。"
Inst1Quest5_Location = "格里安·斯托曼（西部荒野 - 哨兵岭 "..NORMAL.."[56 / 47] "..WHITE.."）"
Inst1Quest5_Note = "此系列任务开始于格里安·斯托曼（西部荒野 - 哨兵岭; "..NORMAL.."[56 / 47]"..WHITE.."）。\n艾德温·范克里夫是死亡矿井的最后一个 Boss。你可以在他的船的最上层找到他，位置在"..NORMAL.."[6]"..WHITE.."。"
Inst1Quest5_Prequest = "有，迪菲亚兄弟会"
Inst1Quest5_Folgequest = "有，未寄出的信"
Inst1Quest5PreQuest = "true"
--
Inst1Quest5name1 = "Chausses of Westfall"
Inst1Quest5name2 = "Tunic of Westfall"
Inst1Quest5name3 = "Staff of Westfall"

--Quest 6 allianz

Inst1Quest6 = "正义试炼（圣骑士任务）"
Inst1Quest6_Level = "22"
Inst1Quest6_Attain = "20"
Inst1Quest6_Aim = "按照乔丹的武器材料单上的说明去寻找一些白石橡木、精炼矿石、乔丹的铁锤和一块科尔宝石，然后回到铁炉堡去见乔丹·斯迪威尔。"
Inst1Quest6_Location = "乔丹·斯迪威尔（丹莫罗 - 铁炉堡 "..NORMAL.."[52 / 36] "..WHITE.."）"
Inst1Quest6_Note = "点击"..NORMAL.."[乔丹的武器材料单]"..WHITE.."查看乔丹的武器材料单。"
Inst1Quest6_Prequest = "有，勇气之书 > 正义试炼"
Inst1Quest6_Folgequest = "有，正义试炼"
Inst1Quest6PreQuest = "true"
--
Inst1Quest6name1 = "Verigan's Fist"

Inst1Quest7 = "正义试炼说明"
Inst1Quest7TEXT = "只有圣骑士们才能接到这个任务！\n\n1. 你可以从"..NORMAL.."[死亡矿井]"..WHITE.."地精木匠"..NORMAL.."[3]"..WHITE.."那儿得到白石橡木。\n\n2. 要得到精炼矿石，你必须先与白洛尔·石手交谈（洛克莫丹 - 塞尔萨玛; "..NORMAL.."[35 / 44]"..WHITE.."）。他会给你《白洛尔的矿石》任务。 你在一棵树后面找到乔丹的矿石"..NORMAL.."[71 / 21]"..WHITE.."。\n\n3. 你可以在"..NORMAL.."[影牙城堡]"..WHITE.."紧靠"..NORMAL.."[3]"..WHITE.."的地方找到乔丹的铁锤（安全地点）。\n\n4. 要得到科尔宝石，你必须去找桑迪斯·织风（黑海岸 - 奥伯丁; "..NORMAL.."[37 / 40]"..WHITE.."）并且做完《寻找科尔宝石》任务。为了完成这个任务，你必须杀掉"..NORMAL.."[黑暗深渊]"..WHITE.."前的黑暗深渊智者或者黑暗深渊海潮祭司。他们会掉落被污染的科尔宝石。桑迪斯·织风会为你清洁它的。"
Inst1Quest7_Level = "100"
Inst1Quest7_Attain = ""
Inst1Quest7_Aim = ""
Inst1Quest7_Location = ""
Inst1Quest7_Note = ""
Inst1Quest7_Prequest = ""
Inst1Quest7_Folgequest = ""
Inst1Quest7FQuest = "true"

--------------WaillingCaverns/HDW ( 7 quests)------------
Inst2Story = "最近一个名叫纳拉雷克斯的暗夜精灵德鲁伊在贫瘠之地中的地下发现了一个错综复杂的洞穴网。这个被称作“哀嚎洞穴”的地方有很多的蒸汽缝隙，所以当蒸气喷射的时候发出的声音就犹如哀嚎一般，其因此而得名。纳拉雷克斯可以利用洞穴中的温泉来恢复贫瘠之地的生态，让这里重新获得生机——但是这样做需要吸收传说中的翡翠梦境的能量。一旦和翡翠梦境相连接，德鲁伊的视线中就变成了一场噩梦。不久之后，哀嚎洞穴开始变化——洞中的水开始腐化——曾经温顺的生物开始变成狂暴，致命的捕食者。据说纳拉雷克斯自己还居住在这个迷宫的最深处，他被翡翠梦境的边缘所困扰着。即使他以前的随从也被他们的主人所经历的噩梦所腐化——他们都变成了邪恶的尖牙德鲁伊。"
Inst2Caption = "哀嚎洞穴"
Inst2QAA = "5 个任务"
Inst2QAH = "7 个任务"

--QUEST 1 Alliance

Inst2Quest1 = "变异皮革"
Inst2Quest1_Level = "17"
Inst2Quest1_Attain = "?"
Inst2Quest1_Aim = "哀嚎洞穴的纳尔帕克想要20张变异皮革。"
Inst2Quest1_Location = "纳尔帕克（贫瘠之地 - 哀嚎洞穴; "..NORMAL.."[47 / 36] "..WHITE.."）"
Inst2Quest1_Note = "每个副本前面或里面的变异的怪都可能掉落变异皮革。纳尔帕克在入口上方的山顶洞穴里。"
Inst2Quest1_Prequest = "无"
Inst2Quest1_Folgequest = "无"
--
Inst2Quest1name1 = "Slick Deviate Leggings"
Inst2Quest1name2 = "Deviate Hide Pack"


--QUEST 2 Allianz

Inst2Quest2 = "港口的麻烦"
Inst2Quest2_Level = "18"
Inst2Quest2_Attain = "14"
Inst2Quest2_Aim = "棘齿城的起重机操作员比戈弗兹让你从疯狂的马格利什那儿取回一瓶99年波尔多陈酿，疯狂的马格利什就藏在哀嚎洞穴里。"
Inst2Quest2_Location = "起重机操作员比戈弗兹（贫瘠之地 - 棘齿城; "..NORMAL.."[63 / 37] "..WHITE.."）"
Inst2Quest2_Note = "你进入副本杀死疯狂的马格利什，拿到酒瓶。当你进入洞穴后向右转，他就在一个凹进去的洞里"..NORMAL.."副本入口地图[2]"..WHITE.."。"
Inst2Quest2_Prequest = "无"
Inst2Quest2_Folgequest = "无"

--QUEST 3 Allianz

Inst2Quest3 = "智慧饮料"
Inst2Quest3_Level = "18"
Inst2Quest3_Attain = "?"
Inst2Quest3_Aim = "收集6份哀嚎香精，把它们交给棘齿城的麦伯克·米希瑞克斯。"
Inst2Quest3_Location = "麦伯克·米希瑞克斯（贫瘠之地 - 棘齿城; "..NORMAL.."[62 / 37] "..WHITE.."）"
Inst2Quest3_Note = "此任务的前导任务也是在麦伯克·米希瑞克斯这儿接到的。\n软浆怪掉落香精。"
Inst2Quest3_Prequest = "有，迅猛龙角"
Inst2Quest3_Folgequest = "无"
Inst2Quest3PreQuest = "true"

--QUEST 4 horde

Inst2Quest4 = "清除变异者"
Inst2Quest4_Level = "21"
Inst2Quest4_Attain = "?"
Inst2Quest4_Aim = "哀嚎洞穴的厄布鲁要求你杀掉7只变异破坏者、7只剧毒飞蛇、7只变异蹒跚者和7只变异尖牙风蛇。"
Inst2Quest4_Location = "厄布鲁（贫瘠之地 - 哀嚎洞穴; "..NORMAL.."[47 / 36] "..WHITE.."）"
Inst2Quest4_Note = "厄布鲁在入口上方山顶的洞穴里。"
Inst2Quest4_Prequest = "无"
Inst2Quest4_Folgequest = "无"
--
Inst2Quest4name1 = "Pattern: Deviate Scale Belt"
Inst2Quest4name2 = "Sizzle Stick"
Inst2Quest4name3 = "Dagmire Gauntlets"

--QUEST 5 Allianz

Inst2Quest5 = "发光的碎片"
Inst2Quest5_Level = "25"
Inst2Quest5_Attain = "21"
Inst2Quest5_Aim = "去棘齿城寻找更多有关这块噩梦碎片的信息。"
Inst2Quest5_Location = "发光的碎片（掉落）（哀嚎洞穴"..NORMAL.."[9]"..WHITE.."）"
Inst2Quest5_Note = "当你杀死了最后的 Boss 吞噬者穆坦努斯后，你就会得到发光的碎片。而只有当你杀死了4个德鲁伊，并完成护送德鲁伊任务后，吞噬者穆坦努斯才会出现。\n当你拿到碎片后，你必须把它带回棘齿城，然后返回哀嚎洞穴外面山顶找到菲拉·古风。注意：去棘齿城找个地精说话，（就是做《什么什么平衡器》那个任务的地精），他头上是没有问号的，要自己去点他。"
Inst2Quest5_Prequest = "无"
Inst2Quest5_Folgequest = "有，在噩梦中"
--
Inst2Quest5name1 = "Talbar Mantle"
Inst2Quest5name2 = "Quagmire Galoshes"


--QUEST 1 horde

Inst2Quest1_HORDE = "变异皮革"
Inst2Quest1_HORDE_Level = "17"
Inst2Quest1_HORDE_Attain = "?"
Inst2Quest1_HORDE_Aim = "哀嚎洞穴的纳尔帕克想要20张变异皮革。"
Inst2Quest1_HORDE_Location = "纳尔帕克（贫瘠之地 - 哀嚎洞穴; "..NORMAL.."[47 / 36] "..WHITE.."）"
Inst2Quest1_HORDE_Note = "每个副本前面或里面的变异的怪都可能掉落变异皮革。纳尔帕克在入口上方的山顶洞穴里。"
Inst2Quest1_HORDE_Prequest = "无"
Inst2Quest1_HORDE_Folgequest = "无"
--
Inst2Quest1name1_HORDE = "Slick Deviate Leggings"
Inst2Quest1name2_HORDE = "Deviate Hide Pack"

--QUEST 2 horde

Inst2Quest2_HORDE = "港口的麻烦"
Inst2Quest2_HORDE_Level = "18"
Inst2Quest2_HORDE_Attain = "14"
Inst2Quest2_HORDE_Aim = "棘齿城的起重机操作员比戈弗兹让你从疯狂的马格利什那儿取回一瓶99年波尔多陈酿，疯狂的马格利什就藏在哀嚎洞穴里。"
Inst2Quest2_HORDE_Location = "起重机操作员比戈弗兹（贫瘠之地 - 棘齿城; "..NORMAL.."[63 / 37] "..WHITE.."）"
Inst2Quest2_HORDE_Note = "你进入副本杀死疯狂的马格利什，拿到酒瓶。当你进入洞穴后向右转，他就在一个凹进去的洞里"..NORMAL.."副本入口地图[2]"..WHITE.."。"
Inst2Quest2_HORDE_Prequest = "无"
Inst2Quest2_HORDE_Folgequest = "无"

--QUEST 3 horde

Inst2Quest3_HORDE = "毒蛇花"
Inst2Quest3_HORDE_Level = "18"
Inst2Quest3_HORDE_Attain = "14"
Inst2Quest3_HORDE_Aim = "为雷霆崖的药剂师扎玛收集10朵毒蛇花。"
Inst2Quest3_HORDE_Location = "药剂师扎玛（雷霆崖 -灵魂高地; "..NORMAL.."[22 / 20] "..WHITE.."）"
Inst2Quest3_HORDE_Note = "你可以在药剂师赫布瑞姆处领取前导任务（贫瘠之地 - 十字路口; "..NORMAL.."[51 / 30]"..WHITE.."）。\n你可以在山洞里副本前或副本内采到毒蛇花。学习草药学的玩家打开寻找草药技能就可以在自己的小地图上看到毒蛇花的位置。"
Inst2Quest3_HORDE_Prequest = "有，菌类孢子 -> 药剂师扎玛"
Inst2Quest3_HORDE_Folgequest = "无"
Inst2Quest3PreQuest_HORDE = "true"
--
Inst2Quest3name1_HORDE = "Apothecary Gloves"

--QUEST 4 horde

Inst2Quest4_HORDE = "智慧饮料"
Inst2Quest4_HORDE_Level = "18"
Inst2Quest4_HORDE_Attain = "?"
Inst2Quest4_HORDE_Aim = "收集6份哀嚎香精，把它们交给棘齿城的麦伯克·米希瑞克斯。"
Inst2Quest4_HORDE_Location = "麦伯克·米希瑞克斯（贫瘠之地 - 棘齿城; "..NORMAL.."[62 / 37] "..WHITE.."）"
Inst2Quest4_HORDE_Note = "此任务的前导任务也是在麦伯克·米希瑞克斯这儿接到的。\n软浆怪掉落香精。"
Inst2Quest4_HORDE_Prequest = "有，迅猛龙角"
Inst2Quest4_HORDE_Folgequest = "无"
Inst2Quest4PreQuest_HORDE = "true"

--QUEST 5 horde

Inst2Quest5_HORDE = "清除变异者"
Inst2Quest5_HORDE_Level = "21"
Inst2Quest5_HORDE_Attain = "?"
Inst2Quest5_HORDE_Aim = "哀嚎洞穴的厄布鲁要求你杀掉7只变异破坏者、7只剧毒飞蛇、7只变异蹒跚者和7只变异尖牙风蛇。"
Inst2Quest5_HORDE_Location = "厄布鲁（贫瘠之地 - 哀嚎洞穴; "..NORMAL.."[47 / 36] "..WHITE.."）"
Inst2Quest5_HORDE_Note = "厄布鲁在入口上方山顶的洞穴里。"
Inst2Quest5_HORDE_Prequest = "无"
Inst2Quest5_HORDE_Folgequest = "无"
--
Inst2Quest5name1_HORDE = "Pattern: Deviate Scale Belt"
Inst2Quest5name2_HORDE = "Sizzle Stick"
Inst2Quest5name3_HORDE = "Dagmire Gauntlets"

--QUEST 6 horde

Inst2Quest6_HORDE = "尖牙德鲁伊（连续任务）"
Inst2Quest6_HORDE_Level = "22"
Inst2Quest6_HORDE_Attain = "18"
Inst2Quest6_HORDE_Aim = "将考布莱恩宝石、安娜科德拉宝石、皮萨斯宝石和瑟芬迪斯宝石交给雷霆崖的纳拉·蛮鬃。"
Inst2Quest6_HORDE_Location = "纳拉·蛮鬃（雷霆崖; "..NORMAL.."[75 / 31] "..WHITE.."）"
Inst2Quest6_HORDE_Note = "系列任务始于哈缪尔·符文图腾（雷霆崖 - 长者高地; "..NORMAL.."[78 / 28]"..WHITE.."）\n掉落宝石的4个德鲁伊位于"..NORMAL.."[2]"..WHITE..", "..NORMAL.."[3]"..WHITE..", "..NORMAL.."[5]"..WHITE..", "..NORMAL.."[7]"..WHITE.."。"
Inst2Quest6_HORDE_Prequest = "有，哈缪尔·符文图腾 > 纳拉·蛮鬃 > 尖牙德鲁伊"
Inst2Quest6_HORDE_Folgequest = "无"
Inst2Quest6PreQuest_HORDE = "true"
--
Inst2Quest6name1_HORDE = "Crescent Staff"
Inst2Quest6name2_HORDE = "Wingblade"

--QUEST 7 horde

Inst2Quest7_HORDE = "发光的碎片"
Inst2Quest7_HORDE_Level = "25"
Inst2Quest7_HORDE_Attain = "21"
Inst2Quest7_HORDE_Aim = "去棘齿城寻找更多有关这块噩梦碎片的信息。"
Inst2Quest7_HORDE_Location = "发光的碎片（掉落）（哀嚎洞穴"..NORMAL.."[9]"..WHITE.."）"
Inst2Quest7_HORDE_Note = "当你杀死了最后的 Boss 吞噬者穆坦努斯后，你就会得到发光的碎片。而只有当你杀死了4个德鲁伊，并完成护送德鲁伊任务后，吞噬者穆坦努斯才会出现。\n当你拿到碎片后，你必须把它带回棘齿城，然后返回哀嚎洞穴外面山顶找到菲拉·古风。注意：去棘齿城找个地精说话，（就是做《什么什么平衡器》那个任务的地精），他头上是没有问号的，要自己去点他。"
Inst2Quest7_HORDE_Prequest = "无"
Inst2Quest7_HORDE_Folgequest = "有，在噩梦中"
--
Inst2Quest7name1_HORDE = "Talbar Mantle"
Inst2Quest7name2_HORDE = "Quagmire Galoshes"


--------------Uldaman/Inst4 ( 16 quests)------------
Inst4Story = "奥达曼是古代泰坦创世之时所留下的深埋于地下的城市。矮人探险队最近发觉到了这块被遗忘的城市，将泰坦一款失败的创造物：食腭怪唤醒了。传说说泰坦是从石头中创造了食腭怪。当实施证明这次试验很失败的时候，泰坦把食腭怪锁了起来并进行了第二次的尝试——最终创造了矮人这个种族。矮人创造的秘密被记录在精密的白金圆盘中——那是位于古代城市最底部的大型泰坦遗迹。最近，黑铁矮人在奥达曼进行了一系列的侵入活动，希望为他们的火焰之主拉格纳罗斯获得圆盘。然而，在这个地下城市中，有一些巨大的石头守卫会攻击任何入侵者。而白金圆盘是由一名巨大的石头守卫阿扎达斯。有传言说矮人的一些石头皮肤的祖先，土灵还居住在城市的隐蔽之处。"
Inst4Caption = "奥达曼"
Inst4QAA = "16 个任务"
Inst4QAH = "10 个任务"

--QUEST 1 Allianz

Inst4Quest1 = "一线希望"
Inst4Quest1_Level = "35"
Inst4Quest1_Attain = "35"
Inst4Quest1_Aim = "在奥达曼找到铁趾格雷兹。"
Inst4Quest1_Location = "勘察员雷杜尔（荒芜之地; "..NORMAL.."[53 / 43] "..WHITE.."）"
Inst4Quest1_Note = "前导任务始于弄皱的地图（荒芜之地; "..NORMAL.."[53 / 33]"..WHITE.."）。\n你可以在进入"..NORMAL.."副本入口地图[1]"..WHITE.."找到铁趾格雷兹。"
Inst4Quest1_Prequest = "有，一线希望"
Inst4Quest1_Folgequest = "有，铁趾的护符"
Inst4Quest1PreQuest = "true"

--QUEST 2 Allianz

Inst4Quest2 = "铁趾的护符"
Inst4Quest2_Level = "40"
Inst4Quest2_Attain = "?"
Inst4Quest2_Aim = "找到铁趾的护符，把它交给奥达曼的铁趾。"
Inst4Quest2_Location = "铁趾格雷兹（奥达曼; "..NORMAL.."副本入口地图[1]"..WHITE.."）。"
Inst4Quest2_Note = "马格雷甘·深影掉落铁趾的护符"..NORMAL.."副本入口地图[2]"..WHITE.."。"
Inst4Quest2_Prequest = "有，一线希望"
Inst4Quest2_Folgequest = "有，铁趾的遗愿"
Inst4Quest2FQuest = "true"


--QUEST 3 Allianz

Inst4Quest3 = "意志石板"
Inst4Quest3_Level = "45"
Inst4Quest3_Attain = "38"
Inst4Quest3_Aim = "找到意志石板，把它们交给铁炉堡的顾问贝尔格拉姆。"
Inst4Quest3_Location = "顾问贝尔格拉姆（铁炉堡 - 探险者大厅; "..NORMAL.."[77 / 10] "..WHITE.."）"
Inst4Quest3_Note = "石板位置在"..NORMAL.."[8]"..WHITE.."。"
Inst4Quest3_Prequest = "有，铁趾的遗愿 -> 邪恶的使者"
Inst4Quest3_Folgequest = "无"
Inst4Quest3FQuest = "true"
--
Inst4Quest3name1 = "Medal of Courage"

--QUEST 4 Allianz

Inst4Quest4 = "能量石"
Inst4Quest4_Level = "36"
Inst4Quest4_Attain = "?"
Inst4Quest4_Aim = "给荒芜之地的里格弗兹带去8块德提亚姆能量石和8块安纳洛姆能量石。"
Inst4Quest4_Location = "里格弗兹（荒芜之地; "..NORMAL.."[42 / 52] "..WHITE.."）"
Inst4Quest4_Note = "能量石可以在副本内外的暗炉敌人身上找到。"
Inst4Quest4_Prequest = "无"
Inst4Quest4_Folgequest = "无"
--
Inst4Quest4name1 = "Energized Stone Circle"
Inst4Quest4name2 = "Duracin Bracers"
Inst4Quest4name3 = "Everlast Boots"

--QUEST 5 Allianz

Inst4Quest5 = "阿戈莫德的命运"
Inst4Quest5_Level = "38"
Inst4Quest5_Attain = "38"
Inst4Quest5_Aim = "收集4个雕纹石罐，把它们交给洛克莫丹的勘察员基恩萨·铁环。"
Inst4Quest5_Location = "勘察员基恩萨·铁环（洛克莫丹 - 铁环挖掘场; "..NORMAL.."[65 / 65] "..WHITE.."）"
Inst4Quest5_Note = "前导任务始于勘察员塔伯斯·雷矛（铁炉堡 - 探险者大厅; "..NORMAL.."[74 / 12]"..WHITE.."）。\n雕纹石罐散布于副本前的山洞里。"
Inst4Quest5_Prequest = "有，铁环挖掘场需要你！ -> 莫达洛克"
Inst4Quest5_Folgequest = "无"
Inst4Quest5PreQuest = "true"
--
Inst4Quest5name1 = "Prospector Gloves"

--QUEST 6 Allianz

Inst4Quest6 = "化解灾难"
Inst4Quest6_Level = "40"
Inst4Quest6_Attain = "31"
Inst4Quest6_Aim = "把雷乌纳石板带给迷失者塞尔杜林。"
Inst4Quest6_Location = "迷失者塞尔杜林（荒芜之地; "..NORMAL.."[51 / 76] "..WHITE.."）"
Inst4Quest6_Note = "石板在洞穴北部，通道的东部尽头"..NORMAL.."副本入口地图[3]"..WHITE.."。"
Inst4Quest6_Prequest = "无"
Inst4Quest6_Folgequest = "有，远赴铁炉堡"
--
Inst4Quest6name1 = "Doomsayer's Robe"

--QUEST 7 Allianz

Inst4Quest7 = "失踪的矮人"
Inst4Quest7_Level = "40"
Inst4Quest7_Attain = "?"
Inst4Quest7_Aim = "在奥达曼找到巴尔洛戈。"
Inst4Quest7_Location = "勘察员塔伯斯·雷矛（铁炉堡 - 探险者大厅; "..NORMAL.."[75 / 12] "..WHITE.."）"
Inst4Quest7_Note = "巴尔洛戈在"..NORMAL.."[1]"..WHITE.."。"
Inst4Quest7_Prequest = "无"
Inst4Quest7_Folgequest = "有，密室"

--QUEST 8 Allianz

Inst4Quest8 = "密室"
Inst4Quest8_Level = "40"
Inst4Quest8_Attain = "?"
Inst4Quest8_Aim = "阅读巴尔洛戈的日记，探索密室，然后向铁炉堡的勘察员塔伯斯·雷矛汇报。"
Inst4Quest8_Location = "巴尔洛戈（奥达曼;"..NORMAL.."[1]"..WHITE.."）"
Inst4Quest8_Note = "密室在"..NORMAL.."[4]"..WHITE.."。"
Inst4Quest8_Prequest = "有，失踪的矮人"
Inst4Quest8_Folgequest = "无"
Inst4Quest8FQuest = "true"
--
Inst4Quest8name1 = "Dwarven Charge"
Inst4Quest8name2 = "Explorer's League Lodestar"

--QUEST 9 Allianz

Inst4Quest9 = "破碎的项链"
Inst4Quest9_Level = "41"
Inst4Quest9_Attain = "37"
Inst4Quest9_Aim = "找到破碎的项链的来源，从而了解其潜在的价值。"
Inst4Quest9_Location = "破碎的项链（随机掉落）（奥达曼）"
Inst4Quest9_Note = "把项链带给铁炉堡的塔瓦斯德·基瑟尔（铁炉堡 - 秘法区; "..NORMAL.."[36 / 3]"..WHITE.."）。"
Inst4Quest9_Prequest = "无"
Inst4Quest9_Folgequest = "有，昂贵的知识"

--QUEST 10 Allianz

Inst4Quest10 = "回到奥达曼"
Inst4Quest10_Level = "41"
Inst4Quest10_Attain = "37"
Inst4Quest10_Aim = "去奥达曼寻找塔瓦斯的魔法项链，被杀的圣骑士是最后一个拿着它的人。"
Inst4Quest10_Location = "塔瓦斯德·基瑟尔（铁炉堡 - 秘法区; "..NORMAL.."[36 / 3] "..WHITE.."）"
Inst4Quest10_Note = "圣骑士在"..NORMAL.."[2]"..WHITE.."。"
Inst4Quest10_Prequest = "有，昂贵的知识"
Inst4Quest10_Folgequest = "有，寻找宝石"

--QUEST 11 Allianz

Inst4Quest11 = "寻找宝石"
Inst4Quest11_Level = "43"
Inst4Quest11_Attain = "37"
Inst4Quest11_Aim = "在奥达曼寻找红宝石、蓝宝石和黄宝石的下落。找到它们之后，通过塔瓦斯德给你的占卜之瓶和他进行联系。"
Inst4Quest11_Location = "圣骑士的遗体（奥达曼; "..NORMAL.."[2]"..WHITE.."）"
Inst4Quest11_Note = "宝石在"..NORMAL.."[1]"..WHITE.."，"..NORMAL.."[8]"..WHITE.."和"..NORMAL.."[9]"..WHITE.."。"
Inst4Quest11_Prequest = "有，回到奥达曼"
Inst4Quest11_Folgequest = "有，修复项链"
Inst4Quest11FQuest = "true"

--QUEST 12 Allianz

Inst4Quest12 = "修复项链"
Inst4Quest12_Level = "44"
Inst4Quest12_Attain = "38"
Inst4Quest12_Aim = "从奥达曼最强大的石人身上获得能量源，然后将其交给铁炉堡的塔瓦斯德。"
Inst4Quest12_Location = "塔瓦斯德的占卜之碗"
Inst4Quest12_Note = "破碎项链的能量源在阿扎达斯掉落"..NORMAL.."[10]"..WHITE.."。"
Inst4Quest12_Prequest = "有，寻找宝石"
Inst4Quest12_Folgequest = "无"
--
Inst4Quest12name1 = "Talvash's Enhancing Necklace"
Inst4Quest12FQuest = "true"

--QUEST 13 Allianz

Inst4Quest13 = "奥达曼的蘑菇"
Inst4Quest13_Level = "42"
Inst4Quest13_Attain = "38"
Inst4Quest13_Aim = "收集12颗紫色蘑菇，把它们交给塞尔萨玛的加克。"
Inst4Quest13_Location = "加克（洛克莫丹 - 塞尔萨玛; "..NORMAL.."[37 / 49] "..WHITE.."）"
Inst4Quest13_Note = "蘑菇散布于副本各处。"
Inst4Quest13_Prequest = "有，荒芜之地的材料"
Inst4Quest13_Folgequest = "无"
--
Inst4Quest13name1 = "Restorative Potion"

--QUEST 14 Allianz

Inst4Quest14 = "失而复得"
Inst4Quest14_Level = "43"
Inst4Quest14_Attain = "?"
Inst4Quest14_Aim = "到奥达曼的北部大厅去找到克罗姆·粗臂的箱子，从里面拿出他的宝贵财产，然后回到铁炉堡把东西交给他。"
Inst4Quest14_Location = "克罗姆·粗臂（铁炉堡 - 探险者大厅; "..NORMAL.."[74 / 9] "..WHITE.."）"
Inst4Quest14_Note = "你在进入副本前就找到克罗姆·粗臂的财产。它就在洞穴的北部，第一个通道的东南角尽头"..NORMAL.."副本入口地图[4]"..WHITE.."。"
Inst4Quest14_Prequest = "无"
Inst4Quest14_Folgequest = "无"

--QUEST 15 Allianz

Inst4Quest15 = "白金圆盘"
Inst4Quest15_Level = "45"
Inst4Quest15_Attain = "40"
Inst4Quest15_Aim = "和石头守护者交谈，从他那里了解更多古代的知识。一旦你了解到了所有的内容之后就激活诺甘农圆盘。 -> 把迷你版的诺甘农圆盘带到铁炉堡的探险者协会去。"
Inst4Quest15_Location = "诺甘农圆盘（奥达曼; "..NORMAL.."[11]"..WHITE.."）"
Inst4Quest15_Note = "接到任务后，和石头守护者交谈左边的盘子。然后再次使用白金圆盘，取得缩小版的圆盘， 并把缩小版的白金圆盘带给铁炉堡的资深探险家麦格拉斯（铁炉堡 - 探险者大厅; "..NORMAL.."[69 / 18]"..WHITE.."）。"
Inst4Quest15_Prequest = "无"
Inst4Quest15_Folgequest = "奥丹姆的预兆"
--
Inst4Quest15name1 = "鼹鼠袋"
Inst4Quest15name2 = "Superior Healing Potion"
Inst4Quest15name3 = "Greater Mana Potion"

--QUEST 16 Allianz

Inst4Quest16 = "奥达曼的能量源（法师任务）"
Inst4Quest16_Level = "40"
Inst4Quest16_Attain = "35"
Inst4Quest16_Aim = "找到一个黑曜石能量源，将其交给尘泥沼泽的塔贝萨。"
Inst4Quest16_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[46 / 57] "..WHITE.."）"
Inst4Quest16_Note = "这个任务只能法师做！\n黑曜石哨兵"..NORMAL.."[5]"..WHITE.."掉落黑曜石能量源。"
Inst4Quest16_Prequest = "有，驱除魔鬼"
Inst4Quest16_Folgequest = "有，法力怒灵"
Inst4Quest16PreQuest = "true"

--QUEST 1 Horde

Inst4Quest1_HORDE = "能量石"
Inst4Quest1_HORDE_Level = "36"
Inst4Quest1_HORDE_Attain = "?"
Inst4Quest1_HORDE_Aim = "给荒芜之地的里格弗兹带去8块德提亚姆能量石和8块安纳洛姆能量石。"
Inst4Quest1_HORDE_Location = "里格弗兹（荒芜之地; "..NORMAL.."[42 / 52] "..WHITE.."）"
Inst4Quest1_HORDE_Note = "能量石可以在副本内外的暗炉敌人身上找到。"
Inst4Quest1_HORDE_Prequest = "无"
Inst4Quest1_HORDE_Folgequest = "无"
--
Inst4Quest1name1_HORDE = "Energized Stone Circle"
Inst4Quest1name2_HORDE = "Duracin Bracers"
Inst4Quest1name3_HORDE = "Everlast Boots"

--QUEST 2 Horde

Inst4Quest2_HORDE = "化解灾难"
Inst4Quest2_HORDE_Level = "40"
Inst4Quest2_HORDE_Attain = "31"
Inst4Quest2_HORDE_Aim = "把雷乌纳石板带给迷失者塞尔杜林。"
Inst4Quest2_HORDE_Location = "迷失者塞尔杜林（荒芜之地; "..NORMAL.."[51 / 76] "..WHITE.."）"
Inst4Quest2_HORDE_Note = "石板在洞穴北部，通道的东部尽头"..NORMAL.."副本入口地图[3]"..WHITE.."。"
Inst4Quest2_HORDE_Prequest = "无"
Inst4Quest2_HORDE_Folgequest = "有，远赴幽暗城"
--
Inst4Quest2name1_HORDE = "Doomsayer's Robe"

--QUEST 3 Horde

Inst4Quest3_HORDE = "搜寻项链"
Inst4Quest3_HORDE_Level = "41"
Inst4Quest3_HORDE_Attain = "37"
Inst4Quest3_HORDE_Aim = "在奥达曼挖掘场中寻找一条珍贵的项链，然后将其交给奥格瑞玛的德兰·杜佛斯。项链有可能已经损坏。 "
Inst4Quest3_HORDE_Location = "德兰·杜佛斯（奥格瑞玛 - 暗巷区; "..NORMAL.."[59 / 36] "..WHITE.."）"
Inst4Quest3_HORDE_Note = "项链在副本里是随机掉落的。"
Inst4Quest3_HORDE_Prequest = "无"
Inst4Quest3_HORDE_Folgequest = "有，搜寻项链，再来一次"

--QUEST 4 Horde

Inst4Quest4_HORDE = "搜寻项链，再来一次"
Inst4Quest4_HORDE_Level = "41"
Inst4Quest4_HORDE_Attain = "38"
Inst4Quest4_HORDE_Aim = "在奥达曼里找寻宝石的线索。"
Inst4Quest4_HORDE_Location = "德兰·杜佛斯（奥格瑞玛 - 暗巷区; "..NORMAL.."[59 / 36] "..WHITE.."）"
Inst4Quest4_HORDE_Note = "圣骑士在"..NORMAL.."[2]"..WHITE.."。"
Inst4Quest4_HORDE_Prequest = "有，搜寻项链"
Inst4Quest4_HORDE_Folgequest = "有，翻译日记"
Inst4Quest4FQuest_HORDE = "true"

--QUEST 5 Horde

Inst4Quest5_HORDE = "翻译日记"
Inst4Quest5_HORDE_Level = "42"
Inst4Quest5_HORDE_Attain = "40"
Inst4Quest5_HORDE_Aim = "在荒芜之地的卡加斯哨所里寻找一个可以帮你翻译圣骑士日记的人。"
Inst4Quest5_HORDE_Location = "圣骑士的遗体（奥达曼; "..NORMAL.."[2]"..WHITE.."）"
Inst4Quest5_HORDE_Note = "翻译圣骑士日记的人加卡尔（荒芜之地 - 卡加斯; "..NORMAL.."[2 / 46]"..WHITE.."） -> 将项链借给加卡尔，他帮你翻译日记。"
Inst4Quest5_HORDE_Prequest = "有，搜寻项链，再来一次"
Inst4Quest5_HORDE_Folgequest = "有，寻找宝贝"
Inst4Quest5FQuest_HORDE = "true"

--QUEST 6 Horde

Inst4Quest6_HORDE = "寻找宝贝"
Inst4Quest6_HORDE_Level = "44"
Inst4Quest6_HORDE_Attain = "37"
Inst4Quest6_HORDE_Aim = "从奥达曼找回项链上的所有三块宝石和能量源，然后把它们交给卡加斯的加卡尔。\n红宝石被藏在暗影矮人层层设防的地区。\n黄宝石藏在石腭怪活动地区的一个瓮中。\n蓝宝石在格瑞姆洛克手中，他是石腭怪的领袖。\n能量源可能在奥达曼的某个最强生物的手中。"
Inst4Quest6_HORDE_Location = "加卡尔（荒芜之地 - 卡加斯; "..NORMAL.."[2 / 46] "..WHITE.."）"
Inst4Quest6_HORDE_Note = "红宝石在暗炉矮人手里，黄宝石在石腭怪手里，而蓝宝石则在一个名叫格瑞姆洛克的石腭怪那里"..NORMAL.."[1]"..WHITE.."，"..NORMAL.."[8]"..WHITE.."和"..NORMAL.."[9]"..WHITE.."。  破碎项链的能量源从阿扎达斯身上掉落"..NORMAL.."[10]"..WHITE.."。"
Inst4Quest6_HORDE_Prequest = "有，翻译日记"
Inst4Quest6_HORDE_Folgequest = "有，交付宝石"
Inst4Quest6FQuest_HORDE = "true"
--
Inst4Quest6name1_HORDE = "Jarkal's Enhancing Necklace"

--QUEST 7 Horde

Inst4Quest7_HORDE = "奥达曼的蘑菇"
Inst4Quest7_HORDE_Level = "42"
Inst4Quest7_HORDE_Attain = "38"
Inst4Quest7_HORDE_Aim = "收集12颗紫色蘑菇，把它们交给卡加斯的加卡尔。"
Inst4Quest7_HORDE_Location = "加卡尔（荒芜之地 - 卡加斯; "..NORMAL.."[2 / 69] "..WHITE.."）"
Inst4Quest7_HORDE_Note = "前导任务也是在加卡尔这儿领取。\n蘑菇散布于副本内各处。"
Inst4Quest7_HORDE_Prequest = "有，荒芜之地的材料"
Inst4Quest7_HORDE_Folgequest = "有，荒芜之地的材料 II"
Inst4Quest7PreQuest_HORDE = "true"
--
Inst4Quest7name1_HORDE = "Restorative Potion"

--QUEST 8 Horde

Inst4Quest8_HORDE = "寻找宝藏"
Inst4Quest8_HORDE_Level = "43"
Inst4Quest8_HORDE_Attain = "?"
Inst4Quest8_HORDE_Aim = "从奥达曼南部大厅的箱子中找到加勒特的家族宝藏，然后把它交给幽暗城的帕特里克·加瑞特。"
Inst4Quest8_HORDE_Location = "帕特里克·加瑞特（幽暗城; "..NORMAL.."[72 / 48] "..WHITE.."）"
Inst4Quest8_HORDE_Note = "你在进入副本之前就会找到加勒特的家族宝藏。它就在南部通道的尽头"..NORMAL.."副本入口ditu[5]"..WHITE.."。"
Inst4Quest8_HORDE_Prequest = "无"
Inst4Quest8_HORDE_Folgequest = "无"


--QUEST 9 Horde

Inst4Quest9_HORDE = "白金圆盘"
Inst4Quest9_HORDE_Level = "45"
Inst4Quest9_HORDE_Attain = "40"
Inst4Quest9_HORDE_Aim = "和石头守护者交谈，从他那里了解更多古代的知识。一旦你了解到了所有的内容之后就激活诺甘农圆盘。 -> 把迷你版的诺甘农圆盘带到雷霆崖的贤者（圣者图希克）那里。"
Inst4Quest9_HORDE_Location = "诺甘农圆盘（奥达曼; "..NORMAL.."[11]"..WHITE.."）"
Inst4Quest9_HORDE_Note = "你领取到任务后，和石头守护着交谈盘子的左边。然后再次使用白金圆盘得到迷你版的圆盘，带着它去雷霆崖找圣者图希克（"..NORMAL.."[34 / 46]"..WHITE.."）。"
Inst4Quest9_HORDE_Prequest = "无"
Inst4Quest9_HORDE_Folgequest = "奥丹姆的预兆"
--
Inst4Quest9name1_HORDE = "鼹鼠袋"
Inst4Quest9name2_HORDE = "Superior Healing Potion"
Inst4Quest9name3_HORDE = "Greater Mana Potion"

--QUEST 10 Horde

Inst4Quest10_HORDE = "奥达曼的能量源（法师任务）"
Inst4Quest10_HORDE_Level = "40"
Inst4Quest10_HORDE_Attain = "35"
Inst4Quest10_HORDE_Aim = "找到一个黑曜石能量源，将其交给尘泥沼泽的塔贝萨。"
Inst4Quest10_HORDE_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[46 / 57] "..WHITE.."）"
Inst4Quest10_HORDE_Note = "这个任务只能法师做！\n黑曜石哨兵"..NORMAL.."[5]"..WHITE.."掉落黑曜石能量源。"
Inst4Quest10_HORDE_Prequest = "有，驱除魔鬼"
Inst4Quest10_HORDE_Folgequest = "有，法力怒灵"
Inst4Quest10PreQuest_HORDE = "true"


--------------------------Ragfire ( 5 Quests)
Inst3Story = "怒焰裂谷是一个错综复杂的火焰洞穴，它位于兽人的新都城奥格瑞玛中。最近，有传言说一批崇拜恶魔阴影教的信徒占据了怒焰裂谷。这个被称为火刃的组织对杜隆塔尔的安全。许多人认为兽人的酋长萨尔已经意识到了火刃的存在并不打算摧毁他们，因为萨尔希望能够将他引到阴影议会那里。不管怎么样，黑暗的力量从怒焰裂谷散发出来，它们可能毁了兽人所有的一切。"
Inst3Caption = "怒焰裂谷"
Inst3QAA = "没有任务"
Inst3QAH = "5 个任务"

--QUEST 1 Horde

Inst3Quest1_HORDE = "试探敌人"
Inst3Quest1_HORDE_Level = "15"
Inst3Quest1_HORDE_Attain = "?"
Inst3Quest1_HORDE_Aim = "在奥格瑞玛找到怒焰裂谷，杀掉8个怒焰穴居人和8个怒焰萨满祭司，然后向雷霆崖的拉哈罗复命。"
Inst3Quest1_HORDE_Location = "拉哈罗（雷霆崖 - 长者高地; "..NORMAL.."[70 / 29] "..WHITE.."）"
Inst3Quest1_HORDE_Note = "你一开始就能找到穴居人。"
Inst3Quest1_HORDE_Prequest = "无"
Inst3Quest1_HORDE_Folgequest = "无"

--QUEST 2 Horde

Inst3Quest2_HORDE = "毁灭之力"
Inst3Quest2_HORDE_Level = "16"
Inst3Quest2_HORDE_Attain = "?"
Inst3Quest2_HORDE_Aim = "将《暗影法术研究》和《扭曲虚空的魔法》这两本书交给幽暗城的瓦里玛萨斯。"
Inst3Quest2_HORDE_Location = "瓦里玛萨斯（幽暗城 - 皇家区; "..NORMAL.."[56 / 92] "..WHITE.."）"
Inst3Quest2_HORDE_Note = "燃刃信徒和燃刃术士掉落这两本书。"
Inst3Quest2_HORDE_Prequest = "无"
Inst3Quest2_HORDE_Folgequest = "无"
--
Inst3Quest2name1_HORDE = "Ghastly Trousers"
Inst3Quest2name2_HORDE = "Dredgemire Leggings"
Inst3Quest2name3_HORDE = "Gargoyle Leggings"

--QUEST 3 Horde

Inst3Quest3_HORDE = "寻找背包"
Inst3Quest3_HORDE_Level = "16"
Inst3Quest3_HORDE_Attain = "?"
Inst3Quest3_HORDE_Aim = "在怒焰裂谷搜寻玛尔·恐怖图腾的尸体以及他留下的东西。"
Inst3Quest3_HORDE_Location = "拉哈罗（雷霆崖 - 长者高地; "..NORMAL.."[70 / 29] "..WHITE.."）"
Inst3Quest3_HORDE_Note = "你会在"..NORMAL.."[1]"..WHITE.."发现玛尔·恐怖图腾。得到背包后你需要把它交回给雷霆崖的拉哈罗。"
Inst3Quest3_HORDE_Prequest = "无"
Inst3Quest3_HORDE_Folgequest = "有，归还背包"
--
Inst3Quest3name1_HORDE = "Featherbead Bracers"
Inst3Quest3name2_HORDE = "Savannah Bracers"

--QUEST 4 Horde

Inst3Quest4_HORDE = "隐藏的敌人"
Inst3Quest4_HORDE_Level = "16"
Inst3Quest4_HORDE_Attain = "?"
Inst3Quest4_HORDE_Aim = "杀死巴扎兰和祈求者耶戈什，然后返回奥格瑞玛见萨尔。"
Inst3Quest4_HORDE_Location = "萨尔（奥格瑞玛 - 智慧谷; "..NORMAL.."[31 / 37] "..WHITE.."）"
Inst3Quest4_HORDE_Note = "你会在"..NORMAL.."[4]"..WHITE.."发现巴扎兰，在"..NORMAL.."[3]"..WHITE.."发现祈求者耶戈什。"
Inst3Quest4_HORDE_Prequest = "有，隐藏的敌人"
Inst3Quest4_HORDE_Folgequest = "有，隐藏的敌人"
Inst3Quest4PreQuest_HORDE = "true"
--
Inst3Quest4name1_HORDE = "Kris of Orgrimmar"
Inst3Quest4name2_HORDE = "Hammer of Orgrimmar"
Inst3Quest4name3_HORDE = "Axe of Orgrimmar"
Inst3Quest4name4_HORDE = "Staff of Orgrimmar"

--QUEST 5 Horde

Inst3Quest5_HORDE = "饥饿者塔拉加曼"
Inst3Quest5_HORDE_Level = "16"
Inst3Quest5_HORDE_Attain = "?"
Inst3Quest5_HORDE_Aim = "进入怒焰裂谷，杀死饥饿者塔拉加曼，然后把他的心脏交给奥格瑞玛的尼尔鲁·火刃。"
Inst3Quest5_HORDE_Location = "尼尔鲁·火刃（奥格瑞玛 - 暗影裂口; "..NORMAL.."[49 / 50] "..WHITE.."）"
Inst3Quest5_HORDE_Note = "你会在"..NORMAL.."[2]"..WHITE.."找到塔拉加曼。"
Inst3Quest5_HORDE_Prequest = "无"
Inst3Quest5_HORDE_Folgequest = "无"

--------------------------Inst27 Zul'Farrak / ZUL
Inst27Story = "日光暴晒下的这座城市是沙怒巨魔的家园，他们一向以来都以其无情和黑暗魔法而闻名。巨魔传说中有一把强大的名叫鞭笞者苏萨斯的武器能够让最弱小的人可以击败最强大的敌人。很久以前，这把武器被分成了两半。然而，有传言说这两半可以在祖尔法拉克任何地方找到。据说还有一批加基森派来的雇佣兵进入了城市并被困住。他们的命运还不得而知。但是也许最让人感到不安的是一头远古生物正沉睡在城市中心的一个神圣的水池中——它是一个半神，它会摧毁任何胆敢唤醒它的人。"
Inst27Caption = "祖尔法拉克"
Inst27QAA = "7 个任务"
Inst27QAH = "7 个任务"



--QUEST 1 Allianz

Inst27Quest1 = "圣甲虫的壳"
Inst27Quest1_Level = "45"
Inst27Quest1_Attain = "?"
Inst27Quest1_Aim = "给加基森的特兰雷克带去5个完整的圣甲虫壳。"
Inst27Quest1_Location = "特兰雷克（塔纳利斯 - 加基森; "..NORMAL.."[51 / 26] "..WHITE.."）"
Inst27Quest1_Note = "前导任务始于克拉兹克（荆棘谷 - 藏宝海湾; "..NORMAL.."[25 / 77]"..WHITE.."）。\n每个圣甲虫都可能掉落壳儿。大量圣甲虫集中在"..NORMAL.."[2]"..WHITE.."。"
Inst27Quest1_Prequest = "有，特兰雷克"
Inst27Quest1_Folgequest = "无"

--QUEST 2 Allianz

Inst27Quest2 = "深渊皇冠"
Inst27Quest2_Level = "45"
Inst27Quest2_Attain = "?"
Inst27Quest2_Aim = "将深渊皇冠交给尘泥沼泽的塔贝萨。"
Inst27Quest2_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[46 / 57] "..WHITE.."）"
Inst27Quest2_Note = "前导任务从彬克（铁炉堡; "..NORMAL.."[25 / 8]"..WHITE.."）处获得。\n水占师维蕾萨掉落深渊皇冠。你可以在"..NORMAL.."[6]"..WHITE.."找到她。"
Inst27Quest2_Prequest = "有，塔贝萨的任务"
Inst27Quest2_Folgequest = "无"
Inst27Quest2PreQuest = "true"

--QUEST 3 Allianz

Inst27Quest3 = "耐克鲁姆的徽章（系列任务）"
Inst27Quest3_Level = "46"
Inst27Quest3_Attain = "40"
Inst27Quest3_Aim = "将耐克鲁姆的徽章交给诅咒之地的萨迪斯·格希德。"
Inst27Quest3_Location = "萨迪斯·格希德（诅咒之地 - 守望堡; "..NORMAL.."[66 / 19] "..WHITE.."）"
Inst27Quest3_Note = "此系列任务始于狮鹫管理员沙拉克·鹰斧（辛特兰 - 蛮锤城堡; "..NORMAL.."[9 / 44]"..WHITE.."）。\n你可以在"..NORMAL.."[4]"..WHITE.."找到耐克鲁姆。"
Inst27Quest3_Prequest = "有，枯木巨魔的牢笼 -> 萨迪斯·格希德"
Inst27Quest3_Folgequest = "有，占卜"
Inst27Quest3PreQuest = "true"
--
Inst27Quest3name1 = "Spellshifter Rod"
Inst27Quest3name2 = "Gemshale Pauldrons"

--QUEST 4 Allianz

Inst27Quest4 = "巨魔调和剂"
Inst27Quest4_Level = "47"
Inst27Quest4_Attain = "40"
Inst27Quest4_Aim = "收集20瓶巨魔调和剂，把它们交给加基森的特伦顿·轻锤。"
Inst27Quest4_Location = "特伦顿·轻锤（塔纳利斯 - 加基森; "..NORMAL.."[51 / 28] "..WHITE.."）"
Inst27Quest4_Note = "每个巨魔都可能掉落调和剂。"
Inst27Quest4_Prequest = "Witherbark Cages -> Thadius Grimshade"
Inst27Quest4_Folgequest = "占卜"
Inst27Quest4PreQuest = "true"

--QUEST 5 Allianz

Inst27Quest5 = "摩沙鲁的预言（系列任务）"
Inst27Quest5_Level = "47"
Inst27Quest5_Attain = "40"
Inst27Quest5_Aim = "将第一块和第二块摩沙鲁石板交给塔纳利斯的叶基亚。"
Inst27Quest5_Location = "叶基亚（塔纳利斯 - 热砂港; "..NORMAL.."[66 / 22] "..WHITE.."）"
Inst27Quest5_Note = "前导任务也是在此获得。\n\n两块石板分别由殉教者塞卡"..NORMAL.."[2]"..WHITE.."和水占师维蕾萨"..NORMAL.."[6]"..WHITE.."掉落。"
Inst27Quest5_Prequest = "有，尖啸者的灵魂"
Inst27Quest5_Folgequest = "有，远古之卵"
Inst27Quest5PreQuest = "true"

--QUEST 6 Allianz

Inst27Quest6 = "探水棒"
Inst27Quest6_Level = "46"
Inst27Quest6_Attain = "?"
Inst27Quest6_Aim = "把探水棒交给加基森的首席工程师沙克斯·比格维兹。"
Inst27Quest6_Location = "比格维兹（塔纳利斯 - 加基森; "..NORMAL.."[52 / 28] "..WHITE.."）"
Inst27Quest6_Note = "你可以从布莱中士那里得到探水棒。你可以在"..NORMAL.."[4]"..WHITE.."找到他。但要在神庙百人斩事件后后打败布莱中士，才能得到探水棒。"
Inst27Quest6_Prequest = "无"
Inst27Quest6_Folgequest = "无"
--
Inst27Quest6name1 = "Masons Fraternity Ring"
Inst27Quest6name2 = "Engineer's Guild Headpiece"


--QUEST 7 Allianz

Inst27Quest7 = "加兹瑞拉"
Inst27Quest7_Level = "50"
Inst27Quest7_Attain = "40"
Inst27Quest7_Aim = "把加兹瑞拉的鳞片交给闪光平原的维兹尔·铜栓。"
Inst27Quest7_Location = "维兹尔·铜栓（千针石林 - 闪光平原; "..NORMAL.."[78 / 77] "..WHITE.."）"
Inst27Quest7_Note = "前导任务从科罗莫特·钢尺（铁炉堡 - 侏儒区; "..NORMAL.."[68 / 46]"..WHITE.."）得到。但这不是一个必要的任务。\n你可以在"..NORMAL.."[6]"..WHITE.."使用祖尔法拉克之槌敲锣召唤加兹瑞拉。\n槌来自守护者奇尔加（辛特兰 - 祖尔祭坛; "..NORMAL.."[49 / 70]"..WHITE.."）的神圣之槌并在辛萨罗祭坛"..NORMAL.."[59 / 77]"..WHITE.."上使用，才能在祖尔法拉克敲锣。"
Inst27Quest7_Prequest = "有，铜栓兄弟"
Inst27Quest7_Folgequest = "无"
Inst27Quest7PreQuest = "true"
--
Inst27Quest7name1 = "Carrot on a Stick"

--QUEST 1 Horde

Inst27Quest1_HORDE = "蜘蛛之神（系列任务）"
Inst27Quest1_HORDE_Level = "45"
Inst27Quest1_HORDE_Attain = "42"
Inst27Quest1_HORDE_Aim = "阅读塞卡石板，了解枯木巨魔的蜘蛛之神的名字，然后回到加德林大师那里。"
Inst27Quest1_HORDE_Location = "加德林大师（杜隆塔尔 - 森金村; "..NORMAL.."[55 / 74] "..WHITE.."）"
Inst27Quest1_HORDE_Note = "此任务始于辛特兰巨魔村庄的毒液瓶任务。\n你会在"..NORMAL.."[2]"..WHITE.."发现石板。"
Inst27Quest1_HORDE_Prequest = "有，毒液瓶 -> 请教加德林大师"
Inst27Quest1_HORDE_Folgequest = "有，召唤沙德拉"
Inst27Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst27Quest2_HORDE = "巨魔调和剂"
Inst27Quest2_HORDE_Level = "45"
Inst27Quest2_HORDE_Attain = "?"
Inst27Quest2_HORDE_Aim = "收集20瓶巨魔调和剂，把它们交给加基森的特伦顿·轻锤。"
Inst27Quest2_HORDE_Location = "特伦顿·轻锤（塔纳利斯 - 加基森; "..NORMAL.."[51 / 28] "..WHITE.."）"
Inst27Quest2_HORDE_Note = "每个巨魔都可能掉落调和剂。"
Inst27Quest2_HORDE_Prequest = "无"
Inst27Quest2_HORDE_Folgequest = "无"

--QUEST 3 Horde

Inst27Quest3_HORDE = "圣甲虫的壳"
Inst27Quest3_HORDE_Level = "45"
Inst27Quest3_HORDE_Attain = "?"
Inst27Quest3_HORDE_Aim = "给加基森的特兰雷克带去5个完整的圣甲虫壳。"
Inst27Quest3_HORDE_Location = "特兰雷克（塔纳利斯 - 加基森; "..NORMAL.."[51 / 26] "..WHITE.."）"
Inst27Quest3_HORDE_Note = "前导任务始于克拉兹克（荆棘谷 - 藏宝海湾; "..NORMAL.."[25 / 77]"..WHITE.."）。\n每个圣甲虫都可能掉落壳儿。大量圣甲虫集中在"..NORMAL.."[2]"..WHITE.."。"
Inst27Quest3_HORDE_Prequest = "有，特兰雷克"
Inst27Quest3_HORDE_Folgequest = "无"
Inst27Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst27Quest4_HORDE = "深渊皇冠"
Inst27Quest4_HORDE_Level = "46"
Inst27Quest4_HORDE_Attain = "40"
Inst27Quest4_HORDE_Aim = "将深渊皇冠交给尘泥沼泽的塔贝萨。"
Inst27Quest4_HORDE_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[46 / 57] "..WHITE.."）"
Inst27Quest4_HORDE_Note = "水占师维蕾萨掉落深渊皇冠。你可以在"..NORMAL.."[6]"..WHITE.."找到她。"
Inst27Quest4_HORDE_Prequest = "Tabetha's Task"
Inst27Quest4_HORDE_Folgequest = "无"
Inst27Quest4PreQuest_HORDE = "true"
--
Inst27Quest4name1_HORDE = "Spellshifter Rod"
Inst27Quest4name2_HORDE = "Gemshale Pauldrons"

--QUEST 5 Horde

Inst27Quest5_HORDE = "摩沙鲁的预言（系列任务）"
Inst27Quest5_HORDE_Level = "47"
Inst27Quest5_HORDE_Attain = "40"
Inst27Quest5_HORDE_Aim = "将第一块和第二块摩沙鲁石板交给塔纳利斯的叶基亚。"
Inst27Quest5_HORDE_Location = "叶基亚（塔纳利斯 - 热砂港; "..NORMAL.."[66 / 22] "..WHITE.."）"
Inst27Quest5_HORDE_Note = "前导任务也是在此获得。\n\n两块石板分别由殉教者塞卡"..NORMAL.."[2]"..WHITE.."和水占师维蕾萨"..NORMAL.."[6]"..WHITE.."掉落。"
Inst27Quest5_HORDE_Prequest = "有，尖啸者的灵魂"
Inst27Quest5_HORDE_Folgequest = "有，远古之卵"
Inst27Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst27Quest6_HORDE = "探水棒"
Inst27Quest6_HORDE_Level = "46"
Inst27Quest6_HORDE_Attain = "?"
Inst27Quest6_HORDE_Aim = "把探水棒交给加基森的首席工程师沙克斯·比格维兹。"
Inst27Quest6_HORDE_Location = "比格维兹（塔纳利斯 - 加基森; "..NORMAL.."[52 / 28] "..WHITE.."）"
Inst27Quest6_HORDE_Note = "你可以从布莱中士那里得到探水棒。你可以在"..NORMAL.."[4]"..WHITE.."找到他。但要在神庙百人斩事件后后打败布莱中士，才能得到探水棒。"
Inst27Quest6_HORDE_Prequest = "无"
Inst27Quest6_HORDE_Folgequest = "无"
--
Inst27Quest6name1_HORDE = "Masons Fraternity Ring"
Inst27Quest6name2_HORDE = "Engineer's Guild Headpiece"

--QUEST 7 Horde

Inst27Quest7_HORDE = "加兹瑞拉"
Inst27Quest7_HORDE_Level = "50"
Inst27Quest7_HORDE_Attain = "40"
Inst27Quest7_HORDE_Aim = "把加兹瑞拉的鳞片交给闪光平原的维兹尔·铜栓。"
Inst27Quest7_HORDE_Location = "维兹尔·铜栓（千针石林 - 闪光平原; "..NORMAL.."[78 / 77] "..WHITE.."）"
Inst27Quest7_HORDE_Note = "你可以在"..NORMAL.."[6]"..WHITE.."使用祖尔法拉克之槌敲锣召唤加兹瑞拉。\n槌来自守护者奇尔加（辛特兰 - 祖尔祭坛; "..NORMAL.."[49 / 70]"..WHITE.."）的神圣之槌并在辛萨罗祭坛"..NORMAL.."[59 / 77]"..WHITE.."上使用，才能在祖尔法拉克敲锣。"
Inst27Quest7_HORDE_Prequest = "The Brassbolts Brothers"
Inst27Quest7_HORDE_Folgequest = "无"
--
Inst27Quest7name1_HORDE = "Carrot on a Stick"

--------------------------Stockade/verlies (6 quests)
Inst24Story = "监狱是位于暴风城运河区戒备森原的牢房。那里由典狱官塞尔沃特看守着，监狱是那些小偷，政治犯，谋杀者和许多最危险的罪犯的家园。最近，异常暴动导致了监狱的混乱——所有的守卫都被赶了出来，里面的罪犯可以自由的活动。典狱官塞尔沃特试图控制局面并召集勇敢的冒险者进入监狱杀死暴动的主脑——那个狡猾的巴吉尔·特雷德。"
Inst24Caption = "监狱"
Inst24QAA = "6 个任务"
Inst24QAH = "没有任务"



--QUEST 1 Allianz

Inst24Quest1 = "伸张正义"
Inst24Quest1_Level = "25"
Inst24Quest1_Attain = "22"
Inst24Quest1_Aim = "把塔格尔的头颅带给湖畔镇的卫兵伯尔顿。"
Inst24Quest1_Location = "卫兵伯尔顿（赤脊山 - 湖畔镇; "..NORMAL.."[26 / 46] "..WHITE.."）"
Inst24Quest1_Note = "你可以在"..NORMAL.."[1]"..WHITE.."找到塔格尔。"
Inst24Quest1_Prequest = "无"
Inst24Quest1_Folgequest = "无"
--
Inst24Quest1name1 = "Lucine Longsword"
Inst24Quest1name2 = "Hardened Root Staff"

--QUEST 2 Allianz

Inst24Quest2 = "罪与罚"
Inst24Quest2_Level = "26"
Inst24Quest2_Attain = "22"
Inst24Quest2_Aim = "夜色镇的米尔斯迪普议员要你杀死迪克斯特·瓦德，并把他的手带回来作为证明。"
Inst24Quest2_Location = "米尔斯迪普议员（暮色森林 - 夜色镇; "..NORMAL.."[72 / 47] "..WHITE.."）"
Inst24Quest2_Note = "你可以在"..NORMAL.."[5]"..WHITE.."找到迪克斯特·瓦德."
Inst24Quest2_Prequest = "无"
Inst24Quest2_Folgequest = "无"
--
Inst24Quest2name1 = "Ambassador's Boots"
Inst24Quest2name2 = "Darkshire Mail Leggings"


--QUEST 3 Allianz

Inst24Quest3 = "镇压暴动"
Inst24Quest3_Level = "26"
Inst24Quest3_Attain = "22"
Inst24Quest3_Aim = "暴风城的典狱官塞尔沃特要求你杀死监狱中的10名迪菲亚囚徒、8名迪菲亚罪犯和8名迪菲亚叛军。"
Inst24Quest3_Location = "典狱官塞尔沃特（暴风城 - 监狱; "..NORMAL.."[41 / 58] "..WHITE.."）"
Inst24Quest3_Note = "副本外的典狱官会给你这个任务。"
Inst24Quest3_Prequest = "无"
Inst24Quest3_Folgequest = "无"

--QUEST 4 Allianz

Inst24Quest4 = "鲜血的颜色"
Inst24Quest4_Level = "26"
Inst24Quest4_Attain = "?"
Inst24Quest4_Aim = "暴风城的尼科瓦·拉斯克要你取得10条红色毛纺面罩。"
Inst24Quest4_Location = "尼科瓦·拉斯克（暴风城 - 旧城区; "..NORMAL.."[73 / 46] "..WHITE.."）"
Inst24Quest4_Note = "副本里每个敌人都可能掉落面罩。"
Inst24Quest4_Prequest = "无"
Inst24Quest4_Folgequest = "无"

--QUEST 5 Allianz

Inst24Quest5 = "卡姆·深怒"
Inst24Quest5_Level = "27"
Inst24Quest5_Attain = "25"
Inst24Quest5_Aim = "丹莫德的莫特雷·加玛森要求你把卡姆·深怒的头颅交给他。"
Inst24Quest5_Location = "莫特雷·加玛森（湿地 - 丹莫德; "..NORMAL.."[49 / 18] "..WHITE.."）"
Inst24Quest5_Note = "前导任务也从莫特雷·加玛森处得到。你可以在"..NORMAL.."[2]"..WHITE.."找到卡姆·深怒。"
Inst24Quest5_Prequest = "有，黑铁战争"
Inst24Quest5_Folgequest = "无"
Inst24Quest5PreQuest = "true"
--
Inst24Quest5name1 = "Belt of Vindication"
Inst24Quest5name2 = "Headbasher"


--QUEST 6 Allianz

Inst24Quest6 = "监狱暴动（系列任务）"
Inst24Quest6_Level = "29"
Inst24Quest6_Attain = "16"
Inst24Quest6_Aim = "杀死巴基尔·斯瑞德，把他的头带给监狱的典狱官塞尔沃特。"
Inst24Quest6_Location = "典狱官塞尔沃特（暴风城 - 监狱; "..NORMAL.."[41 / 58] "..WHITE.."）"
Inst24Quest6_Note = "前导任务详情请参见"..NORMAL.."[死亡矿井][迪菲亚兄弟会]"..WHITE..".。\n巴基尔·斯瑞德在"..NORMAL.."[4]"..WHITE.."。"
Inst24Quest6_Prequest = "有，未寄出的信 -> 巴吉尔·特雷德"
Inst24Quest6_Folgequest = "有，好奇的访客"
Inst24Quest6PreQuest = "true"



--------------Razorfen Downs/Inst17 ( 4 quests)------------
Inst17Story = "剃刀高地和剃刀沼泽一样由巨大的藤蔓组成，剃刀高地是野猪人的传统都城。在那错综复杂的荆棘迷宫中居住着大群忠诚的野猪人军队以及他们的高等牧师——亡首部族。然而最近，一股阴影力量笼罩了这个原始的洞穴。亡灵天灾的人在巫妖寒冰之王亚门纳尔的带领下控制了野猪部族并将荆棘迷宫变成了亡灵力量的堡垒。现在野猪人正奋力战斗来重新夺回他们的城市，并阻止亚门纳尔继续控制贫瘠之地。"
Inst17Caption = "剃刀高地"
Inst17QAA = "3 个任务"
Inst17QAH = "4 个任务"

--QUEST 1 Allianz

Inst17Quest1 = "邪恶之地"
Inst17Quest1_Level = "35"
Inst17Quest1_Attain = "30"
Inst17Quest1_Aim = "杀掉8个剃刀沼泽护卫者、8个剃刀沼泽织棘者和8个亡首教徒，然后向剃刀高地入口处的麦雷姆·月歌复命。"
Inst17Quest1_Location = "麦雷姆·月歌（贫瘠之地 - 剃刀高地; "..NORMAL.."[49 / 94] "..WHITE.."）"
Inst17Quest1_Note = "这些怪出现在你进入副本前经过的路上。"
Inst17Quest1_Prequest = "无"
Inst17Quest1_Folgequest = "无"

--QUEST 2 Allianz

Inst17Quest2 = "封印神像"
Inst17Quest2_Level = "37"
Inst17Quest2_Attain = "34"
Inst17Quest2_Aim = "保护奔尼斯特拉兹来到剃刀高地的野猪人神像处。当他在进行仪式封印神像时保护他。"
Inst17Quest2_Location = "奔尼斯特拉兹（剃刀高地; "..NORMAL.."[2] "..WHITE.."）"
Inst17Quest2_Note = "你必须同意帮助奔尼斯特拉兹封印神像，封印过程中会刷新怪物攻击他，必须保证他的安全。完成后在神像面前获得奖励。"
Inst17Quest2_Prequest = "有，剃刀高地的亡灵天灾"
Inst17Quest2_Folgequest = "无"
Inst17Quest2PreQuest = "true"
--
Inst17Quest2name1 = "Dragonclaw Ring"

--QUEST 3 Allianz

Inst17Quest3 = "与圣光同在"
Inst17Quest3_Attain = "39"
Inst17Quest3_Level = "42"
Inst17Quest3_Aim = "大主教本尼迪塔斯要你去杀死剃刀高地的寒冰之王亚门纳尔。"
Inst17Quest3_Location = "大主教本尼迪塔斯（暴风城 - 光明大教堂; "..NORMAL.."[39 / 27] "..WHITE.."）"
Inst17Quest3_Note = "寒冰之王亚门纳尔是剃刀高地的最后一个 Boss。你可以在"..NORMAL.."[6]"..WHITE.."找到他。"
Inst17Quest3_Prequest = "无"
Inst17Quest3_Folgequest = "无"
--
Inst17Quest3name1 = "Vanquisher's Sword"
Inst17Quest3name2 = "Amberglow Talisman"

--QUEST 1 Horde

Inst17Quest1_HORDE = "邪恶之地"
Inst17Quest1_HORDE_Level = "35"
Inst17Quest1_HORDE_Attain = "30"
Inst17Quest1_HORDE_Aim = "杀掉8个剃刀沼泽护卫者、8个剃刀沼泽织棘者和8个亡首教徒，然后向剃刀高地入口处的麦雷姆·月歌复命。"
Inst17Quest1_HORDE_Location = "麦雷姆·月歌（贫瘠之地 - 剃刀高地; "..NORMAL.."[49 / 94] "..WHITE.."）"
Inst17Quest1_HORDE_Note = "这些怪出现在你进入副本前经过的路上。"
Inst17Quest1_HORDE_Prequest = "无"
Inst17Quest1_HORDE_Folgequest = "无"

--Quest 2 Horde

Inst17Quest2_HORDE = "邪恶的盟友"
Inst17Quest2_HORDE_Level = "36"
Inst17Quest2_HORDE_Attain = "?"
Inst17Quest2_HORDE_Aim = "把玛克林大使的头颅带给幽暗城的瓦里玛萨斯。"
Inst17Quest2_HORDE_Location = "瓦里玛萨斯（幽暗城 - 皇家区; "..NORMAL.."[56 / 92] "..WHITE.."）"
Inst17Quest2_HORDE_Note = "剃刀沼泽最后的 Boss 给出前导任务。玛克林大使位置在进入副本前外面的空地上（贫瘠之地 - 剃刀高地; "..NORMAL.."[48 / 92]"..WHITE.."）。"
Inst17Quest2_HORDE_Prequest = "有，邪恶的盟友"
Inst17Quest2_HORDE_Folgequest = "无"
Inst17Quest2PreQuest_HORDE = "true"
--
Inst17Quest2name1_HORDE = "Skullbreaker"
Inst17Quest2name2_HORDE = "Nail Spitter"
Inst17Quest2name3_HORDE = "Zealot's Robe"

-- Quest 3 Horde

Inst17Quest3_HORDE = "封印神像"
Inst17Quest3_HORDE_Level = "37"
Inst17Quest3_HORDE_Attain = "34"
Inst17Quest3_HORDE_Aim = "保护奔尼斯特拉兹来到剃刀高地的野猪人神像处。当他在进行仪式封印神像时保护他。"
Inst17Quest3_HORDE_Location = "奔尼斯特拉兹（剃刀高地; "..NORMAL.."[2] "..WHITE.."）"
Inst17Quest3_HORDE_Note = "你必须同意帮助奔尼斯特拉兹封印神像，封印过程中会刷新怪物攻击他，必须保证他的安全。完成后在神像面前获得奖励。"
Inst17Quest3_HORDE_Prequest = "有，剃刀高地的亡灵天灾"
Inst17Quest3_HORDE_Folgequest = "无"
Inst17Quest3PreQuest_HORDE = "true"
--
Inst17Quest3name1_HORDE = "Dragonclaw Ring"

--QUEST 4 Horde

Inst17Quest4_HORDE = "寒冰之王"
Inst17Quest4_HORDE_Attain = "37"
Inst17Quest4_HORDE_Level = "42"
Inst17Quest4_HORDE_Aim = "安德鲁·布隆奈尔要你杀了寒冰之王亚门纳尔并将其头骨带回来。"
Inst17Quest4_HORDE_Location = "安德鲁·布隆奈尔（幽暗城 - 魔法区; "..NORMAL.."[72 / 32] "..WHITE.."）"
Inst17Quest4_HORDE_Note = "寒冰之王亚门纳尔是剃刀高地最后一个 Boss。位于"..NORMAL.."[6]"..WHITE.."。"
Inst17Quest4_HORDE_Prequest = "无"
Inst17Quest4_HORDE_Folgequest = "无"
--
Inst17Quest4name1_HORDE = "Vanquisher's Sword"
Inst17Quest4name2_HORDE = "Amberglow Talisman"

--------------Kloster/SM ( 6 quests)------------
Inst19Story = "这座修道院曾是洛丹伦牧师团引以为傲的堡垒，也是学习与启迪的中心。随着第三次大战期间天灾军团的崛起，这座宁静的修道院被改造成狂热血色十字军的要塞。十字军无法容忍任何非人类种族，不论其阵营或立场为何。他们相信所有外来者都可能携带亡灵瘟疫，因此必须被消灭。报告指出，进入修道院的冒险者将不得不面对率领大批狂热战士的血色指挥官莫格莱尼。然而，这座修道院真正的主人是大检察官怀特迈恩，这位可怕的女祭司拥有让倒下战士复活、再次为她而战的能力。"
Inst19Caption = "血色修道院"
Inst19QAA = "3 个任务"
Inst19QAH = "6 个任务"

--QUEST 1 Allianz

Inst19Quest1 = "能量仪祭（法师任务）"
Inst19Quest1_Level = "38"
Inst19Quest1_Attain = "?"
Inst19Quest1_Aim = "将《能量仪祭》交给尘泥沼泽的塔贝萨。"
Inst19Quest1_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[43 / 57]"..WHITE.."）"
Inst19Quest1_Note = "法师职业任务，你可以在血色修道院的图书馆奥法师杜安之前左侧一个走廊的地板上（"..NORMAL.."[2]"..WHITE.."）找到这本书。"
Inst19Quest1_Prequest = "有，解封咒语"
Inst19Quest1_Folgequest = "有，法师的魔杖"
--
Inst19Quest1name1 = "Explorers' League Commendation"

--QUEST 2 Allianz

Inst19Quest2 = "泰坦神话"
Inst19Quest2_Level = "40"
Inst19Quest2_Attain = "39"
Inst19Quest2_Aim = "从修道院拿回《泰坦神话》，把它交给铁炉堡的图书馆员麦伊·苍尘。"
Inst19Quest2_Location = "图书馆员麦伊·苍尘（铁炉堡 - 探险者大厅; "..NORMAL.."[74 / 12] "..WHITE.."）"
Inst19Quest2_Note = "你可以在血色修道院的图书馆奥法师杜安之前左侧一个走廊的地板上（"..NORMAL.."[2]"..WHITE.."）找到这本书。"
Inst19Quest2_Prequest = "Brother Anton -> Down the Scarlet Path"
Inst19Quest2_Folgequest = "无"
Inst19Quest2PreQuest = "true"
--
Inst19Quest2name1 = "Sword of Serenity"
Inst19Quest2name2 = "Bonebiter"
Inst19Quest2name3 = "Black Menace"
Inst19Quest2name4 = "Orb of Lorica"


--QUEST 3 Allianz MAGIER

Inst19Quest3 = "以圣光之名"
Inst19Quest3_Level = "40"
Inst19Quest3_Attain = "31"
Inst19Quest3_Aim = "杀死大检察官怀特迈恩，血色十字军指挥官莫格莱尼，十字军的勇士赫洛德和驯犬者洛克希并向南海镇的莱雷恩复命。"
Inst19Quest3_Location = "虔诚的莱雷恩（希尔斯布莱德丘陵 - 南海镇; "..NORMAL.."[51 / 58] "..WHITE.."）"
Inst19Quest3_Note = "此系列任务始于克罗雷修士（暴风城 - 光明大教堂; "..NORMAL.."[42 / 24]"..WHITE.."）。\n大检察官怀特迈恩和血色十字军指挥官莫格莱尼在血色修道院"..NORMAL.."教堂[2]"..WHITE.."，赫洛德在血色修道院"..NORMAL.."军械库[1]"..WHITE.."，驯犬者洛克希在血色修道院"..NORMAL.."图书馆[1]"..WHITE.."。"
Inst19Quest3_Prequest = "有，安东修士 -> 血色之路"
Inst19Quest3_Folgequest = "有"
Inst19Quest3PreQuest = "true"

--QUEST 1 Horde

Inst19Quest1_HORDE = "狂热之心"
Inst19Quest1_HORDE_Level = "33"
Inst19Quest1_HORDE_Attain = "?"
Inst19Quest1_HORDE_Aim = "幽暗城的大药剂师法拉尼尔需要20颗狂热之心。"
Inst19Quest1_HORDE_Location = "大药剂师法拉尼尔（幽暗城 - 炼金房; "..NORMAL.."[48 / 69] "..WHITE.."）"
Inst19Quest1_HORDE_Note = "血色所有的怪均掉落。"
Inst19Quest1_HORDE_Prequest = "有，蝙蝠的粪便（"..NORMAL.."[剃刀沼泽]"..WHITE.."）"
Inst19Quest1_HORDE_Folgequest = "无"
--
Inst19Quest1name1_HORDE = "Vorrel's Boots"
Inst19Quest1name2_HORDE = "Mantle of Woe"
Inst19Quest1name3_HORDE = "Grimsteel Cape"

--Quest 2 Horde

Inst19Quest2_HORDE = "狂热之心"
Inst19Quest2_HORDE_Level = "33"
Inst19Quest2_HORDE_Attain = "?"
Inst19Quest2_HORDE_Aim = "幽暗城的大药剂师法拉尼尔需要20颗狂热之心。"
Inst19Quest2_HORDE_Location = "大药剂师法拉尼尔（幽暗城 - 炼金房; "..NORMAL.."[48 / 69] "..WHITE.."）"
Inst19Quest2_HORDE_Note = "血色所有的怪物均会掉落。"
Inst19Quest2_HORDE_Prequest = "有，蝙蝠的粪便（"..NORMAL.."[剃刀沼泽]"..WHITE.."）"
Inst19Quest2_HORDE_Folgequest = "无"
Inst19Quest2PreQuest_HORDE = "true"


-- Quest 3 Horde

Inst19Quest3_HORDE = "能量仪祭（法师任务）"
Inst19Quest3_HORDE_Level = "36"
Inst19Quest3_HORDE_Attain = "32"
Inst19Quest3_HORDE_Aim = "将《能量仪祭》交给尘泥沼泽的塔贝萨。"
Inst19Quest3_HORDE_Location = "塔贝萨（尘泥沼泽; "..NORMAL.."[43 / 57]"..WHITE.."）"
Inst19Quest3_HORDE_Note = "法师职业任务，你可以在血色修道院的图书馆奥法师杜安之前左侧一个走廊的地板上（"..NORMAL.."[2]"..WHITE.."）找到这本书。"
Inst19Quest3_HORDE_Prequest = "有，解封咒语"
Inst19Quest3_HORDE_Folgequest = "有，法师的魔杖"
Inst19Quest3PreQuest_HORDE = "true"

--QUEST 4 Horde

Inst19Quest4_HORDE = "堕落者纲要"
Inst19Quest4_HORDE_Level = "38"
Inst19Quest4_HORDE_Attain = "?"
Inst19Quest4_HORDE_Aim = "从提瑞斯法林地血色修道院里找到《堕落者纲要》，把它交给雷霆崖的圣者图希克。"
Inst19Quest4_HORDE_Location = "圣者图希克（雷霆崖; "..NORMAL.."[34 / 47]"..WHITE.."）"
Inst19Quest4_HORDE_Note = "你可以在血色图书馆里找到这这本书。"
Inst19Quest4_HORDE_Prequest = "无"
Inst19Quest4_HORDE_Folgequest = "无"
--
Inst19Quest4name1_HORDE = "Vile Protector"
Inst19Quest4name2_HORDE = "Forcestone Buckler"
Inst19Quest4name3_HORDE = "Omega Orb"

--QUEST 5 Horde

Inst19Quest5_HORDE = "知识的试炼"
Inst19Quest5_HORDE_Level = "42"
Inst19Quest5_HORDE_Attain = "33"
Inst19Quest5_HORDE_Aim = "找到《亡灵的起源》，把它交给幽暗城的帕科瓦·芬塔拉斯。"
Inst19Quest5_HORDE_Location = "帕科瓦·芬塔拉斯（幽暗城 - 炼金房; "..NORMAL.."[57 / 65] "..WHITE.."）"
Inst19Quest5_HORDE_Note = "此系列任务始于多恩·平原行者（千针石林; "..NORMAL.."[53 / 41]"..WHITE.."）。\n书在血色修道院图书馆里。"
Inst19Quest5_HORDE_Prequest = "有，信仰的试炼 -> 耐力的试炼 -> 力量的试炼"
Inst19Quest5_HORDE_Folgequest = "有，知识的试炼"
--
Inst19Quest5name1_HORDE = "Sword of Omen"
Inst19Quest5name2_HORDE = "Prophetic Cane"
Inst19Quest5name3_HORDE = "Dragon's Blood Necklace"

--QUEST 6 Horde

Inst19Quest6_HORDE = "深入血色修道院"
Inst19Quest6_HORDE_Level = "40"
Inst19Quest6_HORDE_Attain = "31"
Inst19Quest6_HORDE_Aim = "杀掉大检察官怀特迈恩、血色十字军指挥官莫格莱尼、血色十字军勇士赫洛德和驯犬者洛克希，然后向幽暗城的瓦里玛萨斯回报。"
Inst19Quest6_HORDE_Location = "瓦里玛萨斯（幽暗城 - 皇家区; "..NORMAL.."[56 / 92] "..WHITE.."）"
Inst19Quest6_HORDE_Note = "大检察官怀特迈恩和血色十字军指挥官莫格莱尼在血色修道院"..NORMAL.."教堂[2]"..WHITE.."，赫洛德在血色修道院"..NORMAL.."军械库[1]"..WHITE.."，驯犬者洛克希在血色修道院"..NORMAL.."图书馆[1]"..WHITE.."。"
Inst19Quest6_HORDE_Prequest = "Get the Scoop"
Inst19Quest6_HORDE_Folgequest = "法师的魔杖"
Inst19Quest6PreQuest_HORDE = "true"

--------------Kral ( 5 quests)------------
Inst18Story = "在一万年前的古代战争中，万能的半神阿迦玛甘和燃烧军团进行了激战。虽然这头巨大的猪在战斗中倒下了，但是他的努力最终拯救了艾泽拉斯大陆免遭涂炭。虽然已经过去了很久，但是在它血液流淌的地方巨大的荆棘藤蔓生长出来。那些被认为是半神后代的野猪人占领了这些地区并将其奉为圣地。这些荆棘地的中心被称为剃刀岭。而巨大的剃刀沼泽则被一个老丑婆卡尔加·刺肋所占据。在她的统治下，信奉萨满教的野猪人和别的部族以及部落为敌。有些人甚至猜测卡尔加还在和亡灵天灾的有来往——她想要联合亡灵天灾来达到一些不可告人的险恶目的。"
Inst18Caption = "剃刀沼泽"
Inst18QAA = "5 个任务"
Inst18QAH = "5 个任务"

--QUEST 1 Allianz

Inst18Quest1 = "蓝叶薯"
Inst18Quest1_Level = "26"
Inst18Quest1_Attain = "20"
Inst18Quest1_Aim = "找到一个开孔的箱子。\n找到一根地鼠指挥棒。\n找到并阅读《地鼠指挥手册》。\n在剃刀沼泽里用开孔的箱子召唤一只地鼠，然后用指挥棒驱使它去搜寻蓝叶薯。\n把地鼠指挥棒、开孔的箱子和10块蓝叶薯交给棘齿城的麦伯克·米希瑞克斯。"
Inst18Quest1_Location = "麦伯克·米希瑞克斯（贫瘠之地 - 棘齿城; "..NORMAL.."[62 / 37]"..WHITE.."）"
Inst18Quest1_Note = "开孔的箱子，地鼠指挥棒和《地鼠指挥手册》都在麦伯克·米希瑞克斯附近不远的地方。"
Inst18Quest1_Prequest = "无"
Inst18Quest1_Folgequest = "无"
--
Inst18Quest1name1 = "A Small Container of Gems"

--QUEST 2 Allianz

Inst18Quest2 = "临终遗言"
Inst18Quest2_Level = "30"
Inst18Quest2_Attain = "?"
Inst18Quest2_Aim = "将塔莎拉的坠饰带给达纳苏斯的塔莎拉·静水。"
Inst18Quest2_Location = "赫尔拉斯·静水（剃刀沼泽; "..NORMAL.." [8]"..WHITE.."）"
Inst18Quest2_Note = "坠饰随机掉落。你必须把坠饰带给塔莎拉·静水（达纳苏斯 - 贸易区; "..NORMAL.."[69 / 67]"..WHITE.."）。"
Inst18Quest2_Prequest = "无"
Inst18Quest2_Folgequest = "无"
--
Inst18Quest2name1 = "Mourning Shawl"
Inst18Quest2name2 = "Lancer Boots"

--QUEST 3 Allianz

Inst18Quest3 = "进口商威利克斯"
Inst18Quest3_Level = "30"
Inst18Quest3_Attain = "?"
Inst18Quest3_Aim = "护送进口商威利克斯逃出剃刀沼泽。"
Inst18Quest3_Location = "进口商威利克斯（剃刀沼泽; "..NORMAL.." [8]"..WHITE.."）"
Inst18Quest3_Note = "你必须把威利克斯护送到入口处。完成后向他领取奖励。"
Inst18Quest3_Prequest = "无"
Inst18Quest3_Folgequest = "无"
--
Inst18Quest3name1 = "Monkey Ring"
Inst18Quest3name2 = "Snake Hoop"
Inst18Quest3name3 = "Tiger Band"

--QUEST 4 Allianz

Inst18Quest4 = "卡尔加·刺肋"
Inst18Quest4_Level = "34"
Inst18Quest4_Attain = "30"
Inst18Quest4_Aim = "把卡尔加·刺肋的徽章交给萨兰纳尔的法芬德尔。"
Inst18Quest4_Location = "法芬德尔（菲拉斯 - 萨兰纳尔; "..NORMAL.."[89 / 46]"..WHITE.."）"
Inst18Quest4_Note = "卡尔加·刺肋"..NORMAL.."[7]"..WHITE.."掉落徽章。"
Inst18Quest4_Prequest = "有，亨里格的日记"
Inst18Quest4_Folgequest = "有，卡尔加·刺肋"
Inst18Quest4PreQuest = "true"
--
Inst18Quest4name1 = "'Mage-Eye' Blunderbuss"
Inst18Quest4name2 = "Berylline Pads"
Inst18Quest4name3 = "Stonefist Girdle"
Inst18Quest4name4 = "Marbled Buckler"

--QUEST 5 Allianz KRIEGER

Inst18Quest5 = "弗伦的铠甲（战士任务）"
Inst18Quest5_Level = "28"
Inst18Quest5_Attain = "20"
Inst18Quest5_Aim = "收集必需的材料，将它们交给暴风城的弗伦·长须。"
Inst18Quest5_Location = "弗伦·长须（暴风城 - 矮人区; "..NORMAL.."[57 / 16]"..WHITE.."）"
Inst18Quest5_Note = "只有战士才能接到这个任务！\n你可以从鲁古格"..NORMAL.."[1]"..WHITE.."得到燃素。\n\n湿地的蜘蛛掉落烧焦的蜘蛛牙，石爪山脉的奇美幼崽拉掉落烧焦的奇美拉角、雌奇美拉掉落光滑的奇美拉角。"
Inst18Quest5_Prequest = "有，铸盾师"
Inst18Quest5_Folgequest = "有，（请见注释）"
Inst18Quest5PreQuest = "true"


--QUEST 1 Horde

Inst18Quest1_HORDE = "蓝叶薯"
Inst18Quest1_HORDE_Level = "26"
Inst18Quest1_HORDE_Attain = "20"
Inst18Quest1_HORDE_Aim = "找到一个开孔的箱子。\n找到一根地鼠指挥棒。\n找到并阅读《地鼠指挥手册》。\n在剃刀沼泽里用开孔的箱子召唤一只地鼠，然后用指挥棒驱使它去搜寻蓝叶薯。\n把地鼠指挥棒、开孔的箱子和10块蓝叶薯交给棘齿城的麦伯克·米希瑞克斯。"
Inst18Quest1_HORDE_Location = "麦伯克·米希瑞克斯（贫瘠之地 - 棘齿城; "..NORMAL.."[62 / 37]"..WHITE.."）"
Inst18Quest1_HORDE_Note = "开孔的箱子，地鼠指挥棒和《地鼠指挥手册》都在麦伯克·米希瑞克斯附近不远的地方。"
Inst18Quest1_HORDE_Prequest = "无"
Inst18Quest1_HORDE_Folgequest = "无"
--
Inst18Quest1name1_HORDE = "A Small Container of Gems"

--Quest 2 Horde

Inst18Quest2_HORDE = "进口商威利克斯"
Inst18Quest2_HORDE_Level = "30"
Inst18Quest2_HORDE_Attain = "?"
Inst18Quest2_HORDE_Aim = "护送进口商威利克斯逃出剃刀沼泽。"
Inst18Quest2_HORDE_Location = "进口商威利克斯（剃刀沼泽; "..NORMAL.." [8]"..WHITE.."）"
Inst18Quest2_HORDE_Note = "你必须把威利克斯护送到入口处。完成后向他领取奖励。"
Inst18Quest2_HORDE_Prequest = "无"
Inst18Quest2_HORDE_Folgequest = "无"
--
Inst18Quest2name1_HORDE = "Monkey Ring"
Inst18Quest2name2_HORDE = "Snake Hoop"
Inst18Quest2name3_HORDE = "Tiger Band"

-- Quest 3 Horde

Inst18Quest3_HORDE = "蝙蝠的粪便"
Inst18Quest3_HORDE_Level = "33"
Inst18Quest3_HORDE_Attain = "?"
Inst18Quest3_HORDE_Aim = "帮幽暗城的大药剂师法拉尼尔带回一堆沼泽蝙蝠的粪便。"
Inst18Quest3_HORDE_Location = "法拉尼尔（幽暗城 - 炼金房; "..NORMAL.."[48 / 69] "..WHITE.."）"
Inst18Quest3_HORDE_Note = "任何蝙蝠都会掉落沼泽蝙蝠的粪便。"
Inst18Quest3_HORDE_Prequest = "无"
Inst18Quest3_HORDE_Folgequest = "有，狂热之心（"..NORMAL.."[剃刀高地]"..WHITE.."）"

--QUEST 4 Horde

Inst18Quest4_HORDE = "奥尔德的报复"
Inst18Quest4_HORDE_Level = "34"
Inst18Quest4_HORDE_Attain = "29"
Inst18Quest4_HORDE_Aim = "把卡尔加·刺肋的心脏交给雷霆崖的奥尔德·石塔。"
Inst18Quest4_HORDE_Location = "奥尔德·石塔（雷霆崖; "..NORMAL.."[36 / 59] "..WHITE.."）"
Inst18Quest4_HORDE_Note = "卡尔加·刺肋在"..NORMAL.."[7]"..WHITE.."、"
Inst18Quest4_HORDE_Prequest = "无"
Inst18Quest4_HORDE_Folgequest = "无"
--
Inst18Quest4name1_HORDE = "Berylline Pads"
Inst18Quest4name2_HORDE = "Stonefist Girdle"
Inst18Quest4name3_HORDE = "Marbled Buckler"

--QUEST 5 Horde

Inst18Quest5_HORDE = "野蛮护甲（战士任务）"
Inst18Quest5_HORDE_Level = "30"
Inst18Quest5_HORDE_Attain = "20"
Inst18Quest5_HORDE_Aim = "为索恩格瑞姆收集15根烟雾铁锭、10份蓝铜粉、10块铁锭和1瓶燃素。"
Inst18Quest5_HORDE_Location = "索恩格瑞姆·火眼（贫瘠之地; "..NORMAL.."[57 / 30] "..WHITE.."）"
Inst18Quest5_HORDE_Note = "只有战士才能接到这个任务！\n你可以从鲁古格"..NORMAL.."[1]"..WHITE.."得到燃素。\n\n完成这个任务后他会给你一个新的任务。"
Inst18Quest5_HORDE_Prequest = "有，和索恩格瑞姆交谈"
Inst18Quest5_HORDE_Folgequest = "有，（请见注释）"
Inst18Quest5PreQuest_HORDE = "true"

--------------Scholo ( 9 quests)------------
Inst20Story = "通灵学院位于凯尔达隆废弃的城堡中的地下室中。那里曾经是高贵的巴罗夫家族的，但是在第二次大战中凯尔达隆变成了一块废墟。法师克尔苏加德经常向他的诅咒神教信徒承诺可以用对于巫妖王的效忠来换取永恒的生命。巴罗克家族受到克尔苏加德的魅惑而将城堡和其地下室献给了亡灵天灾。那些信徒然后将巴罗夫家族的人杀死并把地下室变成了通灵学院。虽然克尔苏加德不再住在这个地下室中，但是狂热的信徒和讲师都还留在那里。强大的巫妖，莱斯·霜语以亡灵天灾的名义控制了这里——而凡人亡灵巫师黑暗院长加丁则是这个学校邪恶的校长。"
Inst20Caption = "通灵学院"
Inst20QAA = "9 个任务"
Inst20QAH = "9 个任务"

--QUEST 1 Allianz

Inst20Quest1 = "瘟疫之龙"
Inst20Quest1_Attain = "55"
Inst20Quest1_Level = "58"
Inst20Quest1_Aim = "杀掉20只瘟疫龙崽，然后向圣光之愿礼拜堂的贝蒂娜·比格辛克复命。"
Inst20Quest1_Location = "贝蒂娜·比格辛克（东瘟疫之地 - 圣光之愿礼拜堂; "..NORMAL.."[81 / 59]"..WHITE.."）"
Inst20Quest1_Note = "瘟疫之龙在尸骨储藏所，去往血骨傀儡的大房间。"
Inst20Quest1_Prequest = "无"
Inst20Quest1_Folgequest = "有，健康的龙鳞"

--QUEST 2 Allianz

Inst20Quest2 = "健康的龙鳞"
Inst20Quest2_Attain = ""
Inst20Quest2_Level = "58"
Inst20Quest2_Aim = "把健康的龙鳞交给东瘟疫之地圣光之愿礼拜堂中的贝蒂娜·比格辛克。"
Inst20Quest2_Location = "健康的龙鳞（通灵学院瘟疫龙崽掉落）"
Inst20Quest2_Note = "瘟疫龙崽掉落健康的龙鳞（8% 掉率）。贝蒂娜·比格辛克在（东瘟疫之地 - 圣光之愿礼拜堂;"..NORMAL.."[81 / 59]"..WHITE.."）。"
Inst20Quest2_Prequest = "有，瘟疫之龙"
Inst20Quest2_Folgequest = "无"
Inst20Quest2FQuest = "true"

--QUEST 3 Allianz

Inst20Quest3 = "瑟尔林·卡斯迪诺夫教授"
Inst20Quest3_Attain = "55"
Inst20Quest3_Level = "60"
Inst20Quest3_Aim = "在通灵学院中找到瑟尔林·卡斯迪诺夫教授。杀死他，并烧毁艾瓦·萨克霍夫和卢森·萨克霍夫的遗体。任务完成后就回到艾瓦·萨克霍夫那儿。"
Inst20Quest3_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest3_Note = "你可以在"..NORMAL.."[9]"..WHITE.."找到瑟尔林·卡斯迪诺夫教授。"
Inst20Quest3_Prequest = "无"
Inst20Quest3_Folgequest = "有，卡斯迪诺夫的恐惧之袋"

--QUEST 4 Allianz

Inst20Quest4 = "卡斯迪诺夫的恐惧之袋"
Inst20Quest4_Attain = "55"
Inst20Quest4_Level = "60"
Inst20Quest4_Aim = "在通灵学院找到詹迪斯·巴罗夫并打败她。从她的尸体上找到卡斯迪诺夫的恐惧之袋，然后将其交给艾瓦·萨克霍夫。"
Inst20Quest4_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest4_Note = "你可以在"..NORMAL.."[3]"..WHITE.."詹迪斯·巴罗夫。"
Inst20Quest4_Prequest = "有，瑟尔林·卡斯迪诺夫教授"
Inst20Quest4_Folgequest = "有，传令官基尔图诺斯"
Inst20Quest4FQuest = "true"

--QUEST 5 Allianz

Inst20Quest5 = "传令官基尔图诺斯"
Inst20Quest5_Attain = "56"
Inst20Quest5_Level = "60"
Inst20Quest5_Aim = "带着无辜者之血回到通灵学院，将它放在门廊的火盆下面，基尔图诺斯会前来吞噬你的灵魂。勇敢地战斗吧，不要退缩！杀死基尔图诺斯，然后回到艾瓦·萨克霍夫那儿。"
Inst20Quest5_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest5_Note = "门廊就在"..NORMAL.."[2]"..WHITE.."。"
Inst20Quest5_Prequest = "有，卡斯迪诺夫的恐惧之袋"
Inst20Quest5_Folgequest = "有，莱斯·霜语"
Inst20Quest5FQuest = "true"
--
Inst20Quest5name1 = "Spectral Essence"
Inst20Quest5name2 = "Penelope's Rose"
Inst20Quest5name3 = "Mirah's Song"

--QUEST 6 Allianz

Inst20Quest6 = "巫妖莱斯·霜语"
Inst20Quest6_Attain = "60"
Inst20Quest6_Level = "60"
Inst20Quest6_Aim = "在通灵学院里找到莱斯·霜语。当你找到他之后，使用禁锢灵魂的遗物破除其亡灵的外壳。如果你成功地破除了他的不死之身，就杀掉他并拿到莱斯·霜语的头颅。把那个头颅交给马杜克镇长。"
Inst20Quest6_Location = "马杜克镇长（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest6_Note = "你可以在"..NORMAL.."[7]"..WHITE.."找到莱斯·霜语。"
Inst20Quest6_Prequest = "有，莱斯·霜语  - > 禁锢灵魂的遗物"
Inst20Quest6_Folgequest = "无"
Inst20Quest6PreQuest = "true"
--
Inst20Quest6name1 = "Darrowshire Strongguard"
Inst20Quest6name2 = "Warblade of Caer Darrow"
Inst20Quest6name3 = "Crown of Caer Darrow"
Inst20Quest6name4 = "Darrowspike"

--QUEST 7 Allianz

Inst20Quest7 = "巴罗夫家族的宝藏"
Inst20Quest7_Attain = "60"
Inst20Quest7_Level = "60"
Inst20Quest7_Aim = "到通灵学院中去取得巴罗夫家族的宝藏。这份宝藏包括四份地契：凯尔达隆地契、布瑞尔地契、塔伦米尔地契，还有南海镇地契。完成任务之后就回到维尔顿·巴罗夫那儿去。"
Inst20Quest7_Location = "维尔顿·巴罗夫（西瘟疫之地 - 寒风营地; "..NORMAL.."[43 / 83]"..WHITE.."）"
Inst20Quest7_Note = "你可以在"..NORMAL.."[12]"..WHITE.."找到凯尔达隆地契，在"..NORMAL.."[7]"..WHITE.."找到布瑞尔地契，在"..NORMAL.."[4]"..WHITE.."找到塔伦米尔地契，在"..NORMAL.."[1]"..WHITE.."找到南海镇地契。"
Inst20Quest7_Prequest = "无"
Inst20Quest7_Folgequest = "有，巴罗夫的继承人\n（去亡灵壁垒暗杀阿莱克斯·巴罗夫。把他的脑袋交给维尔顿·巴罗夫。）"

--QUEST 8 Allianz

Inst20Quest8 = "黎明先锋"
Inst20Quest8_Attain = "59"
Inst20Quest8_Level = "60"
Inst20Quest8_Aim = "将黎明先锋放在通灵学院的观察室里。打败维克图斯,然后回到贝蒂娜·比格辛克那里去。"
Inst20Quest8_Location = "贝蒂娜·比格辛克（东瘟疫之地 - 圣光之愿礼拜堂; "..NORMAL.."[81 / 59]"..WHITE.."）"
Inst20Quest8_Note = "雏龙精华开始于丁奇·斯迪波尔（燃烧平原 - 烈焰峰; "..NORMAL.."[65 / 23]"..WHITE.."）。 观察室在"..NORMAL.."[6]"..WHITE.."。"
Inst20Quest8_Prequest = "有，雏龙精华 - > 莱尼德·巴萨罗梅 - > 贝蒂娜·比格辛克"
Inst20Quest8_Folgequest = "无"
Inst20Quest8PreQuest = "true"
--
Inst20Quest8name1 = "Windreaper"
Inst20Quest8name2 = "Dancing Sliver"

--QUEST 9 Allaince

Inst20Quest9 = "瓶中的小鬼（术士任务）"
Inst20Quest9_Attain = "60"
Inst20Quest9_Level = "60"
Inst20Quest9_Aim = "把瓶中的小鬼带到通灵学院的炼金实验室中。在小鬼制造出羊皮纸之后，把瓶子还给戈瑟奇·邪眼。"
Inst20Quest9_Location = "戈瑟奇·邪眼（燃烧平原; "..NORMAL.."[12 / 31]"..WHITE.."）"
Inst20Quest9_Note = "只有术士才能得到这个任务！你可以在"..NORMAL.."[7]"..WHITE.."找到炼金实验室。"
Inst20Quest9_Prequest = "有，莫苏尔·召血者 - > 克索诺斯星尘"
Inst20Quest9_Folgequest = "有，克索诺斯恐惧战马"
Inst20Quest9PreQuest = "true"



--QUEST 1 Horde

Inst20Quest1_HORDE = "瘟疫之龙"
Inst20Quest1_HORDE_Attain = "55"
Inst20Quest1_HORDE_Level = "58"
Inst20Quest1_HORDE_Aim = "杀掉20只瘟疫龙崽，然后向圣光之愿礼拜堂的贝蒂娜·比格辛克复命。"
Inst20Quest1_HORDE_Location = "贝蒂娜·比格辛克（东瘟疫之地 - 圣光之愿礼拜堂; "..NORMAL.."[81 / 59]"..WHITE.."）"
Inst20Quest1_HORDE_Note = "瘟疫之龙在尸骨储藏所，去往血骨傀儡的大房间。"
Inst20Quest1_HORDE_Prequest = "无"
Inst20Quest1_HORDE_Folgequest = "有，健康的龙鳞"


--QUEST 2 Horde

Inst20Quest2_HORDE = "健康的龙鳞"
Inst20Quest2_HORDE_Attain = ""
Inst20Quest2_HORDE_Level = "58"
Inst20Quest2_HORDE_Aim = "把健康的龙鳞交给东瘟疫之地圣光之愿礼拜堂中的贝蒂娜·比格辛克。"
Inst20Quest2_HORDE_Location = "健康的龙鳞（通灵学院瘟疫龙崽掉落）"
Inst20Quest2_HORDE_Note = "瘟疫龙崽掉落健康的龙鳞（8% 掉率）。贝蒂娜·比格辛克在（东瘟疫之地 - 圣光之愿礼拜堂;"..NORMAL.."[81 / 59]"..WHITE.."）。"
Inst20Quest2_HORDE_Prequest = "有，瘟疫之龙"
Inst20Quest2_HORDE_Folgequest = "无"
Inst20Quest2FQuest_HORDE = "true"


--QUEST 3 Horde

Inst20Quest3_HORDE = "瑟尔林·卡斯迪诺夫教授"
Inst20Quest3_HORDE_Attain = "55"
Inst20Quest3_HORDE_Level = "60"
Inst20Quest3_HORDE_Aim = "在通灵学院中找到瑟尔林·卡斯迪诺夫教授。杀死他，并烧毁艾瓦·萨克霍夫和卢森·萨克霍夫的遗体。任务完成后就回到艾瓦·萨克霍夫那儿。"
Inst20Quest3_HORDE_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest3_HORDE_Note = "你可以在"..NORMAL.."[9]"..WHITE.."找到瑟尔林·卡斯迪诺夫教授。"
Inst20Quest3_HORDE_Prequest = "无"
Inst20Quest3_HORDE_Folgequest = "有，卡斯迪诺夫的恐惧之袋"

--QUEST 4 Horde

Inst20Quest4_HORDE = "卡斯迪诺夫的恐惧之袋"
Inst20Quest4_HORDE_Attain = "55"
Inst20Quest4_HORDE_Level = "60"
Inst20Quest4_HORDE_Aim = "在通灵学院找到詹迪斯·巴罗夫并打败她。从她的尸体上找到卡斯迪诺夫的恐惧之袋，然后将其交给艾瓦·萨克霍夫。"
Inst20Quest4_HORDE_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest4_HORDE_Note = "你可以在"..NORMAL.."[3]"..WHITE.."詹迪斯·巴罗夫。"
Inst20Quest4_HORDE_Prequest = "有，瑟尔林·卡斯迪诺夫教授"
Inst20Quest4_HORDE_Folgequest = "有，传令官基尔图诺斯"
Inst20Quest4FQuest_HORDE = "true"


--QUEST 5 Horde

Inst20Quest5_HORDE = "传令官基尔图诺斯"
Inst20Quest5_HORDE_Attain = "56"
Inst20Quest5_HORDE_Level = "60"
Inst20Quest5_HORDE_Aim = "带着无辜者之血回到通灵学院，将它放在门廊的火盆下面，基尔图诺斯会前来吞噬你的灵魂。勇敢地战斗吧，不要退缩！杀死基尔图诺斯，然后回到艾瓦·萨克霍夫那儿。"
Inst20Quest5_HORDE_Location = "艾瓦·萨克霍夫（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest5_HORDE_Note = "门廊就在"..NORMAL.."[2]"..WHITE.."。"
Inst20Quest5_HORDE_Prequest = "有，卡斯迪诺夫的恐惧之袋"
Inst20Quest5_HORDE_Folgequest = "有，莱斯·霜语"
Inst20Quest5FQuest_HORDE = "true"
--
Inst20Quest5name1_HORDE = "Spectral Essence"
Inst20Quest5name2_HORDE = "Penelope's Rose"
Inst20Quest5name3_HORDE = "Mirah's Song"

--QUEST 6 Horde

Inst20Quest6_HORDE = "巫妖莱斯·霜语"
Inst20Quest6_HORDE_Attain = "60"
Inst20Quest6_HORDE_Level = "60"
Inst20Quest6_HORDE_Aim = "在通灵学院里找到莱斯·霜语。当你找到他之后，使用禁锢灵魂的遗物破除其亡灵的外壳。如果你成功地破除了他的不死之身，就杀掉他并拿到莱斯·霜语的头颅。把那个头颅交给马杜克镇长。"
Inst20Quest6_HORDE_Location = "马杜克镇长（西瘟疫之地 - 凯尔达隆; "..NORMAL.."[70 / 73]"..WHITE.."）"
Inst20Quest6_HORDE_Note = "你可以在"..NORMAL.."[7]"..WHITE.."找到莱斯·霜语。"
Inst20Quest6_HORDE_Prequest = "有，莱斯·霜语  - > 禁锢灵魂的遗物"
Inst20Quest6_HORDE_Folgequest = "无"
Inst20Quest6PreQuest_HORDE = "true"
--
Inst20Quest6name1_HORDE = "Darrowshire Strongguard"
Inst20Quest6name2_HORDE = "Warblade of Caer Darrow"
Inst20Quest6name3_HORDE = "Crown of Caer Darrow"
Inst20Quest6name4_HORDE = "Darrowspike"

--QUEST 7 Horde

Inst20Quest7_HORDE = "巴罗夫家族的宝藏"
Inst20Quest7_HORDE_Attain = "60"
Inst20Quest7_HORDE_Level = "60"
Inst20Quest7_HORDE_Aim = "到通灵学院中去取得巴罗夫家族的宝藏。这份宝藏包括四份地契：凯尔达隆地契、布瑞尔地契、塔伦米尔地契，还有南海镇地契。当你拿到这四份地契之后就回到阿莱克斯·巴罗夫那儿去。"
Inst20Quest7_HORDE_Location = "阿莱克斯·巴罗夫（西瘟疫之地 - 亡灵壁垒; "..NORMAL.."[28 / 57]"..WHITE.."）"
Inst20Quest7_HORDE_Note = "你可以在"..NORMAL.."[12]"..WHITE.."找到凯尔达隆地契，在"..NORMAL.."[7]"..WHITE.."找到布瑞尔地契，在"..NORMAL.."[4]"..WHITE.."找到塔伦米尔地契，在"..NORMAL.."[1]"..WHITE.."找到南海镇地契。"
Inst20Quest7_HORDE_Prequest = "无"
Inst20Quest7_HORDE_Folgequest = "有，巴罗夫的继承人\n（到寒风营地去暗杀维尔顿·巴罗夫。把他的脑袋交给阿莱克斯·巴罗夫。）"


--QUEST 8 Horde

Inst20Quest8_HORDE = "黎明先锋"
Inst20Quest8_HORDE_Attain = "59"
Inst20Quest8_HORDE_Level = "60"
Inst20Quest8_HORDE_Aim = "将黎明先锋放在通灵学院的观察室里。打败维克图斯,然后回到贝蒂娜·比格辛克那里去。"
Inst20Quest8_HORDE_Location = "贝蒂娜·比格辛克（东瘟疫之地 - 圣光之愿礼拜堂; "..NORMAL.."[81 / 59]"..WHITE.."）"
Inst20Quest8_HORDE_Note = "雏龙精华开始于丁奇·斯迪波尔（燃烧平原 - 烈焰峰; "..NORMAL.."[65 / 23]"..WHITE.."）。 观察室在"..NORMAL.."[6]"..WHITE.."。"
Inst20Quest8_HORDE_Prequest = "有，雏龙精华 - > 莱尼德·巴萨罗梅 - > 贝蒂娜·比格辛克"
Inst20Quest8_HORDE_Folgequest = "无"
Inst20Quest8PreQuest_HORDE = "true"
--
Inst20Quest8name1_HORDE = "Windreaper"
Inst20Quest8name2_HORDE = "Dancing Sliver"

--QUEST 9 Horde

Inst20Quest9_HORDE = "瓶中的小鬼（术士任务）"
Inst20Quest9_HORDE_Attain = "60"
Inst20Quest9_HORDE_Level = "60"
Inst20Quest9_HORDE_Aim = "把瓶中的小鬼带到通灵学院的炼金实验室中。在小鬼制造出羊皮纸之后，把瓶子还给戈瑟奇·邪眼。"
Inst20Quest9_HORDE_Location = "戈瑟奇·邪眼（燃烧平原; "..NORMAL.."[12 / 31]"..WHITE.."）"
Inst20Quest9_HORDE_Note = "只有术士才能得到这个任务！你可以在"..NORMAL.."[7]"..WHITE.."找到炼金实验室。"
Inst20Quest9_HORDE_Prequest = "有，莫苏尔·召血者 - > 克索诺斯星尘"
Inst20Quest9_HORDE_Folgequest = "有，克索诺斯恐惧战马"
Inst20Quest9PreQuest_HORDE = "true"

--------------Inst7/BFD(6  quests)------------
Inst7Story = "位于灰谷佐拉姆海岸的黑暗深渊曾经是为供奉暗夜精灵月神艾露尼尔建造的。然而，在大爆炸中，神庙受到极大的冲击然后沉入了海中。它一直保持着原样——直到，其蕴含的古老的力量吸引来了纳迦和萨特。传说，古代怪兽阿库麦尔就居住在神庙遗迹中。作为古代之神最喜欢的宠物之一，阿库麦尔就一直生活在这个地区进行捕食。在阿库麦尔的吸引下，一群被称作幕光之锤的教徒也聚集在这里从事邪恶的勾当。"
Inst7Caption = "黑暗深渊"
Inst7QAA = "6 个任务"
Inst7QAH = "5 个任务"

--QUEST 1 Allianz

Inst7Quest1 = "深渊中的知识"
Inst7Quest1_Attain = "18"
Inst7Quest1_Level = "23"
Inst7Quest1_Aim = "把洛迦里斯手稿带给铁炉堡的葛利·硬骨。"
Inst7Quest1_Location = "葛利·硬骨（铁炉堡 - 荒弃的洞穴; "..NORMAL.."[50 / 5]"..WHITE.."）"
Inst7Quest1_Note = "你可以在靠近"..NORMAL.."[2]"..WHITE.."的水中找到手稿。"
Inst7Quest1_Prequest = "无"
Inst7Quest1_Folgequest = "无"
--
Inst7Quest1name1 = "Sustaining Ring"

--QUEST 2 Allianz

Inst7Quest2 = "研究堕落"
Inst7Quest2_Attain = "19"
Inst7Quest2_Level = "24"
Inst7Quest2_Aim = "奥伯丁的戈沙拉·夜语需要8块堕落者的脑干。"
Inst7Quest2_Location = "戈沙拉·夜语（黑海岸 - 奥伯丁; "..NORMAL.."[38 / 43]"..WHITE.."）"
Inst7Quest2_Note = "前导任务可以从阿古斯·夜语（暴风城 - 花园; "..NORMAL.."[21 / 55]"..WHITE.."）处得到。 黑暗深渊副本里面和门前的所有纳迦都可能掉落脑干。"
Inst7Quest2_Prequest = "有，遥远的旅途"
Inst7Quest2_Folgequest = "无"
Inst7Quest2PreQuest = "true"
--
Inst7Quest2name1 = "Beetle Clasps"
Inst7Quest2name2 = "Prelacy Cape"

--QUEST 3 Allianz

Inst7Quest3 = "寻找塞尔瑞德"
Inst7Quest3_Attain = "19"
Inst7Quest3_Level = "24"
Inst7Quest3_Aim = "到黑色深渊去找到银月守卫塞尔瑞德。"
Inst7Quest3_Location = "哨兵山德拉斯（达纳苏斯 - 工匠区; "..NORMAL.."[55 / 24]"..WHITE.."）"
Inst7Quest3_Note = "你可以在"..NORMAL.."[4]"..WHITE.."找到银月守卫塞尔瑞德。"
Inst7Quest3_Prequest = "无"
Inst7Quest3_Folgequest = "有，黑暗深渊中的恶魔"

--QUEST 4 Alliance

Inst7Quest4 = "黑暗深渊中的恶魔"
Inst7Quest4_Attain = "-"
Inst7Quest4_Level = "27"
Inst7Quest4_Aim = "把梦游者克尔里斯的头颅交给达纳苏斯的哨兵塞尔高姆。"
Inst7Quest4_Location = "哨兵塞尔瑞德（黑暗深渊; "..NORMAL.."[4]"..WHITE.."）"
Inst7Quest4_Note = "克尔里斯在"..NORMAL.."[8]"..WHITE.."。你可以哨兵找到塞尔高姆（达纳苏斯 - 工匠区; "..NORMAL.."[55 / 24]"..WHITE.."）。注意！如果你点燃了克尔里斯旁边的火焰，敌人会出现并攻击你。"
Inst7Quest4_Prequest = "有，寻找塞尔瑞德"
Inst7Quest4_Folgequest = "无"
Inst7Quest4FQuest = "true"
--
Inst7Quest4name1 = "Gravestone Scepter"
Inst7Quest4name2 = "Arctic Buckler"

--QUEST 5 Alliance

Inst7Quest5 = "暮光之锤的末日"
Inst7Quest5_Attain = "20"
Inst7Quest5_Level = "25"
Inst7Quest5_Aim = "收集10个暮光坠饰，把它们交给达纳苏斯的银月守卫玛纳杜斯。"
Inst7Quest5_Location = "银月守卫玛纳杜斯（达纳苏斯 - 工匠区; "..NORMAL.."[55 / 23]"..WHITE.."）"
Inst7Quest5_Note = "每个暮光敌人都会掉落坠饰。"
Inst7Quest5_Prequest = "无"
Inst7Quest5_Folgequest = "无"
--
Inst7Quest5name1 = "Nimbus Boots"
Inst7Quest5name2 = "Heartwood Girdle"

--QUEST 6 Alliance (hexenmeister)

Inst7Quest6 = "6. 索兰鲁克宝珠（术士）"
Inst7Quest6_Attain = "21"
Inst7Quest6_Level = "26"
Inst7Quest6_Aim = "找到 3 块索兰鲁克碎片和 1 块大型索兰鲁克碎片，并把它们交给贫瘠之地的杜安·卡汉。"
Inst7Quest6_Location = "杜安·卡汉（贫瘠之地; "..YELLOW.."49,67"..WHITE.."）"
Inst7Quest6_Note = "只有术士才能接到这个任务！3 块索兰鲁克碎片由 "..NORMAL.."[黑暗深渊]"..WHITE.." 中的暮光侍僧掉落。大型索兰鲁克碎片由 "..NORMAL.."[影牙城堡]"..WHITE.." 中的影牙暗魂掉落。"
Inst7Quest6_Prequest = "无"
Inst7Quest6_Folgequest = "无"
--
Inst7Quest6name1 = "Orb of Soran'ruk"
Inst7Quest6name2 = "Staff of Soran'ruk"


--QUEST 1 Horde

Inst7Quest1_HORDE = "阿库麦尔水晶"
Inst7Quest1_HORDE_Attain = "17"
Inst7Quest1_HORDE_Level = "22"
Inst7Quest1_HORDE_Aim = "收集20颗阿库麦尔蓝宝石，把它们交给灰谷的耶努萨克雷。"
Inst7Quest1_HORDE_Location = "耶努萨克雷（灰谷 - 佐拉姆加前哨站; "..NORMAL.."[11 / 33]"..WHITE.."）"
Inst7Quest1_HORDE_Note = "前导任务《帮助耶努萨克雷》可以在苏纳曼（石爪山脉 - 烈日石居; "..NORMAL.."[47 / 64]"..WHITE.."）接到。蓝宝石多生长在通往黑暗深渊入口的那条通道的洞穴墙壁上。"
Inst7Quest1_HORDE_Prequest = "有，帮助耶努萨克雷"
Inst7Quest1_HORDE_Folgequest = "废墟之间"
Inst7Quest1PreQuest_HORDE = "true"

--QUEST 2 Horde

Inst7Quest2_HORDE = "上古之神的仆从"
Inst7Quest2_HORDE_Attain = "-"
Inst7Quest2_HORDE_Level = "26"
Inst7Quest2_HORDE_Aim = "把潮湿的便笺交给灰谷的耶努萨克雷。 -> 杀掉黑暗深渊里的洛古斯·杰特，然后向灰谷的耶努萨克雷复命。"
Inst7Quest2_HORDE_Location = "潮湿的便笺（掉落）（请见注释）"
Inst7Quest2_HORDE_Note = "潮湿的便笺可从黑暗深渊海潮祭司处得到（5% 掉落几率）。然后去耶努萨克雷（灰谷 - 佐拉姆加前哨站; "..NORMAL.."[11 / 33]"..WHITE.."）。洛古斯·杰特在"..NORMAL.."[6]"..WHITE.."。"
Inst7Quest2_HORDE_Prequest = "无"
Inst7Quest2_HORDE_Folgequest = "无"
--
Inst7Quest2name1_HORDE = "Band of the Fist"
Inst7Quest2name2_HORDE = "Chestnut Mantle"

--QUEST 3 Horde

Inst7Quest3_HORDE = "废墟之间"
Inst7Quest3_HORDE_Attain = "-"
Inst7Quest3_HORDE_Level = "27"
Inst7Quest3_HORDE_Aim = "把深渊之核交给灰谷佐拉姆加前哨站里的耶努萨克雷。"
Inst7Quest3_HORDE_Location = "耶努萨克雷（灰谷 - 佐拉姆加前哨站; "..NORMAL.."[11 / 33]"..WHITE.."）"
Inst7Quest3_HORDE_Note = "深渊之核在"..NORMAL.."[7]"..WHITE.."区水域里。当你得到深远之核后，阿奎尼斯男爵会出现并攻击你。他会掉落一件任务物品，你要把它带给耶努萨克雷。"
Inst7Quest3_HORDE_Prequest = "无"
Inst7Quest3_HORDE_Folgequest = "无"

--QUEST 4 Horde

Inst7Quest4_HORDE = "黑暗深渊中的恶魔"
Inst7Quest4_HORDE_Attain = "-"
Inst7Quest4_HORDE_Level = "27"
Inst7Quest4_HORDE_Aim = "把梦游者克尔里斯的头颅带回雷霆崖交给巴珊娜·符文图腾 。"
Inst7Quest4_HORDE_Location = "银月守卫塞尔瑞德（黑暗深渊; "..NORMAL.."[4]"..WHITE.."）"
Inst7Quest4_HORDE_Note = "克尔里斯在"..NORMAL.."[8]"..WHITE.."。巴珊娜·符文图腾可以在（雷霆崖 - 长者高地 "..NORMAL.."[70 / 33]"..WHITE.."）处找到。注意！如果你点燃了克尔里斯身旁的火焰，会出现敌人攻击你。"
Inst7Quest4_HORDE_Prequest = "无"
Inst7Quest4_HORDE_Folgequest = "无"
--
Inst7Quest4name1_HORDE = "Gravestone Scepter"
Inst7Quest4name2_HORDE = "Arctic Buckler"

--QUEST 5 Horde (Warlock)

Inst7Quest5_HORDE = "阿奎尼斯男爵"
Inst7Quest5_HORDE_Attain = "20"
Inst7Quest5_HORDE_Level = "25"
Inst7Quest5_HORDE_Aim = "把奇怪的水球交给灰谷佐拉姆加前哨站的耶努·萨克雷。"
Inst7Quest5_HORDE_Location = "奇异的水之球（黑暗深渊; "..NORMAL.."[7]"..WHITE.."）"
Inst7Quest5_HORDE_Note = "在任务 #3 中使用深渊石 "..NORMAL.."[7]"..WHITE.." 会召唤阿奎尼斯男爵。他会掉落开启该任务的奇异的水之球。"
Inst7Quest5_HORDE_Prequest = "无"
Inst7Quest5_HORDE_Folgequest = "无"
--
Inst7Quest5name1_HORDE = "Orb of Soran'ruk"
Inst7Quest5name2_HORDE = "Staff of Soran'ruk"

--------------Inst25 ( 8 quests)------------
Inst25Story = "在一千年之前，强大的古拉巴什王国被一次大型内部战争所毁灭。一部份被称为阿塔莱的巨魔牧师试图将古代血神哈卡灵魂掠夺者带回这个世界。虽然这些牧师被击败并最终被流放，这个伟大的王国变得四分五裂。流放的牧师逃到了北面，来到了悲伤沼泽。他们为哈卡建立了一座伟大的神庙——在那里他们期望能够把哈卡重新带回世间。伟大的守护神龙伊瑟拉了解了阿塔莱的计划并将神庙摧毁沉入沼泽之中。在今天，神庙沉没的遗迹被绿龙所守卫并阻止任何人进入或者出去。然而，有些阿塔莱巨魔从伊瑟拉的怒火中幸存下来并再此奖自己奉献与复活哈卡的事业中。 "
Inst25Caption = "沉没的神庙"
--classq
Inst25QAA = "8 个任务"
Inst25QAH = "8 个任务"

--QUEST 1 Allianz

Inst25Quest1 = "进入阿塔哈卡神庙"
Inst25Quest1_Attain = "46"
Inst25Quest1_Level = "50"
Inst25Quest1_Aim = "为暴风城的布罗哈恩·铁桶收集10块阿塔莱石板。"
Inst25Quest1_Location = "布罗哈恩·铁桶（暴风城 - 矮人区; "..NORMAL.."[64 / 20]"..WHITE.."）"
Inst25Quest1_Note = "前导任务在此领取。\n\n石板你在神庙内外里到处都能见到。"
Inst25Quest1_Prequest = "有，调查神庙 -> 拉普索迪的故事"
Inst25Quest1_Folgequest = "无"
Inst25Quest1PreQuest = "true"
--
Inst25Quest1name1 = "Guardian Talisman"

--QUEST 2 Allianz

Inst25Quest2 = "2. 沉没的神庙"
Inst25Quest2_Attain = "-"
Inst25Quest2_Level = "51"
Inst25Quest2_Aim = "在塔纳利斯找到玛尔冯·瑞文斯克。"
Inst25Quest2_Location = "安吉拉斯·月风（菲拉斯; "..YELLOW.."31,45"..WHITE..")"
Inst25Quest2_Note = "你可以在 52,45 找到玛尔冯·瑞文斯克。"
Inst25Quest2_Prequest = "无"
Inst25Quest2_Folgequest = "有，石环"

--QUEST 3 Allianz

Inst25Quest3 = "3. 深入神庙"
Inst25Quest3_Attain = "-"
Inst25Quest3_Level = "51"
Inst25Quest3_Aim = "在悲伤沼泽的沉没的神庙中找到哈卡祭坛。"
Inst25Quest3_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_Note = "祭坛位于 [1]。"
Inst25Quest3_Prequest = "有，石环"
Inst25Quest3_Folgequest = "有，雕像群的秘密"
Inst25Quest3FQuest = "true"


--QUEST 4 Alliance

Inst25Quest4 = "4. 雕像群的秘密"
Inst25Quest4_Attain = "-"
Inst25Quest4_Level = "51"
Inst25Quest4_Aim = "进入沉没的神庙，找出隐藏在雕像环中的秘密。"
Inst25Quest4_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_Note = "雕像位于 [1]，按 1-6 的顺序启动它们。"
Inst25Quest4_Prequest = "有，深入神庙"
Inst25Quest4_Folgequest = "无"
Inst25Quest4FQuest = "true"
--
Inst25Quest4name1 = "Hakkari Urn"

--QUEST 5 Alliance

Inst25Quest5 = "雕像群的秘密"
Inst25Quest5_Attain = "50"
Inst25Quest5_Level = "52"
Inst25Quest5_Aim = "到沉没的神庙去，揭开雕像群中隐藏的秘密。"
Inst25Quest5_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..NORMAL.."[52 / 45]"..WHITE.."）"
Inst25Quest5_Note = "雕像群就在图中"..NORMAL.."[1]"..WHITE.."所示位置，按照地图指示的顺序打开他们。"
Inst25Quest5_Prequest = "有，深入神庙"
Inst25Quest5_Folgequest = "无"
Inst25Quest5PreQuest = "true"



--QUEST 6 Alliance

Inst25Quest6 = "邪恶之雾"
Inst25Quest6_Attain = "43"
Inst25Quest6_Level = "53"
Inst25Quest6_Aim = "收集5份阿塔莱之雾的样本，然后向安戈洛环形山的穆尔金复命。"
Inst25Quest6_Location = "格雷甘·山酒（菲拉斯; "..NORMAL.."[45 / 25]"..WHITE.."）"
Inst25Quest6_Note = "前导任务《穆尔金和拉瑞安》开始于穆尔金（安戈洛环形山 - 马绍尔营地; "..NORMAL.."[42 / 9]"..WHITE.."）。你可以从阿塔哈卡神庙里的神庙深渊潜伏者、黑暗虫或者融合软泥怪那里得到阿塔莱之雾。"
Inst25Quest6_Prequest = "有，穆尔金和拉瑞安 -> 造访格雷甘"
Inst25Quest6_Folgequest = "无"
Inst25Quest6PreQuest = "true"
--
Inst25Quest6name1 = "Avenguard Helm"
Inst25Quest6name2 = "Lifeforce Dirk"
Inst25Quest6name3 = "Gemburst Circlet"

--QUEST 7 Alliance

Inst25Quest7 = "神灵哈卡（系列任务）"
Inst25Quest7_Attain = "43"
Inst25Quest7_Level = "53"
Inst25Quest7_Aim = "将装满的哈卡之卵交给塔纳利斯的叶基亚。"
Inst25Quest7_Location = "叶基亚（塔纳利斯 - 热砂港; "..NORMAL.."[66 / 22]"..WHITE.."）"
Inst25Quest7_Note = "此系列任务始于《尖啸者的灵魂》（同样在此领取，见"..NORMAL.."[祖儿法拉克]"..WHITE.."）。\n你必须在"..NORMAL.."[3]"..WHITE.."使用哈卡之卵，触发事件。一旦事件开始，敌人会像潮水般涌出来攻击你。其中一些敌人掉落哈卡莱之血。用这些血液熄灭包含哈卡灵魂能量的不灭火焰。当你熄灭所有的火焰时，哈卡的化身就可以进入我们的世界了。"
Inst25Quest7_Prequest = "有，尖啸者的灵魂 -> 远古之卵"
Inst25Quest7_Folgequest = "无"
--
Inst25Quest7name1 = "Rainstrider Leggings"
Inst25Quest7name2 = "Helm of Exile"

--QUEST 8 Alliance
Inst25Quest8 = "预言者迦玛兰"
Inst25Quest8_Attain = "-"
Inst25Quest8_Level = "55"
Inst25Quest8_Aim = "辛特兰的阿塔莱流放者要你给他带回迦玛兰的头。"
Inst25Quest8_Location = "阿塔莱流放者（辛特兰; "..NORMAL.."[33 / 75]"..WHITE.."）"
Inst25Quest8_Note = "你可以在"..NORMAL.."[4]"..WHITE.."找到迦玛兰。"
Inst25Quest8_Prequest = "无"
Inst25Quest8_Folgequest = "伊兰尼库斯精华"
--
Inst25Quest8name1 = "Chained Essence of Eranikus"


--QUEST 1 Horde

Inst25Quest1_HORDE = "阿塔哈卡神庙"
Inst25Quest1_HORDE_Attain = "38"
Inst25Quest1_HORDE_Level = "50"
Inst25Quest1_HORDE_Aim = "收集20个哈卡神像，把它们带给斯通纳德的费泽鲁尔。"
Inst25Quest1_HORDE_Location = "费泽鲁尔（悲伤沼泽 - 斯通纳德; "..NORMAL.."[47 / 54]"..WHITE.."）"
Inst25Quest1_HORDE_Note = "神庙里的所有敌人都掉落哈卡神像。"
Inst25Quest1_HORDE_Prequest = "有，泪水之池 -> 向费泽鲁尔复命"
Inst25Quest1_HORDE_Folgequest = "无"
Inst25Quest1PreQuest_HORDE = "true"
--
Inst25Quest1name1_HORDE = "Guardian Talisman"

--QUEST 2 Horde

Inst25Quest2_HORDE = "2. 沉没的神庙"
Inst25Quest2_HORDE_Attain = ""
Inst25Quest2_HORDE_Level = "51"
Inst25Quest2_HORDE_Aim = "在塔纳利斯找到玛尔冯·瑞文斯克。"
Inst25Quest2_HORDE_Location = "巫医尤克里（菲拉斯; "..YELLOW.."74,43"..WHITE..")"
Inst25Quest2_HORDE_Note = "你可以在 52,45 找到玛尔冯·瑞文斯克。"
Inst25Quest2_HORDE_Prequest = "无"
Inst25Quest2_HORDE_Folgequest = "有，石环"

--QUEST 3 Horde

Inst25Quest3_HORDE = "3. 深入神庙"
Inst25Quest3_HORDE_Attain = "-"
Inst25Quest3_HORDE_Level = "51"
Inst25Quest3_HORDE_Aim = "在悲伤沼泽的沉没的神庙中找到哈卡祭坛。"
Inst25Quest3_HORDE_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest3_HORDE_Note = "祭坛位于 [1]。"
Inst25Quest3_HORDE_Prequest = "有，石环"
Inst25Quest3_HORDE_Folgequest = "有，雕像群的秘密"
Inst25Quest3FQuest_HORDE = "true"

--QUEST 4 Horde

Inst25Quest4_HORDE = "4. 雕像群的秘密"
Inst25Quest4_HORDE_Attain = "-"
Inst25Quest4_HORDE_Level = "51"
Inst25Quest4_HORDE_Aim = "进入沉没的神庙，找出隐藏在雕像环中的秘密。"
Inst25Quest4_HORDE_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..YELLOW.."52,45"..WHITE..")"
Inst25Quest4_HORDE_Note = "雕像位于 [1]，按 1-6 的顺序启动它们。"
Inst25Quest4_HORDE_Prequest = "有，深入神庙"
Inst25Quest4_HORDE_Folgequest = "无"
Inst25Quest4FQuest_HORDE = "true"
--
Inst25Quest4name1_HORDE = "Hakkari Urn"

--QUEST 5 Horde

Inst25Quest5_HORDE = "雕像群的秘密"
Inst25Quest5_HORDE_Attain = "50"
Inst25Quest5_HORDE_Level = "52"
Inst25Quest5_HORDE_Aim = "到沉没的神庙去，揭开雕像群中隐藏的秘密。"
Inst25Quest5_HORDE_Location = "玛尔冯·瑞文斯克（塔纳利斯; "..NORMAL.."[52 / 45]"..WHITE.."）"
Inst25Quest5_HORDE_Note = "雕像群就在图中"..NORMAL.."[1]"..WHITE.."所示位置，按照地图指示的顺序打开他们。"
Inst25Quest5_HORDE_Prequest = "有，深入神庙"
Inst25Quest5_HORDE_Folgequest = "无"
Inst25Quest5PreQuest_HORDE = "true"

--QUEST 6 Horde

Inst25Quest6_HORDE = "除草器的燃料"
Inst25Quest6_HORDE_Attain = "43"
Inst25Quest6_HORDE_Level = "53"
Inst25Quest6_HORDE_Aim = "收集5份阿塔莱之雾的样本，然后将它们送到马绍尔营地的拉瑞安那里。"
Inst25Quest6_HORDE_Location = "莉芙·雷兹菲克斯（贫瘠之地; "..NORMAL.."[62 / 38]"..WHITE.."）"
Inst25Quest6_HORDE_Note = "前导任务《拉瑞安和穆尔金》开始于拉瑞安（安戈洛环形山; "..NORMAL.."[45 / 8]"..WHITE.."）。沉没的神庙里的神庙深渊潜伏者、黑暗虫和软泥怪身上都有阿塔莱之雾。"
Inst25Quest6_HORDE_Prequest = "有，拉瑞安和穆尔金 > 玛尔冯的车间"
Inst25Quest6_HORDE_Folgequest = "无"
Inst25Quest6PreQuest_HORDE = "true"
--
Inst25Quest6name1_HORDE = "Avenguard Helm"
Inst25Quest6name2_HORDE = "Lifeforce Dirk"
Inst25Quest6name3_HORDE = "Gemburst Circlet"

--QUEST 7 Horde

Inst25Quest7_HORDE = "神灵哈卡（系列任务）"
Inst25Quest7_HORDE_Attain = "43"
Inst25Quest7_HORDE_Level = "53"
Inst25Quest7_HORDE_Aim = "将装满的哈卡之卵交给塔纳利斯的叶基亚。"
Inst25Quest7_HORDE_Location = "叶基亚（塔纳利斯 - 热砂港; "..NORMAL.."[66 / 22]"..WHITE.."）"
Inst25Quest7_HORDE_Note = "此系列任务始于《尖啸者的灵魂》（同样在此领取，见"..NORMAL.."[祖儿法拉克]"..WHITE.."）。\n你必须在"..NORMAL.."[3]"..WHITE.."使用哈卡之卵，触发事件。一旦事件开始，敌人会像潮水般涌出来攻击你。其中一些敌人掉落哈卡莱之血。用这些血液熄灭包含哈卡灵魂能量的不灭火焰。当你熄灭所有的火焰时，哈卡的化身就可以进入我们的世界了。"
Inst25Quest7_HORDE_Prequest = "有，尖啸者的灵魂 -> 远古之卵"
Inst25Quest7_HORDE_Folgequest = "无"
--
Inst25Quest7name1_HORDE = "Rainstrider Leggings"
Inst25Quest7name2_HORDE = "Helm of Exile"

--QUEST 8 Horde

Inst25Quest8_HORDE = "预言者迦玛兰"
Inst25Quest8_HORDE_Attain = "-"
Inst25Quest8_HORDE_Level = "55"
Inst25Quest8_HORDE_Aim = "辛特兰的阿塔莱流放者要你给他带回迦玛兰的头。"
Inst25Quest8_HORDE_Location = "阿塔莱流放者（辛特兰; "..NORMAL.."[33 / 75]"..WHITE.."）"
Inst25Quest8_HORDE_Note = "你可以在"..NORMAL.."[4]"..WHITE.."找到迦玛兰。"
Inst25Quest8_HORDE_Prequest = "无"
Inst25Quest8_HORDE_Folgequest = "伊兰尼库斯精华"
--
Inst25Quest8name1_HORDE = "Chained Essence of Eranikus"

--------------Burg Shadowfang/Inst21/BSF ------------
Inst21Story = "在第三次大战中，奇灵托的法师和亡灵天灾进行了殊死的战斗。当达拉然的法师最终在战斗中战死之后，他们的意志转移到了复苏的亡灵天灾身上，然后重生了。由于对于缓慢的进展感到失望（并且对他的手下的建议不予理会）大法师阿鲁高选择召唤异次沅空间的生物来壮大达拉然日渐消失的力量。阿鲁高的召唤将贪婪的狼人带到了艾泽拉斯大陆。这些狂暴的狼型生物不仅屠杀了亡灵天灾的人，而且迅速将目标转向那些法师。那些狼人开始围攻席瓦莱恩男爵的城堡。这座位于焚木村的城堡不久之后变成了黑暗势力的聚集地并从此荒废。因为对于自己罪过的愧疚，阿鲁高将那些狼人当作自己的孩子并隐居在“影牙城堡”中。据说他还住在那里，被他巨大的宠物芬鲁斯所保护着，另外，在城堡中还徘徊着瓦莱恩男爵的那些复仇的幽灵。"
Inst21Caption = "影牙城堡"
Inst21QAA = "2 个任务"
Inst21QAH = "4 个任务"

--Quest 1 allianz

Inst21Quest1 = "正义试炼（圣骑士任务）"
Inst21Quest1_Level = "22"
Inst21Quest1_Attain = "20"
Inst21Quest1_Aim = "按照乔丹的武器材料单上的说明去寻找一些白石橡木、精炼矿石、乔丹的铁锤和一块科尔宝石，然后回到铁炉堡去见乔丹·斯迪威尔。"
Inst21Quest1_Location = "乔丹·斯迪威尔（丹莫罗 - 铁炉堡 "..NORMAL.."[52 / 36] "..WHITE.."）"
Inst21Quest1_Note = "点击"..NORMAL.."[乔丹的武器材料单]"..WHITE.."查看乔丹的武器材料单。"
Inst21Quest1_Prequest = "有，勇气之书 -> 正义试炼"
Inst21Quest1_Folgequest = "有，正义试炼"
Inst21Quest1PreQuest = "true"
--
Inst21Quest1name1 = "Verigan's Fist"

Inst21Quest2 = "正义试炼说明"
Inst21Quest2TEXT = "只有圣骑士们才能接到这个任务！\n\n1. 你可以从"..NORMAL.."[死亡矿井]"..WHITE.."地精木匠"..NORMAL.."[3]"..WHITE.."那儿得到白石橡木。\n\n2. 要得到精炼矿石，你必须先与白洛尔·石手交谈（洛克莫丹 - 塞尔萨玛; "..NORMAL.."[35 / 44]"..WHITE.."）。他会给你《白洛尔的矿石》任务。 你在一棵树后面找到乔丹的矿石"..NORMAL.."[71 / 21]"..WHITE.."。\n\n3. 你可以在"..NORMAL.."[影牙城堡]"..WHITE.."紧靠"..NORMAL.."[3]"..WHITE.."的地方找到乔丹的铁锤（安全地点）。\n\n4. 要得到科尔宝石，你必须去找桑迪斯·织风（黑海岸 - 奥伯丁; "..NORMAL.."[37 / 40]"..WHITE.."）并且做完《寻找科尔宝石》任务。为了完成这个任务，你必须杀掉"..NORMAL.."[黑暗深渊]"..WHITE.."前的黑暗深渊智者或者黑暗深渊海潮祭司。他们会掉落被污染的科尔宝石。桑迪斯·织风会为你清洁它的。"
Inst21Quest2_Level = "100"
Inst21Quest2_Attain = ""
Inst21Quest2_Aim = ""
Inst21Quest2_Location = ""
Inst21Quest2_Note = ""
Inst21Quest2_Prequest = ""
Inst21Quest2_Folgequest = ""
Inst21Quest2FQuest = "true"

--QUEST 2 Alliance (hexenmeister)

Inst21Quest3 = "索兰鲁克宝珠（术士任务）"
Inst21Quest3_Attain = "21"
Inst21Quest3_Level = "26"
Inst21Quest3_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst21Quest3_Location = "杜安·卡汉（贫瘠之地; "..NORMAL.."[49 / 57]"..WHITE.."）"
Inst21Quest3_Note = "只有术士才能得到这个任务！3块索兰鲁克宝珠的碎片，你可以从"..NORMAL.."[黑暗深渊]"..WHITE.."的暮光侍僧那里得到。那块索兰鲁克宝珠的大碎片，你要去"..NORMAL.."[影牙城堡]"..WHITE.."找影牙魔魂狼人。"
Inst21Quest3_Prequest = "无"
Inst21Quest3_Folgequest = "无"
--
Inst21Quest3name1 = "Orb of Soran'ruk"
Inst21Quest3name2 = "Staff of Soran'ruk"

--QUEST 1 Horde

Inst21Quest1_HORDE = "影牙城堡里的亡灵哨兵"
Inst21Quest1_HORDE_Attain = "-"
Inst21Quest1_HORDE_Level = "25"
Inst21Quest1_HORDE_Aim = "找到亡灵哨兵阿达曼特和亡灵哨兵文森特。"
Inst21Quest1_HORDE_Location = "高级执行官哈德瑞克（银松森林 - 瑟伯切尔; "..NORMAL.."[43 / 40]"..WHITE.."）"
Inst21Quest1_HORDE_Note = "阿达曼特位于"..NORMAL.."[1]"..WHITE.."，文森特在你一进庭院的右侧"..NORMAL.."[2]"..WHITE.."。"
Inst21Quest1_HORDE_Prequest = "无"
Inst21Quest1_HORDE_Folgequest = "无"
--
Inst21Quest1name1_HORDE = "Ghostly Mantle"

--QUEST 2 Horde

Inst21Quest2_HORDE = "乌尔之书"
Inst21Quest2_HORDE_Attain = "16"
Inst21Quest2_HORDE_Level = "26"
Inst21Quest2_HORDE_Aim = "把乌尔之书带给幽暗城炼金区里的看守者贝尔杜加。"
Inst21Quest2_HORDE_Location = "看守者贝尔杜加（幽暗城 - 炼金房; "..NORMAL.."[53 / 54]"..WHITE.."）"
Inst21Quest2_HORDE_Note = "你可以找到书在进门的左边"..NORMAL.."[8]"..WHITE..")。"
Inst21Quest2_HORDE_Prequest = "无"
Inst21Quest2_HORDE_Folgequest = "无"
--
Inst21Quest2name1_HORDE = "Grizzled Boots"
Inst21Quest2name2_HORDE = "Steel-clasped Bracers"

--QUEST 3 Horde

Inst21Quest3_HORDE = "除掉阿鲁高"
Inst21Quest3_HORDE_Attain = "?"
Inst21Quest3_HORDE_Level = "27"
Inst21Quest3_HORDE_Aim = "杀死阿鲁高，把他的头带给瑟伯切尔的达拉尔·道恩维沃尔。"
Inst21Quest3_HORDE_Location = "达拉尔·道恩维沃尔（银松森林 - 瑟伯切尔; "..NORMAL.."[44 / 39]"..WHITE.."）"
Inst21Quest3_HORDE_Note = "你可以在"..NORMAL.."[10]"..WHITE.."找到阿鲁高。"
Inst21Quest3_HORDE_Prequest = "无"
Inst21Quest3_HORDE_Folgequest = "无"
--
Inst21Quest3name1_HORDE = "Seal of Sylvanas"

--QUEST 4 Horde (hexenmeister)

Inst21Quest4_HORDE = "索兰鲁克宝珠（术士任务）"
Inst21Quest4_HORDE_Attain = "21"
Inst21Quest4_HORDE_Level = "26"
Inst21Quest4_HORDE_Aim = "找到3块索兰鲁克宝珠的碎片和1块索兰鲁克宝珠的大碎片，把它们交给贫瘠之地的杜安·卡汉。"
Inst21Quest4_HORDE_Location = "杜安·卡汉（贫瘠之地; "..NORMAL.."[49 / 57]"..WHITE.."）"
Inst21Quest4_HORDE_Note = "只有术士才能得到这个任务！3块索兰鲁克宝珠的碎片，你可以从"..NORMAL.."[黑暗深渊]"..WHITE.."的暮光侍僧那里得到。那块索兰鲁克宝珠的大碎片，你要去"..NORMAL.."[影牙城堡]"..WHITE.."找影牙魔魂狼人。"
Inst21Quest4_HORDE_Prequest = "无"
Inst21Quest4_HORDE_Folgequest = "无"
--
Inst21Quest4name1_HORDE = "Orb of Soran'ruk"
Inst21Quest4name2_HORDE = "Staff of Soran'ruk"

--------------Inst5/Blackrocktiefen/BRD ------------
Inst5Story = "黑石深渊曾经是黑铁矮人的伟大都城，这个火山中的迷宫现在成为拉格纳罗斯火焰领主的王座所在地。拉格纳罗斯找到了使用石头和设计图来创造一支无敌石头人均对来帮助它征服黑石深渊。即使是需要打败奈法利安和他的龙子龙孙，拉格纳罗斯会不惜一切代价来达到最后的胜利。"
Inst5Caption = "黑石深渊"
Inst5QAA = "14 个任务"
Inst5QAH = "14 个任务"

--QUEST1 Allianz

Inst5Quest1 = "黑铁的遗产"
Inst5Quest1_Attain = "48"
Inst5Quest1_Level = "52"
Inst5Quest1_Aim = "杀掉弗诺斯·达克维尔并拿回战锤铁胆。把铁胆之锤拿到索瑞森神殿去，将其放在弗兰克罗恩·铸铁的雕像上。"
Inst5Quest1_Location = "弗兰克罗恩·铸铁（黑石山; "..NORMAL.."副本入口地图[3]"..WHITE.."）"
Inst5Quest1_Note = "弗兰克罗恩在黑石的中心，在他的墓上方。你必须死亡后才能见到他！和他交谈2次，激活任务。\n弗诺斯·达克维尔在"..NORMAL.."[9]"..WHITE.."区。你会在"..NORMAL.."[7]"..WHITE.."区找到神殿。"
Inst5Quest1_Prequest = "Dark Iron Legacy"
Inst5Quest1_Folgequest = "无"
--
Inst5Quest1name1 = "Shadowforge Key"

--QUEST2 Allianz

Inst5Quest2 = "雷布里·斯库比格特"
Inst5Quest2_Attain = "50"
Inst5Quest2_Level = "53"
Inst5Quest2_Aim = "把雷布里的头颅交给燃烧平原的尤卡·斯库比格特。"
Inst5Quest2_Location = "尤卡·斯库比格特（燃烧平原 - 烈焰峰; "..NORMAL.."[65 / 22]"..WHITE.."）"
Inst5Quest2_Note = "可以直接接到任务，也可以接到前导任务从尤卡·斯库比格特（塔纳利斯 - 热砂港; "..NORMAL.."[67 / 23]"..WHITE.."）那儿得到。\n雷布里位于"..NORMAL.."[15]"..WHITE.."。"
Inst5Quest2_Prequest = "有，尤卡·斯库比格特"
Inst5Quest2_Folgequest = "无"
Inst5Quest2PreQuest = "true"
--
Inst5Quest2name1 = "Rancor Boots"
Inst5Quest2name2 = "Penance Spaulders"
Inst5Quest2name3 = "Splintsteel Armor"

--QUEST3 Allianz

Inst5Quest3 = "爱情药水"
Inst5Quest3_Attain = "50"
Inst5Quest3_Level = "54"
Inst5Quest3_Aim = "将4份格罗姆之血、10块巨型银矿和装满水的娜玛拉之瓶交给黑石深渊的娜玛拉小姐。"
Inst5Quest3_Location = "娜玛拉小姐（黑石深渊; "..NORMAL.."[15]"..WHITE.."）"
Inst5Quest3_Note = "巨型银矿可从艾萨拉的巨人们那里得到。格罗姆之血可以请学习了草药学的玩家帮助寻找。 你可以在（安戈洛环形山 - 葛拉卡温泉; "..NORMAL.."[31 / 50]"..WHITE.."）为瓶子装满水。\n完成任务后，你可以使用后门而不必杀死法拉克斯。"
Inst5Quest3_Prequest = "无"
Inst5Quest3_Folgequest = "无"
--
Inst5Quest3name1 = "Manacle Cuffs"
Inst5Quest3name2 = "Nagmara's Whipping Belt"

--QUEST4 Allianz

Inst5Quest4 = "霍尔雷·黑须"
Inst5Quest4_Attain = "?"
Inst5Quest4_Level = "55"
Inst5Quest4_Aim = "把遗失的雷酒秘方带给卡拉诺斯的拉格纳·雷酒。"
Inst5Quest4_Location = "拉格纳·雷酒（丹莫罗 - 卡拉诺斯; "..NORMAL.."[46 / 52]"..WHITE.."）"
Inst5Quest4_Note = "前导任务从 恩诺哈尔·雷酒（诅咒之地 - 守望堡; "..NORMAL.."[61 / 18]"..WHITE.."）处获得。\n如果你在"..NORMAL.."[15]"..WHITE.."区摧毁装有雷霆啤酒的桶，守卫就会出现。秘方就在这其中一个守卫身上。"
Inst5Quest4_Prequest = "有，拉格纳·雷酒"
Inst5Quest4_Folgequest = "无"
Inst5Quest4PreQuest = "true"
--
Inst5Quest4name1 = "Dark Dwarven Lager"
Inst5Quest4name2 = "Swiftstrike Cudgel"
Inst5Quest4name3 = "Limb Cleaver"


--QUEST5 Allianz

Inst5Quest5 = "征服者派隆"
Inst5Quest5_Attain = "?"
Inst5Quest5_Level = "56"
Inst5Quest5_Aim = "杀掉征服者派隆，然后向加琳达复命。"
Inst5Quest5_Location = "加琳达（燃烧平原 - 摩根的岗哨; "..NORMAL.."[85 / 69]"..WHITE.."）"
Inst5Quest5_Note = "征服者派隆是副本门口外面的一个火元素精英。在黑石深渊地图的"..NORMAL.."[24]"..WHITE.."，黑石深渊副本入口地图的"..NORMAL.."[1]"..WHITE.."。"
Inst5Quest5_Prequest = "Overmaster Pyron"
Inst5Quest5_Folgequest = "有，伊森迪奥斯"
Inst5Quest5PreQuest = "true"
--
Inst5Quest5name1 = "Sunborne Cape"
Inst5Quest5name2 = "Nightfall Gloves"
Inst5Quest5name3 = "Crypt Demon Bracers"
Inst5Quest5name4 = "Stalwart Clutch"

--QUEST6 Horde

Inst5Quest6 = "伊森迪奥斯！"
Inst5Quest6_Attain = "50"
Inst5Quest6_Level = "55"
Inst5Quest6_Aim = "在黑石深渊里找到伊森迪奥斯，然后把他干掉！"
Inst5Quest6_Location = "加琳达（燃烧平原 - 摩根的岗哨; "..NORMAL.."[85 / 69]"..WHITE.."）"
Inst5Quest6_Note = "伊森迪奥斯在"..NORMAL.."[10]"..WHITE.."。"
Inst5Quest6_Prequest = "有，征服者派隆"
Inst5Quest6_Folgequest = "无"

--QUEST6 Allianz

Inst5Quest7 = "山脉之心"
Inst5Quest7_Attain = "?"
Inst5Quest7_Level = "56"
Inst5Quest7_Aim = "把山脉之心交给燃烧平原的麦克斯沃特·尤博格林。"
Inst5Quest7_Location = "麦克斯沃特·尤博格林（燃烧平原 - 烈焰峰; "..NORMAL.."[65 / 23]"..WHITE.."）"
Inst5Quest7_Note = "你可以从"..NORMAL.."[8]"..WHITE.."的宝箱里找到山脉之心。你必须打开黑色宝库所有的小宝箱出来 Boss 之后才能拿到钥匙。"
Inst5Quest7_Prequest = "无"
Inst5Quest7_Folgequest = "无"
--
Inst5Quest7name1 = "A Dingy Fanny Pack"

--QUEST7 Allianz

Inst5Quest8 = "好东西"
Inst5Quest8_Attain = "48"
Inst5Quest8_Level = "54"
Inst5Quest8_Aim = "到黑石深渊去找到20个黑铁挎包。当你完成任务之后，回到奥拉留斯那里复命。你认为黑石深渊里的黑铁矮人应该会有这些黑铁挎包。"
Inst5Quest8_Location = "奥拉留斯（燃烧平原 - 摩根的岗哨; "..NORMAL.."[84 / 68]"..WHITE.."）"
Inst5Quest8_Note = "所有矮人都可能掉落挎包。"
Inst5Quest8_Prequest = "Dragonkin Menace -> The True Masters"
Inst5Quest8_Folgequest = "失落的希望"
Inst5Quest8PreQuest = "true"
--
Inst5Quest8name1 = "Conservator Helm"
Inst5Quest8name2 = "Shieldplate Sabatons"
Inst5Quest8name3 = "Windshear Leggings"

--QUEST8 Allianz

Inst5Quest9 = "温德索尔元帅（奥妮克希亚系列任务）"
Inst5Quest9_Attain = "51"
Inst5Quest9_Level = "54"
Inst5Quest9_Aim = "到西北部的黑石山脉去，在黑石深渊中找到温德索尔元帅的下落。\n狼狈不堪的约翰曾告诉你说温德索尔被关进了一个监狱。"
Inst5Quest9_Location = "麦克斯韦尔元帅（燃烧平原 - 摩根的岗哨; "..NORMAL.."[84 / 68]"..WHITE.."）"
Inst5Quest9_Note = "此系列任务始于赫林迪斯·河角（燃烧平原 - 摩根的岗哨"..NORMAL.."[85 / 68]"..WHITE.."）。\n温德索尔元帅在"..NORMAL.."[4]"..WHITE.."。完成这个任务后，你要回到麦克斯韦尔元帅那里."
Inst5Quest9_Prequest = "有，黑龙的威胁 -> 真正的主人"
Inst5Quest9_Folgequest = "有，被遗弃的希望 -> 弄皱的便笺"
Inst5Quest9FQuest = "true"

--QUEST9 Allianz

Inst5Quest10 = "弄皱的便笺（奥妮克希亚系列任务）"
Inst5Quest10_Attain = "51"
Inst5Quest10_Level = "58"
Inst5Quest10_Aim = "温德索尔元帅也许会对你手中的东西感兴趣。毕竟，希望还没有被完全扼杀。"
Inst5Quest10_Location = "弄皱的便笺（掉落）（黑石深渊）"
Inst5Quest10_Note = "这个任务是弄皱的便笺触发的。温德索尔元帅在"..NORMAL.."[4]"..WHITE.."。副本里和外的所有黑铁矮人都有很大几率掉落便笺。"
Inst5Quest10_Prequest = "有，温德索尔元帅"
Inst5Quest10_Folgequest = "有，一丝希望"
Inst5Quest10FQuest = "true"

--QUEST10 Allianz

Inst5Quest11 = "一丝希望（奥妮克希亚系列任务）"
Inst5Quest11_Attain = "54"
Inst5Quest11_Level = "58"
Inst5Quest11_Aim = "找回温德索尔元帅遗失的情报。\n温德索尔元帅确信那些情报在安格弗将军和傀儡统帅阿格曼奇的手里。"
Inst5Quest11_Location = "温德索尔元帅（黑石深渊; "..NORMAL.."[4]"..WHITE.."）"
Inst5Quest11_Note = "温德索尔元帅在"..NORMAL.."[4]"..WHITE.."。\n傀儡统帅阿格曼奇在"..NORMAL.."[14]"..WHITE.."，安格弗将军在"..NORMAL.."[13]"..WHITE.."。"
Inst5Quest11_Prequest = "有，弄皱的便笺"
Inst5Quest11_Folgequest = "有，冲破牢笼！"
Inst5Quest11FQuest = "true"
--
Inst5Quest11name1 = "Ward of the Elements"
Inst5Quest11name2 = "Blade of Reckoning"
Inst5Quest11name3 = "Skilled Fighting Blade"

--QUEST12 Allianz

Inst5Quest12 = "冲破牢笼！（奥妮克希亚系列任务）"
Inst5Quest12_Attain = "52"
Inst5Quest12_Level = "58"
Inst5Quest12_Aim = "帮助温德索尔元帅拿回他的装备并救出他的朋友。当你成功之后就回去向麦克斯韦尔元帅复命。"
Inst5Quest12_Location = "温德索尔元帅（黑石深渊; "..NORMAL.."[4]"..WHITE.."）"
Inst5Quest12_Note = "温德索尔元帅在"..NORMAL.."[4]"..WHITE.."。\n如果你清掉法律之环一圈的怪（"..NORMAL.."[6]"..WHITE.."）和通向副本门口的怪的话会轻松很多。护送完成后去找麦克斯韦尔元帅（燃烧平原 - 摩根的岗哨; "..NORMAL.."[84 / 68]"..WHITE.."）。"
Inst5Quest12_Prequest = "有，一丝希望"
Inst5Quest12_Folgequest = "有，集合在暴风城"
Inst5Quest12PreQuest = "true"
--
Inst5Quest12name1 = "Shaleskin Cape"
Inst5Quest12name2 = "Wyrmhide Spaulders"
Inst5Quest12name3 = "Valconian Sash"

--QUEST13 Allianz

Inst5Quest13 = "烈焰精华"
Inst5Quest13_Attain = "?"
Inst5Quest13_Level = "59"
Inst5Quest13_Aim = "到黑石深渊去杀掉贝尔加。\n你只知道这个巨型怪物住在黑石深渊的最深处。记住你要使用特殊的黑龙皮从贝尔加的尸体上采集烈焰精华。\n将你采集到的烈焰精华交给塞勒斯·萨雷芬图斯。"
Inst5Quest13_Location = "塞勒斯·萨雷芬图斯（燃烧平原; "..NORMAL.."[94 / 31]"..WHITE.."）"
Inst5Quest13_Note = "此系列任务始于卡拉然·温布雷（灼热峡谷; "..NORMAL.."[39 / 38]"..WHITE.."）。\n 贝尔加在"..NORMAL.."[11]"..WHITE.."。"
Inst5Quest13_Prequest = "有，无瑕之焰 -> 烈焰精华"
Inst5Quest13_Folgequest = "卡兰的故事"
Inst5Quest13PreQuest = "true"

--QUEST14 Allianz

Inst5Quest14 = "卡兰·巨锤"
Inst5Quest14_Attain = "?"
Inst5Quest14_Level = "59"
Inst5Quest14_Aim = " 去黑石深渊找到卡兰·巨锤。\n国王提到卡兰在那里负责看守囚犯——也许你应该在监狱附近寻找他。"
Inst5Quest14_Location = "国王麦格尼·铜须（铁炉堡; "..NORMAL.."[39 / 55]"..WHITE.."）"
Inst5Quest14_Note = "前导任务始于皇家历史学家阿克瑟努斯（铁炉堡; "..NORMAL.."[38 / 55]"..WHITE.."）。卡兰·巨锤位于"..NORMAL.."[2]"..WHITE.."。"
Inst5Quest14_Prequest = "有，索瑞森废墟"
Inst5Quest14_Folgequest = "有，卡兰的故事 - > 糟糕的消息 - > 王国的命运 - > 语出惊人的公主"
Inst5Quest14FQuest = "true"
--
Inst5Quest14name1 = "Magni's Will"
Inst5Quest14name2 = "Songstone of Ironforge"

--QUEST1 Horde

Inst5Quest1_HORDE = "黑铁的遗产"
Inst5Quest1_HORDE_Attain = "48"
Inst5Quest1_HORDE_Level = "52"
Inst5Quest1_HORDE_Aim = "杀掉弗诺斯·达克维尔并拿回战锤铁胆。把铁胆之锤拿到索瑞森神殿去，将其放在弗兰克罗恩·铸铁的雕像上。"
Inst5Quest1_HORDE_Location = "弗兰克罗恩·铸铁（黑石山; "..NORMAL.."副本入口地图[3]"..WHITE.."）"
Inst5Quest1_HORDE_Note = "弗兰克罗恩在黑石的中心，在他的墓上方。你必须死亡后才能见到他！和他交谈2次，激活任务。\n弗诺斯·达克维尔在"..NORMAL.."[9]"..WHITE.."区。你会在"..NORMAL.."[7]"..WHITE.."区找到神殿。"
Inst5Quest1_HORDE_Prequest = "Dark Iron Legacy"
Inst5Quest1_HORDE_Folgequest = "无"
--
Inst5Quest1name1_HORDE = "Shadowforge Key"

--QUEST2 Horde

Inst5Quest2_HORDE = "雷布里·斯库比格特"
Inst5Quest2_HORDE_Attain = "50"
Inst5Quest2_HORDE_Level = "53"
Inst5Quest2_HORDE_Aim = "把雷布里的头颅交给燃烧平原的尤卡·斯库比格特。"
Inst5Quest2_HORDE_Location = "尤卡·斯库比格特（燃烧平原 - 烈焰峰; "..NORMAL.."[65 / 22]"..WHITE.."）"
Inst5Quest2_HORDE_Note = "可以直接接到任务，也可以接到前导任务从尤卡·斯库比格特（塔纳利斯 - 热砂港; "..NORMAL.."[67 / 23]"..WHITE.."）那儿得到。\n雷布里位于"..NORMAL.."[15]"..WHITE.."。"
Inst5Quest2_HORDE_Prequest = "有，尤卡·斯库比格特"
Inst5Quest2_HORDE_Folgequest = "无"
Inst5Quest2PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Rancor Boots"
Inst5Quest11name2_HORDE = "Penance Spaulders"
Inst5Quest11name3_HORDE = "Splintsteel Armor"

--QUEST3 Horde

Inst5Quest3_HORDE = "爱情药水"
Inst5Quest3_HORDE_Attain = "50"
Inst5Quest3_HORDE_Level = "54"
Inst5Quest3_HORDE_Aim = "将4份格罗姆之血、10块巨型银矿和装满水的娜玛拉之瓶交给黑石深渊的娜玛拉小姐。"
Inst5Quest3_HORDE_Location = "娜玛拉小姐（黑石深渊; "..NORMAL.."[15]"..WHITE.."）"
Inst5Quest3_HORDE_Note = "巨型银矿可从艾萨拉的巨人们那里得到。格罗姆之血可以请学习了草药学的玩家帮助寻找。 你可以在（安戈洛环形山 - 葛拉卡温泉; "..NORMAL.."[31 / 50]"..WHITE.."）为瓶子装满水。\n完成任务后，你可以使用后门而不必杀死法拉克斯。"
Inst5Quest3_HORDE_Prequest = "无"
Inst5Quest3_HORDE_Folgequest = "无"
--
Inst5Quest3name1_HORDE = "Manacle Cuffs"
Inst5Quest3name2_HORDE = "Nagmara's Whipping Belt"

--QUEST 4 Horde

Inst5Quest4_HORDE = "遗失的雷酒秘方"
Inst5Quest4_HORDE_Attain = "50"
Inst5Quest4_HORDE_Level = "55"
Inst5Quest4_HORDE_Aim = "把遗失的雷酒秘方交给卡加斯的薇薇安·拉格雷。"
Inst5Quest4_HORDE_Location = "暗法师薇薇安·拉格雷（荒芜之地 - 卡加斯; "..NORMAL.."[2 / 47]"..WHITE.."）"
Inst5Quest4_HORDE_Note = "前导任务由药剂师金格（幽暗城 - 炼金房; "..NORMAL.."[50 / 68]"..WHITE.."）给予。\n秘方在某个守卫身上，只要你破坏"..NORMAL.."[15]"..WHITE.."的酒桶这些守卫就会出现。"
Inst5Quest4_HORDE_Prequest = "有，薇薇安·拉格雷"
Inst5Quest4_HORDE_Folgequest = "无"
Inst5Quest4PreQuest_HORDE = "true"
--
Inst5Quest4name1_HORDE = "Superior Healing Potion"
Inst5Quest4name2_HORDE = "Greater Mana Potion"
Inst5Quest4name3_HORDE = "Swiftstrike Cudgel"
Inst5Quest4name4_HORDE = "Limb Cleaver"

--QUEST5 Horde

Inst5Quest5_HORDE = "山脉之心"
Inst5Quest5_HORDE_Attain = "50"
Inst5Quest5_HORDE_Level = "55"
Inst5Quest5_HORDE_Aim = "在黑石深渊里找到伊森迪奥斯，然后把他干掉！"
Inst5Quest5_HORDE_Location = "加琳达（燃烧平原 - 摩根的岗哨; "..NORMAL.."[85 / 69]"..WHITE.."）"
Inst5Quest5_HORDE_Note = "伊森迪奥斯在"..NORMAL.."[10]"..WHITE.."。"
Inst5Quest5_HORDE_Prequest = "有，征服者派隆"
Inst5Quest5_HORDE_Folgequest = "无"

--QUEST 6 Horde

Inst5Quest6_HORDE = "格杀勿论：黑铁矮人"
Inst5Quest6_HORDE_Attain = "48"
Inst5Quest6_HORDE_Level = "52"
Inst5Quest6_HORDE_Aim = "到黑石深渊去消灭那些邪恶的侵略者！军官高图斯要你去杀死15个铁怒卫士、10个铁怒狱卒和5个铁怒步兵。完成任务之后回去向他复命。"
Inst5Quest6_HORDE_Location = "通缉（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 47]"..WHITE.."）"
Inst5Quest6_HORDE_Note = "矮人可在黑石深渊第一部分找到。\n卡加斯的高图斯在瞭望塔顶（荒芜之地; "..NORMAL.."[5 / 47]"..WHITE.."）。"
Inst5Quest6_HORDE_Prequest = "无"
Inst5Quest6_HORDE_Folgequest = "有，格杀勿论：高阶黑铁军官"

--QUEST 7 Horde

Inst5Quest7_HORDE = "格杀勿论：高阶黑铁军官"
Inst5Quest7_HORDE_Attain = "50"
Inst5Quest7_HORDE_Level = "54"
Inst5Quest7_HORDE_Aim = "到黑石深渊去消灭那些邪恶的侵略者！高图斯军阀要你杀死10个铁怒医师、10个铁怒士兵和10个铁怒军官。完成任务之后回去向他复命。"
Inst5Quest7_HORDE_Location = "通缉（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 47]"..WHITE.."）"
Inst5Quest7_HORDE_Note = "矮人可以在"..NORMAL.."[11]"..WHITE.."贝尔加附近被找到。卡加斯的高图斯在瞭望塔顶（荒芜之地; "..NORMAL.."[5 / 47]"..WHITE.."）。\n任务开始于雷克斯洛特（荒芜之地 - 卡加斯; "..NORMAL.."[5 / 47]"..WHITE.."）。 格拉克·洛克鲁布位置在燃烧平原（"..NORMAL.."[38 / 35]"..WHITE.."）。 要绑定他并开始护送任务（精英），他的生命需要减少到低于50%。"
Inst5Quest7_HORDE_Prequest = "有，格杀勿论：黑铁矮人"
Inst5Quest7_HORDE_Folgequest = "有，格拉克·洛克鲁布 -> 押送囚徒（护送任务）"
Inst5Quest7FQuest_HORDE = "true"

--QUEST 8 Horde

Inst5Quest8_HORDE = "行动：杀死安格弗将军"
Inst5Quest8_HORDE_Attain = "55"
Inst5Quest8_HORDE_Level = "58"
Inst5Quest8_HORDE_Aim = "到黑石深渊去杀掉安格弗将军！当任务完成之后向军官高图斯复命。"
Inst5Quest8_HORDE_Location = "军官高图斯（荒芜之地 - 卡加斯; "..NORMAL.."[5 / 47]"..WHITE.."）"
Inst5Quest8_HORDE_Note = "安格弗将军位置在"..NORMAL.."[13]"..WHITE.."。注意：当他生命低于30%时，他会召唤帮手！"
Inst5Quest8_HORDE_Prequest = "有，押送囚徒"
Inst5Quest8_HORDE_Folgequest = "无"
Inst5Quest8FQuest_HORDE = "true"
--
Inst5Quest8name1_HORDE = "Conqueror's Medallion"

--QUEST 5 Horde

Inst5Quest9_HORDE = "机器的崛起"
Inst5Quest9_HORDE_Attain = "?"
Inst5Quest9_HORDE_Level = "58"
Inst5Quest9_HORDE_Aim = "找到并杀掉傀儡统帅阿格曼奇，将他的头交给鲁特维尔。你还需要从守卫着阿格曼奇的狂怒傀儡和战斗傀儡身上收集10块完整的元素核心。"
Inst5Quest9_HORDE_Location = "鲁特维尔·沃拉图斯（荒芜之地; "..NORMAL.."[25 / 44]"..WHITE.."）"
Inst5Quest9_HORDE_Note = "前导任务来自圣者塞朵拉·穆瓦丹尼（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 47]"..WHITE.."）。\n你可以在"..NORMAL.."[14]"..WHITE.."发现阿格曼奇。"
Inst5Quest9_HORDE_Prequest = "有，机器的崛起"
Inst5Quest9_HORDE_Folgequest = "无"
Inst5Quest9PreQuest_HORDE = "true"
--
Inst5Quest9name1_HORDE = "Azure Moon Amice"
Inst5Quest9name2_HORDE = "Raincaster Drape"
Inst5Quest9name3_HORDE = "Basaltscale Armor"
Inst5Quest9name4_HORDE = "Lavaplate Gauntlets"


--QUEST13 Horde

Inst5Quest10_HORDE = "烈焰精华"
Inst5Quest10_HORDE_Attain = "52"
Inst5Quest10_HORDE_Level = "58"
Inst5Quest10_HORDE_Aim = "帮助温德索尔元帅拿回他的装备并救出他的朋友。当你成功之后就回去向麦克斯韦尔元帅复命。"
Inst5Quest10_HORDE_Location = "温德索尔元帅（黑石深渊; "..NORMAL.."[4]"..WHITE.."）"
Inst5Quest10_HORDE_Note = "温德索尔元帅在"..NORMAL.."[4]"..WHITE.."。\n如果你清掉法律之环一圈的怪（"..NORMAL.."[6]"..WHITE.."）和通向副本门口的怪的话会轻松很多。护送完成后去找麦克斯韦尔元帅（燃烧平原 - 摩根的岗哨; "..NORMAL.."[84 / 68]"..WHITE.."）。"
Inst5Quest10_HORDE_Prequest = "有，一丝希望"
Inst5Quest10_HORDE_Folgequest = "有，集合在暴风城"
Inst5Quest10PreQuest_HORDE = "true"
--
Inst5Quest10name1_HORDE = "Shaleskin Cape"
Inst5Quest10name2_HORDE = "Wyrmhide Spaulders"
Inst5Quest10name3_HORDE = "Valconian Sash"

--QUEST 11 Horde

Inst5Quest11_HORDE = "不和谐的烈焰"
Inst5Quest11_HORDE_Attain = "?"
Inst5Quest11_HORDE_Level = "56"
Inst5Quest11_HORDE_Aim = "到黑石山脉的采石场去干掉征服者派隆，然后向桑德哈特回报。"
Inst5Quest11_HORDE_Location = "桑德哈特（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 48]"..WHITE.."）"
Inst5Quest11_HORDE_Note = "征服者派隆是副本门口外面的一个火元素精英。在黑石深渊"..NORMAL.."副本入口地图[1]"..WHITE.."。"
Inst5Quest11_HORDE_Prequest = "Disharmony of Flame"
Inst5Quest11_HORDE_Folgequest = "有，不和谐的火焰"
Inst5Quest11PreQuest_HORDE = "true"
--
Inst5Quest11name1_HORDE = "Sunborne Cape"
Inst5Quest11name2_HORDE = "Nightfall Gloves"
Inst5Quest11name3_HORDE = "Crypt Demon Bracers"
Inst5Quest11name4_HORDE = "Stalwart Clutch"

--QUEST 12 Horde

Inst5Quest12_HORDE = "不和谐的火焰"
Inst5Quest12_HORDE_Attain = "?"
Inst5Quest12_HORDE_Level = "54"
Inst5Quest12_HORDE_Aim = "进入黑石深渊并找到伊森迪奥斯。杀掉它，然后把你找到的信息汇报给桑德哈特。"
Inst5Quest12_HORDE_Location = "桑德哈特（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 48]"..WHITE.."）"
Inst5Quest12_HORDE_Note = "伊森迪奥斯在"..NORMAL.."[10]"..WHITE.."。"
Inst5Quest12_HORDE_Prequest = "有，不和谐的烈焰"
Inst5Quest12_HORDE_Folgequest = "无"
Inst5Quest12PreQuest_HORDE = "true"
--
Inst5Quest12name1_HORDE = "Lagrave's Seal"

--QUEST 8 Horde

Inst5Quest13_HORDE = "最后的元素"
Inst5Quest13_HORDE_Attain = "?"
Inst5Quest13_HORDE_Level = "52"
Inst5Quest13_HORDE_Aim = "到黑石深渊去取得10份元素精华。你应该在那些作战傀儡和傀儡制造者身上找找，另外，薇薇安·拉格雷也提到了一些有关元素生物的话题……"
Inst5Quest13_HORDE_Location = "暗法师薇薇安·拉格雷（荒芜之地 - 卡加斯; "..NORMAL.."[2 / 47]"..WHITE.."）"
Inst5Quest13_HORDE_Note = "前导任务来自桑德哈特（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 48]"..WHITE.."）。派隆就在副本入口处前。\n 每个元素生物都可能会掉落精华。"
Inst5Quest13_HORDE_Prequest = "有，不和谐的烈焰"
Inst5Quest13_HORDE_Folgequest = "发生了什么事？"
Inst5Quest13PreQuest_HORDE = "true"


--QUEST14 Horde

Inst5Quest14_HORDE = "指挥官哥沙克"
Inst5Quest14_HORDE_Attain = "51"
Inst5Quest14_HORDE_Level = "59"
Inst5Quest14_HORDE_Aim = "在黑石深渊里找到指挥官哥沙克。\n在那幅草图上画着的是一个铁栏后面的兽人，也许你应该到某个类似监狱的地方去找找看。"
Inst5Quest14_HORDE_Location = "神射手贾拉玛弗（荒芜之地 - 卡加斯; "..NORMAL.."[5 / 47]"..WHITE.."）"
Inst5Quest14_HORDE_Note = "前导任务来自桑德哈特（荒芜之地 - 卡加斯; "..NORMAL.."[3 / 48]"..WHITE.."）。派隆就在副本入口处前。\n你能在"..NORMAL.."[3]"..WHITE.."找到指挥官哥沙克。位于"..NORMAL.."[5]"..WHITE.."的审讯官格斯塔恩掉落打开监狱的钥匙。如果你跟他交谈并开始下一个任务，敌人便会出现。"
Inst5Quest14_HORDE_Prequest = "有，不和谐的烈焰"
Inst5Quest14_HORDE_Folgequest = "有，出了什么事？"
Inst5Quest14FQuest_HORDE = "true"
--
Inst5Quest14name1_HORDE = "Thrall's Resolve"
Inst5Quest14name2_HORDE = "Eye of Orgrimmar"



--------------Inst8 / lower blackrock spier ------------
Inst8Story = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全都占为己有。"
Inst8Caption = "黑石塔下层"

--------------Inst9 / lower blackrock spier ------------
Inst9Story = "黑石深渊深处的巨大堡垒是由矮人建筑大师弗兰克罗恩·铸铁所设计的。这个堡垒是矮人力量的象征并被邪恶的黑铁矮人占据了数个世纪。然而，奈法利安——死亡之翼狡猾的儿子——对这个巨大的堡垒别有意图。他和他的黑龙军团占据了上层黑石塔并向占据着黑石深渊的黑铁矮人宣战。奈法利安知道矮人是由强大的火元素拉格纳罗斯所领导的，所以他立志要摧毁他的敌人并将黑石深渊全都占为己有。"
Inst9Caption = "黑石塔上层"

--------------Dire Maul East/ Inst10------------
Inst10Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst10Caption = "厄运之槌（东）"

--------------Dire Maul North/ Inst11------------
Inst11Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst11Caption = "厄运之槌（北）"

--------------Dire Maul West/ Inst12------------
Inst12Story = "埃雷萨拉斯古城是在一万二千年前由当时的一批暗夜精灵法师秘密地建造的，它被用于保护艾莎拉皇后最宝贵的奥法秘密。虽然受到了世界大震动的影响，这座伟大的城市基本屹立在那里，现在其被称为厄运之槌。这座遗迹城市分为三个部分，分别被不同的生物所占据——包括幽灵般的高等精灵，邪恶的萨特和鲁莽的食人魔。只有最勇敢的冒险队伍才敢进入这个破碎的城市并面对远古大厅中邪恶力量。"
Inst12Caption = "厄运之槌（西）"

--------------Inst13/Maraudon------------
Inst13Story = "玛拉顿被狂暴的玛拉顿半人马所保护，那是凄凉之地最神圣的地方。玛拉顿是扎尔塔的伟大神庙，扎尔塔使半神塞纳留斯不朽的儿子之一。传说说扎尔塔和瑟莱德丝大地元素公主的私生子成为了半人马种族。据说半人马这个野蛮的种族在其出生了之后就开始转向他们的父亲并将其杀死。有些人则相信瑟莱德丝在悲伤中将扎尔塔的灵魂困了起来，并将其藏在洞中——利用它的能量来达到一些不可告人的目的。在玛拉顿错综复杂的地下通道中到处都是邪恶的半人马可汗灵魂和瑟莱德丝的元素爪牙。"
Inst13Caption = "玛拉顿"

--------------Inst22/Stratholme------------
Inst22Story = "斯坦索姆曾经是洛丹伦北部一颗璀璨的明珠，但是就是在这座城市阿尔萨斯王子背叛了他的导师乌瑟尔，并屠杀了数百个被认为感染了可怕瘟疫的臣民。阿尔萨斯不久之后就向巫妖王臣服。这个破碎的城市也被巫妖克尔苏拉德领导的亡灵天灾所占据。而一直由大十字军战士达索汉领导的血色十字军分遣队也占据了这个城市的一部分。这两方力量在城市中进行着激烈的战斗。而那些勇敢（亦或是愚蠢的）的冒险者在进入斯坦索姆之后将不得不面对两方的力量。据说整座城市由三座大型的通灵塔以及无数强大的亡灵巫师，女妖和憎恶所守卫着。据报告，邪恶的死亡骑士乘坐在一匹骷髅战马——他会将怒火倾泻在任何胆敢进入亡灵天灾领域的人。"
Inst22Caption = "斯坦索姆"

--------------Inst29/Gnomeregan------------
Inst29Story = "位于丹莫洛的科技奇迹城市诺莫瑞根世代以来都是侏儒的主城。最近，一群邪恶的变异食鄂怪侵入了包括侏儒主城在内的多处丹莫洛地区。为了做出殊死一搏来干掉入侵的食腭怪，大工匠梅卡托克命令打开城市中的紧急辐射水箱。侏儒在等待那些食腭怪死亡或者逃跑的同时也在寻找躲避辐射的方法。不幸的是，虽然食腭怪在经过辐射之后感染了毒性——但是它们的攻击没有停止，也没有丝毫的减弱。那些没有被辐射杀死的侏儒被迫逃离，他们在附近的矮人城市铁炉堡找到了安身之处。大工匠梅卡托克组建了一个智囊团来商议重新夺回他们挚爱的城市的计划。传说大工匠梅卡托克曾经最信任的顾问，麦克尼尔·瑟玛普拉格被判了他的人民并纵容了这次入侵的发生。现在，他的心智，麦克尼尔·瑟玛普拉格还留在诺莫瑞根中——他在继续筹划着自己黑暗的计划并成为这座城市新的科技领主。"
Inst29Caption = "诺莫瑞根"

------------------------------------------------------------------------------------------------------
------------------------------------------------- RAID -----------------------------------------------
------------------------------------------------------------------------------------------------------

--------------Inst30/Alptraumdrachen------------
Inst30Story = "那些远古巨树周围出现了异动。新的威胁正笼罩着灰谷、暮色森林、菲拉斯和辛特兰这些偏远之地。绿龙军团的四位伟大守护者自梦境中归来，但这些昔日高贵的守卫如今只追求毁灭与死亡。与你的同伴一起武装起来，奔赴这些隐秘的树林吧。只有你们才能守护艾泽拉斯，抵御他们带来的腐化。"
Inst30Caption = "梦魇之龙"
Inst30Caption1 = "伊瑟拉与绿龙军团"
Inst30Caption2 = "莱索恩"
Inst30Caption3 = "艾莫莉丝"
Inst30Caption4 = "泰拉尔"
Inst30Caption5 = "伊森德雷"

Inst30Story1 = "伟大的梦境守护者伊瑟拉统御着神秘的绿龙军团。她的领域是奇幻而玄妙的翡翠梦境，据说她正是从那里引导着整个世界的自然演化。她是自然与想象的守护者，而绿龙军团的职责，就是守护散布在世界各地、仅供德鲁伊进入梦境之用的伟大古树。近来，伊瑟拉最值得信赖的副官们却被翡翠梦境中的一股黑暗新力量所扭曲。如今，这些迷失的守卫者已经穿过古树进入艾泽拉斯，意图把疯狂与恐惧散播到凡人王国之中。即便是最强大的冒险者，也最好对这些巨龙保持敬畏，否则就只能承受它们被误导后的怒火。"
Inst30Story2 = "莱索恩在翡翠梦境中的畸变影响下，不仅令自己那强大龙鳞的色泽变得暗沉，还获得了从敌人体内抽取邪恶暗影的能力。一旦这些暗影与其主人融合，便会为巨龙灌注治疗性的能量。因此，莱索恩被视为伊瑟拉那些堕落副官中最为可怕的一位，也就丝毫不令人意外了。"
Inst30Story3 = "翡翠梦境中的神秘黑暗力量，把原本庄严华美的艾莫莉丝扭曲成了一头腐烂、染病的怪物。那些少数在与这头巨龙交锋后侥幸生还的人，带回了可怕的传闻：他们死去同伴的尸体上，会爆出腐臭的蘑菇。毫无疑问，艾莫莉丝是伊瑟拉那些离经叛道的绿龙之中最恶心、最令人惊骇的一头。"
Inst30Story4 = "在伊瑟拉那些失控的副官中，泰拉尔也许是受影响最深的一位。他与翡翠梦境中那股黑暗力量的接触，不仅粉碎了他的理智，也撕裂了他的实体形态。如今，这头巨龙以幽魂般的姿态存在，能够分裂成多个个体，而每一个分身都掌握着毁灭性的魔法力量。泰拉尔是一名狡诈而无情的敌人，他一心想要把自己存在中的疯狂，强加给艾泽拉斯的所有居民。"
Inst30Story5 = "伊森德雷曾是伊瑟拉最信任的副官之一，如今却已经堕落，在艾泽拉斯的大地上播撒恐惧与混乱。她曾经慈悲的治愈之力如今已化为黑暗魔法，使她能够施放炽烈的闪电波，并召唤邪恶德鲁伊前来助战。伊森德雷和她的同类还拥有诱导沉睡的能力，把不幸的凡人敌人拖入他们最可怕的噩梦之中。"

Inst30Quest1 = ""
Inst30Quest1_Attain = ""
Inst30Quest1_Level = "100"
Inst30Quest1_Aim = ""
Inst30Quest1_Location = ""
Inst30Quest1_Note = ""
Inst30Quest1_Prequest = ""
Inst30Quest1_Folgequest = ""

--QUEST 1 Horde

Inst30Quest1_HORDE = ""
Inst30Quest1_HORDE_Attain = ""
Inst30Quest1_HORDE_Level = "100"
Inst30Quest1_HORDE_Aim = ""
Inst30Quest1_HORDE_Location = ""
Inst30Quest1_HORDE_Note = ""
Inst30Quest1_HORDE_Prequest = ""
Inst30Quest1_HORDE_Folgequest = ""

Inst30Quest2 = ""
Inst30Quest2_Attain = ""
Inst30Quest2_Level = "100"
Inst30Quest2_Aim = ""
Inst30Quest2_Location = ""
Inst30Quest2_Note = ""
Inst30Quest2_Prequest = ""
Inst30Quest2_Folgequest = ""

--QUEST 2 Horde

Inst30Quest2_HORDE = ""
Inst30Quest2_HORDE_Attain = ""
Inst30Quest2_HORDE_Level = "100"
Inst30Quest2_HORDE_Aim = ""
Inst30Quest2_HORDE_Location = ""
Inst30Quest2_HORDE_Note = ""
Inst30Quest2_HORDE_Prequest = ""
Inst30Quest2_HORDE_Folgequest = ""

Inst30Quest3 = ""
Inst30Quest3_Attain = ""
Inst30Quest3_Level = "100"
Inst30Quest3_Aim = ""
Inst30Quest3_Location = ""
Inst30Quest3_Note = ""
Inst30Quest3_Prequest = ""
Inst30Quest3_Folgequest = ""

--QUEST 3 Horde

Inst30Quest3_HORDE = ""
Inst30Quest3_HORDE_Attain = ""
Inst30Quest3_HORDE_Level = "100"
Inst30Quest3_HORDE_Aim = ""
Inst30Quest3_HORDE_Location = ""
Inst30Quest3_HORDE_Note = ""
Inst30Quest3_HORDE_Prequest = ""
Inst30Quest3_HORDE_Folgequest = ""

Inst30Quest4 = ""
Inst30Quest4_Attain = ""
Inst30Quest4_Level = "100"
Inst30Quest4_Aim = ""
Inst30Quest4_Location = ""
Inst30Quest4_Note = ""
Inst30Quest4_Prequest = ""
Inst30Quest4_Folgequest = ""

--QUEST 4 Horde

Inst30Quest4_HORDE = ""
Inst30Quest4_HORDE_Attain = ""
Inst30Quest4_HORDE_Level = "100"
Inst30Quest4_HORDE_Aim = ""
Inst30Quest4_HORDE_Location = ""
Inst30Quest4_HORDE_Note = ""
Inst30Quest4_HORDE_Prequest = ""
Inst30Quest4_HORDE_Folgequest = ""

--------------Azuregos------------
Inst31Story = "在世界大分裂之前，暗夜精灵之城埃达拉斯在如今被称作艾萨拉的土地上可说是非常繁盛。据说很多古老和强大的高等精灵神器，可能就藏在强极一时的堡垒里。经历了无数世代，蓝龙军团全力保护神器与魔法传说，确保它们不落入凡人手中。蓝龙，艾索雷葛斯的出现，似乎暗示着那些具有极重要意义的物品，像是预言中的永恒之瓶，或许就能在艾萨拉的荒野里找到。无论艾索雷葛斯在寻找什么，可以肯定的是：他会誓死保卫艾萨拉的魔法宝藏。"
Inst31Caption = "艾索雷葛斯"

--------------Kazzak------------
Inst32Story = "第三次战争末期，燃烧军团战败后，残余的敌军在巨型恶魔卡扎克领主的率领下撤回了诅咒之地。直到今天，他们仍盘踞在一片名为腐蚀之痕的区域，等待黑暗之门重新开启。传闻一旦黑暗之门重开，卡扎克就会率领残军前往外域。外域曾是兽人的故乡德拉诺，但兽人萨满耐奥祖同时开启多道传送门后，这个世界被彻底撕裂，如今已成为一片破碎之地，被暗夜精灵叛徒伊利丹麾下的恶魔军团所占据。"
Inst32Caption = "卡扎克领主"

--------------Inst14/geschmolzener Kern------------
Inst14Story = "熔火之心就在黑石深渊的底层。这是黑石山的中心，也是很久以前扭转矮人内战情势的地方，索瑞森大帝将元素火焰之王，拉格纳罗斯召唤到世界来。尽管火焰之王无法远离熔火之心，但人们相信他的元素爪牙控制着黑铁矮人，在遗迹之外组建军队。拉格纳罗斯休眠的燃烧之湖有一道裂缝连接火平面，让邪恶的元素可以通过。拉格纳罗斯的首要代理人是管理者埃克索图斯——因为这是唯一能唤醒火焰之王的狡猾元素。"
Inst14Caption = "熔火之心"

--------------Inst16/Onyxia------------
Inst16Story = "奥妮克希亚是强大之龙死亡之翼的女儿，也是黑石塔擅长阴谋的奈法利安大王的妹妹。据说奥妮克希亚喜欢借由干涉人类种族的政治来腐化他们。为达此目的他会变成各种人型生物形态，使用魔法和力量干预不同种族间的所有事情。有些人更认为奥妮克希亚使用父亲曾用过的化名——皇室普瑞斯托。若不插手凡人事务的时候，奥妮克希亚就在黑龙谷下的一处火焰洞穴居住，那是尘泥沼泽里的一个阴暗沼泽。阴险的黑龙军团剩余成员在此守护着她。"
Inst16Caption = "奥妮克希亚的巢穴"

--------------Inst6------------
Inst6Story = "黑翼之巢位于黑石塔的最顶端。在那座山峰幽暗的深处，奈法利安已经开始实施他计划的最后阶段，意图彻底消灭拉格纳罗斯，并率领自己的军队在艾泽拉斯的所有种族之上建立无可争议的霸权。"
Inst6Caption = "黑翼之巢"
Inst6Caption1 = "黑翼之巢（背景第一部分）"
Inst6Caption2 = "黑翼之巢（背景第二部分）"

Inst6Story1 = "坐落在黑石山炽热腹地中的宏伟堡垒，由矮人大工匠弗兰克罗恩·铸铁亲手设计，原本是黑铁矮人力量的象征。数个世纪以来，这座堡垒都由这些阴险的矮人所掌控。然而，狡诈的死亡之翼之子奈法利安对这座要塞另有图谋。他与自己的巨龙爪牙占据了上层黑石塔，并向位于火山深处、作为炎魔拉格纳罗斯权力核心的矮人据点发动战争。拉格纳罗斯已经掌握了以石造生的秘密，并计划打造一支势不可挡的石像魔军队，帮助自己征服整座黑石山。"
Inst6Story2 = "奈法利安发誓要彻底击溃拉格纳罗斯。为此，他近来开始大力扩充自己的势力，仿佛他的父亲死亡之翼在往昔岁月中的所作所为一般。只是这一次，死亡之翼未能完成的野心，诡计多端的奈法利安似乎正在成功实现。奈法利安那疯狂的统治欲甚至招来了红龙军团的愤怒，因为他们一直都是黑龙军团最大的宿敌。虽然奈法利安的意图已经昭然若揭，但他达成目的的方法依旧成谜。不过人们相信，他一直在利用各大巨龙军团的鲜血进行实验，试图制造出无法阻挡的战士。\n \n奈法利安的圣所黑翼之巢，就位于黑石塔的最高处。正是在那片山巅的黑暗深处，奈法利安正逐步展开自己计划的最后阶段，誓要彻底毁灭拉格纳罗斯，并让自己的军队在艾泽拉斯所有种族之上建立无可争议的霸权。"

Inst6Quest1 = ""
Inst6Quest1_Attain = ""
Inst6Quest1_Level = "100"
Inst6Quest1_Aim = ""
Inst6Quest1_Location = ""
Inst6Quest1_Note = ""
Inst6Quest1_Prequest = ""
Inst6Quest1_Folgequest = ""

Inst6Quest1_HORDE = ""
Inst6Quest1_HORDE_Attain = ""
Inst6Quest1_HORDE_Level = "100"
Inst6Quest1_HORDE_Aim = ""
Inst6Quest1_HORDE_Location = ""
Inst6Quest1_HORDE_Note = ""
Inst6Quest1_HORDE_Prequest = ""
Inst6Quest1_HORDE_Folgequest = ""

Inst6Quest2 = ""
Inst6Quest2_Attain = ""
Inst6Quest2_Level = "100"
Inst6Quest2_Aim = ""
Inst6Quest2_Location = ""
Inst6Quest2_Note = ""
Inst6Quest2_Prequest = ""
Inst6Quest2_Folgequest = ""

Inst6Quest2_HORDE = ""
Inst6Quest2_HORDE_Attain = ""
Inst6Quest2_HORDE_Level = "100"
Inst6Quest2_HORDE_Aim = ""
Inst6Quest2_HORDE_Location = ""
Inst6Quest2_HORDE_Note = ""
Inst6Quest2_HORDE_Prequest = ""
Inst6Quest2_HORDE_Folgequest = ""

--------------Inst23------------
Inst23Story = "在流沙之战最后几个小时里，四巨龙军团和暗夜精灵的联军将战场逼至其拉帝国的最中心，希利苏斯的异种虫群退败至最终堡垒安其拉城。但在安其拉之门内，等待着的却是大规模的其拉异种虫，数量是卡利姆多联军所无法想象的。经过漫长的战役，卡利姆多联军仍然无法击败其拉帝王以及他的异种虫群，只能以一个强大的魔法结界将它们困禁在内，而安其拉城也因为战火而成了一个被诅咒的废墟。经过了数千年，其拉的侵略心却没有因为结界而消退。新一代的异种虫群从巢穴中慢慢的破茧而出，安其拉废墟又再度充满了其拉异种虫。这股威胁一定要被消灭，否则艾泽拉斯将可能会被这股恐怖的新世代其拉势力给毁灭。"
Inst23Caption = "安其拉废墟"

--------------Inst26------------
Inst26Story = "在安其拉中心矗立着一座古老神庙综合体。它在史前时代就被建造，用以纪念伟大的神与提供其拉大军繁衍的场地。自数千年前的流沙之战结束后，其拉帝国的双子皇帝就被青铜龙阿纳克洛斯和暗夜精灵们以强大的魔法结界困在了神庙里。随着时间流逝，流沙权杖已被重组，魔法结界上的封印也逐渐消失，通往安其拉神庙深处的道路也再度敞开。那些被困在神庙地下蠢蠢欲动的其拉军团开始准备入侵。为了避免第二次流沙之战再度爆发、贪婪的虫群再次于卡利姆多大陆倾巢而出，无论如何一定要阻止它们。"
Inst26Caption = "安其拉神殿"

--------------Inst28------------
Inst28Story = "一千多年前，强大的古拉巴什帝国因一场巨大的内战而分崩离析。一群被称为阿塔莱的巨魔祭司唤出了古老而可怕的血神哈卡的化身。尽管这些祭司最终被击败并流放，伟大的巨魔帝国仍就此崩溃。被放逐的祭司逃往遥远的北方，进入悲伤沼泽，在那里为哈卡建造了一座宏伟的神庙，以准备迎接他降临到现实世界。"

Inst28Story1 = "后来，阿塔莱祭司们发现，哈卡的实体只能在古老的古拉巴什帝国首都祖尔格拉布中被召唤出来。不幸的是，他们最近似乎在召唤哈卡的计划上取得了成功，种种报告都证实，这位可怕的夺灵者已经出现在古拉巴什废墟的核心之中。\n \n为了平息这位血神，巨魔们联合起来，派出了一支高阶祭司队伍进入古城。每一位祭司都是某位原始神灵的强大化身，分别代表蝙蝠、豹、虎、蜘蛛与蛇。然而，尽管他们竭尽全力，最终还是屈从于哈卡的意志。如今，这些勇士以及他们所侍奉的原始神灵化身，反而在为夺灵者提供强大的力量。任何胆敢深入这片不祥废墟的冒险者，都必须先击败这些高阶祭司，才有希望直面那位强大的血神。"
Inst28Caption = "祖尔格拉布"
Inst28Caption1 = "祖尔格拉布（背景）"

Inst28Quest1 = ""
Inst28Quest1_Attain = ""
Inst28Quest1_Level = "100"
Inst28Quest1_Aim = ""
Inst28Quest1_Location = ""
Inst28Quest1_Note = ""
Inst28Quest1_Prequest = ""
Inst28Quest1_Folgequest = ""

--QUEST 1 Horde

Inst28Quest1_HORDE = ""
Inst28Quest1_HORDE_Attain = ""
Inst28Quest1_HORDE_Level = "100"
Inst28Quest1_HORDE_Aim = ""
Inst28Quest1_HORDE_Location = ""
Inst28Quest1_HORDE_Note = ""
Inst28Quest1_HORDE_Prequest = ""
Inst28Quest1_HORDE_Folgequest = ""


--------------Inst15 /Naxxramas------------
Inst15Story = "飘浮在瘟疫之地上空的浮空要塞纳克萨玛斯是巫妖王最强大的副官——克尔苏加德的旗舰。巫妖王的仆从们在这座要塞中筹划着新的攻势，要给整个艾泽拉斯世界带来恐慌和灾难。天灾军团再一次开始了他们的征程……"
Inst15Caption = "纳克萨玛斯"

--------------Inst33 / Alterac Vally------------
Inst33Story = "雷矛远征军已经在奥特兰克山谷中安营扎寨，想要研究这里的资源和远古遗物。尽管他们来此的目的并不是为了挑衅，但是矮人们却与居住在山谷南部的霜狼氏族发生了激烈的冲突。霜狼氏族由此发誓要将入侵者赶出他们的家园. "
Inst33Caption = "奥特兰克山谷"

--------------Inst34 / Arathi Basin------------
Inst34Story = "位于阿拉希高地的阿拉希盆地是一处激动人心的战场。盆地拥有丰富的资源，部落和联盟都对此垂涎不已。污染者和阿拉索联军在阿拉希盆地展开激战，想要为他们所在的阵营抢夺盆地中的资源."
Inst34Caption = "阿拉希盆地"

--------------Inst35 / Warsong Gulch------------
Inst35Story = "战歌峡谷位于灰谷森林南部。在第三次兽人战争中，格罗姆·地狱咆哮和他麾下的兽人们几乎将战歌峡谷附近的森林砍伐殆尽。其中部分兽人仍然盘踞在这里，继续砍伐着森林，想要扩张部落的势力范围。他们称自己为战歌侦查骑兵。\n\n暗夜精灵早已纠集兵力，打算收复灰谷森林。他们想要将战歌侦察骑兵彻底赶出这片土地。因此，银翼哨兵挺身而出，发誓在将兽人驱逐出战歌峡谷之前他们决不休息. "
Inst35Caption = "战歌峡谷（WSG）"


--    AQINSTANZ :
-- 1  = VC     21 = BSF
-- 2  = WC     22 = STRAT
-- 3  = RFA    23 = AQ20
-- 4  = ULD    24 = STOCKADE
-- 5  = BRD    25 = TEMPLE
-- 6  = BWl    26 = AQ40
-- 7  = BFD    27 = ZUL
-- 8  = LBRS   28 = ZG
-- 9  = UBRS   29 = GNOMERE
-- 10 = DME    30 = DRAGONS
-- 11 = DMN    31 = AZUREGOS
-- 12 = DMW    32 = KAZZAK
-- 13 = MARA   33 = AV
-- 14 = MC     34 = AB
-- 15 = NAXX   35 = WS
-- 16 = ONY    36 = REST
-- 17 = HUEGEL
-- 18 = KRAL
-- 19 = KLOSTER
-- 20 = SCHOLO
Inst1QAA = "5 个任务"
Inst1QAH = "没有任务"
Inst2QAA = "5 个任务"
Inst2QAH = "7 个任务"
Inst4QAA = "16 个任务"
Inst4QAH = "10 个任务"
Inst3QAA = "没有任务"
Inst3QAH = "5 个任务"
Inst27QAA = "7 个任务"
Inst27QAH = "7 个任务"
Inst24QAA = "6 个任务"
Inst24QAH = "没有任务"
Inst17QAA = "3 个任务"
Inst17QAH = "4 个任务"
Inst19QAA = "3 个任务"
Inst19QAH = "6 个任务"
Inst18QAA = "5 个任务"
Inst18QAH = "5 个任务"
Inst20QAA = "9 个任务"
Inst20QAH = "9 个任务"
Inst7QAA = "6 个任务"
Inst7QAH = "5 个任务"
Inst25QAA = "8 个任务"
Inst25QAH = "8 个任务"
Inst21QAA = "2 个任务"
Inst21QAH = "4 个任务"
Inst5QAA = "14 个任务"
Inst5QAH = "14 个任务"
end
