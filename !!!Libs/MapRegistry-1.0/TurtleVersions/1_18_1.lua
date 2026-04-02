MapRegistryTurtleVersions = MapRegistryTurtleVersions or {}

local function copyAstrolabeOverrides(source)
    local result = {}
    if not source then
        return result
    end
    for mapKey, mapData in pairs(source) do
        local mapCopy = {}
        for key, value in pairs(mapData) do
            if key == "zoneData" and type(value) == "table" then
                local zoneDataCopy = {}
                for zoneKey, zoneValues in pairs(value) do
                    local zoneCopy = {}
                    for zoneField, zoneValue in pairs(zoneValues) do
                        zoneCopy[zoneField] = zoneValue
                    end
                    zoneDataCopy[zoneKey] = zoneCopy
                end
                mapCopy.zoneData = zoneDataCopy
            else
                mapCopy[key] = value
            end
        end
        result[mapKey] = mapCopy
    end
    return result
end

local inheritedAstrolabeOverrides = nil

MapRegistryTurtleVersions["1.18.1"] = {
    extractedVersion = "1.18.1",
    extractedAt = "2026-04-02 22:58:04",
    source = "WorldMapArea.dbc",
    records = {
        [1004] = {
            areaTableId = 5024,
            astrolabeKey = "Icepoint",
            clientMapId = 1,
            clientWorldMapAreaId = 511,
            mapFile = "Frostpoint",
        },
        [1012] = {
            areaTableId = 5121,
            astrolabeKey = "TelAbim",
            clientMapId = 1,
            clientWorldMapAreaId = 507,
            mapFile = "Telabim",
        },
        [1016] = {
            areaTableId = 5536,
            astrolabeKey = "BlackstoneIsland",
            clientMapId = 1,
            clientWorldMapAreaId = 512,
            mapFile = "BlackrockIsle",
        },
        [1017] = {
            areaTableId = 5602,
            astrolabeKey = "GrimReaches",
            clientMapId = 0,
            clientWorldMapAreaId = 684,
            mapFile = "ColdCoast",
        },
        [1018] = {
            areaTableId = 5581,
            astrolabeKey = "Northwind",
            clientMapId = 0,
            clientWorldMapAreaId = 686,
            mapFile = "NorthwindCleft",
        },
        [1019] = {
            areaTableId = 408,
            astrolabeKey = "GillijimsIsle",
            clientMapId = 0,
            clientWorldMapAreaId = 505,
            mapFile = "GillijimsIsle",
        },
        [1020] = {
            areaTableId = 5179,
            astrolabeKey = "Gilneas",
            clientMapId = 0,
            clientWorldMapAreaId = 510,
            mapFile = "Gilneas",
        },
        [1022] = {
            areaTableId = 5561,
            astrolabeKey = "Balor",
            clientMapId = 0,
            clientWorldMapAreaId = 685,
            mapFile = "Balo",
        },
        [1023] = {
            areaTableId = 409,
            astrolabeKey = "LapidisIsle",
            clientMapId = 0,
            clientWorldMapAreaId = 504,
            mapFile = "LapidisIsle",
        },
        [1025] = {
            areaTableId = 5225,
            astrolabeKey = "ThalassianHighlands",
            clientMapId = 0,
            clientWorldMapAreaId = 513,
            mapFile = "SalasHighlands",
        },
        [1026] = {
            areaTableId = 5136,
            clientMapId = 189,
            clientWorldMapAreaId = 643,
            mapFile = "ScarletMonastery",
        },
        [1027] = {
            areaTableId = 4012,
            astrolabeKey = "ScarletEnclave",
            clientMapId = 0,
            clientWorldMapAreaId = 502,
            mapFile = "ScarletEnclave",
        },
        [1029] = {
            areaTableId = 2040,
            astrolabeKey = "Alsarath",
            clientMapId = 0,
            clientWorldMapAreaId = 509,
            mapFile = "Alsarath",
        },
        [1031] = {
            areaTableId = 0,
            astrolabeKey = "WinterVeilVale",
            clientMapId = 0,
            clientWorldMapAreaId = 0,
            mapFile = "WinterVeilVale",
        },
        [1032] = {
            areaTableId = 5208,
            astrolabeKey = "GilneasCity",
            clientMapId = 815,
            clientWorldMapAreaId = 665,
            mapFile = "GilneasCity",
        },
        [1033] = {
            areaTableId = 5077,
            astrolabeKey = "CrescentGrove",
            clientMapId = 802,
            clientWorldMapAreaId = 670,
            mapFile = "CrescentGrove",
        },
        [1034] = {
            areaTableId = 5103,
            astrolabeKey = "HateforgeQuarry",
            clientMapId = 808,
            clientWorldMapAreaId = 672,
            mapFile = "HateforgeQuarry",
        },
        [1035] = {
            areaTableId = 5086,
            astrolabeKey = "KarazhanCrypt",
            clientMapId = 800,
            clientWorldMapAreaId = 674,
            mapFile = "KarazhanCrypt",
        },
        [1036] = {
            areaTableId = 5087,
            astrolabeKey = "StormwindVault",
            clientMapId = 35,
            clientWorldMapAreaId = 676,
            mapFile = "StormwindVault",
        },
        [1037] = {
            areaTableId = 5097,
            astrolabeKey = "EmeraldSanctum",
            clientMapId = 807,
            clientWorldMapAreaId = 678,
            mapFile = "EmeraldSanctum",
        },
        [1038] = {
            areaTableId = 5601,
            astrolabeKey = "DragonmawRetreat",
            clientMapId = 816,
            clientWorldMapAreaId = 691,
            mapFile = "DragonmawRetreat",
        },
    },
    astrolabeOverrides = copyAstrolabeOverrides(inheritedAstrolabeOverrides),
}

do
    local astrolabeOverrides = MapRegistryTurtleVersions["1.18.1"].astrolabeOverrides
    astrolabeOverrides[1] = astrolabeOverrides[1] or {}
    astrolabeOverrides[1].zoneData = astrolabeOverrides[1].zoneData or {}
    astrolabeOverrides[1].zoneData["BlackstoneIsland"] = {
        height = 1665.0,
        width = 2472.0,
        xOffset = 23340.599609,
        yOffset = 12000.900391,
    }
    astrolabeOverrides[1].zoneData["Icepoint"] = {
        height = 1075.0,
        width = 1608.0,
        xOffset = 22661.599609,
        yOffset = -1605.099609,
    }
    astrolabeOverrides[1].zoneData["TelAbim"] = {
        height = 2187.0,
        width = 3227.0,
        xOffset = 22245.599609,
        yOffset = 19983.900391,
    }
    astrolabeOverrides[2] = astrolabeOverrides[2] or {}
    astrolabeOverrides[2].zoneData = astrolabeOverrides[2].zoneData or {}
    astrolabeOverrides[2].zoneData["Alsarath"] = {
        height = 976.0,
        width = 1468.0,
        xOffset = 18169.0,
        yOffset = 2559.600098,
    }
    astrolabeOverrides[2].zoneData["Balor"] = {
        height = 2068.0,
        width = 3098.0,
        xOffset = 11272.0,
        yOffset = 15043.600098,
    }
    astrolabeOverrides[2].zoneData["GillijimsIsle"] = {
        height = 2047.009766,
        width = 3092.10022,
        xOffset = 11563.779785,
        yOffset = 19995.310059,
    }
    astrolabeOverrides[2].zoneData["Gilneas"] = {
        height = 2442.0,
        width = 3666.0,
        xOffset = 12747.0,
        yOffset = 7825.600098,
    }
    astrolabeOverrides[2].zoneData["GrimReaches"] = {
        height = 3584.0,
        width = 5387.0,
        xOffset = 18072.0,
        yOffset = 10370.600098,
    }
    astrolabeOverrides[2].zoneData["LapidisIsle"] = {
        height = 1915.939453,
        width = 2901.450073,
        xOffset = 11066.669922,
        yOffset = 18510.080566,
    }
    astrolabeOverrides[2].zoneData["Northwind"] = {
        height = 2157.0,
        width = 3241.0,
        xOffset = 13742.0,
        yOffset = 13793.600098,
    }
    astrolabeOverrides[2].zoneData["ScarletEnclave"] = {
        height = 2108.0,
        width = 3159.0,
        xOffset = 20050.0,
        yOffset = 4379.600098,
    }
    astrolabeOverrides[2].zoneData["ThalassianHighlands"] = {
        height = 2061.0,
        width = 3082.0,
        xOffset = 17005.0,
        yOffset = 2514.600098,
    }
end
