--[[
	Gatherer-Astrolabe Integration Bridge

	Provides Astrolabe-based coordinate functions for Gatherer,
	replacing the hardcoded GatherRegionData zone tables.

	Requires: AceLibrary, Astrolabe-0.2 (loaded via !!!Libs)
]]

-- Get Astrolabe reference
local Gatherer_Astrolabe = AceLibrary("Astrolabe-0.2")

-- Replace Gatherer's coordinate conversion with Astrolabe equivalents
-- Gatherer_AbsCoord is no longer needed — Astrolabe handles zone-to-continent
-- coordinate conversion internally via WorldMapSize data.

-- Compute distance in game yards between two zone-coordinate points
function Gatherer_AstrolabeDistance(c1, z1, x1, y1, c2, z2, x2, y2)
	local dist, xDelta, yDelta = Gatherer_Astrolabe:ComputeDistance(c1, z1, x1, y1, c2, z2, x2, y2)
	return dist or 0, xDelta or 0, yDelta or 0
end

-- Place a gather icon on the minimap via Astrolabe
function Gatherer_AstrolabePlaceOnMinimap(icon, continent, zone, xPos, yPos)
	return Gatherer_Astrolabe:PlaceIconOnMinimap(icon, continent, zone, xPos, yPos)
end

-- Remove a gather icon from Astrolabe's minimap tracking
function Gatherer_AstrolabeRemoveFromMinimap(icon)
	return Gatherer_Astrolabe:RemoveIconFromMinimap(icon)
end

-- Place a gather icon on the world map via Astrolabe
function Gatherer_AstrolabePlaceOnWorldMap(worldMapFrame, icon, continent, zone, xPos, yPos)
	return Gatherer_Astrolabe:PlaceIconOnWorldMap(worldMapFrame, icon, continent, zone, xPos, yPos)
end

-- Get current player position via Astrolabe
function Gatherer_AstrolabePlayerPos()
	return Gatherer_Astrolabe:GetCurrentPlayerPosition()
end

-- Check if minimap is outdoors (Astrolabe tracks this)
function Gatherer_AstrolabeIsOutdoor()
	return Gatherer_Astrolabe.minimapOutside
end
