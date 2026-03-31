--[[

	Cartography data for Gatherer
	Revision: $Id: GatherRegionData.lua 275 2006-08-27 09:21:38Z islorgris $

	Zone coordinate data has been replaced by Astrolabe (!!!Libs/Astrolabe-0.2).
	This file now only contains the zone match table used for saved data migration.

]]


-- Zone Match Table for use in GathererUI_ZoneRematch function
GathererUI_ZoneMatchTable = {
	-- French transition matrix
	["FR 1_11_0"] = {
		["FR 1_12_0"] = { -- Identical for name fixes purpose only
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ,20, 21 },
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ,15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		};
	},
	["FR 1_12_0"] = {
		["FR 1_12_0"] = { -- Identical for name fixes purpose only
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ,20, 21 },
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ,15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		};
		["US/UK"] = {
			{ 1,  2, 21, 20,  4, 6,  5,  9,  8, 14, 17,  7, 18, 11, 12, 10, 13,  3, 15, 16, 19 },
			{ 8, 17,  21, 11, 7, 6, 10, 16, 15,  2, 12, 14, 20, 25, 13,  9, 23, 19, 24,  1,  5, 4, 3, 22, 18 };
		},
	},
	-- German transition matrix
	["DE 1_11_0"] = {
		["DE 1_12_0"] = { -- Identical for name fixes purpose only
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ,20, 21 },
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ,15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		},
	},
	["DE 1_12_0"] = {
		["DE 1_12_0"] = { -- Identical for name fixes purpose only
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ,20, 21 },
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ,15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		},
	},
	["US/UK"] = {
		["FR 1_12_0"] = {
			{  1, 2, 18,  5,  7, 6, 12, 9,  8, 16, 14, 15, 17, 10, 19, 20, 11, 13, 21,  4,  3 },
			{ 20,10, 23, 22, 21, 6,  5, 1, 16,  7,  4, 11, 15, 12,  9,  8,  2, 25, 18, 13,  3, 24, 17, 19, 14 };
		},
		["US/UK"] = { -- Identical for name fixes purpose only
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9 ,10, 11, 12, 13, 14, 15, 16, 17, 18, 19 ,20, 21 },
			{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 ,15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		};
	},
};
