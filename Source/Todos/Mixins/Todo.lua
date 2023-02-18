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
  DragonflightHelperStatusBarMixin.OnShow(self)

  self:RegisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoMixin:OnHide()
  DragonflightHelperStatusBarMixin.OnHide(self)

  self:UnregisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoMixin:OnEvent(event, ...)
  DragonflightHelperStatusBarMixin.OnEvent(self, event, ...)

  print(event, ...)

  if event == "QUEST_TURNED_IN" then
    self:Update()
  end
end

function DragonflightHelperTodoMixin:Update()
  if #self.questIds == 0 then
    return
  end

  for _, questId in ipairs(self.questIds) do
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      self.completed = self.completed + 1
    end
  end

  self:SetDescription(self.completed .. " / " .. self.completionCount)
  self:SetValue(self.completed)
end

ProfessionLookupMixin = {}

function ProfessionLookupMixin:OnLoad()
  local firstProfession, secondProfession = GetProfessions()

  DragonflightHelper.Utilities.dump(firstProfession, "First Profession")

  self.professionInfo = {
    { name = "None", skillId = 0 },
    { name = "None", skillId = 0 }
  }
  self.hasFirstProfession = firstProfession ~= nil
  self.hasSecondProfession = secondProfession ~= nil

  if self.hasFirstProfession ~= nil then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(firstProfession)
    self.professionInfo[1] = { name = name, skillId = skillLine }
  end

  if self.hasSecondProfession ~= nil then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(secondProfession)
    self.professionInfo[2] = { name = name, skillId = skillLine }
  end
end

DragonflightHelperProfessionTodoItemMixin = CreateFromMixins(ProfessionLookupMixin, DragonflightHelperTodoMixin)

function DragonflightHelperProfessionTodoItemMixin:OnLoad()
  ProfessionLookupMixin.OnLoad(self)
  DragonflightHelperTodoMixin.OnLoad(self)
end
