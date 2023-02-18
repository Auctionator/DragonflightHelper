DFH_ProfessionStatusBar = CreateFromMixins(
  DFH_ProfessionLoader,
  DFH_ProfessionEventHandler,
  DFH_ProfessionUpdate,
  DragonflightHelperStatusBarMixin
)

function DFH_ProfessionStatusBar:OnLoad()
  print("DFH_ProfessionStatusBar:OnLoad()")

  DragonflightHelperStatusBarMixin.OnLoad(self)
  self:LoadProfessions()

  local completedColor = FACTION_BAR_COLORS[5]
  local incompleteColor = FACTION_BAR_COLORS[1]

  self:SetBackgroundColor(incompleteColor.r, incompleteColor.g, incompleteColor.b, 0.3)
  self:SetForegroundColor(completedColor.r, completedColor.g, completedColor.b)
end
