--[[
	Name: GameVersion-1.0
	Author: Questie Contributors
	Description: A library to detect game version and server type (vanilla, TurtleWoW, expansion).
	Dependencies: AceLibrary

	Version detection notes:
	- Some custom vanilla clients such as TurtleWoW expose GetBuildInfo().
	- The TOC Interface version (e.g. 11200) is not queryable at runtime in 1.12.
	- Cannot distinguish 1.12.0 from 1.12.1 programmatically.
	- TurtleWoW detection relies on explicit build info when available.
]]

local MAJOR_VERSION = "GameVersion-1.0"
local MINOR_VERSION = 3

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local GameVersion = {}

-- Cache detection results (only computed once)
local isTurtleWoW = nil
local isExpansion = nil

local function getBuildVersion()
	if not GetBuildInfo then
		return nil
	end

	local version = GetBuildInfo()
	if version and version ~= "" then
		return version
	end

	return nil
end

function GameVersion:GetBuildVersion()
    return getBuildVersion()
end

local function parseMajorVersion(version)
	if not version then
		return nil
	end

	local _, _, major = string.find(version, "^(%d+)")
	if not major then
		return nil
	end

	return tonumber(major)
end

---------------------------------------------------------------------------------------------------
-- TurtleWoW Detection
-- TurtleWoW's custom client reports a 1.x build string such as 1.18.1.
---------------------------------------------------------------------------------------------------
function GameVersion:IsTurtleWoW()
	if isTurtleWoW == nil then
		local version = getBuildVersion()
		isTurtleWoW = version and string.find(version, "^1%.", 1, false) ~= nil or false
	end
	return isTurtleWoW
end

---------------------------------------------------------------------------------------------------
-- Expansion Detection
-- Real TBC clients report a 2.x+ build or MAX_PLAYER_LEVEL = 70.
-- TurtleWoW may expose GetBuildInfo() while still being a vanilla-era client.
---------------------------------------------------------------------------------------------------
function GameVersion:IsExpansion()
	if isExpansion == nil then
		local version = getBuildVersion()
		local major = parseMajorVersion(version)

		if major then
			isExpansion = (major >= 2)
		else
			isExpansion = (MAX_PLAYER_LEVEL == 70)
		end
	end
	return isExpansion
end

---------------------------------------------------------------------------------------------------
-- Vanilla Detection
-- Returns true if running on vanilla WoW (not TurtleWoW, not expansion)
---------------------------------------------------------------------------------------------------
function GameVersion:IsVanilla()
	return not self:IsTurtleWoW() and not self:IsExpansion()
end

---------------------------------------------------------------------------------------------------
-- Get Interface Version
-- Returns the TOC interface version number.
-- In some clients, GetBuildInfo() provides this as its 4th return value.
-- Otherwise we fall back to 11200.
---------------------------------------------------------------------------------------------------
function GameVersion:GetInterfaceVersion()
	if GetBuildInfo then
		local _, _, _, tocVersion = GetBuildInfo()
		if tocVersion then return tocVersion end
	end
	return 11200
end

---------------------------------------------------------------------------------------------------
-- Get Max Player Level
---------------------------------------------------------------------------------------------------
function GameVersion:GetMaxLevel()
	return MAX_PLAYER_LEVEL or 60
end

---------------------------------------------------------------------------------------------------
-- Get Version String (for debugging)
---------------------------------------------------------------------------------------------------
function GameVersion:GetVersionString()
	if self:IsExpansion() then
		return "The Burning Crusade"
	elseif self:IsTurtleWoW() then
		return "TurtleWoW"
	else
		return "Vanilla"
	end
end

AceLibrary:Register(GameVersion, MAJOR_VERSION, MINOR_VERSION)
