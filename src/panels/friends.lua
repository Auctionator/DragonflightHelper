local addon, ns = ...
local components = ns.components
local theme = ns.theme
local constants = ns.constants
local media = ns.media

local frame_name = addon .. "_faction_frame"
local friends = CreateFrame("Frame", frame_name)

function friends:init(parent)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(
    self,
    media:get_font_object(theme:get_font()),
    "Friends"
  )
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight() + 3)

  self:initialize_friends()

  return self
end

function friends:recalculate_height()
  local selected_friends = theme:get_friends()

  self:SetHeight(self.title:GetStringHeight())

  local count = 0

  for key, is_showing in pairs(selected_friends) do
    if is_showing then
      self:SetHeight(self:GetHeight() + self.friend_bars[key]:GetHeight() + 3)
      count = count + 1
    end
  end

  if count > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

function friends:initialize_friends()
  self.friend_bars = {}

  local friends = theme:get_section(constants.SECTIONS.FRIENDS)
  local statusbar_texture = theme:get_statusbar()
  local font_object = media:get_font_object(theme:get_font())
  local bars_showing = 0

  for key, subsection in pairs(friends.subsections) do
    local bar = components.helpers:create_status_bar({
      parent = self,
      font_object = font_object,
      statusbar_texture = statusbar_texture,
      visible = subsection.display,
      title = key
    })
    ns.factions.info:attach(bar, key)

    if subsection.display then
      bar:SetPoint("TOP", self.previous, "BOTTOM", 0, -2)
      bar:SetPoint("RIGHT", self.previous, "RIGHT")
      self.previous = bar
      self:SetHeight(self:GetHeight() + bar:GetHeight() + 3)

      bars_showing = bars_showing + 1
      bar:Show()
    end

    self.friend_bars[key] = bar
    self.previous = bar
  end

  if bars_showing > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

ns.panels.friends = friends
