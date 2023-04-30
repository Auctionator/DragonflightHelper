local addon, ns = ...
local components = ns.components

local frame_name = addon .. "_faction_frame"
local friends = CreateFrame("Frame", frame_name)

function friends:init(parent, initial_font_object, statusbar_texture, selected_friends)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(self, initial_font_object, "Friends")
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight())

  self:initialize_friends(selected_friends, initial_font_object, statusbar_texture)

  return self
end

function friends:initialize_friends(selected_friends, font_object, statusbar_texture)
  self.friend_bars = {}

  local bars_showing = 0

  for key, is_showing in pairs(selected_friends) do
    local bar = components.helpers:create_status_bar({
      parent = self,
      font_object = font_object,
      statusbar_texture = statusbar_texture,
      visible = is_showing,
    })
    ns.factions.info:attach(bar, key)

    if is_showing then
      bar:Show()

      bar:SetPoint("TOP", self.previous, "BOTTOM", 0, -2)
      bar:SetPoint("RIGHT", self.previous, "RIGHT")
      self.previous = bar
      self:SetHeight(self:GetHeight() + bar:GetHeight() + 2)

      bars_showing = bars_showing + 1
    end

    table.insert(self.friend_bars, bar)
  end

  if bars_showing > 0 then
    self:SetHeight(self:GetHeight() + 3)
  end
end

ns.panels.friends = friends
