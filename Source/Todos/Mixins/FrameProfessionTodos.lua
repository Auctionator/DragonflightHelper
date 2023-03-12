local KnowledgeCurrencies = DFH_Constants.KnowledgeCurrencies
local ProfessionQuests = DFH_Constants.ProfessionQuests

DFH_ProfessionContainerMixin = CreateFromMixins(DFH_TodoEventHandler, DFH_ProfessionLoader)

function DFH_ProfessionContainerMixin:OnLoad()
  if self.professionIndex == nil then
    DFH_Utilities.error("[DEBUG]", "Unable to create profession container; no profession index provided")
  end

  self.professionChildren = {
    self.Treatise, self.Gathering, self.WeeklyDrops, self.WeeklyServices, self.ValdrakkenTrainers,
    self.WeeklyProfession, self.ProfessionMasters
  }

  for _, child in ipairs(self.professionChildren) do
    child.professionIndex = self.professionIndex
    child:AfterLayout(function()
      self:Update()
    end)
  end

  self.weeklyClickInitialized = false
  self.professionMasterClickInitialized = false

  self:LoadProfessions()
end

function DFH_ProfessionContainerMixin:Update()
  if not self:hasProfession(self.professionIndex) then
    self.Title:SetTitle("Profession " .. self.professionIndex .. " not selected")
    return
  end

  self.profession = self.professionInfo[self.professionIndex]

  if not self.Treatise.initialized then
    self.Treatise:Init(self.profession)
  end

  if not self.weeklyClickInitialized then
    self.weeklyClickInitialized = true
    self.WeeklyDrops:SetClickCallback(function()
      self:WeeklyDropClick()
    end)
  end

  if not self.professionMasterClickInitialized then
    self.professionMasterClickInitialized = true
    self.ProfessionMasters:SetClickCallback(function()
      self:ProfessionMasterClick()
    end)
  end

  local frameHeight = self.Title:GetHeight()

  for _, child in ipairs(self.professionChildren) do
    if not child.collapsed then
      frameHeight = frameHeight + child:GetHeight()
    end
  end

  self.Title:SetTitle(self:getTitle())
  self:SetHeight(frameHeight)
end

function DFH_ProfessionContainerMixin:skillIsLevel25()
  -- TODO could add some messaging or hide/show based on availability
  return self.profession.rank >= 25
end

function DFH_ProfessionContainerMixin:getTitle()
  if self:skillIsLevel25() and KnowledgeCurrencies[self.profession.skillId] ~= nil then
    local unspentPoints = C_CurrencyInfo.GetCurrencyInfo(KnowledgeCurrencies[self.profession.skillId]).quantity

    if unspentPoints > 0 then
      return self.profession.name .. " (" .. unspentPoints .. ")"
    end
  end

  return self.profession.name
end

function DFH_ProfessionContainerMixin:WeeklyDropClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  local entry = ProfessionQuests.WeeklyDrops[self.profession.skillId]

  for i, waypoint in ipairs(entry.waypoints) do
    if not C_QuestLog.IsQuestFlaggedCompleted(entry.quests[i]) then
      TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
    end
  end
end

function DFH_ProfessionContainerMixin:ProfessionMasterClick()
  if TomTom == nil then
    DFH_Utilities.error("TomTom required to use this functionality")
  end

  local waypoint = ProfessionQuests.ProfessionMasters[self.profession.skillId].waypoints[1]

  TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
end
