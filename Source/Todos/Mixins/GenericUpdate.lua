DFH_GenericUpdate = {}

function DFH_GenericUpdate:update(entry, optionalTitle)
  local completed = 0
  local completionCount = entry.completionCount

  if completionCount == nil then
    completionCount = #entry.quests
  end

  for _, questId in ipairs(entry.quests) do
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      print(questId .. " completed ")
      completed = completed + 1
    end
  end

  self:SetMinMaxValues(0, completionCount)

  if entry.title ~= nil then
    self:SetTitle(entry.title)
  elseif optionalTitle ~= nil then
    self:SetTitle(optionalTitle)
  else
    self:SetTitle(C_QuestLog.GetTitleForQuestID(entry.quests[1]))
  end

  self:SetDescription(completed .. " / " .. completionCount)
  self:SetValue(completed)
end
