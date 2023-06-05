local _, ns = ...

local theme = ns.theme
local SKILL_CURRENCIES = ns.constants.professions.SKILL_CURRENCIES
local helpers = ns.components.helpers
local log = ns.debug.log
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local loader = ns.professions.loader

local professions = {}

local PROFESSION_EVENTS = {
  "ENCOUNTER_LOOT_RECEIVED",
  "QUEST_TURNED_IN",
  "CURRENCY_DISPLAY_UPDATE",
  "QUEST_ACCEPTED",
  "QUEST_REMOVED",
  custom_events.PROFESSION_LOADED
}

function professions:init(parent, section_identifier)
  log(nil, "professions", 1, "init", section_identifier)

  local section_data = theme:get_section(section_identifier)
  local frame = helpers:create_auto_sizing_frame(parent, section_identifier, true)

  frame.section_identifier = section_identifier

  function frame:notify(event_name, ...)
    if event_name == "CURRENCY_DISPLAY_UPDATE" then
      self:update_title()
    elseif event_name == custom_events.PROFESSION_LOADED then
      local identifier, event_data = ...

      if identifier ~= frame.section_identifier then
        return
      end

      frame.profession_data = event_data
      frame.profession_initialized = true
      frame:update_title()
      frame:initialize_bars()
    end
  end

  function frame:update_title()
    if not frame.profession_initialized then
      return
    end

    if SKILL_CURRENCIES[frame.profession_data.skill_id] ~= nil then
      local unspent_points = C_CurrencyInfo.GetCurrencyInfo(
        SKILL_CURRENCIES[frame.profession_data.skill_id]
      ).quantity

      frame.title:SetText(("%s%s"):format(
        frame.profession_data.name,
        (unspent_points > 0 and (" (%d)"):format(unspent_points) or "")
      ))
    end
  end

  function frame:initialize_bars()
    if not frame.profession_initialized then
      return
    end

    table.sort(section_data.subsections, function(s1, s2) return s1.order < s2.order end)

    for id, subsection in pairs(section_data.subsections) do
      local statusbar = ns.professions.create_profession_statusbar(
        frame, frame.profession_data, id, subsection)

      if statusbar ~= nil then
        frame:add(statusbar, subsection.display)
      end
    end

    frame:recalculate_height()
  end

  event_manager:subscribe(frame, PROFESSION_EVENTS, "Profession " .. section_identifier)
  loader:load_profession(section_identifier)

  return frame
end

ns.panels.professions = professions
