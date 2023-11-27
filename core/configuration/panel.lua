local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log

local font_dropdown = ns.config.font_dropdown
local statusbar_dropdown = ns.config.statusbar_dropdown
local section_selector = ns.config.section_selector
local opacity_slider = ns.config.opacity_slider

local frame_name = addon .. "_configuration_panel"
local addon_configuration = CreateFrame("Frame", frame_name, ns.main)

function addon_configuration:init()
  log("OK", "addon_configuration", 1, "init", "Loading")

  self:SetHeight(0)
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

  return self
end

function addon_configuration:initialize_frames(theme)
  log("OK", "addon_configuration", 3, "initialize_frames", "frames initing")
  self.texture:SetAlpha(theme.background_opacity)

  self.font_dropdown = font_dropdown:init(self, theme.font_name)
  self.font_dropdown:SetPoint("TOP", self, "TOP")
  self.font_dropdown:SetPoint("LEFT", self, "LEFT")
  self.font_dropdown:SetPoint("RIGHT", self, "RIGHT")
  self:SetHeight(self:GetHeight() + self.font_dropdown:GetHeight())

  self.statusbar_dropdown = statusbar_dropdown:init(self, theme.statusbar_name)
  self.statusbar_dropdown:SetPoint("TOPLEFT", self.font_dropdown, "BOTTOMLEFT")
  self.statusbar_dropdown:SetPoint("RIGHT", self, "RIGHT")
  self:SetHeight(self:GetHeight() + self.statusbar_dropdown:GetHeight())

  self.opacity_slider = opacity_slider:init(
    self,
    theme.background_opacity,
    media:get_font_object(theme.font_name),
    theme.statusbar_name
  )
  self.opacity_slider:SetPoint("TOPLEFT", self.statusbar_dropdown, "BOTTOMLEFT", 0, -5)
  self.opacity_slider:SetPoint("RIGHT", self, "RIGHT")
  self:SetHeight(self:GetHeight() + self.opacity_slider:GetHeight() + 5)

  self.section_selector = section_selector:init(self)
  self.section_selector:SetPoint("TOPLEFT", self.opacity_slider, "BOTTOMLEFT", 0, -5)
  self.section_selector:SetPoint("RIGHT", self, "RIGHT")
  self:SetHeight(self:GetHeight() + self.section_selector:GetHeight() + 5)
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
    local opacity = ...
    self.texture:SetAlpha(opacity)
  end
end

ns.config.panel = addon_configuration:init()
