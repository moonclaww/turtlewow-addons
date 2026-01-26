--[[ 

	QuestSay
	author: carahuevo

	Prints out a quest objectives state in the selected output channel.

	"/qs <where> <Quest Title>" (where s,p,r,g for /say, /party, /guild, /raid).
	"/qs <Quest Title>"  (where auto-selected).
	"/qs <where>"  (quest auto-selected).
	"/qs"  (where and quest auto-selected).

HISTORY

version 0.2
-  Ctrl+click in quest title shorcut to /qs

version 0.11
- Fixed output channel selecion.

version 0.1
- Initial release.

]]

QS_title = "QuestSay";
QS_version = "0.2";
QS_author = "carahuevo";


--localization
QS_LB_OBJECTIVES = "宗旨";
QS_LB_DESCRIPTION = "描述";
QS_LB_GOSSIP = "闲谈";
QS_LB_SAY = "说";
QS_LB_PARTY = "小队";
QS_LB_RAID = "团队";
QS_LB_GUILD = "工会";

-- Colours
COLOR_RED = "|cffff0000";
COLOR_GREEN = "|cff00ff00";
COLOR_BLUE = "|cff0000ff";
COLOR_PURPLE = "|cff700090";
COLOR_YELLOW = "|cffffff00";
COLOR_ORANGE = "|cffff6d00";
COLOR_GREY = "|cff808080";
COLOR_GOLD = "|cffcfb52b";
COLOR_NEON_BLUE = "|cff4d4dff";
COLOR_END = "|r";

local WOW_QuestLogTitleButton_OnClick;
local selectedMenu;

-- onload event handle
function QS_OnLoad()
	--register slash commands
	SLASH_QS1 = "/qs";
	SlashCmdList["QS"] = function(msg)
		QS_Command(msg);
	end

	--hooks QuestLogTitleButton click event to overwrite it
	WOW_QuestLogTitleButton_OnClick = QuestLogTitleButton_OnClick;
	QuestLogTitleButton_OnClick = QS_QuestLogTitleButton_OnClick;

	--prepare QS menu
	----UIDropDownMenu_Initialize(this, QS_ListDropDown_Initialize, "MENU");

	QS_Print("Version "..QS_version.." by "..QS_author.." loaded. Type \"/qs help\" for help.");
end

-- print function
function QS_Print (msg)
	DEFAULT_CHAT_FRAME:AddMessage(COLOR_RED..QS_title.."> "..COLOR_END..msg);
end

-- slash function handle
function QS_Command(msg)
	--cmd will contain the channel (s,p,r,g) and param the quest title
	local cmd, param = QS_ParamParser(msg);
	local channel;
	local quest;

	if ( cmd == "" ) then
		channel = nil;
	elseif (cmd=="help" and param==nil) then
		--help is default option
		QS_Print("Usages: /qs s|p|g|r Quest Title -> (s=/say, p=/party, g=/guild, r=/raid).");
		QS_Print("        /qs Quest Title -> Output selected automatically.");
		QS_Print("        /qs -> Output selected automatically and pick selected quest in log window).");
		return;
	elseif(cmd~="s" and cmd~="p" and cmd~="g" and cmd~="r") then
		channel = nil;
	else
		channel = cmd;
	end

	if( not channel ) then
		--no output, auto-choose one...
		if ( param ) then
			param = cmd.." "..param;
		end
		if (GetNumPartyMembers()>0) then
			channel = "p";
		elseif( UnitInRaid("player") ) then
			channel = "r";
		else
			channel = "s";
		end
	end

	if (param == nil) then
		if ( QuestLogFrame.selectedButtonID ) then
			quest = GetQuestLogTitle(QuestLogFrame.selectedButtonID);
		else
			QS_Print(COLOR_RED.."没有给定的任务. 详细说明一个标题或在任务日志里选择一个."..COLOR_END);
			return;
		end
	else
		quest = param;
	end
	QS_PrintQuestProperty(channel, quest);
end

-- Parse data after /qs command
function QS_ParamParser(msg)
 	if msg then
 		local a,b,c=strfind(msg, "(%S+)"); --contiguous string of non-space characters
 		if a then
 			return c, strsub(msg, b+2);
 		else	
 			return "";
 		end
 	end
end;

-- Returns quest index based on title
function QS_GetQuestIndexByTitle(title)
	local numEntries = GetNumQuestLogEntries();
	local questLogTitleText;
	for i=1, numEntries do
		questLogTitleText = GetQuestLogTitle(i);
		if ( questLogTitleText == title ) then
			return i;
		end
	end
	return nil;
end

-- Prints out a quest objectives 
function QS_PrintQuestProperty(output, questTitle, questProperty)
	local questIdx = QS_GetQuestIndexByTitle(questTitle);
	if ( not questIdx ) then
		QS_Print(COLOR_RED.."任务没有找到."..COLOR_END);
		return;
	else
		if ( questProperty==nil) then
			questProperty = QS_LB_OBJECTIVES;
		end

		if ( questProperty==QS_LB_OBJECTIVES) then
			local numObjectives = GetNumQuestLeaderBoards(questIdx);
			if (numObjectives == 0) then
				QS_Print(COLOR_RED.."这个任务没有宗旨."..COLOR_END);
			else
				QS_PrintOut(output, "# 任务 \""..questTitle.."\" 宗旨:");
				for i=1, numObjectives do
					local text, type, finished = GetQuestLogLeaderBoard(i, questIdx);
					if (not finished) then
						text = text.." <--";
					end
					QS_PrintOut(output, " - "..text);
				end
			end
		elseif ( questProperty==QS_LB_DESCRIPTION) then
		elseif ( questProperty==QS_LB_GOSSIP) then
		end
	end
end

function QS_PrintOut(outsystem, msg)
	msg = string.sub(msg, 1, 254);
	if ( outsystem == "p" and GetNumPartyMembers()>0 ) then
		SendChatMessage(msg, "PARTY");
	elseif ( outsystem == "r" and UnitInRaid("player") ) then
		SendChatMessage(msg, "RAID");
	elseif ( outsystem == "g" and IsInGuild() ) then
		SendChatMessage(msg, "GUILD");
	else
		SendChatMessage(msg, "SAY");
	end
end

--hooked QuestLog button event
function QS_QuestLogTitleButton_OnClick(button)
	--processes first the "super" function
	WOW_QuestLogTitleButton_OnClick();

	--CTRL+Click=/qs
	if ( button=="LeftButton" ) then
		if ( IsControlKeyDown() ) then
			QS_Command(nil);
		end
	elseif ( button=="RightButton" ) then
		--ToggleDropDownMenu(1, nil, QuestSayFrame, "QuestLogTitle"..QuestLogFrame.selectedButtonID, 0, 0);
	end
end

function QS_ListDropDown_Initialize()
	--title
	--Objectives>
	--Description>
	--Text>
	  --party
	  --say
	  --raid
	  --guild
	if ( UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		selectedMenu = UIDROPDOWNMENU_MENU_VALUE;

		info = {};
		info.text = QS_LB_PARTY;
		info.value = "p";
		info.func = QS_DropDownAction;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = QS_LB_SAY;
		info.value = "s";
		info.func = QS_DropDownAction;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = QS_LB_RAID;
		info.value = "r";
		info.func = QS_DropDownAction;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		info = {};
		info.text = QS_LB_GUILD;
		info.value = "g";
		info.func = QS_DropDownAction;
		info.notCheckable = 1;
		UIDropDownMenu_AddButton(info, UIDROPDOWNMENU_MENU_LEVEL);

		return;
	end

	info = {};
	info.text = QS_title.." "..QS_version;
	info.value = QS_title;
	info.isTitle = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = QS_LB_OBJECTIVES;
	info.value = QS_LB_OBJECTIVES;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = QS_LB_DESCRIPTION;
	info.value = QS_LB_DESCRIPTION;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);

	info = {};
	info.text = QS_LB_GOSSIP;
	info.value = QS_LB_GOSSIP;
	info.hasArrow = 1;
	UIDropDownMenu_AddButton(info);
end

function QS_DropDownAction()
	QS_PrintQuestProperty(this.value, GetQuestLogTitle(QuestLogFrame.selectedButtonID) , selectedMenu);
end