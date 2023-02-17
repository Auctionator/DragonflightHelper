DragonflightHelperTodoRowMixin = {}

function DragonflightHelperTodoRowMixin:OnLoad()
  -- print("DragonflightHelperTodoRowMixin:OnLoad()")
end

function DragonflightHelperTodoRowMixin:Init(todoEntry)
  self.maximum = todoEntry.maximum
  self.completed = 0

  for _, quest in ipairs(todoEntry.quests) do
    local title = C_QuestLog.GetTitleForQuestID(quest.id)
    local isWQ = C_QuestLog.IsWorldQuest(quest.id)

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

  self.Container.Name:SetText(self.title .. " " .. self.completed .. " / " .. self.maximum)
end
