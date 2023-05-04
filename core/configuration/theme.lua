local _, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log

local theme = {}

function theme:init()
  event_manager:subscribe(
    self,
    {
      "ADDON_LOADED",
      -- Make sure theme reloads as new fonts and statusbar textures load
      custom_events.NEW_FONT_AVAILABLE,
      custom_events.NEW_STATUSBAR_AVAILABLE,
      -- Configuration updates
      custom_events.STATUSBAR_TEXTURE_CHANGED,
      custom_events.FONT_CHANGED,
      custom_events.BACKGROUND_OPACITY_CHANGED,
      custom_events.SECTION_SELECTION_CHANGED,
      custom_events.FRAME_SHOWING_CHANGED,
      custom_events.FRAME_LOCKED_CHANGED
    },
    "Theme"
  )

  return self
end

function theme:notify(event_name, ...)
  log(nil, "theme", 1, "notify", event_name, ...)

  if event_name == "ADDON_LOADED" then
    event_manager:unsubscribe(self, "ADDON_LOADED")

    self.config = DRAGONFLIGHT_HELPER_CONFIG.theme or {}
    event_manager:handle(
      custom_events.THEME_LOADED,
      self:to_message()
    )
  elseif event_name == custom_events.NEW_FONT_AVAILABLE then
    event_manager:handle(
      custom_events.THEME_MEDIA_UPDATED,
      self:to_message()
    )
  elseif event_name == custom_events.NEW_STATUSBAR_AVAILABLE then
    event_manager:handle(
      custom_events.THEME_MEDIA_UPDATED,
      self:to_message()
    )
  elseif event_name == custom_events.STATUSBAR_TEXTURE_CHANGED then
    self.config.statusbar = ...
  elseif event_name == custom_events.FONT_CHANGED then
    self.config.font = ...
  elseif event_name == custom_events.SECTION_SELECTION_CHANGED then
    local section, enabled = ...
    print(event_name, section, enabled)
    event_manager:handle(custom_events.THEME_SECTIONS_UPDATED, section, enabled)
  elseif event_name == custom_events.FRAME_SHOWING_CHANGED then
    self.config.showing = ...
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self.config.background_opacity = math.floor(... * 100) / 100
  elseif event_name == custom_events.FRAME_LOCKED_CHANGED then
    self.config.locked = ...
  end
end

function theme:to_message()
  return {
    font_name = self:get_font(),
    statusbar_name = self:get_statusbar(),
    background_opacity = self:get_background_opacity(),
    is_showing = self:get_is_showing(),
    is_locked = self:get_is_locked(),
    sections = self:get_sections()
  }
end

function theme:get_font()
  if self.config.font == nil then
    self.config.font = media:get_default_font()
  end

  return self.config.font
end

function theme:get_statusbar()
  return self.config.statusbar or media:get_default_statusbar()
end

function theme:get_background_opacity()
  return self.config.background_opacity or 0.5
end

function theme:get_is_showing()
  if self.config.showing == nil then
    self.config.showing = true
  end

  return self.config.showing
end

function theme:get_is_locked()
  if self.config.locked == nil then
    self.config.locked = true
  end

  return self.config.locked
end

function theme:get_sections()
  if self.config.SECTIONS == nil then
    self.config.SECTIONS = ns.constants.DEFAULT_THEME.SECTIONS
  end

  return self.config.SECTIONS
end

function theme:get_section(section_name)
  local sections = self:get_sections()

  for _, section in ipairs(sections) do
    if section.name == section_name then
      return section
    end
  end

  return {}
end

ns.theme = theme:init()
