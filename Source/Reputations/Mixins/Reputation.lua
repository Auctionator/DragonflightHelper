DragonflightHelperReputationItemMixin = CreateFromMixins(DragonflightHelperStatusBarMixin)

function DragonflightHelperReputationItemMixin:OnLoad()
  DragonflightHelperStatusBarMixin.OnLoad(self)
  self.initialized = false
end

function DragonflightHelperReputationItemMixin:OnShow()
  FrameUtil.RegisterFrameForEvents(self, {
    "UPDATE_FACTION",
    "MAJOR_FACTION_RENOWN_LEVEL_CHANGED",
    "MAJOR_FACTION_UNLOCKED"
  })
end

function DragonflightHelperReputationItemMixin:OnHide()
  FrameUtil.UnregisterFrameForEvents(self, {
    "UPDATE_FACTION",
    "MAJOR_FACTION_RENOWN_LEVEL_CHANGED",
    "MAJOR_FACTION_UNLOCKED"
  })
end

function DragonflightHelperReputationItemMixin:OnEvent(event, ...)
  if event == "UPDATE_FACTION" and self.initialized == false then
    self:Init()
    self:Update()
  elseif event == "UPDATE_FACTION" or event == "MAJOR_FACTION_RENOWN_LEVEL_CHANGED" or event == "MAJOR_FACTION_UNLOCKED" then
    self:Update()
  end
end

function DragonflightHelperReputationItemMixin:Init()
  self.initialized = true
end

function DragonflightHelperReputationItemMixin:Update()
  self.factionInfo:update()

  self:SetText()
  self:SetMinMaxValues(self.factionInfo.barMin, self.factionInfo.barMax)
  self:SetValue(self.factionInfo.barValue)
end

function DragonflightHelperReputationItemMixin:SetText()
  -- Artisan's Consortium name too long:
  local dashIndex = self.factionInfo.title:find("-")
  if dashIndex == nil then
    self:SetTitle(self.factionInfo.title)
  else
    self:SetTitle(self.factionInfo.title:sub(0, dashIndex - 1))
  end

  self:SetDescription(self.factionInfo.detail)
  self:SetRolloverDescription(("%d / %d"):format(self.factionInfo.barValue, self.factionInfo.barMax))
end
