--[[
	Name: GameVersion-1.0
	Author: Questie Contributors
	Description: A library to detect game version and server type (vanilla, TurtleWoW, expansion).
	Dependencies: AceLibrary
]]

local MAJOR_VERSION = "GameVersion-1.0"
local MINOR_VERSION = 1

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local GameVersion = {}

-- Cache detection results (only computed once)
local isTurtleWoW = nil
local isExpansion = nil

---------------------------------------------------------------------------------------------------
-- TurtleWoW Detection
-- TurtleWoW has 24+ zones in Kalimdor, vanilla has ~21
-- This is locale-independent and reliable
---------------------------------------------------------------------------------------------------
function GameVersion:IsTurtleWoW()
	if isTurtleWoW == nil then
		local kalimdorZones = {GetMapZones(1)}
		isTurtleWoW = table.getn(kalimdorZones) >= 24
	end
	return isTurtleWoW
end

---------------------------------------------------------------------------------------------------
-- Expansion (TBC) Detection
-- TBC has MAX_PLAYER_LEVEL = 70, vanilla/TurtleWoW has 60
---------------------------------------------------------------------------------------------------
function GameVersion:IsExpansion()
	if isExpansion == nil then
		isExpansion = (MAX_PLAYER_LEVEL == 70)
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
