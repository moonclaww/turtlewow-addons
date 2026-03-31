-- MetaKB Import Module
-- Written by MetaHawk aka Urshurak

MMCVT_MAPNOTES  = "MapNotes";
MMCVT_MAPMOD    = "MapMod";
MMCVT_USERWKB   = "用户知识库";
MMCVT_USERNOTES = "用户标记";
MMCVT_BLT       = "默认数据";
MMCVT_QST       = "用户任务";
MMCVT_QSTH      = "任务历史";

local MetaMap_TempData = {};
local Import_MapNotes  = false;
local Import_MapMod    = false;
local Import_UserWKB   = false;
local Import_UserNotes = false;
local Import_BLT       = false;
local Import_QST       = false;
local Import_QSTH      = false;
local MetaMapCVT_MapRegistry = AceLibrary("MapRegistry-1.0");

local function MetaMapCVT_CountCanonicalNotes(noteStore)
	local total = 0;
	if(noteStore and noteStore.__canonical) then
		for mapId, notes in noteStore.__canonical do
			for index, note in notes do
				total = total +1;
			end
		end
	end
	return total;
end

function MetaMapCVT_CheckData()
	local found = false;
	local fileInfo = "MetaMap 导入模块已加载。"
	if(MetaMap_NoteData) then
		MetaMap_InstanceImportButton:Enable();
		found = true;
	end
	if(MapNotes_Data) then
		MetaMap_MapNotesImportButton:Enable();
		Import_MapNotes = true;
		found = true;
	end
	if(CT_UserMap_Notes) then
		MetaMap_MapNotesImportButton:Enable();
		Import_MapMod = true;
		found = true;
	end
	if(MyKB_Data) then
		if(not IsAddOnLoaded("MetaMapWKB")) then
			LoadAddOn("MetaMapWKB");
		end
		if(IsAddOnLoaded("MetaMapWKB")) then
			if(MyKB_Data[MetaKB_dbID]) then
				MetaMap_UserImportButton:Enable();
				Import_UserWKB = true;
				found = true;
			end
		end
	end
	if(MyNotes_Data) then
		MetaMap_UserImportButton:Enable();
		Import_UserNotes = true;
		found = true;
	end
	if(MetaMapBLTDefaultData) then
		if(not IsAddOnLoaded("MetaMapBLT")) then
			LoadAddOn("MetaMapBLT");
		end
		if(IsAddOnLoaded("MetaMapBLT")) then
			MetaMap_BLTImportButton:Enable();
			Import_BLT = true;
			found = true;
		end
	end
	if(QuestHistory_List or MyQST_QuestBase) then
		if(not IsAddOnLoaded("MetaMapQST")) then
			LoadAddOn("MetaMapQST");
		end
		if(IsAddOnLoaded("MetaMapQST")) then
			MetaMap_UserImportButton:Enable();
			if(QuestHistory_List) then
				Import_QSTH = true;
			end
			if(MyQST_QuestBase) then
				Import_QST = true;
			end
			found = true;
		end
	end
	if(not found) then
		fileInfo = fileInfo.."\n没有数据被发现";
	end
	MetaMap_OptionsInfo:SetText(fileInfo);
	MetaMap_LoadImportsButton:Disable();
end

function MetaMap_ImportOptions(mode)
	local ShowFrame = true;
	if(mode == 1) then
		Import_MetaMapData();
		ShowFrame = false;
	elseif(mode == 2) then
		MetaMap_SelectionButton1:SetText(MMCVT_MAPNOTES);
		MetaMap_SelectionButton2:SetText(MMCVT_MAPMOD);
		if(not Import_MapNotes) then
			MetaMap_SelectionButton1:Disable();
		end
		if(not Import_MapMod) then
			MetaMap_SelectionButton2:Disable();
		end
	elseif(mode == 3) then
		MetaMap_SelectionButton1:SetText(MMCVT_USERWKB);
		MetaMap_SelectionButton2:SetText(MMCVT_USERNOTES);
		MetaMap_SelectionButton3:SetText(MMCVT_QSTH);
		MetaMap_SelectionButton4:SetText(MMCVT_QST);
		if(not Import_UserWKB) then
			MetaMap_SelectionButton1:Disable();
		end
		if(not Import_UserNotes) then
			MetaMap_SelectionButton2:Disable();
		end
		if(not Import_QSTH) then
			MetaMap_SelectionButton3:Disable();
		end
		if(not Import_QST) then
			MetaMap_SelectionButton4:Disable();
		end
	elseif(mode == 4) then
		MetaMapBLT_ImportDefault();
		ShowFrame = false;
	end
	if(ShowFrame) then
		MetaMap_ConfirmationHeader:SetText(METAMAPBLT_CONFIRM_IMPORT);
		MetaMap_ConfirmationDialog:Show();
	end
end

function MetaMap_SelectedImport(mode)
	if(mode == MMCVT_MAPNOTES) then
		MetaMap_ImportMapNotes();
	elseif(mode == MMCVT_MAPMOD) then
		MetaMap_ImportMapMod();
	elseif(mode == MMCVT_USERWKB) then
		MetaMap_ImportUserWKB();
	elseif(mode == MMCVT_USERNOTES) then
		MetaMap_ImportMetaNotes();
	elseif(mode == MMCVT_BLT) then
		MetaMapBLT_ImportDefault();
	elseif(mode == MMCVT_QSTH) then
		MetaMap_ImportQuestHistory();
	elseif(mode == MMCVT_QST) then
		MetaMap_ImportQuestBase();
	end
	MetaMap_ConfirmationDialog:Hide();
end

function Import_MetaMapData()
	MetaMap_TempData = {};
	MetaMap_TempData[0] = MetaMapNotes_Data[0];
	MetaMapNotes_Data[0] = {};
	MetaMapNotes_Data[0] = MetaMap_NoteData[0];
	for zone, zoneTable in MetaMap_TempData[0] do
		for index, value in MetaMap_TempData[0][zone] do
			local oldData = MetaMap_TempData[0][zone][index];
			if(oldData["lootid"] == nil) then
				MetaMapNotes_AddNewNote(0, zone, oldData.xPos, oldData.yPos, oldData.name, oldData.inf1, oldData.inf2, oldData.creator, oldData.icon, oldData.ncol, oldData.in1c, oldData.in2c)
			end
		end
	end
	for i=1, 2, 1 do
		for zone, zoneTable in MetaMapNotes_Data[i] do
			for index, value in MetaMapNotes_Data[i][zone] do
				if(MetaMapNotes_Data[i][zone][index]["lootid"] ~= nil) then
					MetaMapNotes_Data[i][zone][index] = nil;
				end
			end
		end
	end
	for i=1, 2, 1 do
		for zone, zoneTable in MetaMap_WorldNoteData[i] do
			for index, value in MetaMap_WorldNoteData[i][zone] do
				local shiftedZone = MetaMapNotes_ZoneShift[i][zone];
				MetaMapNotes_Data[i][shiftedZone][index] = value;
			end
		end
	end
	MetaMapNotes_MapUpdate();
	MetaMap_OptionsInfo:SetText("默认副本数据导入成功");
end

function MetaMap_ImportMapNotes()
	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	local newCheck = false;
	for continent=1, 2, 1 do
		for zone, zoneTable in MapNotes_Data[continent] do
			for i, value in MapNotes_Data[continent][zone] do
				noteTotal = noteTotal +1;
				local newNote = MapNotes_Data[continent][zone][i];
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.xPos, newNote.yPos, newNote.name, newNote.inf1, newNote.inf2, newNote.creator, newNote.icon, newNote.ncol, newNote.in1c, newNote.in2c)
				if(newCheck) then
					noteImport = noteImport +1;
					local zoneTable = MapNotes_Lines[continent][zone]
					for i, value in zoneTable do
						if(zoneTable[i].x1 == newNote.xPos and zoneTable[i].y1 == newNote.yPos) then
							MetaMapNotes_ToggleLine(continent, zone, zoneTable[i].x1, zoneTable[i].y1, zoneTable[i].x2, zoneTable[i].y2)
						end
					end
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "已从MapNotes导入 "..noteImport.." 标记总共 "..noteTotal.." 其中 "..noteDupe.." 重复的未导入";
	MetaMap_OptionsInfo:SetText(msg);
end

function MetaMap_ImportMapMod()
	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	for zoneName in CT_UserMap_Notes do
		for index in CT_UserMap_Notes[zoneName] do
			noteTotal = noteTotal +1;
			if(CT_UserMap_Notes[zoneName][index].set < 6) then
				local newNote = CT_UserMap_Notes[zoneName][index];
				local continent, zone = MetaMap_NameToZoneID(zoneName, 1);
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.x, newNote.y, newNote.name, newNote.descript, "", UnitName("Player"), newNote.set, newNote.set, 0, 0)
				if(newCheck) then
					noteImport = noteImport +1;
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "已从MapMod导入 "..noteImport.." 个标记总共 "..noteTotal.." 其中 "..noteDupe.." 位置已经被占用";
	MetaMap_OptionsInfo:SetText(msg);
end

function MetaMapBLT_ImportDefault()
	LoadAddOn("MetaMapBLT");
	if(not IsAddOnLoaded("MetaMapBLT")) then
		MetaMap_OptionsInfo:SetText(METAMAPBLT_NOT_ENABLED);
		return;
	end
	MetaMapBLTData = {};
	MetaMapBLTData = MetaMapBLTDefaultData;
	MetaMap_OptionsInfo:SetText(METAMAPBLT_IMPORT_DONE);
end

function MetaMap_ImportUserWKB()
	MetaMap_TempData[MetaKB_dbID] = {};
	local totalCount = 0;
	local importCount = 0;
	local dupeCount = 0;
	local unknownCount = 0;
	for import, continentTable in MyKB_Data[MetaKB_dbID] do
		if(MetaKB_Data[MetaKB_dbID][import]) then
			dupeCount = dupeCount +1;
		else
			MetaMap_TempData[MetaKB_dbID][import] = continentTable;
			importCount = importCount +1;
		end
		totalCount = totalCount +1;
	end
	for index in MetaMap_TempData[MetaKB_dbID] do
		MetaKB_Data[MetaKB_dbID][index] = MetaMap_TempData[MetaKB_dbID][index];
	end
	MetaMapWKB_VerifyData();
	MetaMap_TempData = {};
	MetaMap_OptionsInfo:SetText(format(METAKB_IMPORT_SUCCESSFUL, importCount, totalCount, unknownCount, dupeCount));
end

function MetaMap_ImportMetaNotes()
	if(MyNotes_Data and MyNotes_Data.__canonical) then
		local noteTotal = MetaMapCVT_CountCanonicalNotes(MyNotes_Data);
		local noteImport = 0;
		local noteDupe = 0;
		local newCheck = false;
		for mapId, noteTable in MyNotes_Data.__canonical do
			local continent, zone = MetaMapCVT_MapRegistry:GetClientZone(tonumber(mapId));
			local lineTable = nil;
			if(MyLines_Data and MyLines_Data.__canonical) then
				lineTable = MyLines_Data.__canonical[mapId];
			end
			if(continent and zone and continent > 0 and zone > 0) then
				for i, value in noteTable do
					local newNote = noteTable[i];
					newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.xPos, newNote.yPos, newNote.name, newNote.inf1, newNote.inf2, newNote.creator, newNote.icon, newNote.ncol, newNote.in1c, newNote.in2c)
					if(newCheck) then
						noteImport = noteImport +1;
						if(lineTable) then
							for lineIndex, lineData in lineTable do
								if(lineData.x1 == newNote.xPos and lineData.y1 == newNote.yPos) then
									MetaMapNotes_ToggleLine(continent, zone, lineData.x1, lineData.y1, lineData.x2, lineData.y2)
								end
							end
						end
					else
						noteDupe = noteDupe +1;
					end
				end
			end
		end
			MetaMap_OptionsInfo:SetText("Imported "..noteImport.." MetaNotes notes out of "..noteTotal.." total; "..noteDupe.." duplicates were skipped.");
		return;
	end

	local noteTotal = 0;
	local noteImport = 0;
	local noteDupe = 0;
	local newCheck = false;
	for continent=1, 2, 1 do
		for zone, zoneTable in MyNotes_Data[continent] do
			for i, value in MyNotes_Data[continent][zone] do
				noteTotal = noteTotal +1;
				local newNote = MyNotes_Data[continent][zone][i];
				newCheck = MetaMapNotes_AddNewNote(continent, zone, newNote.xPos, newNote.yPos, newNote.name, newNote.inf1, newNote.inf2, newNote.creator, newNote.icon, newNote.ncol, newNote.in1c, newNote.in2c)
				if(newCheck) then
					noteImport = noteImport +1;
					local zoneTable = MyLines_Data[continent][zone]
					for i, value in zoneTable do
						if(zoneTable[i].x1 == newNote.xPos and zoneTable[i].y1 == newNote.yPos) then
							MetaMapNotes_ToggleLine(continent, zone, zoneTable[i].x1, zoneTable[i].y1, zoneTable[i].x2, zoneTable[i].y2)
						end
					end
				else
					noteDupe = noteDupe +1;
				end
			end
		end
	end
	local msg = "已从MetaNotes导入 "..noteImport.." 个标记总共 "..noteTotal.." 其中 "..noteDupe.." 重复的未导入";
	MetaMap_OptionsInfo:SetText(msg);
end

function MetaMap_ImportQuestHistory()
	local total = 0;
	local imported = 0;
	local dupe = 0;
	local noinfo = 0;
	local newfound = true;
	for realm, playerTable in QuestHistory_List do
		for player, questTable in playerTable do
			for index, quest in questTable do
				total = total +1;
				if(not quest.t or not quest.o or not quest.l or not quest.c) then
					noinfo = noinfo +1;
					newfound = false;
				else
					for qIndex, value in QST_QuestBase do
						if(quest.c == value.qTitle and quest.o == value.qObj) then
							dupe = dupe +1;
							newfound = false;
							break;
						end
					end
				end
				if(newfound) then
					local n = table.getn(QST_QuestBase)+1;
					QST_QuestBase[n] = {};
					local qData = QST_QuestBase[n];
					local status = QST_OVERVIEWCOLOUR..QST_QUEST_UNKNOWN;
					if(quest.tc) then
						status = QST_COMPLETEDCOLOUR..QST_QUEST_DONE;
					elseif(quest.a) then
						status = QST_INITIALCOLOUR..QST_QUEST_ABANDON;
					elseif(quest.f) then
						status = QST_INITIALCOLOUR..QST_QUEST_FAILED;
					end
					qData["qPlayer"] = {};
					qData["qPlayer"][player.." of "..realm] = {};
					qData["qPlayer"][player.." of "..realm]["qStatus"] = status;
					qData["qTitle"] = quest.t;
					qData["qObj"] = quest.o;
					qData["qLevel"] = quest.l;
					qData["qZone"] = quest.c;
					qData["qTag"] = quest.y;
					qData["qNPC"] = {};
					qData["qNote"] = "";
					if(QST_Options.SaveDesc) then
						qData["qDesc"] = quest.d;
					end
					if(quest.m) then
						qData["qMoney"] = quest.m;
					else
						qData["qMoney"] = 0;
					end
					if(quest.n) then
						qData["qNote"] = quest.n;
					end
					if(quest.os) then
						qData["qItems"] = {};
						for i, items in quest.os do
							qData["qItems"][i] = items.t;
						end
					end
					if(quest.r and QST_Options.SaveRew) then
						qData["qReward"] = {};
						for i, items in quest.r do
							qData["qReward"][i] = {};
							qData["qReward"][i]["qLink"] = items.l;
							qData["qReward"][i]["qTex"] = items.t;
							qData["qReward"][i]["qAmount"] = items.a;
						end
					end
					if(quest.i and QST_Options.SaveRew) then
						qData["qChoice"] = {};
						for i, items in quest.i do
							qData["qChoice"][i] = {};
							qData["qChoice"][i]["qLink"] = items.l;
							qData["qChoice"][i]["qTex"] = items.t;
							qData["qChoice"][i]["qAmount"] = items.a;
						end
					end
					if(quest.s and QST_Options.SaveRew) then
						qData["qSpell"] = {};
						for i, items in quest.s do
							qData["qSpell"][i] = {};
							qData["qSpell"][i]["qLink"] = items.l;
							qData["qSpell"][i]["qTex"] = items.t;
							qData["qSpell"][i]["qAmount"] = items.a;
						end
					end
					if(quest.g) then
						qData["qNPC"][1] = {};
						qData["qNPC"][1]["qName"] = quest.g;
						qData["qNPC"][1]["qZone"] = quest.az;
						qData["qNPC"][1]["qX"] = quest.ax;
						qData["qNPC"][1]["qY"] = quest.ay;
					end
					if(quest.w) then
						qData["qNPC"][2] = {};
						qData["qNPC"][2]["qName"] = quest.g;
						qData["qNPC"][2]["qZone"] = quest.cz;
						qData["qNPC"][2]["qX"] = quest.cx;
						qData["qNPC"][2]["qY"] = quest.cy;
					end
					if(quest.tl) then
						local y, z, d, h, m, s = string.find(quest.tl, "(%d+)%s*[:]%s*(%d+)%s*[:]%s*(%d+)%s*[:]%s*(%d+)%s*");
						qData["qLogged"] = time() - (d * 79200)+(h * 3600)+(m * 60)+s;
					else
						qData["qLogged"] = GetTime();
					end
					if(quest.tc) then
						local y, z, d, h, m, s = string.find(quest.tl, "(%d+)%s*[:]%s*(%d+)%s*[:]%s*(%d+)%s*[:]%s*(%d+)%s*");
						qData["qEnded"] = time() - (d * 79200)+(h * 3600)+(m * 60)+s;
					else
						qData["qEnded"] = GetTime();
					end
					imported = imported +1;
				end
				newfound = true;
			end
		end
	end
	local msg = "导入 "..imported.." 个任务总共 "..total.." 其中 "..dupe.." 个重复的未导入。"..noinfo.." 个条目缺乏数据被丢弃。";
	MetaMap_OptionsInfo:SetText(msg);
end

function MetaMap_ImportQuestBase()
	local total = 0;
	local imported = 0;
	local dupe = 0;
	local updated = 0;
	for index, qData2 in MyQST_QuestBase do
		total = total +1;
		local qData1 = QST_QuestBase[index];
		if(qData1.qTitle == qData2.qTitle and qData1.qObj == qData2.qObj) then
			if((qData2.qNPC[1] and not qData1.qNPC[1]) or (qData2.qNPC[2] and not qData1.qNPC[2]) or strlen(qData2.qNote) > 0) then
				if(qData2.qNPC[1]) then
					qData1.qNPC[1] = qData2.qNPC[1];
				end
				if(qData2.qNPC[2]) then
					qData1.qNPC[2] = qData2.qNPC[2];
				end
				if(strlen(qData2.qNote) > 0) then
					qData1.qNote = qData1.qNote.."\n\n"..qData2.qNote;
				end
				updated = updated +1;
			else
				dupe = dupe +1;
			end
		else
			QST_QuestBase[index] = qData2;
			QST_QuestBase[index]["qPlayer"] = {};
			imported = imported +1;
		end
	end
	local msg = "导入 "..imported.." 个任务总共 "..total.." 其中 "..dupe.." 个重复的未导入，以及 "..updated.." 任务被更新";
	MetaMap_OptionsInfo:SetText(msg);
end
