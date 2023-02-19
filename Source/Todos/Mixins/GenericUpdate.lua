DFH_GenericUpdate = {}

function DFH_GenericUpdate:update(entry, optionalTitle)
  -- DragonflightHelper.Utilities.dump(entry, "DFH_GenericUpdate:update(" .. (optionalTitle and optionalTitle or "") .. ")")

  local completed = 0
  local completionCount = entry.completionCount

  if completionCount == nil then
    completionCount = #entry.quests
  end

  for _, questId in ipairs(entry.quests) do
    -- print("Looking for ", questId)
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      -- print("Completed ", questId)
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
