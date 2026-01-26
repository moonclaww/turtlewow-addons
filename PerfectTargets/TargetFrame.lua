
PerfectRaidTargetFrame = {
	offset = -2,
	barheight = 7,

	colors = {
		tank = {0,0.7,0.7},
		green = {0,1,0},
		duptank = {1,0.7,1},
		yellow = {1,1,0},
		red = {1,0,0},
		dkred = {0.5,0,0},
		grey = {0.5,0.5,0.5},
		white = {1,1,1},
	},
}


function PerfectRaidTargetFrame:CreateAnchorFrame(mainframe)
	if not mainframe then return end

	local t = CreateFrame("Button", nil, mainframe)
	t:Hide()

	t.MyTarget = t:CreateFontString(nil, "ARTWORK")
	t.MyTarget:SetFontObject(GameFontHighlightSmall)
	t.MyTarget:SetText(">")
	t.MyTarget:SetPoint("BOTTOMLEFT", mainframe, "TOPLEFT")

	t.RaidIcon = t:CreateTexture(nil, "ARTWORK")
	t.RaidIcon:SetPoint("TOPLEFT", t.MyTarget, "TOPRIGHT")
	t.RaidIcon:SetPoint("BOTTOMLEFT", t.MyTarget, "BOTTOMRIGHT")
	t.RaidIcon:SetWidth(t.MyTarget:GetHeight())
	t.RaidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	SetRaidTargetIconTexture(t.RaidIcon, 1)

	t.Targetted = t:CreateFontString(nil, "ARTWORK")
	t.Targetted:SetFontObject(GameFontHighlightSmall)
	t.Targetted:SetText("40")
	t.Targetted:SetPoint("LEFT", t.RaidIcon, "RIGHT")

	t.PetTarget = t:CreateFontString(nil, "ARTWORK")
	t.PetTarget:SetFontObject(GameFontHighlightSmall)
	t.PetTarget:SetText("<")
	t.PetTarget:ClearAllPoints()
	t.PetTarget:SetPoint("LEFT", t.Targetted, "RIGHT")

	t.MobName = t:CreateFontString(nil, "ARTWORK")
	t.MobName:SetFontObject(GameFontHighlightSmall)
	t.MobName:SetText("*Unknown*")
	t.MobName:SetJustifyH("RIGHT")
	t.MobName:SetPoint("LEFT", t.PetTarget, "RIGHT", 2, 0)
	self.namewidth = t.MobName:GetStringWidth()
	self.defaultnamewidth = self.namewidth
	self.minwidth = t.minwidth

	t.Bar = CreateFrame("StatusBar", nil, t)
	t.Bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	t.Bar:SetMinMaxValues(0,100)
	t.Bar:ClearAllPoints()
	t.Bar:SetPoint("LEFT", t.MobName, "RIGHT", 5, 0)
	t.Bar:SetWidth(60)
	t.Bar:SetHeight(self.barheight)

	t.HPP = t:CreateFontString(nil, "ARTWORK")
	t.HPP:SetFontObject(GameFontHighlightSmall)
	t.HPP:SetText("100%")
	t.HPP:ClearAllPoints()
	t.HPP:SetPoint("LEFT", t.Bar, "RIGHT", 5, 0)

	t.Tanks = t:CreateFontString(nil, "ARTWORK")
	t.Tanks:SetFontObject(GameFontHighlightSmall)
	t.Tanks:SetText("X")
	t.Tanks:ClearAllPoints()
	t.Tanks:SetPoint("LEFT", t.HPP, "RIGHT", 5, 0)
	self.tankwidth = t.Tanks:GetStringWidth()
	self.defaulttankwidth = self.tankwidth

	t:SetPoint("TOPLEFT", t.MyTarget, "TOPLEFT")
	t:SetPoint("BOTTOMRIGHT", t.Tanks, "BOTTOMRIGHT")

	self.anchorframe = t
	return t
end


function PerfectRaidTargetFrame:CreateTargetFrame(i, mainframe, anchor)
	if not i or not mainframe or not anchor then return end
	local t = CreateFrame("Button", nil, mainframe)
	t:Hide()

	t:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp", "Button4Up", "Button5Up")
	t:SetScript("OnClick", self.OnClick)
	t:SetScript("OnEnter", self.OnEnter)
	t:SetScript("OnLeave", self.OnLeave)

	t.Targetted = t:CreateFontString(nil, "ARTWORK")
	t.Targetted:SetFontObject(GameFontHighlightSmall)
	t.Targetted:SetText("40")
	t.Targetted:SetTextColor(1,1,1)
	t.Targetted:SetJustifyH("CENTER")
	t.Targetted:SetPoint("TOPLEFT", anchor.Targetted, "BOTTOMLEFT", 0, self.offset)
	t.Targetted:SetPoint("TOPRIGHT", anchor.Targetted, "BOTTOMRIGHT", 0, self.offset)
	t.Targetted:Show()

	t.RaidIcon = t:CreateTexture(nil, "ARTWORK")
	t.RaidIcon:SetPoint("TOPLEFT", anchor.RaidIcon, "BOTTOMLEFT")
	t.RaidIcon:SetPoint("BOTTOMRIGHT", t.Targetted, "BOTTOMLEFT")
	t.RaidIcon:SetWidth(t.RaidIcon:GetHeight())
	t.RaidIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	SetRaidTargetIconTexture(t.RaidIcon, 0)
	t.RaidIcon:Show()

	t.MyTarget = t:CreateFontString(nil, "ARTWORK")
	t.MyTarget:SetFontObject(GameFontHighlightSmall)
	t.MyTarget:SetText(">")
	t.MyTarget:SetJustifyH("RIGHT")
	t.MyTarget:SetPoint("RIGHT", t.RaidIcon, "LEFT")
	t.MyTarget:Show()

	t.PetTarget = t:CreateFontString(nil, "ARTWORK")
	t.PetTarget:SetFontObject(GameFontHighlightSmall)
	t.PetTarget:SetText("<")
	t.PetTarget:SetJustifyH("LEFT")
	t.PetTarget:SetTextColor(1,0,0)
	t.PetTarget:SetPoint("LEFT", t.Targetted, "RIGHT")
	t.PetTarget:Show()

	t.MobName = t:CreateFontString(nil, "ARTWORK")
	t.MobName:SetFontObject(GameFontHighlightSmall)
	t.MobName:SetText("Unknown")
	t.MobName:SetJustifyH("RIGHT")
	t.MobName:SetPoint("TOPLEFT", anchor.MobName, "BOTTOMLEFT", 0, self.offset)
	t.MobName:SetPoint("TOPRIGHT", anchor.MobName, "BOTTOMRIGHT", 0, self.offset)
	t.MobName:Show()

	t.HPP = t:CreateFontString(nil, "ARTWORK")
	t.HPP:SetFontObject(GameFontHighlightSmall)
	t.HPP:SetJustifyH("RIGHT")
	t.HPP:ClearAllPoints()
	t.HPP:SetPoint("TOPLEFT", anchor.HPP, "BOTTOMLEFT", 0, self.offset)
	t.HPP:SetPoint("TOPRIGHT", anchor.HPP, "BOTTOMRIGHT", 0, self.offset)
	t.HPP:Show()

	t.Tanks = t:CreateFontString(nil, "ARTWORK")
	t.Tanks:SetFontObject(GameFontHighlightSmall)
	t.Tanks:SetJustifyH("LEFT")
	t.Tanks:ClearAllPoints()
	t.Tanks:SetPoint("TOP", t.HPP, "TOP")
	t.Tanks:SetPoint("LEFT", anchor.Tanks, "LEFT", 0, self.offset)
	t.Tanks:SetPoint("RIGHT", anchor.Tanks, "RIGHT", 0, self.offset)
	t.Tanks:Show()

	t.Bar = CreateFrame("StatusBar", nil, t)
	t.Bar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar")
	t.Bar:SetMinMaxValues(0,100)
	t.Bar:ClearAllPoints()
	t.Bar:SetPoint("LEFT", t.MobName, "RIGHT", 5, 0)
	t.Bar:SetPoint("RIGHT", t.HPP, "LEFT", -5, 0)
	t.Bar:SetHeight(self.barheight)
	t.Bar:Show()

	t:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT")
	t:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT")
	t:SetPoint("BOTTOM", t.MobName, "BOTTOM")
	t:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 32,
		edgeFile = "", edgeSize = 0,
		insets = {left = 0, right = -2, top = 0, bottom = -2},
		})
	return t
end


function PerfectRaidTargetFrame:OnEnter()
	this.hover = true
end


function PerfectRaidTargetFrame:OnLeave()
	this.hover = nil
end


function PerfectRaidTargetFrame:OnClick()
	local unit = this.unit
	if UnitIsUnit(unit, "player") then unit = "player" end

	local button = arg1

	if PerfectTargetsCustomClick then PerfectTargetsCustomClick(arg1, unit)
	else
		if not UnitExists(unit) then return end

		if SpellIsTargeting() then
			if button == "LeftButton" then SpellTargetUnit(unit)
			elseif button == "RightButton" then	SpellStopTargeting() end
			return
		end

		if CursorHasItem() then
			if button == "LeftButton" then
				if unit=="player" then AutoEquipCursorItem()
				else DropItemOnUnit(unit) end
			else PutItemInBackpack() end
			return
		end

		TargetUnit(unit)
	end
end


function PerfectRaidTargetFrame:UpdateTargetFrame(frame, unit, tank, targCount, hpp, duptank, tankstring, resetwidth)
	if not frame then return end
	frame.unit = unit
	frame.tank = tank
	local mobname = frame.hover and tank and UnitName(tank) or unit and UnitName(unit) or "*Unknown*"
	local oldname = frame.MobNameText
	self:UpdateFrameText(frame, "MyTarget", unit and UnitIsUnit("target", unit) and ">" or "")
	self:UpdateFrameText(frame, "PetTarget", unit and UnitIsUnit("pettarget", unit) and not duptank and "<" or "")
	self:UpdateFrameText(frame, "Targetted", not duptank and targCount or "-")
	self:UpdateFrameText(frame, "MobName", mobname)
	self:UpdateFrameText(frame, "HPP", hpp and string.format("%d%%", hpp) or "")
	self:UpdateFrameText(frame, "Tanks", tankstring or "")
	self:UpdateFrameIcon(frame, unit and GetRaidTargetIndex(unit) or 0)

	self:UpdateMobNameWidth(frame.MobName:GetStringWidth()*UIParent:GetScale(), resetwidth)
	self:UpdateTankNameWidth(frame.Tanks:GetStringWidth()*UIParent:GetScale(), resetwidth)

	if frame.hpp ~= (hpp or 0) then
		frame.hpp = hpp or 0
		frame.Bar:SetStatusBarColor(self:GetHPSeverity(nil, (hpp or 0)/100, 1))
		frame.Bar:SetValue(hpp or 0)
	end

	if frame.shown ~= (unit ~= nil) then
		frame.shown = (unit ~= nil)
		if frame.shown then frame:Show() else frame:Hide() end
	end
end


function PerfectRaidTargetFrame:UpdateFrameText(frame, elem, newtext)
	if not frame or not elem or not frame[elem] then return end
	if frame[elem.."Text"] == newtext then return end

	frame[elem.."Text"] = newtext
	frame[elem]:SetText(newtext)
end


function PerfectRaidTargetFrame:UpdateFrameIcon(frame, newidx)
	if not frame or not frame.RaidIcon then return end
	if frame.RaidIconIdx == newidx then return end

	frame.RaidIconIdx = newidx
	SetRaidTargetIconTexture(frame.RaidIcon, newidx)
end


function PerfectRaidTargetFrame:UpdateTargetFrameColors(frame, tot, playercombat, isfriend, unitcombat, status)
	self:UpdateFrameTextColor(frame, "MyTarget", playercombat and self.colors.red or self.colors.white)
	self:UpdateFrameTextColor(frame, "MobName",
		(frame.hover and frame.tank or frame.unit and frame.tank and frame.unit == frame.tank) and self.colors.tank
		or UnitIsFriend(frame.unit, "player") and self.colors.green
		or status == 1 and self.colors.yellow
		or frame.tank and unitcombat and not tot and not UnitIsDead(frame.unit) and not UnitIsCorpse(frame.unit) and self.colors.duptank
		or status == 2 and unitcombat and self.colors.red
		or status == 2 and self.colors.dkred
		or unitcombat and self.colors.white or self.colors.grey)
end


function PerfectRaidTargetFrame:UpdateFrameTextColor(frame, elem, color)
	if not frame or not elem or not frame[elem] or not color then return end
	if frame[elem.."Color"] == color then return end

	frame[elem.."Color"] = color
	frame[elem]:SetTextColor(color[1], color[2], color[3])
end


function PerfectRaidTargetFrame:UpdateMobNameWidth(newwidth, reset)
	if reset or newwidth > self.namewidth then
		local neww = math.max(reset and 0 or self.namewidth, newwidth, self.defaultnamewidth)
		self.anchorframe.MobName:SetWidth(neww)
		self.namewidth = neww
	end
end


function PerfectRaidTargetFrame:UpdateTankNameWidth(newwidth, reset)
	if reset or newwidth > self.tankwidth then
		local neww = math.max(reset and 1 or self.tankwidth, newwidth, self.defaulttankwidth)
		self.anchorframe.Tanks:SetWidth(neww)
		self.tankwidth = neww
	end
end


function PerfectRaidTargetFrame:GetHPSeverity(unit, percent, smooth)
	if (percent<=0) or (percent > 1.0) then return 0.35, 0.35, 0.35 end

	if smooth then
		if percent >= 0.5 then return (1.0-percent)*2, 1.0, 0.0
		else return 1.0, percent*2, 0.0 end
	else return 0, 1, 0 end
end



