local addon, ns = ...

local event_manager = ns.events.manager
local ui_components = ns.components
local custom_events = ns.events.custom
local theme = ns.theme
local media = ns.media

local font_dropdown = ns.config.font_dropdown
local statusbar_dropdown = ns.config.statusbar_dropdown
local section_selector = ns.config.section_selector
local opacity_slider = ns.config.opacity_slider

local frame_name = addon .. "_configuration_panel"
local addon_configuration = CreateFrame("Frame", frame_name, ns.main)

-- local addon_configuration = ui_components:frame({
--   name = "DFH_Configuration", width = 200, height = 500
-- })

function addon_configuration:init()
  self:SetHeight(500)
  self:SetWidth(200)

  self.texture = self:CreateTexture()
  self.texture:SetAllPoints()
  self.texture:SetColorTexture(0, 0, 0)

  self.showing = false

  event_manager:subscribe(
    self,
    {
      custom_events.OPEN_CONFIG,
      custom_events.CLOSE_CONFIG,
      custom_events.THEME_LOADED,
      custom_events.BACKGROUND_OPACITY_CHANGED
    },
    frame_name
  )
end

function addon_configuration:initialize_frames(theme)
  self.texture:SetAlpha(theme.background_opacity)

  self.font_dropdown = font_dropdown:init(self, theme.font_name)
  self.font_dropdown:SetPoint("TOP", self, "TOP")
  self.font_dropdown:SetPoint("LEFT", self, "LEFT")
  self.font_dropdown:SetPoint("RIGHT", self, "RIGHT")
  -- UIDropDownMenu_SetWidth(self.font_dropdown, self:GetWidth() - 24)

  self.statusbar_dropdown = statusbar_dropdown:init(self, theme.statusbar_name)
  self.statusbar_dropdown:SetPoint("TOPLEFT", self.font_dropdown, "BOTTOMLEFT")
  self.statusbar_dropdown:SetPoint("RIGHT", self, "RIGHT")
  -- UIDropDownMenu_SetWidth(self.statusbar_dropdown, self:GetWidth() - 24)

  self.opacity_slider = opacity_slider:init(self, theme.background_opacity, media:get_font_object(theme.font_name)
  )
  self.opacity_slider:ClearAllPoints()
  self.opacity_slider:SetPoint("TOP", self.statusbar_dropdown, "BOTTOM", 0, -10)
  self.opacity_slider:SetPoint("LEFT", self, "LEFT", 10, 0)
  self.opacity_slider:SetPoint("RIGHT", self, "RIGHT", 10, 0)
  -- self.opacity_slider:SetWidth(200 - 20)
  -- self.opacity_slider:SetPoint("TOP", self.statusbar_dropdown, "BOTTOM", 0, -10)
  -- self.section_selector = section_selector:init(self, sections)
  -- self.section_selector:SetPoint("TOP", self.opacity_slider, "BOTTOM")
  -- self.section_selector:SetPoint("LEFT", self, "LEFT")
  -- self.section_selector:SetPoint("RIGHT", self, "RIGHT")
end

function addon_configuration:notify(event_name, ...)
  if event_name == custom_events.OPEN_CONFIG then
    self:SetPoint("TOPLEFT", ..., "TOPRIGHT")

    self.showing = true
    self:Show()
  elseif event_name == custom_events.CLOSE_CONFIG then
    self.showing = false
    self:Hide()
  elseif event_name == custom_events.THEME_LOADED then
    self:initialize_frames(...)
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self:SetBackdropColor(0, 0, 0, ...)
  end
end

addon_configuration:init()
ns.config.panel = addon_configuration
