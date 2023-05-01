local _, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local log = ns.debug.log

local theme = {}

function theme:init()
  self.sections = {
    FACTIONS = "Factions",
    FRIENDS = "Friends",
    TIMERS = "Timers",
    TODOS = "Todos",
    PROFESSIONS = "Professions",
  }
  self.factions = {
    [2507] = true,
    [2503] = true,
    [2511] = true,
    [2510] = true,
  }
  self.friends = {
    [2544] = true,
    [2550] = true,
    [2518] = true,
    [2517] = true,
  }
  self.timers = {
    Feast = true,
    Siege = true
  }
  self.todos = {
    Aiding = true,
    Catalyst = true,
    Feast = true,
    Siege = true,
    Hunts = true,
    Flood = true,
    Elements = true,
    Bosses = true
  }
  self.professions = {
    true, true
  }
  self.profession_settings = {
    { Treatise = true, Gathering = true, Trainer = true, MobDrops = true, Azley = true, Weekly = true },
    { Treatise = true, Gathering = true, Trainer = true, MobDrops = true, Azley = true, Weekly = true }
  }

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
    self.config.sections[section] = enabled
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
    factions = self:get_factions(),
    friends = self:get_friends(),
    timers = self:get_timers(),
    todos = self:get_todos(),
    professions = self:get_professions(),
    profession_settings = self:get_profession_settings(),
    section_visibility = self:get_sections()
  }
end

function theme:get_font()
  return self.config.font or media:get_default_font()
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
    self.config.sections = {}

    for key, _ in pairs(self.sections) do
      self.config.sections[key] = true
    end
  end

  return self.config.sections
end

function theme:get_factions()
  if self.config.factions == nil then
    self.config.factions = self.factions
  end

  return self.config.factions
end

function theme:get_friends()
  if self.config.friends == nil then
    self.config.friends = self.friends
  end

  return self.config.friends
end

function theme:get_timers()
  if self.config.timers == nil then
    self.config.timers = self.timers
  end

  return self.config.timers
end

function theme:get_todos()
  if self.config.todos == nil then
    self.config.todos = self.todos
  end

  return self.config.todos
end

function theme:get_professions()
  if self.config.professions == nil then
    self.config.professions = self.professions
  end

  return self.config.professions
end

function theme:get_profession_settings()
  if self.config.profession_settings == nil then
    self.config.profession_settings = self.profession_settings
  end

  return self.config.profession_settings
end

ns.theme = theme:init()
