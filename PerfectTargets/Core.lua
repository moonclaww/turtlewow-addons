
------------------------------
--      Are you local?      --
------------------------------

local compost = AceLibrary("Compost-2.0")
local gratuity = AceLibrary("Gratuity-2.0")
local metro = AceLibrary("Metrognome-2.0")

local delaycount, numtargets, framecount, ptframe = 0, 0, 0, PerfectRaidTargetFrame
local targets, targetcounts, tanks, tankstrings = {}, {}, {}, {}
local ccdebufftextures = {
	["Interface\\Icons\\INV_Spear_02"] = true,
	["Interface\\Icons\\Ability_Druid_Cower"] = true,
	["Interface\\Icons\\Ability_Sap"] = true,
	["Interface\\Icons\\Spell_Shadow_MindSteal"] = true,
	["Interface\\Icons\\Spell_Nature_Sleep"] = true,
	["Interface\\Icons\\Spell_Nature_Slow"] = true,
	["Interface\\Icons\\Spell_Frost_ChainsOfIce"] = true,
	["Interface\\Icons\\Spell_Shadow_Cripple"] = true,
	["Interface\\Icons\\Spell_Nature_Polymorph"] = true,
	["Interface\\Icons\\Spell_Magic_PolymorphPig"] = true,
	["Interface\\Icons\\Spell_Magic_PolymorphTurtle"] = true,
}
local ccdebuffs = {
	["翼龙钉刺"] = true,
	["惊吓野兽"] = true,
	["变形术"] = true,
	["变形术：猪"] = true,
	["变形术：龟"] = true,
	["闷棍"] = true,
	["诱惑"] = true,
	["休眠"] = true,
	["束缚亡灵"] = true,
	["冰冻陷阱效果"] = true,
	["放逐"] = true,
}



-------------------------------------
--      Namespace Declaration      --
-------------------------------------

PerfectTargets = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0")
PerfectTargets:RegisterDB("PerfectTargetsDB", "PerfectTargetsDBPC")
PerfectTargets:RegisterDefaults("profile", {
	numinitials = 1,
	maxframes = 10,
	baserate = 0.25,
	framelocked = false,
})
PerfectTargets:RegisterChatCommand({"/ptarg"}, {type = "group", handler = PerfectTargets, args = {
	["lock"] = {
		type = "toggle",
		name = "锁定框体",
		desc = "锁定窗体位置",
		get = function() return PerfectTargets.db.profile.framelocked end,
		set = function(v) PerfectTargets.db.profile.framelocked = v end,
	},
	["tankinitials"] = {
		type = "range",
		name = "mt目标",
		desc = "显示的mt目标最大数量",
		get = function() return PerfectTargets.db.profile.numinitials end,
		set = function(v) PerfectTargets.db.profile.numinitials = v end,
		min = 1, max = 10, step = 1,
	},
	["rate"] = {
		type = "range",
		name = "更新速率",
		desc = "框体更新速率",
		get = function() return PerfectTargets.db.profile.baserate end,
		set = function(v)
			local pt = PerfectTargets
			pt.db.profile.baserate = v
			if pt:IsEventScheduled("PerfectTargets_UpdateMyTarget") then
				pt:CancelScheduledEvent("PerfectTargets_UpdateMyTarget")
				pt:ScheduleRepeatingEvent("PerfectTargets_UpdateMyTarget", PerfectTargets.db.profile.baserate)
			end
		end,
		min = 0.05, max = 2, step = 0.05,
	},
	["targets"] = {
		type = "range",
		name = "目标数量",
		desc = "显示的最大目标数量",
		get = function() return PerfectTargets.db.profile.maxframes end,
		set = function(v) PerfectTargets.db.profile.maxframes = v end,
		min = 1, max = 20, step = 1,
	},
}})


---------------------------
--      Ace Methods      --
---------------------------

function PerfectTargets:OnEnable()
	if not self.mainframe then self:CreateFrame() end
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	metro:Start("PerfectTargets MyTarget")
	metro:Start("PerfectTargets Targets")

	self:RestorePosition()
	self.mainframe:Show()
end


function PerfectTargets:OnDisable()
	metro:Stop("PerfectTargets MyTarget")
	metro:Stop("PerfectTargets Targets")

	self.mainframe:Hide()
	self.headerback:Hide()
end


function PerfectTargets:CreateFrame()
	self.mainframe = CreateFrame("Frame", "PerfectTargetsFrame", UIParent)

	metro:Register("PerfectTargets Targets", self.PerfectTargets_UpdateAllTargets, baserate, self)
	metro:Register("PerfectTargets MyTarget", self.PerfectTargets_UpdateMyTarget, baserate, self)
	metro:Register("PerfectTargets MyTargetChanged", self.PerfectTargets_UpdateMyTargetChanged, 0.02, self)

	self.mainframe:EnableMouse(true)
	self.mainframe:SetMovable(true)
	self.mainframe:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 0, -150)
	self.mainframe:SetWidth(200)
	self.mainframe:SetHeight(14)

	self.anchorframe = ptframe:CreateAnchorFrame(self.mainframe)
	self.frames = {}
	setmetatable(self.frames, {__index = function(t,k) return PerfectTargets:CreateTargetFrame(k) end})

	self.headertext = self.mainframe:CreateFontString(nil, "ARTWORK")
	self.headertext:SetFontObject(GameFontHighlightSmall)
	self.headertext:ClearAllPoints()
	self.headertext:SetPoint("BOTTOM", self.anchorframe, "BOTTOM")
	self.headertext:SetText("Perfect Targets")
	self.headertext:Show()

	self.headerback = CreateFrame("Button", nil, UIParent)
	self.headerback.master = self.mainframe
	self.headerback:RegisterForDrag("LeftButton")
	self.headerback:SetScript("OnDragStart", function()
		if PerfectTargets.db.profile.framelocked then return end
		this.master:StartMoving()
		this.master.isMoving = true
	end)

	self.headerback:SetScript("OnDragStop", function()
		this.master:StopMovingOrSizing()
		this.master.isMoving = nil
		PerfectTargets:SavePosition()
	end)

	self.headerback:SetPoint("TOPLEFT", self.anchorframe, "TOPLEFT")
	self.headerback:SetPoint("BOTTOMRIGHT", self.anchorframe, "BOTTOMRIGHT")
	self.headerback:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 32,
		edgeFile = "", edgeSize = 0,
		insets = {left = 0, right = -2, top = -2, bottom = -2},
		})
	self.headerback:Show()
end


------------------------------
--      Event Handlers      --
------------------------------

function PerfectTargets:PLAYER_TARGET_CHANGED()
	metro:Start("PerfectTargets MyTargetChanged", 1)
--~~ 	self:CancelScheduledEvent("PerfectTargets_UpdateAllTargets")
--~~ 	self:ScheduleEvent("PerfectTargets_UpdateAllTargets", 0.02)
end


----------------------------------
--      Main Frame Methods      --
----------------------------------

function PerfectTargets:SavePosition()
	local s = self.mainframe:GetEffectiveScale()
	self.db.profile.PosX = self.mainframe:GetLeft() * s
	self.db.profile.PosY = self.mainframe:GetTop() * s
end


function PerfectTargets:RestorePosition()
	local x = self.db.profile.PosX
	local y = self.db.profile.PosY
	if not x or not y then return end

	local s = self.mainframe:GetEffectiveScale()
	x, y = x/s, y/s
	self.mainframe:ClearAllPoints()
	self.mainframe:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
end


------------------------------------
--      Target Frame Methods      --
------------------------------------

function PerfectTargets:CreateTargetFrame(i)
	if not i or i > self.db.profile.maxframes then return end
	if framecount < i then framecount = i end
	self.frames[i] = ptframe:CreateTargetFrame(i, self.mainframe, (i > 1) and self.frames[i-1] or self.anchorframe)
	return self.frames[i]
end


function PerfectTargets:PerfectTargets_UpdateMyTarget()
	local numframes = math.min(numtargets, self.db.profile.maxframes)
	for i=1,numframes do
		if UnitIsUnit("target", targets[i].."target") then
			if UnitExists("target") then self:UpdateUnitFrame(targets[i], self.frames[i], i) end
			return
		end
	end
end


function PerfectTargets:UpdateFrames()
	local first = true
	for i=1,framecount do
		self:UpdateUnitFrame(targets[i], self.frames[i], i, first)
		first = nil
	end
	local targs = math.min(numtargets, self.db.profile.maxframes)
	self.mainframe:SetHeight(targs > 0 and targs*14 or 14)
end


function PerfectTargets:UpdateUnitFrame(funit, frame, i, resetwidth)
	local unit = funit and funit.. "target"

	if not unit then ptframe:UpdateTargetFrame(frame)
	else
		if not UnitExists(unit) then
			ptframe:UpdateTargetFrame(frame, funit, funit)
			ptframe:UpdateTargetFrameColors(frame)
		else
			local tank = tanks[funit] and funit
			local isfriend = UnitIsFriend(unit, "player")
			local ucombat = not isfriend and UnitAffectingCombat(unit)
			local status = not isfriend and self:UnitUnderControl(unit) and 1 or self:UnitMarked(unit) and 2
			local tot = not isfriend and UnitIsUnit(unit.."target", funit)
			local hp, hpmax = UnitHealth(unit), UnitHealthMax(unit)
			local hpp = (hpmax ~= 0) and math.floor((hp / hpmax) * 100) or 0
			local numtext = targetcounts[i] or 0

			ptframe:UpdateTargetFrame(frame, unit, tank, (numtext > 0) and numtext, hpp, duptank, tankstrings[i], resetwidth)
			ptframe:UpdateTargetFrameColors(frame, tot, UnitAffectingCombat("player"), isfriend, ucombat, status)
		end
		frame:Show()
	end
end



------------------------------------
--      Unit Testing Methods      --
------------------------------------

function PerfectTargets:PerfectTargets_UpdateMyTargetChanged()
	self:PerfectTargets_UpdateAllTargets(true)
end


function PerfectTargets:PerfectTargets_UpdateAllTargets(override)
	delaycount = delaycount - 1
	if not override and delaycount > 0 then return end

	-- Updates the known target list
	local pmem, rmem = GetNumPartyMembers(), GetNumRaidMembers()
	targets = compost:Erase(targets)
	targetcounts = compost:Erase(targetcounts)
	tankstrings = compost:Erase(tankstrings)
	numtargets = 0

	if rmem > 0 then
		for i = 1,rmem do
			self:TestTarget("raid"..i)
			self:TestTarget(string.format("raid%dpet", i))
		end

		if oRA_MainTank and oRA_MainTank.MainTankTable then
			for _,val in pairs(oRA_MainTank.MainTankTable) do
				local unit
				for i=1,rmem do if UnitName("raid"..i) == val then unit = "raid"..i end end
				if unit then self:AddTank(unit) end
			end
		elseif oRA and oRA.maintanktable then
			for _,val in pairs(oRA.maintanktable) do
				local unit
				for i=1,rmem do if UnitName("raid"..i) == val then unit = "raid"..i end end
				if unit then self:AddTank(unit) end
			end
		elseif CT_RATarget and CT_RATarget.MainTanks then
			for _,val in pairs(CT_RATarget.MainTanks) do self:AddTank("raid"..val[1]) end
		end
	elseif pmem > 0 then
		for i = 1,pmem do
			self:TestTarget("party"..i)
			self:TestTarget(string.format("party%dpet", i))
		end
	end
	if rmem == 0 then self:TestTarget("player") end
	self:TestTarget("pet")

	local numframes = math.min(numtargets, self.db.profile.maxframes)
	if numframes > framecount then framecount = numframes end
	self:UpdateFrames()

--~~ 	local targs = math.min(numtargets, self.db.profile.maxframes)
	delaycount = math.min(numtargets, self.db.profile.maxframes)
--~~ 	local newrate = targs == 0 and self.db.profile.baserate or self.db.profile.baserate*targs
--~~ 	metro:ChangeRate("PerfectTargets Targets", newrate)
end


function PerfectTargets:TestTarget(unit)
	if not unit or not UnitExists(unit) or tanks[unit] or not UnitExists(unit.."target")
	or UnitIsCivilian(unit.."target") or UnitIsDead(unit.."target") or UnitIsCorpse(unit.."target")
	or not UnitCanAttack("player", unit.."target") or not UnitIsVisible(unit) or not UnitIsVisible(unit.."target") then return end

	for i,unit2 in pairs(targets) do
		if UnitIsUnit(unit.."target", unit2.."target") then
			if unit ~= "player" and unit ~= "pet" then targetcounts[i] = targetcounts[i] + 1 end
			return
		end
	end

	table.insert(targets, unit)
	numtargets = numtargets + 1
	if unit ~= "player" and unit ~= "pet" then table.insert(targetcounts, 1)
	else table.insert(targetcounts, 0) end
end


function PerfectTargets:AddTank(unit)
	if not unit or not UnitExists(unit) or not UnitExists(unit.."target") then return end

	local initial = string.sub(UnitName(unit), 0, self.db.profile.numinitials)
	for i,unit2 in pairs(targets) do
		if UnitIsUnit(unit.."target", unit2.."target") then
			tankstrings[i] = (tankstrings[i] or "") .. initial
		end
	end
end


function PerfectTargets:UnitUnderControl(unit)
	for i=1,16 do
		if ccdebufftextures[UnitDebuff(unit, i)] then
			gratuity:SetUnitDebuff(unit,i)

			local txt = gratuity:GetLine(1)
			if txt and ccdebuffs[txt] then return true end
		end
	end
end


function PerfectTargets:UnitMarked(unit)
	for i=1,16 do
		if UnitDebuff(unit, i) == "Interface\\Icons\\Ability_Hunter_SniperShot" then
			gratuity:SetUnitDebuff(unit,i)

			local txt = gratuity:GetLine(1)
			if txt and txt == "猎人印记" then return true end
		end
	end
end


function PerfectTargets:GetHPSeverity(unit, percent, smooth)
	if (percent<=0) or (percent > 1.0) then return 0.35, 0.35, 0.35 end

	if smooth then
		if percent >= 0.5 then return (1.0-percent)*2, 1.0, 0.0
		else return 1.0, percent*2, 0.0 end
	else return 0, 1, 0 end
end

