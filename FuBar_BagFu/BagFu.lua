BagFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0", "AceDB-2.0", "AceEvent-2.0")
BagFu:RegisterDB("BagFuDB")
BagFu:RegisterDefaults('profile', {
	showDepletion = false,
	includeProfession = true,
	includeAmmo = false,
	showTotal = true,
})

BagFu.hasIcon = true
BagFu.cannotDetachTooltip = true
BagFu.defaultPosition = "RIGHT"

local L = AceLibrary("AceLocale-2.2"):new("FuBar_BagFu")
local _G = getfenv(0)

local Tablet = AceLibrary("Tablet-2.0")
local Crayon = AceLibrary("Crayon-2.0")

local options = {
	type = "group",
	args = {
		ammobags = {
			type = "toggle",
			name = L["Ammo/Soul Bags"],
			desc = L["Include ammo/soul bags"],
			get = function() return BagFu.db.profile.includeAmmo end,
			set = function()
				BagFu.db.profile.includeAmmo = not BagFu.db.profile.includeAmmo
				BagFu:Update()
			end,
		},
		professionbags = {
			type = "toggle",
			name = L["Profession Bags"],
			desc = L["Include profession bags"],
			get = function() return BagFu.db.profile.includeProfession end,
			set = function()
				BagFu.db.profile.includeProfession = not BagFu.db.profile.includeProfession
				BagFu:Update()
			end,
		},
		depletion = {
			type = "toggle",
			name = L["Bag Depletion"],
			desc = L["Show depletion of bags"],
			get = function() return BagFu.db.profile.showDepletion end,
			set = function()
				BagFu.db.profile.showDepletion = not BagFu.db.profile.showDepletion
				BagFu:Update()
			end,
		},
		total = {
			type = "toggle",
			name = L["Bag Total"],
			desc = L["Show total amount of space in bags"],
			get = function() return BagFu.db.profile.showTotal end,
			set = function()
				BagFu.db.profile.showTotal = not BagFu.db.profile.showTotal
				BagFu:Update()
			end,
		},
	}
}
BagFu.OnMenuRequest = options

function BagFu:OnEnable()
	self:RegisterBucketEvent("BAG_UPDATE", 1, "Update")
end

local GetItemSubtype
do
	local version = GetBuildInfo()
	if string.find(version, "^2%.") then
		-- 2.0.0
		function GetItemSubtype(link)
			local _,_,_,_,_,_,subtype = GetItemInfo(link)
			return subtype
		end
	else
		function GetItemSubtype(link)
			local itemId = tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0)
			local _,_,_,_,_,subtype = GetItemInfo(itemId)
			return subtype
		end
	end
end

function BagFu:OnTextUpdate()
	local totalSlots = 0
	local takenSlots = 0
	for i = 0, 4 do
		local usable = true
		if i >= 1 then
			local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
			if link ~= nil then
				local subtype = GetItemSubtype(link)
				if not self.db.profile.includeAmmo and (subtype == L["Soul Bag"] or subtype == L["Ammo Pouch"] or subtype == L["Quiver"]) then
					usable = false
				elseif not self.db.profile.includeProfession and (subtype == L["Enchanting Bag"] or subtype == L["Herb Bag"] or subtype == L["Engineering Bag"]) then
					usable = false
				end
			end
		end
		if usable then
			local size = GetContainerNumSlots(i)
			
			if size ~= nil and size > 0 then
				totalSlots = totalSlots + size
				for slot = 1, size do
					if GetContainerItemInfo(i, slot) then
						takenSlots = takenSlots + 1
					end
				end
			end
		end
	end
	
	local color = Crayon:GetThresholdHexColor((totalSlots - takenSlots) / totalSlots)
	
	if self.db.profile.showDepletion then
		takenSlots = totalSlots - takenSlots
	end
	
	if (self.db.profile.showTotal) then
		self:SetText(string.format("|cff%s%d/%d|r", color, takenSlots, totalSlots))
	else
		self:SetText(string.format("|cff%s%d|r", color, takenSlots))
	end
end

function BagFu:OnTooltipUpdate()
	Tablet:SetHint(L["Click to open your bags"])
end

function BagFu:OnClick()
	if not ContainerFrame1:IsShown() then
		for i = 1, 4 do
			if _G["ContainerFrame" .. (i + 1)]:IsShown() then
				_G["ContainerFrame" .. (i + 1)]:Hide()
			end
		end
		ToggleBackpack()
		if ContainerFrame1:IsShown() then
			for i = 1, 4 do
				local link = GetInventoryItemLink("player", ContainerIDToInventoryID(i))
				if link ~= nil then
					local subtype = GetItemSubtype(link)
					local usable = true
					if not self.db.profile.includeAmmo and (subtype == L["Soul Bag"] or subtype == L["Ammo Pouch"] or subtype == L["Quiver"]) then
						usable = false
					elseif not self.db.profile.includeProfession and (subtype == L["Enchanting Bag"] or subtype == L["Herb Bag"] or subtype == L["Engineering Bag"]) then
						usable = false
					end
					if usable then
						ToggleBag(i)
					end
				end
			end
		end
	else
		for i = 0, 4 do
			if _G["ContainerFrame" .. (i + 1)]:IsShown() then
				_G["ContainerFrame" .. (i + 1)]:Hide()
			end
		end
	end
end
