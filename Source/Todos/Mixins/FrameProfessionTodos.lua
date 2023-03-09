local KnowledgeCurrencies = DFH_Constants.KnowledgeCurrencies

DFH_ProfessionContainerMixin = CreateFromMixins(DFH_TodoEventHandler, DFH_ProfessionLoader)

function DFH_ProfessionContainerMixin:OnLoad()
  if self.professionIndex == nil then
    DFH_Utilities.error("[DEBUG]", "Unable to create profession container; no profession index provided")
  end

  self.professionChildren = {
    self.Treatise, self.Gathering, self.WeeklyDrops, self.WeeklyServices, self.ValdrakkenTrainers, self.WeeklyProfession
  }

  for _, child in ipairs(self.professionChildren) do
    child.professionIndex = self.professionIndex
  end

  self:LoadProfessions()
end

function DFH_ProfessionContainerMixin:Update()
  DFH_Utilities.info("DFH_ProfessionContainerMixin:Update()")

  if not self:hasProfession(self.professionIndex) then
    self.Title:SetTitle("Profession " .. self.professionIndex .. " not selected")
    return
  end

  self.profession = self.professionInfo[self.professionIndex]

  if not self.Treatise.initialized then
    self.Treatise:Init(self.profession)
  end

  if not self.WeeklyDrops.Button.initialized then
    self.WeeklyDrops.Button:Init(self.profession)
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
