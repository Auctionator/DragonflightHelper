local addon, ns = ...
local helpers = ns.components.helpers
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media

function helpers:create_status_bar(options)
  if options == nil then
    options = {}
  end

  local parent_frame = options.parent or ns.main
  local font_object = options.font_object
  local statusbar_texture = options.statusbar_texture
  local title = options.title or ""
  local description = options.description or ""
  local color = options.color or BLUE_FONT_COLOR
  local min = options.min or 0
  local max = options.max or 100
  local value = options.value or 0
  local data = options.data or {}
  local visible = options.visible or false

  if font_object == nil then
    error("font_object is required to create a status bar")
  end

  if statusbar_texture == nil then
    error("statusbar_texture is required to create a status bar")
  end

  local container_name = addon .. "_status_bar_container_" .. self:get_id()
  local bar_texture = media:get_statusbar(statusbar_texture)

  local frame = CreateFrame("FRAME", container_name, parent_frame)
  frame:SetHeight(15)
  frame:EnableMouse(true)
  frame.data = data

  if not visible then
    frame:Hide()
  end

  local foreground = CreateFrame("StatusBar", addon .. "_status_bar_" .. self:get_id(), frame)
  foreground:ClearAllPoints()
  foreground:SetPoint("TOPLEFT", frame, "TOPLEFT", 2)
  foreground:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2)
  foreground:SetStatusBarTexture(bar_texture)
  foreground:SetStatusBarColor(color.r, color.g, color.b, color.a)
  foreground:SetMinMaxValues(min, max)
  foreground:SetValue(value)
  frame.foreground = foreground

  local background = CreateFrame("StatusBar", addon .. "_status_bar_" .. self:get_id(), frame)
  background:ClearAllPoints()
  background:SetPoint("TOPLEFT", frame, "TOPLEFT", 2)
  background:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2)
  background:SetStatusBarTexture(bar_texture)
  background:SetStatusBarColor(220, 220, 220, 0.2)
  background:SetMinMaxValues(min, max)
  frame.background = background

  local title = self:create_title_string(foreground, font_object, title)
  title:ClearAllPoints()
  title:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, 0)
  title:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 0)
  title:SetJustifyH("LEFT")
  title:SetJustifyV("MIDDLE")
  frame.title = title

  local description = self:create_title_string(foreground, font_object, description)
  description:ClearAllPoints()
  description:SetPoint("TOPLEFT", frame, "TOPLEFT", 3, 0)
  description:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 0)
  description:SetJustifyH("RIGHT")
  description:SetJustifyV("MIDDLE")
  frame.description = description

  frame.notify = function(_, event_name, ...)
    if event_name == custom_events.STATUSBAR_TEXTURE_CHANGED then
      local new_bar_texture = media:get_statusbar(...)

      frame.background:SetStatusBarTexture(new_bar_texture)
      frame.foreground:SetStatusBarTexture(new_bar_texture)
    end

    if options.notify then
      options.notify(frame, event_name, ...)
    end
  end

  if options.events == nil then
    options.events = {}
  end
  options.events[#options.events + 1] = custom_events.STATUSBAR_TEXTURE_CHANGED

  if options.events then
    event_manager:subscribe(frame, options.events, container_name)
  end

  return frame
end
