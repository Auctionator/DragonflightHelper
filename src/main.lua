local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media
local components = ns.components
local panels = ns.panels
local theme = ns.theme
local constants = ns.constants
local log = ns.debug.log

local main_frame_name = addon .. "_main_frame"
local main = CreateFrame("Frame", main_frame_name, UIParent)

function main:init()
  log("OK", "main", 1, "init", "initializing")

  self.initialized = false

  self:SetPoint("TOPLEFT")

  self:RegisterForDrag("LeftButton")
  self:SetResizable(true)
  self:SetClampedToScreen(true)

  self:SetHeight(20)
  self:SetWidth(200)

  self:SetScript("OnDragStart", function() self:on_drag_start() end)
  self:SetScript("OnDragStop", function() self:on_drag_stop() end)

  event_manager:subscribe(
    self,
    {
      custom_events.THEME_LOADED,
      custom_events.FONT_CHANGED,
      custom_events.BACKGROUND_OPACITY_CHANGED,
      custom_events.THEME_SECTIONS_UPDATED,
      custom_events.FRAME_SHOWING_CHANGED
    },
    main_frame_name
  )

  SlashCmdList["DFH_TOGGLE"] = function()
    -- Slash command logic here
  end

  log("OK", "main", 1, "init", "initializing completed")

  return self
end

function main:notify(event_name, ...)
  log(nil, "main", 1, "event", event_name)

  if event_name == custom_events.THEME_LOADED then
    self:theme_loaded()
  end

  if not self.initialized then
    return
  end

  if event_name == custom_events.FONT_CHANGED then
    local _, font_object = ...

    self.title:SetFontObject(font_object)

    self.minimize_button:SetNormalFontObject(font_object)
    self.lock_button:SetNormalFontObject(font_object)
    self.config_button:SetNormalFontObject(font_object)
  elseif event_name == custom_events.BACKGROUND_OPACITY_CHANGED then
    self.texture:SetAlpha(...)
  elseif event_name == custom_events.THEME_SECTIONS_UPDATED then
    self:recalculate_height()
  elseif event_name == custom_events.FRAME_SHOWING_CHANGED then
    self:update_visibility(...)
  end
end

function main:theme_loaded()
  self.initialized = true
  local font_object = media:get_font_object(theme:get_font())

  self.title = components.helpers:create_title_string(self, font_object, "Dragonflight Helper")
  self.title:ClearAllPoints()
  self.title:SetPoint("TOPLEFT", self, "TOPLEFT", 2, -2)
  self.title:SetPoint("RIGHT", self, "RIGHT", -2)
  self:create_background_texture(theme:get_background_opacity())
  self:SetHeight(self.title:GetHeight() + 3)

  self.is_maximized = theme:get_is_showing()
  self:create_minimize_button(font_object, theme:get_background_opacity())

  self.is_locked = theme:get_is_locked()
  self:create_lock_button(font_object, theme:get_background_opacity())

  self:create_config_button(font_object, theme:get_background_opacity())

  self:initialize_panels()
  self:recalculate_height()
end

function main:create_background_texture(background_opacity)
  self.texture = self:CreateTexture()
  self.texture:SetAllPoints()
  self.texture:SetColorTexture(0, 0, 0)
  self.texture:SetAlpha(background_opacity)
end

function main:create_minimize_button(font_object, background_opacity)
  self.minimize_button = CreateFrame("Button", nil, self)

  self.minimize_button:SetPoint("TOPLEFT", 3, -3)
  self.minimize_button:SetHeight(16)
  self.minimize_button:SetWidth(16)
  self.minimize_button:SetNormalFontObject(font_object)
  self.minimize_button:SetScript("OnClick", function()
    self:minimize_or_maximize()
  end)

  components.helpers:add_border(self.minimize_button, { ["alpha"] = background_opacity })

  if self.is_maximized then
    self.minimize_button:SetText("m")
  else
    self.minimize_button:SetText("M")
  end
end

function main:minimize_or_maximize()
  event_manager:handle(custom_events.FRAME_SHOWING_CHANGED, not self.is_maximized)
end

function main:update_visibility(visible)
  log(nil, "main", 1, "uv", "")
  self.is_maximized = visible

  if visible then
    self.minimize_button:SetText("m")
  else
    self.minimize_button:SetText("M")
  end

  for section, panel in pairs(self.panels) do
    local settings = theme:get_section(section)
    log(nil, "main", 1, "uv", section .. ":" .. (settings.display and "true" or "false"))

    if settings.display and visible then
      panel:Show()
    else
      panel:Hide()
    end

    self:recalculate_height()
  end
end

function main:create_lock_button(font_object, background_opacity)
  self.lock_button = CreateFrame("Button", nil, self)

  self.lock_button:SetPoint("TOPLEFT", 22, -3)
  self.lock_button:SetHeight(16)
  self.lock_button:SetWidth(16)
  self.lock_button:SetNormalFontObject(font_object)
  self.lock_button:SetScript("OnClick", function()
    self:lock_or_unlock()
  end)

  components.helpers:add_border(self.lock_button, { ["alpha"] = background_opacity })

  self:update_lock_functionality()
end

function main:lock_or_unlock()
  self.is_locked = not self.is_locked
  self:update_lock_functionality()

  event_manager:handle(custom_events.FRAME_LOCKED_CHANGED, self.is_locked)
end

function main:update_lock_functionality()
  if self.is_locked then
    self.lock_button:SetText("U")
  else
    self.lock_button:SetText("L")
  end

  self:EnableMouse(not self.is_locked)
  self:SetMovable(not self.is_locked)
end

function main:on_drag_start()
  if not self.is_locked then
    if IsShiftKeyDown() then
      self:StartSizing("BOTTOMRIGHT")
    else
      self:StartMoving()
    end
  end
end

function main:on_drag_stop()
  self:StopMovingOrSizing()
end

function main:create_config_button(font_object, background_opacity)
  self.config_button = CreateFrame("Button", nil, self)
  -- Needed so long as I'm using the UIDropDownMenuTemplate in config
  -- (it invisibly extends outside of config frame boundaries)
  self.config_button:SetFrameStrata("TOOLTIP")
  self.config_showing = false

  self.config_button:SetPoint("TOPRIGHT", -2, -3)
  self.config_button:SetHeight(16)
  self.config_button:SetWidth(16)
  self.config_button:SetNormalFontObject(font_object)
  self.config_button:SetScript("OnClick", function()
    if self.config_showing then
      event_manager:handle(custom_events.CLOSE_CONFIG, self)
    else
      event_manager:handle(custom_events.OPEN_CONFIG, self)
    end

    self.config_showing = not self.config_showing
  end)

  self.config_button:SetText("C")

  components.helpers:add_border(self.config_button, { ["alpha"] = background_opacity })

  -- FOR DEBUG
  -- event_manager:handle(custom_events.OPEN_CONFIG, self)
end

function main:recalculate_height()
  log(nil, "main", 1, "rh", self.is_maximized)

  self:SetHeight(self.title:GetHeight() + 10)

  for section, panel in pairs(self.panels) do
    if panel ~= nil then
      local spec = theme:get_section(section)

      log(nil, "main", 1, "section", spec.display)

      if spec.display and self.is_maximized then
        panel:recalculate_height()
        log(nil, "main", 1, "h", "Height after recalc: " .. panel:GetHeight())

        self:SetHeight(self:GetHeight() + panel:GetHeight())
        log(nil, "main", 1, "h", "Resulting main height: " .. self:GetHeight())
        panel:Show()
      else
        panel:SetHeight(0.01)
        self:SetHeight(self:GetHeight() - panel:GetHeight())
        panel:Hide()
      end
    end
  end

  self.texture:SetAllPoints()
end

function main:initialize_factions(previous)
  local faction_settings = theme:get_section(constants.SECTIONS.FACTIONS)
  self.factions = panels.factions:init(self)
  self.factions:Hide()

  if faction_settings.display then
    self.factions:Show()
    self:SetHeight(self:GetHeight() + self.factions:GetHeight())
    self.texture:SetAllPoints()

    self.factions:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    self.factions:SetPoint("RIGHT")
  end

  self.panels[constants.SECTIONS.FACTIONS] = self.factions

  if faction_settings.display then
    return self.factions
  else
    return previous
  end
end

function main:initialize_friends(previous)
  local friend_settings = theme:get_section(constants.SECTIONS.FRIENDS)
  self.friends = panels.friends:init(self)
  self.friends:Hide()

  if friend_settings.display then
    self.friends:Show()
    self:SetHeight(self:GetHeight() + self.friends:GetHeight())
    self.texture:SetAllPoints()

    self.friends:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    self.friends:SetPoint("RIGHT", self, "RIGHT", -3)
  end

  self.panels[constants.SECTIONS.FRIENDS] = self.friends

  if friend_settings.display then
    return self.friends
  else
    return previous
  end
end

function main:initialize_timers(previous)
  local timer_settings = theme:get_section(constants.SECTIONS.TIMERS)
  self.timers = panels.timers:init(self)
  self.timers:Hide()

  if timer_settings.display then
    self.timers:Show()
    self:SetHeight(self:GetHeight() + self.timers:GetHeight())
    self.texture:SetAllPoints()

    self.timers:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    self.timers:SetPoint("RIGHT")
  end

  self.panels[constants.SECTIONS.TIMERS] = self.timers

  if timer_settings.display then
    return self.timers
  else
    return previous
  end
end

function main:initialize_todos(previous)
  local todo_settings = theme:get_section(constants.SECTIONS.TODOS)
  self.todos = panels.todos:init(self)
  self.todos:Hide()

  if todo_settings.display then
    self.todos:Show()
    self:SetHeight(self:GetHeight() + self.todos:GetHeight())
    self.texture:SetAllPoints()

    self.todos:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    self.todos:SetPoint("RIGHT")
  end

  self.panels[constants.SECTIONS.TODOS] = self.todos

  if todo_settings.display then
    return self.todos
  else
    return previous
  end
end

function main:initialize_profession(previous, section_id)
  local profession_settings = theme:get_section(section_id)
  local panel = panels.professions:init(self, section_id)

  if profession_settings.display then
    panel:Show()
    self:SetHeight(self:GetHeight() + panel:GetHeight())
    self.texture:SetAllPoints()

    panel:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    panel:SetPoint("RIGHT")
  end

  self.panels[section_id] = panel

  if profession_settings.display then
    return panel
  else
    return previous
  end
end

function main:initialize_panels()
  local previous = self.title

  self.panels = {}
  previous = self:initialize_factions(previous)
  previous = self:initialize_friends(previous)
  previous = self:initialize_timers(previous)
  previous = self:initialize_todos(previous)
  previous = self:initialize_profession(previous, constants.SECTIONS.PROFESSIONS_ONE)
  previous = self:initialize_profession(previous, constants.SECTIONS.PROFESSIONS_TWO)
end

ns.main = main:init()
