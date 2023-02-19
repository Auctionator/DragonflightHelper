local KnowledgeCurrencies = {
  [182] = 2034, -- Herbalism
  [186] = 2035, -- Mining
  [393] = 2033, -- Skinning
  [171] = 2024, -- Alchemy
  [164] = 2023, -- Blacksmithing
  [333] = 2030, -- Enchanting
  [202] = 2027, -- Engineering
  [773] = 2028, -- Inscription
  [755] = 2029, -- Jewelcrafting
  [165] = 2025, -- Leatherworking
  [197] = 2026, -- Tailoring
}

DFH_ProfessionContainerMixin = CreateFromMixins(DFH_TodoEventHandler, DFH_ProfessionLoader)

function DFH_ProfessionContainerMixin:OnLoad()
  if self.professionIndex == nil then
    print("[DEBUG] Unable to create profession container; no profession index provided")
  end

  self.professionChildren = { self.Treatise, self.Gathering, self.WeeklyDrops, self.ServicesRequested, self.Trainer,
    self.Valdrakken }
  for _, child in ipairs(self.professionChildren) do
    child.professionIndex = self.professionIndex
  end

  self:LoadProfessions()
end

function DFH_ProfessionContainerMixin:Update()
  if not self:hasProfession(self.professionIndex) then
    self.Title:SetTitle("Profession " .. self.professionIndex .. " not selected")
    return
  end

  self.profession = self.professionInfo[self.professionIndex]

  self.Title:SetTitle(self:getTitle())
  self:AdjustHeight()
end

function DFH_ProfessionContainerMixin:AdjustHeight()
  local adjustedHeight = self.Title:GetHeight()

  for i, child in ipairs(self.professionChildren) do
    if child:IsVisible() then
      print(i, self.professionIndex, child:GetName(), child:GetHeight())
      adjustedHeight = adjustedHeight + child:GetHeight() + 2
    end
  end

  self:SetHeight(adjustedHeight)
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
