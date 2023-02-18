DFH_ProfessionTodosMixin = CreateFromMixins(DFH_ProfessionLoader)

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

function DFH_ProfessionTodosMixin:OnLoad()
  self:LoadProfessions()
end

function DFH_ProfessionTodosMixin:Update()
  if self:hasProfession(1) then
    local knowledge = ""

    if KnowledgeCurrencies[self:getId(1)] ~= nil then
      knowledge = " (" .. C_CurrencyInfo.GetCurrencyInfo(KnowledgeCurrencies[self:getId(1)]).quantity .. ")"
    end

    self.ProfessionOneTitle:SetTitle(self:getName(1) .. knowledge)
  else
    self.ProfessionOneTitle:SetTitle("No profession in slot one")
  end

  if self:hasProfession(2) then
    local knowledge = ""

    if KnowledgeCurrencies[self:getId(2)] ~= nil then
      knowledge = " (" .. C_CurrencyInfo.GetCurrencyInfo(KnowledgeCurrencies[self:getId(2)]).quantity .. ")"
    end

    self.ProfessionTwoTitle:SetTitle(self:getName(2) .. knowledge)
  else
    self.ProfessionTwoTitle:SetTitle("No profession in slot two")
  end
end
