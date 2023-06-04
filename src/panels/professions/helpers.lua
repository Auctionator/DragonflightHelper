local addon, ns = ...

local event_manager = ns.events.manager
local theme = ns.theme

ns.constants.professions.helpers = {}

local function count_completed(config)
  local completed_count = 0
  local is_on_quest = nil
  local items = {}
  local waypoints = {}

  for _, entry in ipairs(config) do
    if C_QuestLog.IsOnQuest(entry.quest_id) then
      is_on_quest = entry.quest_id
    end

    if C_QuestLog.IsQuestFlaggedCompleted(entry.quest_id) then
      completed_count = completed_count + 1
    elseif entry.item ~= nil then
      table.insert(items, entry.item)

      if entry.waypoint then
        table.insert(waypoints, entry.waypoint)
      end
    end
  end

  return completed_count, items, waypoints, is_on_quest
end
ns.constants.professions.helpers.count_completed = count_completed

local function currently_on_quest(config)
  return function()
    local result = false
    local quest_id = nil

    for _, entry in ipairs(config) do
      result = result or C_QuestLog.IsOnQuest(entry.quest_id)
      quest_id = entry.quest_id
    end

    return result, quest_id
  end
end
ns.constants.professions.helpers.currently_on_quest = currently_on_quest

local function quest_tooltip(config)
  return function(parent)
    local is_on_quest, current_quest_id = currently_on_quest(config)()

    if is_on_quest then
      GameTooltip:SetOwner(parent, "ANCHOR_RIGHT")
      GameTooltip_AddQuest(parent, current_quest_id)
      GameTooltip:Show()
    end
  end
end
ns.constants.professions.helpers.quest_tooltip = quest_tooltip

local function notify_update_description(config)
  local max = config.max or #config

  return function(statusbar_frame, event_name, ...)
    local is_on_quest = currently_on_quest(config)()

    local completion_count = count_completed(config)

    local color = theme:get_incomplete_quest_color()

    if is_on_quest then
      color = theme:get_accepted_quest_color()
    end
    statusbar_frame.background:SetStatusBarColor(color.r, color.g, color.b, color.a)
    statusbar_frame.foreground:SetValue(completion_count)
    statusbar_frame.description:SetText(("%d/%d"):format(completion_count, max))

    if completion_count == max then
      event_manager:unsubscribe(statusbar_frame, event_name)
    end
  end
end
ns.constants.professions.helpers.notify_update_description = notify_update_description
