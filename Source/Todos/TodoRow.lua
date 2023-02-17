DragonflightHelperTodoRowMixin = {}

function DragonflightHelperTodoRowMixin:OnLoad()
  -- print("DragonflightHelperTodoRowMixin:OnLoad()")
end

function DragonflightHelperTodoRowMixin:Init(todoEntry)
  self.todoEntry = todoEntry
  self.maximum = todoEntry.maximum
  self.completed = 0

  self:Update()
end

function DragonflightHelperTodoRowMixin:OnShow()
  self:RegisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoRowMixin:OnHide()
  self:UnregisterEvent("QUEST_TURNED_IN")
end

function DragonflightHelperTodoRowMixin:OnEvent(event, ...)
  if event == "QUEST_TURNED_IN" then
    self:Update()
  end
end

function DragonflightHelperTodoRowMixin:Update()
  for _, quest in ipairs(self.todoEntry.quests) do
    local title = C_QuestLog.GetTitleForQuestID(quest.id)
    -- local isWQ = C_QuestLog.IsWorldQuest(quest.id)

    -- print(quest.id .. " " .. (isWQ and "true" or "false") .. " " .. (title and title or ""))

    if title ~= nil then
      self.title = title
    else
      self.title = ""
    end

    if C_QuestLog.IsQuestFlaggedCompleted(quest.id) then
      self.completed = self.completed + 1
    end
  end

  self.Container.Name:SetText(self.title)
  self.Container.Progress:SetText(self.completed .. " / " .. self.maximum)

  if self.completed ~= self.maximum then
    self.Container.Progress:SetTextColor(1, 0, 0, 1)
  else
    self.Container.Progress:SetTextColor(0, 1, 0, 1)
    self:UnregisterEvent("QUEST_TURNED_IN")
  end
end
