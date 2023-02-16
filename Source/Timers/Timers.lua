DragonflightHelperTimersMixin = {}

function DragonflightHelperTimersMixin:OnLoad()
  self.Container.Title:SetText(TIME_REMAINING:gsub(":", ""))

  self.Container.FeastTimer:SetTitle("Iskaara Feast Timer")
  self.Container.FeastTimer:SetDescription("36m")
  self.Container.FeastTimer:SetRolloverDescription("HURRY")

  self.Container.FeastTimer:SetMinMaxValues(0, 100)
  self.Container.FeastTimer:SetValue(80)
end
