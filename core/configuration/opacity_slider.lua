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

  slider:EnableMouse(true)
  slider:RegisterForDrag("LeftButton")

  slider:SetScript("OnUpdate", function()
    if self.sliding then
      local x = GetCursorPosition()
      local ui_scale = UIParent:GetEffectiveScale()
      local opacity = ((x / ui_scale) - self:GetLeft()) / self:GetWidth()
      local value = 100 * opacity

      slider.foreground:SetValue(value)
      slider.title:SetText(("Background Opacity (%d%%)"):format(value))
      event_manager:handle(custom_events.BACKGROUND_OPACITY_CHANGED, opacity)
    end
  end)
  slider:SetScript("OnMouseDown", function(_, button)
    print("OnMouseDown", button)
    self.sliding = true
  end)
  slider:SetScript("OnDragStart", function(_, button)
    print("OnDragStart", button)
    self.sliding = true
  end)
  slider:SetScript("OnDragStop", function(_, button)
    print("OnDragStop", button)
    self.sliding = false
  end)


  slider:SetPoint("TOPLEFT", self, "TOPLEFT", 2, 0)
  slider:SetPoint("RIGHT", self, "RIGHT", -2, 0)

  return self
end

ns.config.opacity_slider = opacity_slider