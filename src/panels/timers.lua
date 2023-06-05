local addon, ns = ...
local components = ns.components
local theme = ns.theme
local media = ns.media
local constants = ns.constants

local frame_name = addon .. "_timers_frame"
local timers = CreateFrame("Frame", frame_name)

function timers:init(parent)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(
    self,
    media:get_font_object(theme:get_font()),
    "Timers"
  )
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight() + 3)

  self:initialize_timers()

  return self
end

function timers:recalculate_height()
  local selected_timers = theme:get_section(constants.SECTIONS.TIMERS)

  self:SetHeight(self.title:GetStringHeight())

  for key, spec in pairs(selected_timers.subsections) do
    if spec.display then
      self:SetHeight(self:GetHeight() + self.timer_bars[key]:GetHeight() + 3)
    end
  end

  self:SetHeight(self:GetHeight() + self.relative_end_frame:GetHeight())
end

function timers:initialize_timers()
  self.timer_bars = {}

  local timers = theme:get_section(constants.SECTIONS.TIMERS)
  local statusbar_texture = theme:get_statusbar()
  local font_object = media:get_font_object(theme:get_font())

  self.siege_bar = components.helpers:create_status_bar({
    parent = self,
    font_object = font_object,
    statusbar_texture = statusbar_texture,
    title = "Siege Timer",
    visible = timers.subsections.Siege.display
  })
  ns.timers.info:attach(
    self.siege_bar,
    2,
    15,
    ITEM_QUALITY_COLORS[4],
    ITEM_QUALITY_COLORS[2],
    { map = 2022, x = 30.51, y = 77.91, title = "Siege starting area" }
  )
  self.timer_bars["Siege"] = self.siege_bar

  if timers.subsections.Siege.display then
    self.siege_bar:ClearAllPoints()
    self.siege_bar:SetPoint("TOPLEFT", self.previous, "BOTTOMLEFT", 0, -2)
    self.siege_bar:SetPoint("RIGHT", self.previous, "RIGHT")
    self.previous = self.siege_bar
    self:SetHeight(self:GetHeight() + self.siege_bar:GetHeight() + 3)

    self.siege_bar:Show()
  end

  self.feast_bar = components.helpers:create_status_bar({
    parent = self,
    font_object = font_object,
    statusbar_texture = statusbar_texture,
    title = "Feast Timer",
    visible = timers.subsections.Feast.display
  })
  ns.timers.info:attach(
    self.feast_bar,
    1.5,
    15,
    ITEM_QUALITY_COLORS[3],
    ITEM_QUALITY_COLORS[2],
    { map = 2024, x = 13.57, y = 48.58, title = "Feast" }
  )
  self.timer_bars["Feast"] = self.feast_bar

  if timers.subsections.Feast.display then
    self.feast_bar:ClearAllPoints()
    self.feast_bar:SetPoint("TOPLEFT", self.previous, "BOTTOMLEFT", 0, -2)
    self.feast_bar:SetPoint("RIGHT", self, "RIGHT")
    self.previous = self.feast_bar
    self:SetHeight(self:GetHeight() + self.feast_bar:GetHeight() + 3)

    self.feast_bar:Show()
  end

  self.relative_end_frame = CreateFrame("Frame", addon .. "_eom_frame", self)
  self.relative_end_frame:SetHeight(4)
  self.relative_end_frame:SetPoint("TOPLEFT", self.feast_bar, "BOTTOMLEFT")
  self.relative_end_frame:SetPoint("RIGHT", self, "RIGHT")

  self:SetHeight(self:GetHeight() + self.relative_end_frame:GetHeight())
end

ns.panels.timers = timers
