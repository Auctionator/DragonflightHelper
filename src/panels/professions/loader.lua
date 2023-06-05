local _, ns = ...

local constants = ns.constants
local log = ns.debug.log
local event_manager = ns.events.manager
local custom_events = ns.events.custom

local profession_loader = {}

local retry_count = {
  [constants.SECTIONS.PROFESSIONS_ONE] = 0,
  [constants.SECTIONS.PROFESSIONS_TWO] = 0
}
local loaded = {
  [constants.SECTIONS.PROFESSIONS_ONE] = false,
  [constants.SECTIONS.PROFESSIONS_TWO] = false
}

function profession_loader:initialize_profession(profession_id)
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

  log("OK", "profession_loader", 1, "done", name .. ":" .. skillLine .. ":" .. rank)

  return {
    name = name,
    skill_id = skillLine,
    skill_level = rank
  }
end

function profession_loader:load_profession(profession_id)
  local profession_one, profession_two = GetProfessions()

  if DRAGONFLIGHT_HELPER_CONFIG.professions == nil then
    DRAGONFLIGHT_HELPER_CONFIG.professions = {}
  end

  self.profession_data = DRAGONFLIGHT_HELPER_CONFIG.professions

  local requested_profession = profession_id == constants.SECTIONS.PROFESSIONS_ONE and profession_one or profession_two

  if requested_profession == nil and retry_count[profession_id] < 5 then
    retry_count[profession_id] = retry_count[profession_id] + 1

    C_Timer.NewTimer(1, function()
      log("ERROR", "profession_loader", 1, "loading", profession_id)
      self:load_profession(profession_id)
    end)
  elseif requested_profession ~= nil then
    log("OK", "profession_loader", 1, "timer", retry_count[profession_id])
    event_manager:handle(custom_events.PROFESSION_LOADED, profession_id,
      profession_loader:initialize_profession(requested_profession))
  end
end

function profession_loader:load_professions()
  if load_started then
    return
  end

  local profession_one, profession_two = GetProfessions()

  DRAGONFLIGHT_HELPER_CONFIG.professions = {}
  self.profession_data = DRAGONFLIGHT_HELPER_CONFIG.professions

  if (profession_one == nil or profession_two == nil) and retry_count < 5 then
    retry_count = retry_count + 1

    C_Timer.NewTimer(1, function()
      log("ERROR", "profession_loader", 1, "timer", retry_count)
      self:load_professions()
    end)
  else
    log("OK", "profession_loader", 1, "loading",
      (profession_one and profession_one or "?") .. ":" .. (profession_two and profession_two or "?"))

    event_manager:handle(custom_events.PROFESSIONS_LOADED, {
      [constants.SECTIONS.PROFESSIONS_ONE] = profession_loader:initialize_profession(profession_one),
      [constants.SECTIONS.PROFESSIONS_TWO] = profession_loader:initialize_profession(profession_two)
    })

    load_started = true
  end
end

ns.professions.loader = profession_loader
