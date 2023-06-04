local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS

local AZLEY_QUESTS = {
  title = "Azley <Artisan's Consortium>",
  description = "Weekly Services Requested",
  [SKILL_IDS.Leatherworking] = { { quest_id = 70594 } },
  [SKILL_IDS.Tailoring] = { { quest_id = 70595 } },
  [SKILL_IDS.Jewelcrafting] = { { quest_id = 70593 } },
  [SKILL_IDS.Blacksmithing] = { { quest_id = 70589 } },
  [SKILL_IDS.Engineering] = { { quest_id = 70591 } },
  [SKILL_IDS.Inscription] = { { quest_id = 70592 } },
}

local setup_azley = function(profession_data)
  if AZLEY_QUESTS[profession_data.skill_id] == nil then
    return {
      is_valid_subsection = false
    }
  end

  local config = AZLEY_QUESTS[profession_data.skill_id]
  local title = AZLEY_QUESTS.title
  local completed = C_QuestLog.IsQuestFlaggedCompleted(config[1].quest_id)
  local max = 1

  return {
    is_valid_subsection = true,
    title = title,
    max = max,
    completed_count = completed and 1 or 0,
    events = { "QUEST_TURNED_IN", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_DATA_LOAD_RESULT" },
    notify_function = profession_helpers.notify_update_description(config),
    tooltip_function = profession_helpers.quest_tooltip(config),
    click_function = nil,
    currently_on_quest = function() return C_QuestLog.IsOnQuest(config[1].quest_id) end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.Azley] = setup_azley
