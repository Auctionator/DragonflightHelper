local addon, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local helpers = ns.components.helpers

local opacity_slider = CreateFrame(
  "Frame",
  addon .. "_section_selector_frame",
  nil
)

function opacity_slider:init(parent, current_opacity, font_object)
  self:SetParent(parent)
  self:SetHeight(20)

  local slider = CreateFrame("Frame", addon .. "_opacity_slider", self)
  slider:SetHeight(15)
  slider:SetPoint("TOPLEFT", self, "TOPLEFT", 10)
  slider:SetPoint("RIGHT", self, "RIGHT", -10)

  helpers:add_border(slider)

  slider:SetScript("OnMouseDown", function()
    local mouse_x, mouse_y = GetCursorPosition()
    local frame_x = slider:GetLeft()
    local width = slider:GetWidth()

    print((mouse_x - frame_x) / width)
  end)

  -- self.slider = CreateFrame(
  --   "Slider",
  --   addon .. "_OpacitySlider",
  --   self
  -- )
  -- self.slider:SetPoint("TOPLEFT", slider, "BOTTOMLEFT")
  -- self.slider:SetPoint("RIGHT", slider, "RIGHT")
  -- self.slider:SetHeight(10)
  -- self.slider:SetOrientation("HORIZONTAL")
  -- self.slider:SetHeight(15)
  -- self.slider:SetMinMaxValues(0, 1)
  -- self.slider:SetValue(current_opacity)
  -- self.slider:SetValueStep(0.01)
  -- self.slider:SetObeyStepOnDrag(true)

  -- self.title = helpers:create_title_string(self, font_object, ("Background Opacity (%d%%)"):format(current_opacity * 100))
  -- self:SetHeight(self.title:GetStringHeight() + 15)
  -- self.title:ClearAllPoints()
  -- self.title:SetAllPoints()

  -- self.slider:SetPoint("TOPLEFT", slider, "BOTTOMLEFT", 0, -2)

  -- self.slider:SetScript("OnValueChanged", function(_, value)
  --   self.slider.Text:SetText("Background Opacity (" .. math.floor(value * 100) .. "%)")

  --   event_manager:handle(custom_events.BACKGROUND_OPACITY_CHANGED, value)
  -- end)

  return self
end

ns.config.opacity_slider = opacity_slider
