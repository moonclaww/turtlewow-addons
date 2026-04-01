-- Shared compatibility helpers for Blizzard OptionsFrame APIs missing on Turtle.

local function OFC_SetRegionColor(region, color, fallbackR, fallbackG, fallbackB)
	if region then
		local r = fallbackR
		local g = fallbackG
		local b = fallbackB

		if color then
			r = color.r
			g = color.g
			b = color.b
		end

		if region.SetTextColor then
			region:SetTextColor(r, g, b)
		else
			if region.SetVertexColor then
				region:SetVertexColor(r, g, b)
			end
		end
	end
end

if not OptionsFrame_EnableCheckBox then
	function OptionsFrame_EnableCheckBox(checkBox)
		if not checkBox then
			return
		end

		checkBox:Enable()
		OFC_SetRegionColor(getglobal(checkBox:GetName().."Text"), NORMAL_FONT_COLOR or HIGHLIGHT_FONT_COLOR, 1.0, 0.82, 0.0)
	end
end

if not OptionsFrame_DisableCheckBox then
	function OptionsFrame_DisableCheckBox(checkBox)
		if not checkBox then
			return
		end

		checkBox:Disable()
		OFC_SetRegionColor(getglobal(checkBox:GetName().."Text"), GRAY_FONT_COLOR, 0.5, 0.5, 0.5)
	end
end

local function OFC_SetSliderLabel(frame, suffix, color, fallbackR, fallbackG, fallbackB)
	OFC_SetRegionColor(getglobal(frame:GetName()..suffix), color, fallbackR, fallbackG, fallbackB)
end

local function OFC_SetSliderState(frame, enabled)
	local thumb = getglobal(frame:GetName().."Thumb")

	if enabled then
		if frame.Enable then
			frame:Enable()
		end
		if frame.EnableMouse then
			frame:EnableMouse(true)
		end
		if frame.EnableMouseWheel then
			frame:EnableMouseWheel(true)
		end
		frame:SetAlpha(1)
		if thumb then
			thumb:SetVertexColor(1, 1, 1)
		end
		OFC_SetSliderLabel(frame, "Text", NORMAL_FONT_COLOR, 1.0, 0.82, 0.0)
		OFC_SetSliderLabel(frame, "Low", HIGHLIGHT_FONT_COLOR, 1.0, 0.82, 0.0)
		OFC_SetSliderLabel(frame, "High", HIGHLIGHT_FONT_COLOR, 1.0, 0.82, 0.0)
		OFC_SetSliderLabel(frame, "Current", nil, 0.4, 0.4, 0.8)
	else
		if frame.Disable then
			frame:Disable()
		end
		if frame.EnableMouse then
			frame:EnableMouse(false)
		end
		if frame.EnableMouseWheel then
			frame:EnableMouseWheel(false)
		end
		frame:SetAlpha(0.7)
		if thumb then
			thumb:SetVertexColor(0.5, 0.5, 0.5)
		end
		OFC_SetSliderLabel(frame, "Text", GRAY_FONT_COLOR, 0.5, 0.5, 0.5)
		OFC_SetSliderLabel(frame, "Low", GRAY_FONT_COLOR, 0.5, 0.5, 0.5)
		OFC_SetSliderLabel(frame, "High", GRAY_FONT_COLOR, 0.5, 0.5, 0.5)
		OFC_SetSliderLabel(frame, "Current", GRAY_FONT_COLOR, 0.5, 0.5, 0.5)
	end
end

if not OptionsFrame_EnableSlider then
	function OptionsFrame_EnableSlider(frame)
		if not frame then
			return
		end

		OFC_SetSliderState(frame, true)
	end
end

if not OptionsFrame_DisableSlider then
	function OptionsFrame_DisableSlider(frame)
		if not frame then
			return
		end

		OFC_SetSliderState(frame)
	end
end
