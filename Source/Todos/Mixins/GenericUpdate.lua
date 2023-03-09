DFH_GenericUpdate = {}

function DFH_GenericUpdate:update(entry, optionalTitle)
  local completed = 0
  local completionCount = entry.completionCount
  local isOnQuest = false
  local onQuestId = 0

  if completionCount == nil then
    completionCount = #entry.quests
  end

  for _, questId in ipairs(entry.quests) do
    if C_QuestLog.IsOnQuest(questId) then
      isOnQuest = true
      onQuestId = questId
    end

    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      completed = completed + 1
    end
  end

  -- it seems like completing any Aiding the Accord quest marks all Aiding the Accord quests as completed?
  if completed > (entry.completionCount or #entry.quests) then
    completed = entry.completionCount
  end

  self:SetMinMaxValues(0, completionCount)

  local onQuestMarker = isOnQuest and "* " or ""

  if entry.title ~= nil then
    self:SetTitle(onQuestMarker .. entry.title)
  elseif optionalTitle ~= nil then
    self:SetTitle(onQuestMarker .. optionalTitle)
  else
    self:SetTitle(onQuestMarker .. C_QuestLog.GetTitleForQuestID(entry.quests[1]))
  end

  self:SetDescription(completed .. " / " .. completionCount)
  self:SetValue(completed)
end
