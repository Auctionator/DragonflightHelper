local addon, ns = ...
local helpers = ns.components.helpers
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log

function helpers:create_title_string(parent_frame, font_object, text)
  local title = parent_frame:CreateFontString()
  local title_frame_name = addon .. "_title_string_" .. self:get_id()

  title:SetFontObject(font_object)
  title:SetText(text)
  title:SetPoint("TOPLEFT", parent_frame, "TOPLEFT", 2, -4)
  title:SetPoint("RIGHT", parent_frame, "RIGHT", -2)

  title.notify = function(_, event, ...)
    if event == custom_events.FONT_CHANGED then
      local _, font_object = ...
      title:SetFontObject(font_object)
    elseif event == custom_events.THEME_MEDIA_UPDATED then
      local theme = ...
      log(nil, "title_string", 1, event, title_frame_name .. ":" .. theme.font_name)
      title:SetFontObject(media:get_font_object(theme.font_name))
    end
  end

  event_manager:subscribe(title, { custom_events.FONT_CHANGED, custom_events.THEME_MEDIA_UPDATED }, title_frame_name)

  return title
end
