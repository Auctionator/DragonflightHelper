local addon, ns = ...
local components = ns.components
local theme = ns.theme
local media = ns.media
local constants = ns.constants

local frame_name = addon .. "_faction_frame"
local factions = CreateFrame("Frame", frame_name)

function factions:init(parent)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(self, media:get_font_object(theme:get_font()), "Factions")
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight() + 3)

  self:initialize_factions()

  return self
end

function factions:recalculate_height()
  local selected_factions = theme:get_section(constants.SECTIONS.FACTIONS)

  self:SetHeight(self.title:GetStringHeight())

  local count = 0

  for key, spec in pairs(selected_factions.subsections) do
    if spec.display then
      self:SetHeight(self:GetHeight() + self.faction_bars[key]:GetHeight() + 3)
      count = count + 1
    end
  end

  if count > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

function factions:initialize_factions()
  self.faction_bars = {}

  local factions = theme:get_section(constants.SECTIONS.FACTIONS)
  local statusbar_texture = theme:get_statusbar()
  local font_object = media:get_font_object(theme:get_font())
  local bars_showing = 0

  for key, subsection in pairs(factions.subsections) do
    local bar = components.helpers:create_status_bar({
      parent = self,
      font_object = font_object,
      statusbar_texture = statusbar_texture,
      visible = subsection.display
    })
    ns.factions.info:attach(bar, key)

    if subsection.display then
      bar:ClearAllPoints()
      bar:SetPoint("TOPLEFT", self.previous, "BOTTOMLEFT", 0, -2)
      bar:SetPoint("RIGHT", self, "RIGHT", -2)
      self:SetHeight(self:GetHeight() + bar:GetHeight() + 3)

      bar:Show()
      bars_showing = bars_showing + 1
    end

    self.faction_bars[key] = bar
    self.previous = bar
  end

  if bars_showing > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

ns.panels.factions = factions
