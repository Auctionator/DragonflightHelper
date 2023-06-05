local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS

local TRAINER_QUESTS = {
  [SKILL_IDS.Alchemy] = {
    title = "Conflago <Trainer>",
    max = 1,
    { quest_id = 70532 }, { quest_id = 70533 }, { quest_id = 70530 }, { quest_id = 70531 } },
  [SKILL_IDS.Blacksmithing] = {
    title = "Metalshaper Kuroko <Trainer>",
    max = 1,
    { quest_id = 70234 }, { quest_id = 70233 }, { quest_id = 70235 }, { quest_id = 70211 } },
  [SKILL_IDS.Enchanting] = {
    title = "Soragosa <Trainer>",
    max = 1,
    { quest_id = 72175 }, { quest_id = 72173 }, { quest_id = 72172 }, { quest_id = 72155 } },
  [SKILL_IDS.Engineering] = {
    title = "Clinkyclick Shatterboom <Trainer>",
    max = 1,
    { quest_id = 70540 }, { quest_id = 70539 }, { quest_id = 70545 }, { quest_id = 70557 } },
  [SKILL_IDS.Herbalism] = {
    title = "Agrikus <Trainer>",
    max = 1,
    { quest_id = 70614 }, { quest_id = 70615 }, { quest_id = 70613 }, { quest_id = 70616 } },
  [SKILL_IDS.Inscription] = {
    title = "Talendara <Trainer>",
    max = 1,
    { quest_id = 70561 }, { quest_id = 70558 }, { quest_id = 70559 }, { quest_id = 70560 } },
  [SKILL_IDS.Jewelcrafting] = {
    title = "Tuluradormi <Trainer>",
    max = 1,
    { quest_id = 70565 }, { quest_id = 70564 }, { quest_id = 70563 }, { quest_id = 70562 } },
  [SKILL_IDS.Leatherworking] = {
    title = "Hideshaper Koruz <Trainer>",
    max = 1,
    { quest_id = 70571 }, { quest_id = 70569 }, { quest_id = 70568 }, { quest_id = 70567 } },
  [SKILL_IDS.Mining] = {
    title = "Sekita the Burrower <Trainer>",
    max = 1,
    { quest_id = 72156 }, { quest_id = 70617 }, { quest_id = 70618 }, { quest_id = 72157 } },
  [SKILL_IDS.Skinning] = {
    title = "Ralathor the Rugged <Trainer>",
    max = 1,
    { quest_id = 72158 }, { quest_id = 70619 }, { quest_id = 72159 }, { quest_id = 70620 } },
  [SKILL_IDS.Tailoring] = {
    title = "Threadfinder Fulafong <Trainer>",
    max = 1,
    { quest_id = 70587 }, { quest_id = 70586 }, { quest_id = 70572 }, { quest_id = 70582 } },
}

local setup_trainer = function(profession_data)
  local config = TRAINER_QUESTS[profession_data.skill_id]
  local max = 1
  local completed_count = profession_helpers.count_completed(config,
    string.format("%s, %s", "Trainer", profession_data.name))

  return {
    is_valid_subsection = true,
    title = config.title,
    max = max,
    completed_count = completed_count,
    events = { "QUEST_TURNED_IN", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_DATA_LOAD_RESULT" },
    notify_function = profession_helpers.notify_update_description(config,
      string.format("%s, %s", "Trainer", profession_data.name)),
    tooltip_function = profession_helpers.quest_tooltip(config),
    click_function = nil,
    currently_on_quest = profession_helpers.currently_on_quest(config)
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.Trainer] = setup_trainer
