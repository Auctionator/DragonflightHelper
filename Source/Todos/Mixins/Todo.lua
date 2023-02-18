DragonflightHelperTodoMixin = CreateFromMixins(DragonflightHelperStatusBarMixin)

function DragonflightHelperTodoMixin:OnLoad()
  DragonflightHelperStatusBarMixin.OnLoad(self)

  local completedColor = FACTION_BAR_COLORS[5]
  local incompleteColor = FACTION_BAR_COLORS[1]

  self:SetBackgroundColor(incompleteColor.r, incompleteColor.g, incompleteColor.b, 0.3)
  self:SetForegroundColor(completedColor.r, completedColor.g, completedColor.b)
end

function DragonflightHelperTodoMixin:Init(questIds, title, completionCount)
  self.questIds = questIds
  self.completed = 0
  self.completionCount = completionCount

  if self.completionCount == nil then
    self.completionCount = #self.questIds
  end
  self:SetMinMaxValues(0, self.completionCount)

  if title == nil then
    self:SetTitle(C_QuestLog.GetTitleForQuestID(self.questIds[1]))
  else
    self:SetTitle(title)
  end

  self:Update()
end

function DragonflightHelperTodoMixin:OnShow()
  self:RegisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoMixin:OnHide()
  self:UnregisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoMixin:OnEvent(event, ...)
  if event == "QUEST_TURNED_IN" then
    self:Update()
  end
end

function DragonflightHelperTodoMixin:Update()
  if self.questIds == nil or #self.questIds == 0 then
    return
  end

  self.completed = 0

  for _, questId in ipairs(self.questIds) do
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      self.completed = self.completed + 1
    end
  end

  self:SetDescription(self.completed .. " / " .. self.completionCount)
  self:SetValue(self.completed)
end
