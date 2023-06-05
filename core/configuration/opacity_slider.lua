local addon, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local helpers = ns.components.helpers

local opacity_slider = CreateFrame(
  "Frame",
  addon .. "_section_selector_frame",
  nil
)

function opacity_slider:init(parent, current_opacity, font_object, statusbar_name)
  self:SetParent(parent)
  self:SetHeight(20)

  local slider = helpers:create_status_bar({
    parent            = self,
    font_object       = font_object,
    title             = ("Background Opacity (%d%%)"):format(current_opacity * 100),
    value             = current_opacity * 100,
    statusbar_texture = statusbar_name,
    visible           = true
  })

  slider.sliding = false

  slider.button:EnableMouse(true)
  slider.button:RegisterForDrag("LeftButton")

  slider.button:SetScript("OnUpdate", function()
    if self.sliding then
      local x = GetCursorPosition()
      local ui_scale = UIParent:GetEffectiveScale()
      local opacity = ((x / ui_scale) - self:GetLeft()) / self:GetWidth()
      local value = 100 * opacity

      if opacity > 1 then opacity = 1 end
      if opacity < 0 then opacity = 0 end

      if value > 100 then value = 100 end
      if value < 0 then value = 0 end

      slider.foreground:SetValue(value)
      slider.title:SetText(("Background Opacity (%d%%)"):format(value))
      event_manager:handle(custom_events.BACKGROUND_OPACITY_CHANGED, opacity)
    end
  end)

  slider.button:SetScript("OnDragStart", function(_, button)
    self.sliding = true
  end)

  slider.button:SetScript("OnDragStop", function(_, button)
    self.sliding = false
  end)

  slider.button:SetScript("OnMouseDown", function(_, button)
    self.sliding = true
  end)

  slider.button:SetScript("OnMouseUp", function(_, button)
    self.sliding = false
  end)

  slider:SetPoint("TOPLEFT", self, "TOPLEFT", 2, 0)
  slider:SetPoint("RIGHT", self, "RIGHT", -2, 0)

  return self
end

ns.config.opacity_slider = opacity_slider
