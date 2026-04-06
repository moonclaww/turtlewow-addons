AtlasLootGeneratedMaps = {
    pages = {
        [2001001] = {
            canonical_map_id = 2001001,
            category = 1,
            legacy_key = "BlackfathomDeeps",
        },
        [2001002] = {
            canonical_map_id = 2001002,
            category = 1,
            legacy_key = "BlackrockDepths",
        },
        [2001003] = {
            canonical_map_id = 2001003,
            category = 1,
            legacy_key = "BlackrockSpireLower",
        },
        [2001004] = {
            canonical_map_id = 2001004,
            category = 1,
            legacy_key = "BlackrockSpireUpper",
        },
        [2001005] = {
            canonical_map_id = 2001005,
            category = 1,
            legacy_key = "BlackwingLair",
        },
        [2001006] = {
            canonical_map_id = 2001006,
            category = 1,
            legacy_key = "DireMaulEast",
        },
        [2001007] = {
            canonical_map_id = 2001007,
            category = 1,
            legacy_key = "DireMaulNorth",
        },
        [2001008] = {
            canonical_map_id = 2001008,
            category = 1,
            legacy_key = "DireMaulWest",
        },
        [2001009] = {
            canonical_map_id = 1028,
            category = 1,
            legacy_key = "Gnomeregan",
        },
        [2001010] = {
            canonical_map_id = 1014,
            category = 1,
            legacy_key = "Maraudon",
        },
        [2001011] = {
            canonical_map_id = 2001011,
            category = 1,
            legacy_key = "MoltenCore",
        },
        [2001012] = {
            canonical_map_id = 2001012,
            category = 1,
            legacy_key = "OnyxiasLair",
        },
        [2001013] = {
            canonical_map_id = 2001013,
            category = 1,
            legacy_key = "RagefireChasm",
        },
        [2001014] = {
            canonical_map_id = 2001014,
            category = 1,
            legacy_key = "RazorfenDowns",
        },
        [2001015] = {
            canonical_map_id = 2001015,
            category = 1,
            legacy_key = "RazorfenKraul",
        },
        [2001016] = {
            canonical_map_id = 1026,
            category = 1,
            legacy_key = "ScarletMonastery",
        },
        [2001017] = {
            canonical_map_id = 2001017,
            category = 1,
            legacy_key = "Scholomance",
        },
        [2001018] = {
            canonical_map_id = 2001018,
            category = 1,
            legacy_key = "ShadowfangKeep",
        },
        [2001019] = {
            canonical_map_id = 2001019,
            category = 1,
            legacy_key = "Stratholme",
        },
        [2001020] = {
            canonical_map_id = 2001020,
            category = 1,
            legacy_key = "TheDeadmines",
        },
        [2001021] = {
            canonical_map_id = 2001021,
            category = 1,
            legacy_key = "TheStockade",
        },
        [2001022] = {
            canonical_map_id = 2001022,
            category = 1,
            legacy_key = "TheSunkenTemple",
        },
        [2001023] = {
            canonical_map_id = 1021,
            category = 1,
            legacy_key = "Uldaman",
        },
        [2001024] = {
            canonical_map_id = 1006,
            category = 1,
            legacy_key = "WailingCaverns",
        },
        [2001025] = {
            canonical_map_id = 2001025,
            category = 1,
            legacy_key = "ZulFarrak",
        },
        [2001026] = {
            canonical_map_id = 2001026,
            category = 1,
            legacy_key = "ZulGurub",
        },
        [2001027] = {
            canonical_map_id = 2001027,
            category = 1,
            legacy_key = "TheTempleofAhnQiraj",
        },
        [2001028] = {
            canonical_map_id = 2001028,
            category = 1,
            legacy_key = "TheRuinsofAhnQiraj",
        },
        [2001029] = {
            canonical_map_id = 2001029,
            category = 1,
            legacy_key = "Naxxramas",
        },
        [2002001] = {
            canonical_map_id = 2002001,
            category = 2,
            legacy_key = "AlteracValleyNorth",
        },
        [2002002] = {
            canonical_map_id = 2002002,
            category = 2,
            legacy_key = "AlteracValleySouth",
        },
        [2002003] = {
            canonical_map_id = 2002003,
            category = 2,
            legacy_key = "ArathiBasin",
        },
        [2002004] = {
            canonical_map_id = 2002004,
            category = 2,
            legacy_key = "WarsongGulch",
        },
        [2005001] = {
            canonical_map_id = 2005001,
            category = 5,
            legacy_key = "Azuregos",
        },
        [2005002] = {
            canonical_map_id = 2005002,
            category = 5,
            legacy_key = "FourDragons",
        },
        [2005003] = {
            canonical_map_id = 2005003,
            category = 5,
            legacy_key = "Kazzak",
        },
    },
}

for pageID, page in pairs(AtlasLootGeneratedMaps.pages) do
    if page.category == 1 and AtlasLootBossButtons and page.legacy_key and AtlasLootBossButtons[page.legacy_key] then
        AtlasLootBossButtons[pageID] = AtlasLootBossButtons[page.legacy_key]
    elseif page.category == 2 and AtlasLootBattlegrounds and page.legacy_key and AtlasLootBattlegrounds[page.legacy_key] then
        AtlasLootBattlegrounds[pageID] = AtlasLootBattlegrounds[page.legacy_key]
    elseif page.category == 5 and AtlasLootWBBossButtons and page.legacy_key and AtlasLootWBBossButtons[page.legacy_key] then
        AtlasLootWBBossButtons[pageID] = AtlasLootWBBossButtons[page.legacy_key]
    end
end
