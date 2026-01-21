--[[
Name: Babble-Ore-2.2
Revision: $Rev: 25632 $
Authors(s): kagaro (sal.scotto@gmail.com)
Website: www.wowace.com
Documentation: http://www.wowace.com/wiki/Babble-Ore-2.2
SVN: http://svn.wowace.com/root/branch/Babble-2.2/Babble-Ore-2.2
Dependencies: AceLibrary, AceLocale-2.2
License: MIT
]]

local MAJOR_VERSION = "Babble-Ore-2.2"
local MINOR_VERSION = tonumber(string.sub("$Revision: 25632 $", 12, -3))

if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:HasInstance("AceLocale-2.2") then error(MAJOR_VERSION .. " requires AceLocale-2.2") end

local _, x = AceLibrary("AceLocale-2.2"):GetLibraryVersion()
MINOR_VERSION = MINOR_VERSION * 100000 + x

if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

local BabbleOre = AceLibrary("AceLocale-2.2"):new(MAJOR_VERSION)

local veinSkill = {}
local veinTypes = {}

BabbleOre:RegisterTranslations("enUS", function() return {
-- Ore
	["Copper Ore"] = true,
	["Tin Ore"] = true,
	["Silver Ore"] = true,
	["Iron Ore"] = true,
	["Gold Ore"] = true,
	["Mithril Ore"] = true,
	["Dark Iron Ore"] = true,
	["Truesilver Ore"] = true,
	["Thorium Ore"] = true,
	["Elementium Ore"] = true,
	["Fel Iron Ore"] = true,
	["Adamantite Ore"] = true,
	["Eternium Ore"] = true,
	["Khroium Ore"] = true,
-- Types
	["Copper"] = true,
	["Tin"] = true,
	["Silver"] = true,
	["Iron"] = true,
	["Gold"] = true,
	["Mithril"] = true,
	["Dark Iron"] = true,
	["Truesilver"] = true,
	["Thorium"] = true,
	["Elementium"] = true,
	["Fel Iron"] = true,
	["Adamantite"] = true,
	["Eternium"] = true,
	["Khorium"] = true,
	["Incendicite"] = true,
	["Lesser Bloodstone"] = true,
	["Indurium"] = true,
	["Large Obsidian Shard"] = true,
	["Small Obsidian Shard"] = true,
-- Quest Ore
	["Underlight Ore"] = true, -- copper and tin
	["Lead Ore"] = true,
	["Rethban Ore"] = true, --quest
	["Incendicite Ore"] = true,
	["Umbral Ore"] = true,
	["Elunite Ore"] = true,
	["Lesser Bloodstone Ore"] = true, --quest
	["Indurium Ore"] = true,
-- Nodes
	["Copper Vein"] = true,
	["Tin Vein"] = true,
	["Iron Deposit"] = true,
	["Silver Vein"] = true,
	["Gold Vein"] = true,
	["Mithril Deposit"] = true,
	["Ooze Covered Mithril Deposit"] = true,
	["Truesilver Deposit"] = true,
	["Ooze Covered Silver Vein"] = true,
	["Ooze Covered Gold Vein"] = true,
	["Ooze Covered Truesilver Deposit"] = true,
	["Ooze Covered Rich Thorium Vein"] = true,
	["Ooze Covered Thorium Vein"] = true,
	["Small Thorium Vein"] = true,
	["Rich Thorium Vein"] = true,
	["Hakkari Thorium Vein"] = true,
	["Dark Iron Deposit"] = true,
	["Lesser Bloodstone Deposit"] = true,
	["Incendicite Mineral Vein"] = true,
	["Indurium Mineral Vein"] = true,
	["Fel Iron Deposit"] = true,
	["Adamantite Deposit"] = true,
	["Rich Adamantite Deposit"] = true,
	["Khorium Vein"] = true,
	["Large Obsidian Chunk"] = true,
	["Small Obsidian Chunk"] = true,
	
} end)

BabbleOre:RegisterTranslations("zhCN", function() return {
-- Ore
	["Copper Ore"] = "\233\147\156\231\159\191\231\159\179",
	["Tin Ore"] = "\233\148\161\231\159\191\231\159\179",
	["Silver Ore"] = "\233\147\182\231\159\191\231\159\179",
	["Iron Ore"] = "\233\147\129\231\159\191\231\159\179",
	["Gold Ore"] = "\233\135\145\231\159\191\231\159\179",
	["Mithril Ore"] = "\231\167\152\233\147\182\231\159\191\231\159\179",
	["Dark Iron Ore"] = "\233\187\145\233\147\129\231\159\191\231\159\179",
	["Truesilver Ore"] = "\231\156\159\233\147\182\231\159\191\231\159\179",
	["Thorium Ore"] = "\231\145\159\233\147\182\231\159\191\231\159\179",
	["Elementium Ore"] = "\230\186\144\232\180\168\231\159\191\231\159\179",
	["Fel Iron Ore"] = "\233\173\148\233\147\129\231\159\191\231\159\179",
	["Adamantite Ore"] = "Adamantite Ore",
	["Eternium Ore"] = "Eternium Ore",
	["Khroium Ore"] = "Khroium Ore",
-- Types
	["Copper"] = "\233\147\156\231\159\191",
	["Tin"] = "\233\148\161\231\159\191",
	["Silver"] = "\233\147\182\231\159\191",
	["Iron"] = "\233\147\129\231\159\191",
	["Gold"] = "\233\135\145\231\159\191",
	["Mithril"] = "\231\167\152\233\147\182\231\159\191",
	["Dark Iron"] = "\233\187\145\233\147\129\231\159\191",
	["Truesilver"] = "\231\156\159\233\147\182\231\159\191",
	["Thorium"] = "\231\145\159\233\147\182\231\159\191",
	["Elementium"] = "\230\186\144\232\180\168\231\159\191",
	["Fel Iron"] = "\233\173\148\233\147\129",
	["Adamantite"] = "Adamantite",
	["Eternium"] = "Eternium",
	["Khorium"] = "Khorium",
	["Incendicite"] = "\231\129\171\229\178\169\231\159\191",
	["Lesser Bloodstone"] = "\230\172\161\231\186\167\232\161\128\231\159\179\231\159\191",
	["Indurium"] = "\231\178\190\233\147\129\231\162\142\231\137\135",
	["Large Obsidian Shard"] = "\229\164\167\229\157\151\233\187\145\230\155\156\231\159\179\231\162\142\231\137\135",
	["Small Obsidian Shard"] = "\229\176\143\229\157\151\233\187\145\230\155\156\231\159\179\231\162\142\231\137\135",
-- Quest Ore
	["Underlight Ore"] = "Underlight Ore", -- copper and tin
	["Lead Ore"] = "\231\159\179\229\162\168",
	["Rethban Ore"] = "\231\145\158\230\150\175\231\143\173\231\159\191\231\159\179", --quest
	["Incendicite Ore"] = "\231\129\171\229\178\169\231\159\191\231\159\179",
	["Umbral Ore"] = "\230\154\151\229\189\177\231\159\191\231\159\179",
	["Elunite Ore"] = "\230\156\136\231\165\158\231\159\191\231\159\179",
	["Lesser Bloodstone Ore"] = "\230\172\161\231\186\167\232\161\128\231\159\179\231\159\191\231\159\179", --quest
	["Indurium Ore"] = "\231\178\190\233\147\129\231\159\191\231\159\179",
-- Nodes
	["Copper Vein"] = "\233\147\156\231\159\191\232\132\137",
	["Tin Vein"] = "\233\148\161\231\159\191\232\132\137",
	["Iron Deposit"] = "\233\147\129\231\159\191\232\132\137",
	["Silver Vein"] = "\233\147\182\231\159\191\232\132\137",
	["Gold Vein"] = "\233\135\145\231\159\191\232\132\137",
	["Mithril Deposit"] = "\231\167\152\233\147\182\231\159\191\232\132\137",
	["Ooze Covered Mithril Deposit"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\231\167\152\233\147\182\231\159\191\232\132\137",
	["Truesilver Deposit"] = "\231\156\159\233\147\182\231\159\191\232\132\137",
	["Ooze Covered Silver Vein"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\233\147\182\231\159\191\232\132\137",
	["Ooze Covered Gold Vein"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\233\135\145\231\159\191\232\132\137",
	["Ooze Covered Truesilver Deposit"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\231\156\159\233\147\182\231\159\191\232\132\137",
	["Ooze Covered Rich Thorium Vein"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\229\175\140\231\145\159\233\147\182\231\159\191\232\132\137",
	["Ooze Covered Thorium Vein"] = "\232\189\175\230\179\165\232\166\134\231\155\150\231\154\132\231\145\159\233\147\182\231\159\191\232\132\137",
	["Small Thorium Vein"] = "\231\145\159\233\147\182\231\159\191\232\132\137",
	["Rich Thorium Vein"] = "\229\175\140\231\145\159\233\147\182\231\159\191\232\132\137",
	["Hakkari Thorium Vein"] = "\229\147\136\229\141\161\232\142\177\231\145\159\233\147\182\231\159\191\232\132\137",
	["Dark Iron Deposit"] = "\233\187\145\233\147\129\231\159\191\232\132\137",
	["Lesser Bloodstone Deposit"] = "\230\172\161\231\186\167\232\161\128\231\159\179\231\159\191\232\132\137",
	["Incendicite Mineral Vein"] = "\231\129\171\229\178\169\231\159\191\232\132\137",
	["Indurium Mineral Vein"] = "\231\178\190\233\147\129\231\159\191\232\132\137",
	["Fel Iron Deposit"] = "\233\173\148\233\147\129\231\159\191\232\132\137",
	["Adamantite Deposit"] = "Adamantite Deposit",
	["Rich Adamantite Deposit"] = "Rich Adamantite Deposit",
	["Khorium Vein"] = "Khorium Vein",
	["Large Obsidian Chunk"] = "\229\164\167\229\158\139\233\187\145\230\155\156\231\159\179\231\162\142\229\157\151",
	["Small Obsidian Chunk"] = "\229\176\143\229\158\139\233\187\145\230\155\156\231\159\179\231\162\142\229\157\151",
	
} end)


BabbleOre:RegisterTranslations("koKR", function() return {
-- Ore
	["Copper Ore"] = "구리 광석",
	["Tin Ore"] = "주석 광석",
	["Silver Ore"] = "은 광석",
	["Iron Ore"] = "철 광석",
	["Gold Ore"] = "금 광석",
	["Mithril Ore"] = "미스릴 광석",
	["Dark Iron Ore"] = "검은무쇠 광석",
	["Truesilver Ore"] = "진은 광석",
	["Thorium Ore"] = "토륨 광석",
	["Elementium Ore"] = "엘레멘티움 광석",
	["Fel Iron Ore"] = "지옥무쇠 광석",
	["Adamantite Ore"] = "아다만티움 광석",
	["Eternium Ore"] = "이터늄 광석",
	["Khroium Ore"] = "코륨 광석",
-- Types
	["Copper"] = "구리",
	["Tin"] = "주석",
	["Iron"] = "철",
	["Silver"] = "은",
	["Gold"] = "금",
	["Mithril"] = "미스릴",
	["Dark Iron"] = "검은무쇠",
	["Truesilver"] = "진은",
	["Thorium"] = "토륨",
	["Elementium"] = "엘레멘티움",
	["Fel Iron"] = "지옥무쇠",
	["Adamantite"] = "아다만타이트",
	["Eternium"] = "이터늄",
	["Khorium"] = "코륨",
	["Incendicite"] = "발연",
	["Lesser Bloodstone"] = "저급 혈석",
--	["Indurium"] = true,
--	["Large Obsidian Shard"] = true,
--	["Small Obsidian Shard"] = true,
-- Quest Ore
--	["Underlight Ore"] = true, -- copper and tin
---	["Lead Ore"] = true,
--	["Rethban Ore"] = true, --quest
--	["Incendicite Ore"] = true,
--	["Umbral Ore"] = true,
--	["Elunite Ore"] = true,
--	["Lesser Bloodstone Ore"] = true, --quest
--	["Indurium Ore"] = true,
-- Nodes
	["Copper Vein"] = "구리 광맥",
	["Tin Vein"] = "주석 광맥",
	["Iron Deposit"] = "철 광맥",
	["Silver Vein"] = "은 광맥",
	["Gold Vein"] = "금 광맥",
	["Mithril Deposit"] = "미스릴 광맥",
	["Ooze Covered Mithril Deposit"] = "진흙으로 덮인 미스릴 광맥",
	["Truesilver Deposit"] = "진은 광맥",
	["Ooze Covered Silver Vein"] = "진흙으로 덮인 은 광맥",
	["Ooze Covered Gold Vein"] = "진흙으로 덮인 금 광맥",
	["Ooze Covered Truesilver Deposit"] = "진흙으로 덮인 진은 광맥",
	["Ooze Covered Rich Thorium Vein"] = "진흙으로 덮인 풍부한 토륨 광맥",
	["Ooze Covered Thorium Vein"] = "진흙으로 덮인 토륨 광맥",
	["Small Thorium Vein"] = "작은 토륨 광맥",
	["Rich Thorium Vein"] = "풍부한 토륨 광맥",
	["Hakkari Thorium Vein"] = "학카리 토륨 광맥",
	["Dark Iron Deposit"] = "검은무쇠 광맥",
--	["Lesser Bloodstone Deposit"] = true,
--	["Incendicite Mineral Vein"] = true,
--	["Indurium Mineral Vein"] = true,
	["Fel Iron Deposit"] = "지옥무쇠 광맥",
	["Adamantite Deposit"] = "아다만타이트 광맥",
	["Rich Adamantite Deposit"] = "풍부한 아다만타이트 광맥",
	["Khorium Vein"] = "코륨 광맥",
--	["Large Obsidian Chunk"] = true,
--	["Small Obsidian Chunk"] = true,
	
} end)

BabbleOre:RegisterTranslations("deDE", function() return {
-- Ore
	["Copper Ore"] = "Kupfererz",
	["Tin Ore"] = "Zinnerz",
	["Silver Ore"] = "Silbererz",
	["Iron Ore"] = "Eisenerz",
	["Gold Ore"] = "Golderz",
	["Mithril Ore"] = "Mithrilerz",
	["Dark Iron Ore"] = "Dunkeleisenerz",
	["Truesilver Ore"] = "Echtsilbererz",
	["Thorium Ore"] = "Thoriumerz",
	["Elementium Ore"] = "Elementiumerz",
	["Fel Iron Ore"] = "Teufelseisenerz",
	["Adamantite Ore"] = "Adamantiterz",
	["Eternium Ore"] = "Eterniumerz",
	["Khroium Ore"] = "Khoriumerz",
-- Types
	["Copper"] = "Kupfer",
	["Tin"] = "Zinn",
	["Silver"] = "Silber",
	["Iron"] = "Eisen",
	["Gold"] = "Gold",
	["Mithril"] = "Mithril",
	["Dark Iron"] = "Dunkeleisen",
	["Truesilver"] = "Echtsilber",
	["Thorium"] = "Thorium",
	["Elementium"] = "Elementium",
	["Fel Iron"] = "Teufelseisen",
	["Adamantite"] = "Adamantit",
	["Eternium"] = "Eternium",
	["Khorium"] = "Khorium",
	["Incendicite"] = "Pyrophor",
	["Lesser Bloodstone"] = "Geringer Blutstein",
	["Indurium"] = "Indurium",
	["Large Obsidian Shard"] = "Großer Obsidiansplitter",
	["Small Obsidian Shard"] = "Kleiner Obsidiansplitter",
-- Quest Ore
--  ["Underlight Ore"] = "", -- copper and tin
	["Lead Ore"] = "Bleierz",
	["Rethban Ore"] = "Rethbanerz", --quest
	["Incendicite Ore"] = "Pyrophorerz",
	["Umbral Ore"] = "Umbralerz",
	["Elunite Ore"] = "Eluniterz",
	["Lesser Bloodstone Ore"] = "Geringes Blutsteinerz", --quest
	["Indurium Ore"] = "Induriumerz",
-- Nodes
	["Copper Vein"] = "Kupfervorkommen",
	["Tin Vein"] = "Zinnvorkommen",
	["Iron Deposit"] = "Eisenablagerung",
	["Silver Vein"] = "Silbervorkommen",
	["Gold Vein"] = "Goldvorkommen",
	["Mithril Deposit"] = "Mithrilablagerung",
	["Ooze Covered Mithril Deposit"] = "Brühschlammbedeckte Mithrilablagerung",
	["Truesilver Deposit"] = "Echtsilberablagerung",
	["Ooze Covered Silver Vein"] = "Brühschlammbedecktes Silbervorkommen",
	["Ooze Covered Gold Vein"] = "Brühschlammbedecktes Goldvorkommen",
	["Ooze Covered Truesilver Deposit"] = "Brühschlammbedeckte Echtsilberablagerung",
	["Ooze Covered Rich Thorium Vein"] = "Brühschlammbedecktes reiches Thoriumvorkommen",
	["Ooze Covered Thorium Vein"] = "Brühschlammbedecktes Thoriumvorkommen",
	["Small Thorium Vein"] = "Kleines Thoriumvorkommen",
	["Rich Thorium Vein"] = "Reiches Thoriumvorkommen",
	["Hakkari Thorium Vein"] = "Hakkari-Thoriumvorkommen", -- check, esp. hyphen
	["Dark Iron Deposit"] = "Dunkeleisenablagerung",
	["Lesser Bloodstone Deposit"] = "Geringes Blutsteinablagerung", --check
	["Incendicite Mineral Vein"] = "Pyrophormineralvorkommen", --check
	["Indurium Mineral Vein"] = "Induriummineralvorkommen", --check
	["Fel Iron Deposit"] = "Teufelseisenablagerung", --check
	["Adamantite Deposit"] = "Adamantitablagerung", --check
	["Rich Adamantite Deposit"] = "Reiche Adamantitablagerung", --check
	["Khorium Vein"] = "Khoriumvorkommen", --check
	["Large Obsidian Chunk"] = "Großer Obsidianbrocken", --check
	["Small Obsidian Chunk"] = "Kleiner Obsidianbrocken", --check
	
} end)

BabbleOre:RegisterTranslations("frFR", function() return {
-- Ore
	["Copper Ore"] = "Minerai de cuivre",
	["Tin Ore"] = "Minerai d'étain",
	["Silver Ore"] = "Minerai d'argent",
	["Iron Ore"] = "Minerai de fer",
	["Gold Ore"] = "Minerai d'or",
	["Mithril Ore"] = "Minerai de mithril",
	["Dark Iron Ore"] = "Minerai de sombrefer",
	["Truesilver Ore"] = "Minerai de vrai-argent",
	["Thorium Ore"] = "Minerai de thorium",
	["Elementium Ore"] = "Minerai d'élémentium",
	["Fel Iron Ore"] = "Minerai de gangrefer",
	["Adamantite Ore"] = "Minerai d'adamantite",
	["Eternium Ore"] = "Minerai d'éternium",
	["Khroium Ore"] = "Minerai de khorium",
-- Types
	["Copper"] = "Cuivre",
	["Tin"] = "Etain",
	["Silver"] = "Argent",
	["Iron"] = "Fer",
	["Gold"] = "Or",
	["Mithril"] = "Mithril",
	["Dark Iron"] = "Sombrefer",
	["Truesilver"] = "Vrai-argent",
	["Thorium"] = "Thorium",
	["Elementium"] = "Elémentium",
	["Fel Iron"] = "Gangrefer",
	["Adamantite"] = "Adamantite",
	["Eternium"] = "Eternium",
	["Khorium"] = "Khorium",
	["Incendicite"] = "Incendicite",
	["Lesser Bloodstone"] = "Pierre de sang inférieure",
	["Indurium"] = "Indurium",
	["Large Obsidian Shard"] = "Grand éclat d'obsidienne",
	["Small Obsidian Shard"] = "Petit éclat d'obsidienne",
-- Quest Ore
	--["Underlight Ore"] = true, -- copper and tin
	["Lead Ore"] = "Minerai de plomb",
	["Rethban Ore"] = "Minerai de rethban", --quest
	["Incendicite Ore"] = "Minerai d'incendicite",
	["Umbral Ore"] = "Minerai d'Umbral",
	["Elunite Ore"] = "Minerai d'Elunite",
	["Lesser Bloodstone Ore"] = "Minerai de pierre de sang inférieur", --quest
	["Indurium Ore"] = "Minerai d'Indurium",
-- Nodes
	["Copper Vein"] = "Filon de cuivre",
	["Tin Vein"] = "Filon d'étain",
	["Iron Deposit"] = "Gisement de fer",
	["Silver Vein"] = "Filon d'argent",
	["Gold Vein"] = "Filon d'or",
	["Mithril Deposit"] = "Gisement de mithril",
	["Ooze Covered Mithril Deposit"] = "Gisement de mithril couvert de vase",
	["Truesilver Deposit"] = "Gisement de vrai-argent",
	["Ooze Covered Silver Vein"] = "Filon d'argent couvert de limon",
	["Ooze Covered Gold Vein"] = "Filon d'or couvert de limon",
	["Ooze Covered Truesilver Deposit"] = "Gisement de vrai-argent couvert de vase",
	["Ooze Covered Rich Thorium Vein"] = "Riche filon de thorium couvert de limon",
	["Ooze Covered Thorium Vein"] = "Filon de thorium couvert de limon",
	["Small Thorium Vein"] = "Petit filon de thorium",
	["Rich Thorium Vein"] = "Riche filon de thorium",
	["Hakkari Thorium Vein"] = "Filon de thorium Hakkari",
	["Dark Iron Deposit"] = "Gisement de sombrefer",
	["Lesser Bloodstone Deposit"] = "Gisement de pierre de sang inférieure",
	["Incendicite Mineral Vein"] = "Filon d'incendicite",
	["Indurium Mineral Vein"] = "Filon d'indurium",
	["Fel Iron Deposit"] = "Gisement de gangrefer",
	["Adamantite Deposit"] = "Gisement d'adamantite",
	["Rich Adamantite Deposit"] = "Riche gisement d'adamantite",
	["Khorium Vein"] = "Filon de khorium",
	["Large Obsidian Chunk"] = "Grand morceau d'obsidienne",
	["Small Obsidian Chunk"] = "Petit morceau d'obsidienne",
	
} end)


BabbleOre:Debug()
BabbleOre:SetStrictness(true)

AceLibrary:Register(BabbleOre, MAJOR_VERSION, MINOR_VERSION)
BabbleOre = nil
