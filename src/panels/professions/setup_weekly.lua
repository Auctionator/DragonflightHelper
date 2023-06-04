local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS

local WEEKLIES = {
  title = "Valdrakken Weekly Profession",
  [SKILL_IDS.Alchemy] = {
    max = 1,
    { quest_id = 75363 },
    -- Dhurrel <Trade Liaison>
    { quest_id = 72427 }, { quest_id = 66940 }, { quest_id = 66938 },
    -- Dothenos <Trade Coordinator>
    { quest_id = 66937 } },
  [SKILL_IDS.Leatherworking] = {
    max = 1,
    -- Dhurrel <Trade Liaison>
    { quest_id = 66363 },
    -- Temnaayu <Trade Negotiator>
    { quest_id = 66951 }, { quest_id = 72407 }, { quest_id = 66364 } },
  [SKILL_IDS.Blacksmithing] = {
    max = 1,
    -- Dhurrel <Trade Liaison>
    { quest_id = 66517 }, { quest_id = 66897 }, { quest_id = 66941 } },
  [SKILL_IDS.Jewelcrafting] = {
    max = 1,
    -- Kayann <Ambassador of Craft>
    { quest_id = 75362 },
    -- Temnaayu <Trade Negotiator>
    { quest_id = 66950 }, { quest_id = 66949 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { quest_id = 72428 }, { quest_id = 66516 } },
  [SKILL_IDS.Enchanting] = {
    max = 1,
    -- Temnaayu <Trade Negotiator>
    { quest_id = 66900 }, { quest_id = 66884 }, { quest_id = 72423 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { quest_id = 66935 } },
  [SKILL_IDS.Tailoring] = {
    max = 1,
    -- Dothenos <Trade Coordinator>
    { quest_id = 66952 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { quest_id = 72410 } },
  [SKILL_IDS.Engineering] = {
    max = 1,
    -- Dothenos <Trade Coordinator>
    { quest_id = 72396 }, { quest_id = 66890 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { quest_id = 66942 }, { quest_id = 66891 } },
  [SKILL_IDS.Inscription] = {
    max = 1,
    -- Dothenos <Trade Coordinator>
    { quest_id = 66945 }, { quest_id = 72438 }, { quest_id = 66943 },
    -- Gnoklin Quirkcoil <Requisitions Officer>
    { quest_id = 66944 } },
}

local setup_weekly = function(profession_data)
  local config = WEEKLIES[profession_data.skill_id]

  if config == nil then
    return { is_valid_subsection = false, currently_on_quest = function() return false end }
  end

  local completed_count = profession_helpers.count_completed(config)

  return {
    is_valid_subsection = true,
    title = WEEKLIES.title,
    max = 1,
    completed_count = completed_count,
    events = { "QUEST_TURNED_IN", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_DATA_LOAD_RESULT" },
    notify_function = profession_helpers.notify_update_description(config),
    tooltip_function = profession_helpers.quest_tooltip(config),
    click_function = nil,
    currently_on_quest = profession_helpers.currently_on_quest(config)
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.Weekly] = setup_weekly
