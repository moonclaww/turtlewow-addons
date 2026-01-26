-- Version : Chinese ( by iWOW )
-- Last Update : 03/21/2005

if ( GetLocale() == "zhCN" ) then

-- Interface Configuration
IEF_FILE		= "文件:";
IEF_STRING		= "字符:";
IEF_LINE		= "行:";
IEF_COUNT		= "列:";
IEF_ERROR		= "错误:";
IEF_ADDON		= "插件: ";
IEF_PATH		= "路径: ";

IEF_CANCEL		= "取消";
IEF_CLOSE		= "关闭";
IEF_REPORT		= "报告";

IEF_INFINITE		= "极多";

-- Slash command strings
IEF_NOTIFY_ON		= "错误提示增强: 启用警告延迟通知.";
IEF_NOTIFY_OFF		= "错误提示增强: 在错误发生时立即报告.";
IEF_BLINK_ON		= "错误提示增强: 有错误等待处理时闪烁.";
IEF_BLINK_OFF		= "错误提示增强: 按钮不再闪烁.";
IEF_COUNT_ON		= "错误提示增强: 显示等待处理的错误数.";
IEF_COUNT_OFF		= "错误提示增强: 不对等待处理的错误计数.";
IEF_ALWAYS_ON		= "错误提示增强: 总是显示错误按钮.";
IEF_ALWAYS_OFF		= "错误提示增强: 发生错误时才显示按钮.";
IEF_SOUND_ON		= "错误提示增强: 错误发生时发声通知.";
IEF_SOUND_OFF		= "错误提示增强: 不再播放错误提示声.";
IEF_EMPTY_ON		= "错误提示增强: 闪烁时按钮图片消失.";
IEF_EMPTY_OFF		= "错误提示增强: 闪烁时按钮图片不改变.";
IEF_DEBUG_ON		= "错误提示增强: FrameXML详细日志模式开启";
IEF_DEBUG_OFF		= "错误提示增强: FrameXML详细日志模式关闭";
IEF_STACK_ON		= "错误提示增强: 开始显示调用堆栈";
IEF_STACK_OFF		= "错误提示增强: 停止显示调用堆栈";
IEF_DEBUGCAPTURE_ON	= "错误提示增强: 开始捕获Sea调试输出";
IEF_DEBUGCAPTURE_OFF	= "错误提示增强: 不再捕获Sea调试输出";
IEF_FORMAT_STR		= "格式: /ief <NOTIFY|BLINK|COUNT|ALWAYS|SOUND|EMPTY|DEBUG|STACK> <ON|OFF>";
IEF_CURRENT_SETTINGS	= "当前设置:";
IEF_BLINK_OPT		= "blink";
IEF_NOTIFY_OPT		= "notify";
IEF_COUNT_OPT		= "count";
IEF_ALWAYS_OPT		= "always";
IEF_SOUND_OPT		= "sound";
IEF_EMPTY_OPT		= "empty";
IEF_DEBUG_OPT		= "debug";
IEF_STACK_OPT		= "stack";
IEF_ON			= "on";
IEF_OFF			= "off";
IEF_HELP_TEXT		= "/ief - 错误提示增强配置";
IEF_HELP_DEBUGCAPTURE_TEXT =	"/iefd - 切换是否捕获Sea调试信息";

-- Tooltip Text
IEF_TOOLTIP		= "单击查看错误.";
-- Header Text
IEF_TITLE_TEXT		= "错误队列";
IEF_ERROR_TEXT		= "实时错误";

-- Khaos/Cosmos descriptions
IEF_OPTION_TEXT		= "错误提示增强";
IEF_OPTION_HELP		= "使你能设置错误报告选项.";
IEF_HEADER_TEXT		= "错误提示增强";
IEF_HEADER_HELP		= "配置错误报告需要的一些选项.";
IEF_NOTIFY_TEXT		= "错误排队";
IEF_NOTIFY_HELP		= "选择后，错误将排队等候显示.";
IEF_BLINK_TEXT		= "闪烁按钮";
IEF_BLINK_HELP		= "选择后，有错误等待处理时闪烁按钮.";
IEF_COUNT_TEXT		= "按钮上显示错误计数";
IEF_COUNT_HELP		= "选择后，错误计数将显示在按钮上.";
IEF_ALWAYS_TEXT		= "总是显示错误按钮";
IEF_ALWAYS_HELP		= "选择后，错误按钮将一直显示在屏幕上.";
IEF_SOUND_TEXT		= "播放通知音";
IEF_SOUND_HELP		= "选择后，队列中加入第一个错误发生时将播放通知音";
IEF_EMPTY_TEXT		= "清除按钮图片";
IEF_EMPTY_HELP		= "选择后, 错误按钮在闪烁时会清除.";
IEF_DEBUG_TEXT		= "详细FrameXML错误日志";
IEF_DEBUG_HELP		= "选择后, FrameXML.log 将以详细模式进行日志记录. (需要UI重新加载)";
IEF_STACK_TEXT		= "显示调用堆栈";
IEF_STACK_HELP		= "选择后, 调用堆栈将和错误信息一起显示";
IEF_DEBUGCAPTURE_TEXT	= "捕获Sea调试输出"
IEF_DEBUGCAPTURE_HELP	= "选择后, 将捕获Sea的调试输出显示在增强错误窗口以便你复制粘贴"
end
