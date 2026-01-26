-- Version : Chinese ( by iWOW )
-- Last Update : 03/21/2005

if (GetLocale()=="zhTW") then

-- Interface Configuration
IEF_FILE		= "文件:";
IEF_STRING		= "字符:";
IEF_LINE		= "行:";
IEF_COUNT		= "列:";
IEF_ERROR		= "錯誤:";
IEF_ADDON		= "插件: ";
IEF_PATH		= "路徑: ";

IEF_CANCEL		= "取消";
IEF_CLOSE		= "關閉";
IEF_REPORT		= "報告";

IEF_INFINITE		= "極多";

-- Slash command strings
IEF_NOTIFY_ON		= "錯誤提示增強: 啟用警告延遲通知.";
IEF_NOTIFY_OFF		= "錯誤提示增強: 在錯誤發生時立即報告.";
IEF_BLINK_ON		= "錯誤提示增強: 有錯誤等待處理時閃爍.";
IEF_BLINK_OFF		= "錯誤提示增強: 按鈕不再閃爍.";
IEF_COUNT_ON		= "錯誤提示增強: 顯示等待處理的錯誤數.";
IEF_COUNT_OFF		= "錯誤提示增強: 不對等待處理的錯誤計數.";
IEF_ALWAYS_ON		= "錯誤提示增強: 總是顯示錯誤按鈕.";
IEF_ALWAYS_OFF		= "錯誤提示增強: 發生錯誤時才顯示按鈕.";
IEF_SOUND_ON		= "錯誤提示增強: 錯誤發生時發聲通知.";
IEF_SOUND_OFF		= "錯誤提示增強: 不再播放錯誤提示聲.";
IEF_EMPTY_ON		= "錯誤提示增強: 閃爍時按鈕圖片消失.";
IEF_EMPTY_OFF		= "錯誤提示增強: 閃爍時按鈕圖片不改變.";
IEF_DEBUG_ON		= "錯誤提示增強: FrameXML詳細日志模式開啟";
IEF_DEBUG_OFF		= "錯誤提示增強: FrameXML詳細日志模式關閉";
IEF_STACK_ON		= "錯誤提示增强: 開始顯示調用堆棧";
IEF_STACK_OFF		= "錯誤提示增强: 停止顯示調用堆棧";
IEF_DEBUGCAPTURE_ON	= "错误提示增强: 开始捕获Sea调试输出";
IEF_DEBUGCAPTURE_OFF	= "错误提示增强: 不再捕获Sea调试输出";
IEF_FORMAT_STR		= "格式: /ief <NOTIFY|BLINK|COUNT|ALWAYS|SOUND|EMPTY|DEBUG|STACK> <ON|OFF>";
IEF_CURRENT_SETTINGS	= "當前設置:";
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
IEF_HELP_TEXT		= "/ief - 錯誤提示增強配置";
IEF_HELP_DEBUGCAPTURE_TEXT =	"/iefd - 切换是否捕获Sea调试信息";

-- Tooltip Text
IEF_TOOLTIP		= "單擊查看錯誤.";
-- Header Text
IEF_TITLE_TEXT		= "錯誤隊列";
IEF_ERROR_TEXT		= "實時錯誤";

-- Khaos/Cosmos descriptions
IEF_OPTION_TEXT		= "錯誤提示增強";
IEF_OPTION_HELP		= "使你能設置錯誤報告選項.";
IEF_HEADER_TEXT		= "錯誤提示增強";
IEF_HEADER_HELP		= "配置錯誤報告需要的一些選項.";
IEF_NOTIFY_TEXT		= "錯誤排隊";
IEF_NOTIFY_HELP		= "選擇後，錯誤將排隊等候顯示.";
IEF_BLINK_TEXT		= "閃爍按鈕";
IEF_BLINK_HELP		= "選擇後，有錯誤等待處理時閃爍按鈕.";
IEF_COUNT_TEXT		= "按鈕上顯示錯誤計數";
IEF_COUNT_HELP		= "選擇後，錯誤計數將顯示在按鈕上.";
IEF_ALWAYS_TEXT		= "總是顯示錯誤按鈕";
IEF_ALWAYS_HELP		= "選擇後，錯誤按鈕將一直顯示在屏幕上.";
IEF_SOUND_TEXT		= "播放通知音";
IEF_SOUND_HELP		= "選擇後，隊列中加入第一個錯誤發生時將播放通知音";
IEF_EMPTY_TEXT		= "清除按鈕圖片";
IEF_EMPTY_HELP		= "選擇後, 錯誤按鈕在閃爍時會清除.";
IEF_DEBUG_TEXT		= "詳細FrameXML錯誤日志";
IEF_DEBUG_HELP		= "選擇後, FrameXML.log 將以詳細模式進行日志記錄. (需要UI重新加載)";
IEF_STACK_TEXT		= "顯示調用堆棧";
IEF_STACK_HELP		= "選擇后, 調用堆棧將和錯誤信息一起顯示";
IEF_DEBUGCAPTURE_TEXT	= "捕获Sea调试输出"
IEF_DEBUGCAPTURE_HELP	= "选择后, 将捕获Sea的调试输出显示在增强错误窗口以便你复制粘贴"
end