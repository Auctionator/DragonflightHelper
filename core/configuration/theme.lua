local _, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log
local SECTIONS = ns.constants.SECTIONS
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS

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
      custom_events.SUBSECTION_SELECTION_CHANGED,
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

    if DRAGONFLIGHT_HELPER_CONFIG == nil then
      DRAGONFLIGHT_HELPER_CONFIG = {}
    end

    self.config = DRAGONFLIGHT_HELPER_CONFIG or { sections = ns.constants.DEFAULT_THEME }

    self:upgrade_config()

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

    section.display = enabled
    for _, entry in pairs(section.subsections) do
      entry.display = enabled
    end

    event_manager:handle(custom_events.THEME_SECTIONS_UPDATED, section, enabled)
  elseif event_name == custom_events.SUBSECTION_SELECTION_CHANGED then
    local section, id, checked = ...

    section.subsections[id].display = checked

    local section_displayed = true
    for _, entry in pairs(section.subsections) do
      section_displayed = section_displayed and not entry.display
    end
    section.display = section_displayed

    event_manager:handle(custom_events.THEME_SECTIONS_UPDATED, section, section_displayed)
  elseif event_name == custom_events.FRAME_SHOWING_CHANGED then
    self.config.showing = ...
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self.config.background_opacity = math.floor(... * 100) / 100
  elseif event_name == custom_events.FRAME_LOCKED_CHANGED then
    self.config.locked = ...
  end
end

function theme:upgrade_config()
  if self.config.theme_version == nil then
    self.config.theme_version = 0
  end

  -- v0.4 adding profession world drops and masters
  if self.config.theme_version < 4 then
    if self.config.sections == nil then
      self.config.sections = ns.constants.DEFAULT_THEME
    end

    self.config.sections[SECTIONS.PROFESSIONS_ONE] = ns.constants.DEFAULT_THEME[SECTIONS.PROFESSIONS_ONE]
    self.config.sections[SECTIONS.PROFESSIONS_TWO] = ns.constants.DEFAULT_THEME[SECTIONS.PROFESSIONS_TWO]

    self.config.theme_version = 4
  end

  -- v0.5 adding ability to (eventually) order bars, enforcing consistency in current ordering
  if self.config.theme_version < 5 then
    local sections_to_update = {
      SECTIONS.FACTIONS,
      SECTIONS.FRIENDS,
      SECTIONS.TIMERS,
      SECTIONS.TODOS,
      SECTIONS.PROFESSIONS_ONE,
      SECTIONS.PROFESSIONS_TWO
    }

    for _, section in ipairs(sections_to_update) do
      if self.config.sections[section] == nil then
        self.config.sections[section] = { subsections = {} }
      end

      for index, subsection in ipairs(self.config.sections[section].subsections) do
        subsection.order = index
      end
    end

    self.config.theme_version = 5
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
  if self.config.sections == nil then
    self.config.sections = ns.constants.DEFAULT_THEME
  end

  return self.config.sections
end

function theme:get_section(section_name)
  local requested_section = self:get_sections()[section_name]

  if requested_section == nil then
    return {}
  else
    return requested_section
  end
end

function theme:get_completed_quest_color()
  return FACTION_BAR_COLORS[5]
end

function theme:get_incomplete_quest_color()
  return { r = FACTION_BAR_COLORS[1].r, g = FACTION_BAR_COLORS[1].g, b = FACTION_BAR_COLORS[1].b, a = 0.4 }
end

function theme:get_accepted_quest_color()
  return { r = FACTION_BAR_COLORS[4].r, g = FACTION_BAR_COLORS[4].g, b = FACTION_BAR_COLORS[4].b, a = 0.4 }
end

ns.theme = theme:init()
