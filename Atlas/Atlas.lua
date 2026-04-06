--Atlas, an instance map browser
--Author: Dan Gilbert
--Email: loglow@gmail.com
--AIM: dan5981
ATLAS_VERSION = "1.8.4";
ATLAS_DATE = "October 21, 2006";

--myAddOns data goes here
AtlasDetails = {
	name = "Atlas",
	version = ATLAS_VERSION,
	releaseDate = ATLAS_DATE,
	author = "Dan Gilbert",
	email = "loglow@gmail.com",
	website = "http://www.atlasmod.com/",
	optionsframe = "AtlasOptionsFrame",
	category = MYADDONS_CATEGORY_MAP
};

local Atlas_Vars_Loaded = nil;
ATLAS_DROPDOWN_LIST = {};
ATLAS_DROPDOWN_LIST_BG = {};
ATLAS_DROPDOWN_LIST_FP = {};
ATLAS_DROPDOWN_LIST_DL = {};
ATLAS_DROPDOWN_LIST_RE = {};

local DefaultAtlasOptions = {
	["AtlasVersion"] = ATLAS_VERSION;
	["AtlasZone"] = 1;
	["AtlasAlpha"] = 1.0;
	["AtlasLocked"] = false;
	["AtlasMapName"] = true;
	["AtlasAutoSelect"] = false;
	["AtlasButtonPosition"] = 268;
	["AtlasButtonShown"] = true;
	["AtlasReplaceWorldMap"] = false;
	["AtlasRightClick"] = false;
	["AtlasType"] = 1;
	["AtlasAcronyms"] = true;
};

local ATLAS_GENERATED_TEXTURE_PATH_PREFIX = "Interface\\AddOns\\Atlas\\Generated\\Images\\";
local ATLAS_GENERATED_RUNTIME_SIZE = 512;
local ATLAS_GENERATED_SOURCE_WIDTH = 1024;
local ATLAS_GENERATED_SOURCE_HEIGHT = 768;
local ATLAS_GENERATED_CONTENT_WIDTH = 1002;
local ATLAS_GENERATED_CONTENT_HEIGHT = 668;
local ATLAS_GENERATED_CONTENT_RUNTIME_WIDTH = (ATLAS_GENERATED_CONTENT_WIDTH * ATLAS_GENERATED_RUNTIME_SIZE) / ATLAS_GENERATED_SOURCE_WIDTH;
local ATLAS_GENERATED_CONTENT_RUNTIME_HEIGHT = (ATLAS_GENERATED_CONTENT_HEIGHT * ATLAS_GENERATED_RUNTIME_SIZE) / ATLAS_GENERATED_SOURCE_WIDTH;
local ATLAS_GENERATED_CONTENT_RUNTIME_OFFSET_Y = (ATLAS_GENERATED_RUNTIME_SIZE - ((ATLAS_GENERATED_SOURCE_HEIGHT * ATLAS_GENERATED_RUNTIME_SIZE) / ATLAS_GENERATED_SOURCE_WIDTH)) / 2;
local ATLAS_MAP_PREVIEW_WIDTH = 512;
local ATLAS_MAP_PREVIEW_HEIGHT = 512;
local ATLAS_MAP_PREVIEW_OFFSET_X = 18;
local ATLAS_MAP_PREVIEW_OFFSET_Y = -84;

local function Atlas_IsGeneratedRuntimeTexture(texturePath)
	return texturePath and string.find(texturePath, ATLAS_GENERATED_TEXTURE_PATH_PREFIX, 1, true);
end

local function Atlas_GetDropdownListForType(mapType)
	if ( mapType == 1 ) then
		return ATLAS_DROPDOWN_LIST;
	elseif ( mapType == 2 ) then
		return ATLAS_DROPDOWN_LIST_BG;
	elseif ( mapType == 3 ) then
		return ATLAS_DROPDOWN_LIST_FP;
	elseif ( mapType == 4 ) then
		return ATLAS_DROPDOWN_LIST_DL;
	elseif ( mapType == 5 ) then
		return ATLAS_DROPDOWN_LIST_RE;
	end
	return nil;
end

local function Atlas_GetPageInfo(pageID)
	if ( AtlasGeneratedMaps and AtlasGeneratedMaps.pages ) then
		return AtlasGeneratedMaps.pages[pageID];
	end
	return nil;
end

local function Atlas_GetLegacyTextTable(category)
	if ( category == 1 ) then
		return AtlasText;
	elseif ( category == 2 ) then
		return AtlasBG;
	elseif ( category == 3 ) then
		return AtlasFP;
	elseif ( category == 4 ) then
		return AtlasDL;
	elseif ( category == 5 ) then
		return AtlasRE;
	end
	return nil;
end

local function Atlas_GetGeneratedLocaleAtlasData()
	if ( not AtlasGeneratedLocales ) then
		return nil;
	end

	local locale = GetLocale();
	local payload = AtlasGeneratedLocales[locale];
	if ( payload and payload["atlas"] and next(payload["atlas"]) ) then
		return payload["atlas"];
	end

	payload = AtlasGeneratedLocales["enUS"];
	if ( payload and payload["atlas"] ) then
		return payload["atlas"];
	end

	return nil;
end

local function Atlas_RegisterGeneratedLocaleEntry(pageID, page, generatedText)
	local legacyTable = Atlas_GetLegacyTextTable(page.category);
	if ( not legacyTable or not generatedText ) then
		return;
	end

	local entry = {
		ZoneName = generatedText["ZoneName"] or page.source_key or page.map_file or tostring(pageID);
		Acronym = generatedText["Acronym"];
		Location = generatedText["Location"] or "---";
		LevelRange = generatedText["LevelRange"] or "---";
		PlayerLimit = generatedText["PlayerLimit"] or "---";
	};

	local lines = generatedText["lines"];
	if ( type(lines) == "table" ) then
		for i = 1, getn(lines), 1 do
			entry[i] = lines[i];
		end
	end

	if ( page.source_key ) then
		legacyTable[page.source_key] = entry;
	end
	legacyTable[pageID] = entry;
end

local function Atlas_ApplyGeneratedLocales()
	local generatedAtlas = Atlas_GetGeneratedLocaleAtlasData();
	if ( not generatedAtlas or not AtlasGeneratedMaps or not AtlasGeneratedMaps.pages ) then
		return;
	end

	for pageID, page in pairs(AtlasGeneratedMaps.pages) do
		local generatedText = nil;
		if ( page.source_key and generatedAtlas[page.source_key] ) then
			generatedText = generatedAtlas[page.source_key];
		elseif ( page.map_file and generatedAtlas[page.map_file] ) then
			generatedText = generatedAtlas[page.map_file];
		elseif ( generatedAtlas[pageID] ) then
			generatedText = generatedAtlas[pageID];
		end

		if ( generatedText ) then
			Atlas_RegisterGeneratedLocaleEntry(pageID, page, generatedText);
		end
	end
end

local function Atlas_GetPageTextEntry(category, pageID, page)
	local legacyTable = Atlas_GetLegacyTextTable(category);
	if ( not legacyTable ) then
		return nil;
	end
	if ( legacyTable[pageID] ) then
		return legacyTable[pageID];
	end
	if ( page and page.source_key and legacyTable[page.source_key] ) then
		return legacyTable[page.source_key];
	end
	if ( page and page.map_file and legacyTable[page.map_file] ) then
		return legacyTable[page.map_file];
	end
	return nil;
end

local function Atlas_GetPageDisplayName(category, pageID)
	local page = Atlas_GetPageInfo(pageID);
	local entry = Atlas_GetPageTextEntry(category, pageID, page);
	if ( entry and entry["ZoneName"] ) then
		return entry["ZoneName"];
	end
	if ( page and page.source_key ) then
		return page.source_key;
	end
	if ( page and page.map_file ) then
		return page.map_file;
	end
	return tostring(pageID);
end

local function Atlas_GetSelectedPageID()
	local dropList = Atlas_GetDropdownListForType(AtlasOptions.AtlasType);
	if ( not dropList or getn(dropList) == 0 ) then
		return nil;
	end

	if ( AtlasOptions.AtlasMapID ) then
		for i = 1, getn(dropList), 1 do
			if ( dropList[i] == AtlasOptions.AtlasMapID ) then
				AtlasOptions.AtlasZone = i;
				return AtlasOptions.AtlasMapID;
			end
		end
	end

	if ( AtlasOptions.AtlasZone and dropList[AtlasOptions.AtlasZone] ) then
		AtlasOptions.AtlasMapID = dropList[AtlasOptions.AtlasZone];
		return AtlasOptions.AtlasMapID;
	end

	AtlasOptions.AtlasZone = 1;
	AtlasOptions.AtlasMapID = dropList[1];
	return AtlasOptions.AtlasMapID;
end

local function Atlas_SetSelectedPageID(pageID)
	local page = Atlas_GetPageInfo(pageID);
	if ( not page ) then
		return nil;
	end

	local dropList = Atlas_GetDropdownListForType(page.category);
	if ( not dropList ) then
		return nil;
	end

	AtlasOptions.AtlasType = page.category;
	for i = 1, getn(dropList), 1 do
		if ( dropList[i] == pageID ) then
			AtlasOptions.AtlasZone = i;
			AtlasOptions.AtlasMapID = pageID;
			return pageID;
		end
	end

	return nil;
end

local function Atlas_GetTextureForPage(pageID)
	local page = Atlas_GetPageInfo(pageID);
	if ( page and page.texture_path ) then
		return page.texture_path, page.texture_width, page.texture_height;
	end
	if ( page and page.texture ) then
		return "Interface\\AddOns\\Atlas\\Images\\"..page.texture, nil, nil;
	end
	return nil, nil, nil;
end

function Atlas_FreshOptions()
	AtlasOptions = CloneTable(DefaultAtlasOptions);
end

--Code by Grayhoof (SCT)
function CloneTable(t)				-- return a copy of the table t
	local new = {};					-- create a new table
	local i, v = next(t, nil);		-- i is an index of t, v = t[i]
	while i do
		if type(v)=="table" then 
			v=CloneTable(v);
		end 
		new[i] = v;
		i, v = next(t, i);			-- get next index
	end
	return new;
end

--Called when the Atlas frame is first loaded
--We CANNOT assume that data in other files is available yet!
function Atlas_OnLoad()

	--Register the Atlas frame for the following events
	this:RegisterEvent("ADDON_LOADED");
	this:RegisterEvent("VARIABLES_LOADED");

	--Allows Atlas to be closed with the Escape key
	tinsert(UISpecialFrames, "AtlasFrame");
	AtlasMapBackground:SetTexture(0.05, 0.05, 0.05, 1.0);
	AtlasMapBackground:SetDrawLayer("BACKGROUND", 0);
	AtlasMap:SetDrawLayer("ARTWORK", 0);
	
	--Dragging involves some special registration
	AtlasFrame:RegisterForDrag("LeftButton");
	
	--Setting up slash commands involves referencing some strage auto-generated variables
	SLASH_ATLAS1 = ATLAS_SLASH;
	SlashCmdList["ATLAS"] = function(msg)
		Atlas_SlashCommand(msg);
	end
end

--Removal of articles in map names (for proper alphabetic sorting)
--For example: "The Deadmines" will become "Deadmines"
--Thus it will be sorted under D and not under T
local function Atlas_SanitizeName(text)
   text = string.lower(text);
   if (AtlasSortIgnore) then
	   for _,v in AtlasSortIgnore do
		   local match = string.gfind(text, v)();
		   if (match) and ((string.len(text) - string.len(match)) <= 4) then
			   return match;
		   end
	   end
   end
   return text;
end

--Comparator function for alphabetic sorting of maps
local function Atlas_SortZonesAlpha(a, b)
	local aa = Atlas_SanitizeName(Atlas_GetPageDisplayName(1, a));
	local bb = Atlas_SanitizeName(Atlas_GetPageDisplayName(1, b));
	return aa < bb;
end

--Comparator function for alphabetic sorting of BG maps
local function Atlas_SortZonesAlphaBG(a, b)
	local aa = Atlas_SanitizeName(Atlas_GetPageDisplayName(2, a));
	local bb = Atlas_SanitizeName(Atlas_GetPageDisplayName(2, b));
	return aa < bb;
end

--Comparator function for alphabetic sorting of FP maps
local function Atlas_SortZonesAlphaFP(a, b)
	local aa = Atlas_SanitizeName(Atlas_GetPageDisplayName(3, a));
	local bb = Atlas_SanitizeName(Atlas_GetPageDisplayName(3, b));
	return aa < bb;
end

--Comparator function for alphabetic sorting of DL maps
local function Atlas_SortZonesAlphaDL(a, b)
	local aa = Atlas_SanitizeName(Atlas_GetPageDisplayName(4, a));
	local bb = Atlas_SanitizeName(Atlas_GetPageDisplayName(4, b));
	return aa < bb;
end

--Comparator function for alphabetic sorting of RE maps
local function Atlas_SortZonesAlphaRE(a, b)
	local aa = Atlas_SanitizeName(Atlas_GetPageDisplayName(5, a));
	local bb = Atlas_SanitizeName(Atlas_GetPageDisplayName(5, b));
	return aa < bb;
end

--These are the REAL level range values!
--Overrides the values that may be found in the localization files
function Atlas_UpdateLevelRanges()
	AtlasText.BlackfathomDeeps.LevelRange =		"24-32";
	AtlasText.BlackrockSpireLower.LevelRange =	"55-60";
	AtlasText.BlackrockSpireUpper.LevelRange =	"55-60";
	AtlasText.BlackrockDepths.LevelRange =		"52-60";
	AtlasText.ShadowfangKeep.LevelRange =		"22-30";
	AtlasText.ScarletMonastery.LevelRange =		"34-45";
	AtlasText.MoltenCore.LevelRange =			"60+";
	AtlasText.TheSunkenTemple.LevelRange =		"50-60";
	AtlasText.WailingCaverns.LevelRange =		"17-24";
	AtlasText.TheStockade.LevelRange =			"24-32";
	AtlasText.TheDeadmines.LevelRange =			"17-26";
	AtlasText.DireMaulNorth.LevelRange =		"56-60";
	AtlasText.DireMaulEast.LevelRange =			"56-60";
	AtlasText.DireMaulWest.LevelRange =			"56-60";
	AtlasText.Gnomeregan.LevelRange =			"29-38";
	AtlasText.RazorfenDowns.LevelRange =		"37-46";
	AtlasText.RazorfenKraul.LevelRange =		"29-38";
	AtlasText.Maraudon.LevelRange =				"46-55";
	AtlasText.OnyxiasLair.LevelRange =			"60+";
	AtlasText.BlackwingLair.LevelRange =		"60+";
	AtlasText.RagefireChasm.LevelRange =		"13-18";
	AtlasText.Scholomance.LevelRange =			"58-60";
	AtlasText.Stratholme.LevelRange =			"58-60";
	AtlasText.Uldaman.LevelRange =				"41-51";
	AtlasText.ZulFarrak.LevelRange =			"44-54";
	AtlasText.ZulGurub.LevelRange =				"60+";
	AtlasText.TheTempleofAhnQiraj.LevelRange =	"60+";
	AtlasText.TheRuinsofAhnQiraj.LevelRange =	"60+";
	AtlasText.Naxxramas.LevelRange =			"60+";
	AtlasBG.AlteracValleyNorth.LevelRange =		"51-60";
	AtlasBG.AlteracValleySouth.LevelRange =		"51-60";
	AtlasBG.ArathiBasin.LevelRange =			"20-60";
	AtlasBG.WarsongGulch.LevelRange =			"10-60";
	AtlasFP.FPAllianceEast.LevelRange =			"---";
	AtlasFP.FPAllianceWest.LevelRange =			"---";
	AtlasFP.FPHordeEast.LevelRange =			"---";
	AtlasFP.FPHordeWest.LevelRange =			"---";
	AtlasDL.DLEast.LevelRange =					"---";
	AtlasDL.DLWest.LevelRange =					"---";
	AtlasRE.Azuregos.LevelRange =				"60+";
	AtlasRE.FourDragons.LevelRange =			"60+";
	AtlasRE.Kazzak.LevelRange =					"60+";
	AtlasText.HCBloodFurnaces.LevelRange =		"61-63";
	AtlasText.HCShatteredHalls.LevelRange =		"70-72";
end

--These are the REAL player limit values!
--Overrides the values that may be found in the localization files
function Atlas_UpdatePlayerLimits()
	AtlasText.BlackfathomDeeps.PlayerLimit =	"10";
	AtlasText.BlackrockSpireLower.PlayerLimit =	"10";
	AtlasText.BlackrockSpireUpper.PlayerLimit =	"10";
	AtlasText.BlackrockDepths.PlayerLimit =		"5";
	AtlasText.ShadowfangKeep.PlayerLimit =		"10";
	AtlasText.ScarletMonastery.PlayerLimit =	"10";
	AtlasText.MoltenCore.PlayerLimit =			"40";
	AtlasText.TheSunkenTemple.PlayerLimit =		"10";
	AtlasText.WailingCaverns.PlayerLimit =		"10";
	AtlasText.TheStockade.PlayerLimit =			"10";
	AtlasText.TheDeadmines.PlayerLimit =		"10";
	AtlasText.DireMaulNorth.PlayerLimit =		"5";
	AtlasText.DireMaulEast.PlayerLimit =		"5";
	AtlasText.DireMaulWest.PlayerLimit =		"5";
	AtlasText.Gnomeregan.PlayerLimit =			"10";
	AtlasText.RazorfenDowns.PlayerLimit =		"10";
	AtlasText.RazorfenKraul.PlayerLimit =		"10";
	AtlasText.Maraudon.PlayerLimit =			"10";
	AtlasText.OnyxiasLair.PlayerLimit =			"40";
	AtlasText.BlackwingLair.PlayerLimit =		"40";
	AtlasText.RagefireChasm.PlayerLimit =		"10";
	AtlasText.Scholomance.PlayerLimit =			"5";
	AtlasText.Stratholme.PlayerLimit =			"5";
	AtlasText.Uldaman.PlayerLimit =				"10";
	AtlasText.ZulFarrak.PlayerLimit =			"10";
	AtlasText.ZulGurub.PlayerLimit =			"20";
	AtlasText.TheTempleofAhnQiraj.PlayerLimit =	"40";
	AtlasText.TheRuinsofAhnQiraj.PlayerLimit =	"20";
	AtlasText.Naxxramas.PlayerLimit =			"40";
	AtlasBG.AlteracValleyNorth.PlayerLimit =	"40";
	AtlasBG.AlteracValleySouth.PlayerLimit =	"40";
	AtlasBG.ArathiBasin.PlayerLimit =			"15";
	AtlasBG.WarsongGulch.PlayerLimit =			"10";
	AtlasFP.FPAllianceEast.PlayerLimit =		"---";
	AtlasFP.FPAllianceWest.PlayerLimit =		"---";
	AtlasFP.FPHordeEast.PlayerLimit =			"---";
	AtlasFP.FPHordeWest.PlayerLimit =			"---";
	AtlasDL.DLEast.PlayerLimit =				"---";
	AtlasDL.DLWest.PlayerLimit =				"---";
	AtlasRE.Azuregos.PlayerLimit =				"40";
	AtlasRE.FourDragons.PlayerLimit =			"40";
	AtlasRE.Kazzak.PlayerLimit =				"40";
	AtlasText.HCBloodFurnaces.PlayerLimit =		"5";
	AtlasText.HCShatteredHalls.PlayerLimit =	"5";
end

--Main Atlas event handler
function Atlas_OnEvent()

	if (event == "ADDON_LOADED") then
		if (strlower(arg1) == "atlas") then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	elseif (event == "VARIABLES_LOADED") then
		if (not Atlas_Vars_Loaded) then
			Atlas_Vars_Loaded = 1;
			Atlas_Init();
		end
	end
	
end

--Initializes everything relating to saved variables and data in other lua files
--This should be called ONLY when we're sure that all other files have been loaded
function Atlas_Init()

	if ( AtlasOptions == nil or AtlasOptions["AtlasVersion"] ~= ATLAS_VERSION) then
		Atlas_FreshOptions();
	end

	ATLAS_DROPDOWN_LIST = {};
	ATLAS_DROPDOWN_LIST_BG = {};
	ATLAS_DROPDOWN_LIST_FP = {};
	ATLAS_DROPDOWN_LIST_DL = {};
	ATLAS_DROPDOWN_LIST_RE = {};

	if ( not AtlasGeneratedMaps or not AtlasGeneratedMaps.categories ) then
		error("AtlasGeneratedMaps is required for Atlas initialization.");
	end

	for _, pageID in ipairs(AtlasGeneratedMaps.categories[1] or {}) do
		table.insert(ATLAS_DROPDOWN_LIST, pageID);
	end
	for _, pageID in ipairs(AtlasGeneratedMaps.categories[2] or {}) do
		table.insert(ATLAS_DROPDOWN_LIST_BG, pageID);
	end
	for _, pageID in ipairs(AtlasGeneratedMaps.categories[3] or {}) do
		table.insert(ATLAS_DROPDOWN_LIST_FP, pageID);
	end
	for _, pageID in ipairs(AtlasGeneratedMaps.categories[4] or {}) do
		table.insert(ATLAS_DROPDOWN_LIST_DL, pageID);
	end
	for _, pageID in ipairs(AtlasGeneratedMaps.categories[5] or {}) do
		table.insert(ATLAS_DROPDOWN_LIST_RE, pageID);
	end

	Atlas_ApplyGeneratedLocales();

	--Update the level ranges and player limits
	--Overrides the values in the localization files because I'm too lazy to change them all
	--It's also nice to have all the these figures come from only one place
	Atlas_UpdateLevelRanges();
	Atlas_UpdatePlayerLimits();
	
	--Sort the lists of maps alphabetically
	table.sort(ATLAS_DROPDOWN_LIST, Atlas_SortZonesAlpha);
	table.sort(ATLAS_DROPDOWN_LIST_BG, Atlas_SortZonesAlphaBG);
	table.sort(ATLAS_DROPDOWN_LIST_FP, Atlas_SortZonesAlphaFP);
	table.sort(ATLAS_DROPDOWN_LIST_DL, Atlas_SortZonesAlphaDL);
	table.sort(ATLAS_DROPDOWN_LIST_RE, Atlas_SortZonesAlphaRE);
	
	--Now that saved variables have been loaded, update everything accordingly
	Atlas_Refresh();
	AtlasOptions_Init();
	Atlas_UpdateLock();
	AtlasButton_UpdatePosition();
	Atlas_UpdateAlpha();
	
	--myAddOns support
	if(myAddOnsFrame_Register) then
		myAddOnsFrame_Register(AtlasDetails);
	end

	--Cosmos integration
	if(EarthFeature_AddButton) then
		EarthFeature_AddButton(
		{
			id = ATLAS_TITLE;
			name = ATLAS_TITLE;
			subtext = ATLAS_SUBTITLE;
			tooltip = ATLAS_DESC;
			icon = "Interface\\AddOns\\Atlas\\Images\\AtlasIcon";
			callback = Atlas_Toggle;
			test = nil;
		}
	);
	elseif(Cosmos_RegisterButton) then
		Cosmos_RegisterButton(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			ATLAS_DESC,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			Atlas_Toggle
		);
	end
	
	--CTMod integration
	if(CT_RegisterMod) then
		CT_RegisterMod(
			ATLAS_TITLE,
			ATLAS_SUBTITLE,
			5,
			"Interface\\AddOns\\Atlas\\Images\\AtlasIcon",
			ATLAS_DESC,
			"switch",
			"",
			Atlas_Toggle
		);
	end
end

--Simple function to toggle the Atlas frame's lock status and update it's appearance
function Atlas_ToggleLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasOptions.AtlasLocked = false;
		Atlas_UpdateLock();
	else
		AtlasOptions.AtlasLocked = true;
		Atlas_UpdateLock();
	end
end

--Updates the appearance of the lock button based on the status of AtlasLocked
function Atlas_UpdateLock()
	if(AtlasOptions.AtlasLocked) then
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Locked-Down");
	else
		AtlasLockNorm:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Up");
		AtlasLockPush:SetTexture("Interface\\AddOns\\Atlas\\Images\\LockButton-Unlocked-Down");
	end
end

--Begin moving the Atlas frame if it's unlocked
function Atlas_StartMoving()
	if(not AtlasOptions.AtlasLocked) then
		AtlasFrame:StartMoving();
	end
end

--Parses slash commands
--If an unrecognized command is given, toggle Atlas
function Atlas_SlashCommand(msg)
	if(msg == ATLAS_SLASH_OPTIONS) then
		AtlasOptions_Toggle();
	else
		Atlas_Toggle();
	end
end

--Sets the transparency of the Atlas frame based on AtlasAlpha
function Atlas_UpdateAlpha()
	AtlasFrame:SetAlpha(AtlasOptions.AtlasAlpha);
end

--Simple function to toggle the visibility of the Atlas frame
function Atlas_Toggle()
	if(AtlasFrame:IsVisible()) then
		HideUIPanel(AtlasFrame);
	else
		ShowUIPanel(AtlasFrame);
	end
end

--Refreshes the Atlas frame, usually because a new map needs to be displayed
--The zoneID variable represents the internal name used for each map
--Also responsible for updating all the text when a map is changed
function Atlas_Refresh()
	local zoneID;
	
	--Just in case AtlasType hasn't been initialized
	--Added in response to a possible error
	if ( AtlasOptions.AtlasType == nil ) then
		AtlasOptions.AtlasType = 1;
	end
	
	if ( AtlasOptions.AtlasType == 1 ) then
		zoneID = Atlas_GetSelectedPageID();
	elseif ( AtlasOptions.AtlasType == 2 ) then
		zoneID = Atlas_GetSelectedPageID();
	elseif ( AtlasOptions.AtlasType == 3 ) then
		zoneID = Atlas_GetSelectedPageID();
	elseif ( AtlasOptions.AtlasType == 4 ) then
		zoneID = Atlas_GetSelectedPageID();
	elseif ( AtlasOptions.AtlasType == 5 ) then
		zoneID = Atlas_GetSelectedPageID();
	end
	if ( not zoneID ) then
		return;
	end

	local page = Atlas_GetPageInfo(zoneID);
	local pageText = Atlas_GetPageTextEntry(AtlasOptions.AtlasType, zoneID, page) or {};
	local texturePath, textureWidth, textureHeight = Atlas_GetTextureForPage(zoneID);
	if ( not texturePath ) then
		return;
	end

	local maxWidth = ATLAS_MAP_PREVIEW_WIDTH;
	local maxHeight = ATLAS_MAP_PREVIEW_HEIGHT;
	local drawWidth = maxWidth;
	local drawHeight = maxHeight;
	local texCoordLeft = 0;
	local texCoordRight = 1;
	local texCoordTop = 0;
	local texCoordBottom = 1;
	if ( Atlas_IsGeneratedRuntimeTexture(texturePath) ) then
		local scale = math.min(maxWidth / ATLAS_GENERATED_CONTENT_RUNTIME_WIDTH, maxHeight / ATLAS_GENERATED_CONTENT_RUNTIME_HEIGHT);
		drawWidth = math.floor(ATLAS_GENERATED_CONTENT_RUNTIME_WIDTH * scale + 0.5);
		drawHeight = math.floor(ATLAS_GENERATED_CONTENT_RUNTIME_HEIGHT * scale + 0.5);
		texCoordRight = ATLAS_GENERATED_CONTENT_RUNTIME_WIDTH / ATLAS_GENERATED_RUNTIME_SIZE;
		texCoordTop = ATLAS_GENERATED_CONTENT_RUNTIME_OFFSET_Y / ATLAS_GENERATED_RUNTIME_SIZE;
		texCoordBottom = (ATLAS_GENERATED_CONTENT_RUNTIME_OFFSET_Y + ATLAS_GENERATED_CONTENT_RUNTIME_HEIGHT) / ATLAS_GENERATED_RUNTIME_SIZE;
	elseif ( textureWidth and textureHeight and textureWidth > 0 and textureHeight > 0 ) then
		local scale = math.min(maxWidth / textureWidth, maxHeight / textureHeight);
		drawWidth = math.floor(textureWidth * scale + 0.5);
		drawHeight = math.floor(textureHeight * scale + 0.5);
	end
	local offsetX = ATLAS_MAP_PREVIEW_OFFSET_X + math.floor((maxWidth - drawWidth) / 2);
	local offsetY = ATLAS_MAP_PREVIEW_OFFSET_Y - math.floor((maxHeight - drawHeight) / 2);

	AtlasMapBackground:ClearAllPoints();
	AtlasMapBackground:SetWidth(maxWidth);
	AtlasMapBackground:SetHeight(maxHeight);
	AtlasMapBackground:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", ATLAS_MAP_PREVIEW_OFFSET_X, ATLAS_MAP_PREVIEW_OFFSET_Y);
	AtlasMap:ClearAllPoints();
	AtlasMap:SetWidth(drawWidth);
	AtlasMap:SetHeight(drawHeight);
	AtlasMap:SetPoint("TOPLEFT", "AtlasFrame", "TOPLEFT", offsetX, offsetY);
	AtlasMap:SetTexCoord(texCoordLeft, texCoordRight, texCoordTop, texCoordBottom);
	AtlasMap:SetTexture(texturePath);
	local ZoneNameText = pageText["ZoneName"] or Atlas_GetPageDisplayName(AtlasOptions.AtlasType, zoneID);
	if ( AtlasOptions.AtlasAcronyms and pageText["Acronym"] ~= nil) then
		local _RED = "|cffcc6666";
		ZoneNameText = ZoneNameText.._RED.." ["..pageText["Acronym"].."]";
	end
	AtlasText_ZoneName:SetText(ZoneNameText);
	AtlasText_Location:SetText(ATLAS_STRING_LOCATION..": "..(pageText["Location"] or "---"));
	AtlasText_LevelRange:SetText(ATLAS_STRING_LEVELRANGE..": "..(pageText["LevelRange"] or "---"));
	AtlasText_PlayerLimit:SetText(ATLAS_STRING_PLAYERLIMIT..": "..(pageText["PlayerLimit"] or "---"));
	for i = 1, 27, 1 do
		getglobal("AtlasText_"..i):SetText(pageText[i] or "");
	end
end

--Function used to initialize the map type dropdown menu
--Cycle through Atlas_MapTypes to populate the dropdown
function AtlasFrameDropDownType_Initialize()
	local info;
	for i = 1, getn(Atlas_MapTypes), 1 do
		info = {
			text = Atlas_MapTypes[i];
			func = AtlasFrameDropDownType_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the map type dropdown menu is shown
function AtlasFrameDropDownType_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDownType, AtlasFrameDropDownType_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, AtlasOptions.AtlasType);
	UIDropDownMenu_SetWidth(175, AtlasFrameDropDownType);
end

--Called whenever an item in the map type dropdown menu is clicked
--Sets the main dropdown menu contents to reflect the category of map selected
function AtlasFrameDropDownType_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDownType, i);
	AtlasOptions.AtlasType = i;
	AtlasOptions.AtlasZone = 1;
	local dropList = Atlas_GetDropdownListForType(i);
	if ( dropList and dropList[1] ) then
		AtlasOptions.AtlasMapID = dropList[1];
	end
	AtlasFrameDropDown_OnShow();
	Atlas_Refresh();
end

--Function used to initialize the main dropdown menu
--Looks at the status of AtlasType to determine how to populate the list
function AtlasFrameDropDown_Initialize()
	if ( AtlasOptions.AtlasType == 1 ) then
		AtlasFrameDropDown_Populate(AtlasText, ATLAS_DROPDOWN_LIST);
	elseif ( AtlasOptions.AtlasType == 2 ) then
		AtlasFrameDropDown_Populate(AtlasBG, ATLAS_DROPDOWN_LIST_BG);
	elseif ( AtlasOptions.AtlasType == 3 ) then
		AtlasFrameDropDown_Populate(AtlasFP, ATLAS_DROPDOWN_LIST_FP);
	elseif ( AtlasOptions.AtlasType == 4 ) then
		AtlasFrameDropDown_Populate(AtlasDL, ATLAS_DROPDOWN_LIST_DL);
	elseif ( AtlasOptions.AtlasType == 5 ) then
		AtlasFrameDropDown_Populate(AtlasRE, ATLAS_DROPDOWN_LIST_RE);
	end
end

--Populates the main dropdown menu based on the arguments given
--mapType is the name used in the localization files for the category of map
--dropList is the (hopefully) sorted list made from one of those categories
function AtlasFrameDropDown_Populate(mapType, dropList)
	local info;
	for i = 1, getn(dropList), 1 do
		local pageID = dropList[i];
		info = {
			text = Atlas_GetPageDisplayName(AtlasOptions.AtlasType, pageID);
			func = AtlasFrameDropDown_OnClick;
		};
		UIDropDownMenu_AddButton(info);
	end
end

--Called whenever the main dropdown menu is shown
function AtlasFrameDropDown_OnShow()
	UIDropDownMenu_Initialize(AtlasFrameDropDown, AtlasFrameDropDown_Initialize);
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, AtlasOptions.AtlasZone);
	UIDropDownMenu_SetWidth(175, AtlasFrameDropDown);
end

--Called whenever an item in the main dropdown menu is clicked
--Sets the newly selected map as current and refreshes the frame
function AtlasFrameDropDown_OnClick()
	i = this:GetID();
	UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, i);
	AtlasOptions.AtlasZone = i;
	local dropList = Atlas_GetDropdownListForType(AtlasOptions.AtlasType);
	if ( dropList and dropList[i] ) then
		AtlasOptions.AtlasMapID = dropList[i];
	end
	Atlas_Refresh();
end

--Modifies the value of GetRealZoneText to account for some naming conventions
--Always use this function instead of GetRealZoneText within Atlas
function Atlas_GetFixedZoneText()
   local currentZone = GetRealZoneText();
   if (AtlasZoneSubstitutions[currentZone]) then
      return AtlasZoneSubstitutions[currentZone];
   end
   return currentZone;
end 

--Checks the player's current location against all Atlas maps
--If a match is found display that map right away
function Atlas_AutoSelect()
	if ( not AceLibrary ) then
		return;
	end
	local mapRegistry = AceLibrary("MapRegistry-1.0");
	if ( not mapRegistry ) then
		return;
	end
	local currentMapID = mapRegistry:GetCurrentMapID();
	local selectedPageID = AtlasGeneratedMaps.defaults[currentMapID];
	if ( selectedPageID and Atlas_SetSelectedPageID(selectedPageID) ) then
		UIDropDownMenu_SetSelectedID(AtlasFrameDropDown, AtlasOptions.AtlasZone);
		Atlas_Refresh();
	end
end

--Called whenever the Atlas frame is displayed
function Atlas_OnShow()
	if(AtlasOptions.AtlasAutoSelect) then
		Atlas_AutoSelect();
	end
end

--Checks to see if the World Map should be replaced by Atlas or not
--Is the feature turned on? Is the player in an instance?
function Atlas_ReplaceWorldMap()
	if(AtlasOptions.AtlasReplaceWorldMap) then
		if ( not AceLibrary ) then
			return false;
		end
		local mapRegistry = AceLibrary("MapRegistry-1.0");
		if ( not mapRegistry ) then
			return false;
		end
		local currentMapID = mapRegistry:GetCurrentMapID();
		if ( AtlasGeneratedMaps.defaults[currentMapID] ) then
			return true;
		end
	end
	return false;
end

--Replaces the default ToggleWorldMap function
local oldToggleWorldMap = ToggleWorldMap;
function ToggleWorldMap()
	if (not WorldMapFrame:IsVisible() and Atlas_ReplaceWorldMap()) then
		Atlas_Toggle();
	else
		SetupFullscreenScale(WorldMapFrame);
		oldToggleWorldMap();
	end
end

--Code provided by tyroney
--Bugfix code by Cold
--Runs when the Atlas frame is clicked on
--RightButton closes Atlas and open the World Map if the RightClick option is turned on
function Atlas_OnClick()
	if ( arg1 == "RightButton" ) then
		if (AtlasOptions.AtlasRightClick) then
			local OldAtlasOptReplWMap = AtlasOptions.AtlasReplaceWorldMap;
			AtlasOptions.AtlasReplaceWorldMap = false;
			Atlas_Toggle();
			ToggleWorldMap();
			AtlasOptions.AtlasReplaceWorldMap = OldAtlasOptReplWMap;
		end
	end
end
