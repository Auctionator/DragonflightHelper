local addon, ns = ...
local components = ns.components

local frame_name = addon .. "_faction_frame"
local factions = CreateFrame("Frame", frame_name)

function factions:init(parent, initial_font_object, statusbar_texture, selected_factions)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(self, initial_font_object, "Factions")
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight())

  self:initialize_factions(selected_factions, initial_font_object, statusbar_texture)

  return self
end

function factions:initialize_factions(selected_factions, font_object, statusbar_texture)
  self.faction_bars = {}

  local bars_showing = 0

  for key, is_showing in pairs(selected_factions) do
    local bar = components.helpers:create_status_bar({
      parent = self,
      font_object = font_object,
      statusbar_texture = statusbar_texture,
      visible = is_showing
    })
    ns.factions.info:attach(bar, key)

    if is_showing then
      bar:ClearAllPoints()
      bar:SetPoint("TOPLEFT", self.previous, "BOTTOMLEFT", 0, -2)
      bar:SetPoint("RIGHT", self.previous, "RIGHT")
      self.previous = bar
      self:SetHeight(self:GetHeight() + bar:GetHeight() + 3)

      bar:Show()
      bars_showing = bars_showing + 1
    end

    table.insert(self.faction_bars, bar)
  end

  if bars_showing > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

ns.panels.factions = factions
