local _, ns = ...

local theme = ns.theme
local constants = ns.constants
local SKILL_CURRENCIES = ns.constants.professions.SKILL_CURRENCIES
local helpers = ns.components.helpers
local log = ns.debug.log
local event_manager = ns.events.manager

local professions = {}

function professions:initialize_profession(profession_id)
  log("OK", "professions", 1, "initialize", profession_id and profession_id or "?")

  if profession_id == nil then
    return {
      name = "No profession",
      skill_id = 0,
      skill_level = 0
    }
  end

  local name, texture, rank, maxRank, numSpells, spellOffset, skillLine, rankModifier, specializationIndex, specializationOffset, skillLineName =
      GetProfessionInfo(profession_id)

  log("OK", "professions", 1, "done", name .. ":" .. skillLine .. ":" .. rank)

  return {
    name = name,
    skill_id = skillLine,
    skill_level = rank
  }
end

local retry_count = 0
function professions:load_professions()
  local profession_one, profession_two = GetProfessions()

  DRAGONFLIGHT_HELPER_CONFIG.professions = {}
  self.profession_data = DRAGONFLIGHT_HELPER_CONFIG.professions

  if (profession_one == nil or profession_two == nil) and retry_count < 5 then
    retry_count = retry_count + 1

    C_Timer.NewTimer(1, function()
      log("ERROR", "professions", 1, "timer", retry_count)
      self:load_professions()
    end)
  else
    log("OK", "professions", 1, "loading",
      (profession_one and profession_one or "?") .. ":" .. (profession_two and profession_two or "?"))

    self.profession_data[constants.SECTIONS.PROFESSIONS_ONE] = professions:initialize_profession(profession_one)
    self.profession_data[constants.SECTIONS.PROFESSIONS_TWO] = professions:initialize_profession(profession_two)
  end
end

function professions:get_profession_data()
  if self.profession_data == nil then
    if DRAGONFLIGHT_HELPER_CONFIG.professions == nil then
      self:load_professions()
    end

    self.profession_data = DRAGONFLIGHT_HELPER_CONFIG.professions
  end

  return self.profession_data
end

local PROFESSION_EVENTS = {
  "ENCOUNTER_LOOT_RECEIVED",
  "QUEST_TURNED_IN",
  "CURRENCY_DISPLAY_UPDATE",
  "QUEST_ACCEPTED",
  "QUEST_REMOVED"
}

function professions:init(parent, section_identifier)
  log(nil, "professions", 1, "init", section_identifier)

  local profession_data = self:get_profession_data()[section_identifier]

  local section_data = theme:get_section(section_identifier)
  local frame = helpers:create_auto_sizing_frame(parent, profession_data.name, section_data.display)

  function frame:notify(event_name, ...)
    if event_name == "CURRENCY_DISPLAY_UPDATE" then
      self:update_title()
    end
  end

  function frame:update_title()
    if SKILL_CURRENCIES[profession_data.skill_id] ~= nil then
      local unspent_points = C_CurrencyInfo.GetCurrencyInfo(
        SKILL_CURRENCIES[profession_data.skill_id]
      ).quantity

      frame.title:SetText(("%s%s"):format(
        profession_data.name,
        (unspent_points > 0 and (" (%d)"):format(unspent_points) or "")
      ))
    end
  end

  table.sort(section_data.subsections, function(s1, s2) return s1.order < s2.order end)
  for id, subsection in pairs(section_data.subsections) do
    local statusbar = ns.professions.create_profession_statusbar(frame, profession_data, id, subsection)

    if statusbar ~= nil then
      frame:add(statusbar, subsection.display)
    end
  end

  frame:update_title()
  event_manager:subscribe(frame, PROFESSION_EVENTS, "Profession " .. section_identifier)

  return frame
end

ns.panels.professions = professions
