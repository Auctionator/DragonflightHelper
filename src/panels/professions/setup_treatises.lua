local _, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS

local SKILL_TREATISES = {
  -- TODO Localize
  title = "Draconic Treatise",
  [SKILL_IDS.Alchemy] = 74108,
  [SKILL_IDS.Blacksmithing] = 74109,
  [SKILL_IDS.Enchanting] = 74110,
  [SKILL_IDS.Engineering] = 74111,
  [SKILL_IDS.Herbalism] = 74107,
  [SKILL_IDS.Inscription] = 74105,
  [SKILL_IDS.Jewelcrafting] = 74112,
  [SKILL_IDS.Leatherworking] = 74113,
  [SKILL_IDS.Mining] = 74106,
  [SKILL_IDS.Skinning] = 74114,
  [SKILL_IDS.Tailoring] = 74115,
}

local setup_treatises = function(profession_data)
  local title = SKILL_TREATISES.title
  local treatise_quest_id = SKILL_TREATISES[profession_data.skill_id]
  local completed = C_QuestLog.IsQuestFlaggedCompleted(treatise_quest_id)
  local max = 1
  local timer

  if not completed then
    timer = C_Timer.NewTicker(3, function()
      event_manager:handle(custom_events.CHECK_FOR_COMPLETED_TREATISE, treatise_quest_id)
    end)
  end

  local function notify(statusbar_frame, event_name, ...)
    completed = C_QuestLog.IsQuestFlaggedCompleted(treatise_quest_id)

    if completed then
      -- If the quest was completed before startup, no timer created
      if timer then
        timer:Cancel()
      end

      statusbar_frame.foreground:SetValue(max)
      statusbar_frame.description:SetText("1/1")
      event_manager:unsubscribe(statusbar_frame, event_name)
    end
  end

  return {
    is_valid_subsection = true,
    title = title,
    max = max,
    completed_count = completed and 1 or 0,
    events = { custom_events.CHECK_FOR_COMPLETED_TREATISE },
    notify_function = notify,
    tooltip_function = nil,
    click_function = nil,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.Treatise] = setup_treatises
