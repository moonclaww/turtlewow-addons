QuestieInterfaceTexts = {
    ["Settings"] = {
        ["alwaysShowObjectives"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Always Show Quest Notes",
                ["description"] = "When this option is enabled, notes for all quests are displayed on the map regardless of the quests tracking status.\n\nWhen it is disabled, notes are only shown for quests tracked in the quest log (Shift+Click a quest in the quest log to change its tracking status).",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "总是显示任务标记",
                ["description"] = "启用此选项时，无论任务追踪状态如何，所有任务的标记都会显示在地图上。\n\n禁用时，只显示任务日志中追踪的任务标记（在任务日志中按住Shift点击任务可更改追踪状态）。",
            },
        },
        ["arrowEnabled"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Enable Questie Arrow",
                ["description"] = "This option toggles the Questie Arrow on and off. You can make the arrow point to the nearest quest icon by clicking on a quest in the Questie Tracker.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "启用任务箭头",
                ["description"] = "此选项开启或关闭任务指引箭头。点击任务追踪器中的任务可使箭头指向最近的任务图标。",
            },
        },
        ["boldColors"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Questie Tracker Colors",
                ["description"] = "This option toggles two different coloring schemes for the Questie Tracker.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "追踪器配色方案",
                ["description"] = "此选项在两种不同的追踪器配色方案之间切换。",
            },
        },
        ["clusterQuests"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Cluster Worldmap Notes",
                ["description"] = "This option toggles the merging of notes on the world map that are close together. It helps with seeing quest notes that would otherwise be ontop of one another (e.g. quest start notes in densely populated quest hubs). Minimap notes are not affected by this setting.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "合并世界地图标记",
                ["description"] = "此选项开启或关闭合并世界地图上相近的标记。这有助于查看原本会重叠的任务标记（例如任务密集区域的任务起始标记）。小地图标记不受此设置影响。",
            },
        },
        ["corpseArrow"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Show Corpse Arrow",
                ["description"] = "This option toggles the Questie Arrow which points to the players corpse when he is dead on and off.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "显示尸体箭头",
                ["description"] = "此选项开启或关闭死亡时指向玩家尸体的箭头。",
            },
        },
        ["getVersion"] = QuestieVersion,
        ["hideMinimapIcons"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Hide Minimap Icons",
                ["description"] = "This option toggles the Questie minimap notes on and off.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "隐藏小地图图标",
                ["description"] = "此选项开启或关闭小地图上的任务标记。",
            },
        },
        ["maxLevelFilter"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Max Level Filter",
                ["description"] = "This option toggles the Max Level Filter for quest start display on and off. When it is enabled only quests up to a certain level above the player are displayed. The level is controled by the \"Max Show Level\" option.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "最高等级过滤",
                ["description"] = "此选项开启或关闭任务起始显示的最高等级过滤。启用时，只显示不超过玩家等级一定范围内的任务。",
            },
        },
        ["maxShowLevel"] = {
            ["enUS"] = {
                ["default"] = "7",
                ["name"] = "Max Show Level",
                ["description"] = "This option controls how much the level requirement of a quest may be above the player level for the quest start to be shown on the map.",
            },
            ["zhCN"] = {
                ["default"] = "7",
                ["name"] = "最高显示等级",
                ["description"] = "此选项控制任务等级可以高于玩家等级多少级仍显示在地图上。",
            },
        },
        ["minimapButton"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Show Minimap Button",
                ["description"] = "This option toggles the Questie minimap button on and off.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "显示小地图按钮",
                ["description"] = "此选项开启或关闭小地图上的Questie按钮。",
            },
        },
        ["minimapZoom"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Hide Minimap Notes",
                ["description"] = "This option toggles the Questie minimap notes on and off.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "隐藏小地图标记",
                ["description"] = "此选项开启或关闭小地图上的任务标记。",
            },
        },
        ["minLevelFilter"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Min Level Filter",
                ["description"] = "This option toggles the Min Level Filter for quest start display on and off. When it is enabled only quests up to a certain level below the player are displayed. The level is controled by the \"Min Show Level\" option.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "最低等级过滤",
                ["description"] = "此选项开启或关闭任务起始显示的最低等级过滤。启用时，只显示不低于玩家等级一定范围内的任务。",
            },
        },
        ["minShowLevel"] = {
            ["enUS"] = {
                ["default"] = "4",
                ["name"] = "Min Show Level",
                ["description"] = "This option controls how much the level of a quest may be below the player level for the quest start to be shown on the map.",
            },
            ["zhCN"] = {
                ["default"] = "4",
                ["name"] = "最低显示等级",
                ["description"] = "此选项控制任务等级可以低于玩家等级多少级仍显示在地图上。",
            },
        },
        ["resizeWorldmap"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Resize Worldmap",
                ["description"] = "When enabled, this option resizes the World Map window from a fullscreen display to a movable window. Note that this setting might have no effect if you use separate a map addon.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "调整世界地图大小",
                ["description"] = "启用时，此选项将世界地图窗口从全屏显示调整为可移动窗口。注意：如果你使用了其他地图插件，此设置可能无效。",
            },
            ["requiresReload"] = true,
        },
        ["showMapNotes"] = {
            ["enUS"] = {
                ["default"] = "True",
                ["name"] = "Show Map Notes",
                ["description"] = "This option toggles Questies world map and minimap notes on and off.",
            },
            ["zhCN"] = {
                ["default"] = "True",
                ["name"] = "显示地图标记",
                ["description"] = "此选项开启或关闭世界地图和小地图上的任务标记。",
            },
        },
        ["hideObjectives"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Hide Objective Markers",
                ["description"] = "This option toggles showing of objectives (mob locations etc). If enabled only quest icons (!/?) are shown.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "隐藏目标标记",
                ["description"] = "此选项开启或关闭目标标记（怪物位置等）的显示。启用时只显示任务图标（!/？）。",
            },
        },
        ["showProfessionQuests"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Show Profession Quests",
                ["description"] = "This option toggles the quest start display of profession quests on and off.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "显示专业任务",
                ["description"] = "此选项开启或关闭专业技能任务的起始标记显示。",
            },
        },
        ["showToolTips"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Show Tooltips",
                ["description"] = "This option toggles the display of additional quest objective information in the tooltips that appear when mousing over a creature, an object or an item.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "显示提示信息",
                ["description"] = "此选项开启或关闭当鼠标悬停在生物、物体或物品上时显示额外的任务目标信息。",
            },
            ["requiresReload"] = true,
        },
        ["showTrackerHeader"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Show Tracker Header",
                ["description"] = "This option toggles the display of the number of active quests in the Questie Tracker.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "显示追踪器标题",
                ["description"] = "此选项开启或关闭在追踪器中显示当前任务数量。",
            },
            ["requiresReload"] = true,
        },
        ["trackerAlpha"] = {
            ["enUS"] = {
                ["default"] = "60%",
                ["name"] = "Tracker Transparency",
                ["description"] = "This option controls how opaque the background of the Questie Tracker is displayed (if the background is enabled.",
            },
            ["zhCN"] = {
                ["default"] = "60%",
                ["name"] = "追踪器透明度",
                ["description"] = "此选项控制追踪器背景的不透明度（如果背景已启用）。",
            },
        },
        ["trackerBackground"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Tracker Background",
                ["description"] = "This option toggles the Questie Tracker background on and off.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "追踪器背景",
                ["description"] = "此选项开启或关闭追踪器的背景显示。",
            },
            ["requiresReload"] = true,
        },
        ["trackerEnabled"] = {
            ["enUS"] = {
                ["default"] = "True",
                ["name"] = "Enable Questie Tracker",
                ["description"] = "This option toggles the Questie Tracker on and off. The Questie Tracker replaces the default quest tracker and allows you to track more quests at the same time. It also enables you to show an arrow pointing to the closest objective of a quest, by clicking on the quest in the tracker.",
            },
            ["zhCN"] = {
                ["default"] = "True",
                ["name"] = "启用任务追踪器",
                ["description"] = "此选项开启或关闭Questie任务追踪器。追踪器替代默认的任务追踪功能，允许同时追踪更多任务。点击追踪器中的任务可显示指向最近目标的箭头。",
            },
            ["requiresReload"] = true,
        },
        ["trackerList"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Tracker Sorting Direction",
                ["description"] = "When this option is enabled, tracker elements are added from top to bottom, meaning the list will grow downwards.\n\nWhen this option is enabled, tracker elements are added from bottom to top, meaning the list will grow upwards.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "追踪器排序方向",
                ["description"] = "启用此选项时，追踪元素从上到下添加，列表向下增长。\n\n禁用时，追踪元素从下到上添加，列表向上增长。",
            },
            ["requiresReload"] = true,
        },
        ["trackerMinimize"] = {
            ["enUS"] = {
                ["default"] = "false",
                ["name"] = "Minimize Tracker",
                ["description"] = "This option toggles the display of the Questie Tracker on and off.",
            },
            ["zhCN"] = {
                ["default"] = "false",
                ["name"] = "最小化追踪器",
                ["description"] = "此选项开启或关闭追踪器的显示。",
            },
        },
        ["trackerScale"] = {
            ["enUS"] = {
                ["default"] = "100%",
                ["name"] = "Tracker Scale",
                ["description"] = "This option controls the size of the Questie Tracker.",
            },
            ["zhCN"] = {
                ["default"] = "100%",
                ["name"] = "追踪器缩放",
                ["description"] = "此选项控制追踪器的大小。",
            },
            ["requiresReload"] = true,
        },
        ["useQuestLinks"] = {
            ["enUS"] = {
                ["default"] = "true",
                ["name"] = "Use Quest Links",
                ["description"] = "When shift-clicking a quest in the quest log while the chat input window is open, paste a link into the chat instead of just plain text.\n\nSome servers filter chat links. If the link does not appear after sending the chat message, disable this option.",
            },
            ["zhCN"] = {
                ["default"] = "true",
                ["name"] = "使用任务链接",
                ["description"] = "当聊天输入框打开时，按住Shift点击任务日志中的任务将粘贴任务链接而非纯文本。\n\n某些服务器会过滤聊天链接。如果发送消息后链接未显示，请禁用此选项。",
            },
            ["requiresReload"] = false,
        },
    }
}
