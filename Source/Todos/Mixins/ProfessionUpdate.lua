local ProfessionQuests = DFH_Constants.ProfessionQuests

DFH_TreatiseUpdater = {}

function DFH_TreatiseUpdater:Init(profession)
  self.initialized = true
  self.profession = profession

  if self.profession == nil or self.profession.skillId == nil then
    self.completed = true
    return
  else
    self.completed = false
    self.treatiseQuestId = ProfessionQuests.Treatise[self.profession.skillId].quests[1]

    if C_QuestLog.IsQuestFlaggedCompleted(self.treatiseQuestId) then
      self.completed = true
    end
  end

  if not self.completed then
    self.timer = C_Timer.NewTicker(3, function() self:Check() end)
  end
end

function DFH_TreatiseUpdater:Check()
  self.completed = C_QuestLog.IsQuestFlaggedCompleted(self.treatiseQuestId)

  if self.completed then
    self.timer:Cancel()
    self:Update()
  end
end

DFH_ProfessionUpdate = CreateFromMixins(DFH_GenericUpdate)

function DFH_ProfessionUpdate:CollapseFrame()
  self:Hide()
  self:SetHeight(1)

  -- This should be "TOPLEFT"
  local point, relativeTo, relativePoint = self:GetPoint()
  self:SetPoint(point, relativeTo, relativePoint, 0, 1)
  self.collapsed = true
end

function DFH_ProfessionUpdate:Update()
  self.collapsed = false

  if self.professionIndex == nil then
    DFH_Utilities.error("[INCORRECT USAGE]", "DFH_ProfessionUpdate: A professionIndex must be provided")
    self:SetTitle("Unknown profession")
    return
  end

  if not self:hasProfession(self.professionIndex) then
    self:SetTitle("No profession selected")
    return
  end

  if self.questTypeKey == nil then
    DFH_Utilities.error("[INCORRECT USAGE]",
      "DFH_ProfessionUpdate: A questTypeKey object must be initialized")
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  if ProfessionQuests[self.questTypeKey] == nil then
    self:CollapseFrame()
    return
  end

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)] == nil then
    self:CollapseFrame()
    return
  end

  local entry = ProfessionQuests[self.questTypeKey]

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].items ~= nil then
    self.items = ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].items

    self:SetEnterCallback(function()
      self:ShowItemsTooltip(entry[self:getId(self.professionIndex)], entry.title)
    end)

    self:SetLeaveCallback(function()
      GameTooltip:Hide()
    end)
  end

  DFH_GenericUpdate.update(self, entry[self:getId(self.professionIndex)], entry.title)
end

function DFH_ProfessionUpdate:ShowItemsTooltip(entry, optionalTitle)
  GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

  GameTooltip_SetTitle(GameTooltip,
    (optionalTitle or entry.title or "") .. " (" .. self:getName(self.professionIndex) .. ")",
    NORMAL_FONT_COLOR)

  GameTooltip_AddBlankLineToTooltip(GameTooltip)

  if entry.description ~= nil then
    GameTooltip_AddHighlightLine(
      GameTooltip,
      entry.description
    )
    GameTooltip_AddBlankLineToTooltip(GameTooltip)
  end

  local completed = 0

  for index, itemId in ipairs(entry.items) do
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.quests[index]) then
      local item = Item:CreateFromItemID(itemId)

      item:ContinueOnItemLoad(function()
        local itemName = item:GetItemName();

        GameTooltip:AddLine(
          CreateSimpleTextureMarkup(item:GetItemIcon(), 25, 25) .. "  " .. itemName
        )
      end)
    else
      completed = completed + 1
    end
  end

  if completed == #entry.quests then
    GameTooltip_AddHighlightLine(GameTooltip, "All items found this week")
  end

  GameTooltip:Show()
end

DFH_ItemWaypointsButton = {}

function DFH_ItemWaypointsButton:Init(profession)
  self.initialized = true
  self.profession = profession
end

function DFH_ItemWaypointsButton:OnEnter()
  self:GetParent():OnEnter()
end

function DFH_ItemWaypointsButton:OnLeave()
  self:GetParent():OnLeave()
end

function DFH_ItemWaypointsButton:OnClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  if not self.initialized then
    DFH_Utilities.error("Profession not initialized")
    return
  end

  local entry = ProfessionQuests.WeeklyDrops[self.profession.skillId]

  for i, waypoint in ipairs(entry.waypoints) do
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.quests[i]) then
      TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
    end
  end
end
