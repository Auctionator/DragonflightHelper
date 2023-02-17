DragonflightHelperReputationsMixin = {}

local MAJOR_FACTIONS = {
  -- Dragonscale Expedition
  { factionIndex = 4,  color = BLUE_FONT_COLOR },
  -- Iskaara Tuskarr
  { factionIndex = 5,  color = BLUE_FONT_COLOR },
  -- Maruuk Centaur
  { factionIndex = 6,  color = BLUE_FONT_COLOR },
  -- Winterpelt Furbolg
  -- [7] = { factionIndex = 7, color = BLUE_FONT_COLOR },
  -- Valdrakken Accord
  { factionIndex = 8,  color = BLUE_FONT_COLOR },
  -- Artisan's Consortium
  { factionIndex = 9,  color = FACTION_BAR_COLORS[5] },
  -- Cobalt Assembly
  { factionIndex = 10, color = FACTION_BAR_COLORS[5] },
  -- Sabellian
  { factionIndex = 11, color = FACTION_BAR_COLORS[5] },
  -- Wrathion
  { factionIndex = 12, color = FACTION_BAR_COLORS[5] },
}

function DragonflightHelperReputationsMixin:OnLoad()
  -- print("DragonflightHelperReputationsMixin:OnLoad()")

  self.lastChild = self.Container.Title
  self.adjustedHeight = self.Container.Title:GetHeight()

  for _, factionSettings in ipairs(MAJOR_FACTIONS) do
    local child = CreateFrame("FRAME", "DFH_Rep_" .. factionSettings.factionIndex, self,
      "DragonflightHelperReputationRowFrame")
    child:Init(factionSettings)
    child:SetBackgroundColor(220, 220, 200, 0.1)

    if self.lastChild == nil then
      child:SetPoint("TOPLEFT", self.Container, "TOPLEFT", 2)
    else
      child:SetPoint("TOPLEFT", self.lastChild, "BOTTOMLEFT", 0, -2)
    end

    self.lastChild = child
    self.adjustedHeight = self.adjustedHeight + child:GetHeight()
  end

  self:SetHeight(self.adjustedHeight + 16)
  self.Container:SetHeight(self.adjustedHeight + 16)
end
