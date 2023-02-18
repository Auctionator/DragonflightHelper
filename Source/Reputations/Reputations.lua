DragonflightHelperReputationsMixin = {}

local MAJOR_FACTIONS = {
  -- Dragonscale Expedition
  { id = 2507, color = BLUE_FONT_COLOR },
  -- Iskaara Tuskarr
  { id = 2511, color = BLUE_FONT_COLOR },
  -- Maruuk Centaur
  { id = 2503, color = BLUE_FONT_COLOR },
  -- Winterpelt Furbolg
  -- [7] = { id = ?, color = BLUE_FONT_COLOR },
  -- Valdrakken Accord
  { id = 2510, color = BLUE_FONT_COLOR },
  -- Artisan's Consortium
  { id = 2544, color = FACTION_BAR_COLORS[5] },
  -- Cobalt Assembly
  { id = 2550, color = FACTION_BAR_COLORS[5] },
  -- Sabellian
  { id = 2518, color = FACTION_BAR_COLORS[5] },
  -- Wrathion
  { id = 2517, color = FACTION_BAR_COLORS[5] },
}

function DragonflightHelperReputationsMixin:OnLoad()
  self:RegisterEvent("UPDATE_FACTION")
end

function DragonflightHelperReputationsMixin:OnEvent(event, ...)
  if event == "UPDATE_FACTION" then
    self:UnregisterEvent("UPDATE_FACTION")
    self:Init()
  end
end

function DragonflightHelperReputationsMixin:Init()
  -- print("DragonflightHelperReputationsMixin:OnLoad()")

  self.lastChild = self.Title
  self.adjustedHeight = self.Title:GetHeight()

  for _, factionSettings in ipairs(MAJOR_FACTIONS) do
    local child = CreateFrame("FRAME", "DFH_Rep_" .. factionSettings.id, self,
      "DragonflightHelperReputationRowFrame")

    DragonflightHelper.Utilities.dump(factionSettings, "Init faction")
    child:Init(factionSettings)
    child:SetBackgroundColor(220, 220, 200, 0.1)

    if self.lastChild == self.Title then
      child:SetPoint("TOPLEFT", self.Title, "BOTTOMLEFT")
    else
      child:SetPoint("TOPLEFT", self.lastChild, "BOTTOMLEFT", 0, -2)
    end

    self.lastChild = child
    self.adjustedHeight = self.adjustedHeight + child:GetHeight()
  end

  self:SetHeight(self.adjustedHeight + 16)
end
