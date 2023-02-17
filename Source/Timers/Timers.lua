DragonflightHelperTimersMixin = {
  nextFeastTimerIndex = 0,
  minutesUntilFeast = 0,
  nextSiegeTimerIndex = 0,
  minutesUntilSiege = 0
}

function DragonflightHelperTimersMixin:OnLoad()
  -- print("DragonflightHelperTimersMixin:OnLoad()")

  self:FindEventTimes()
  C_Timer.NewTicker(30, function()
    self:Update()
  end)

  self.Container.Title:SetText(TIME_REMAINING:gsub(":", ""))

  self.Container.FeastTimer:SetTitle("Iskaara Feast Timer")
  self.Container.FeastTimer:SetReverseFill()
  self.Container.FeastTimer:SetMinMaxValues(0, 90)

  self.Container.SiegeTimer:SetTitle("Dragonbane Keep Siege Timer")
  self.Container.SiegeTimer:SetMinMaxValues(0, 120)
  self.Container.SiegeTimer:SetReverseFill()

  local color = ITEM_QUALITY_COLORS[4]
  self.Container.SiegeTimer:SetForegroundColor(color.r, color.g, color.b, 1)
  self:Update()
end

function DragonflightHelperTimersMixin:FindEventTimes()
  local currentHour, currentMinute = GetGameTime()

  self.nextFeastTimerIndex = 0
  self.nextSiegeTimerIndex = 0

  for index, eventTime in ipairs(DragonflightHelper.Events.SiegeOnDragonbaneKeep) do
    local eventHour = eventTime[1]

    if currentHour >= eventHour then
      self.nextSiegeTimerIndex = index + 1
    end
  end

  self.minutesUntilSiege = (DragonflightHelper.Events.SiegeOnDragonbaneKeep[self.nextSiegeTimerIndex][1] - currentHour) *
      60 - currentMinute

  for index, eventTime in ipairs(DragonflightHelper.Events.IskaaraFeast) do
    local eventHour, eventMinute = eventTime[1], eventTime[2]

    if currentHour >= eventHour and currentMinute > eventMinute then
      self.nextFeastTimerIndex = index + 1
    end
  end

  self.minutesUntilFeast = (DragonflightHelper.Events.IskaaraFeast[self.nextFeastTimerIndex][1] - currentHour) * 60 +
      (DragonflightHelper.Events.IskaaraFeast[self.nextFeastTimerIndex][2] - currentMinute)
end

function DragonflightHelperTimersMixin:Update()
  local currentHour, currentMinute = GetGameTime()

  self.minutesUntilSiege = (DragonflightHelper.Events.SiegeOnDragonbaneKeep[self.nextSiegeTimerIndex][1] - currentHour) *
      60 - currentMinute
  self.minutesUntilFeast = (DragonflightHelper.Events.IskaaraFeast[self.nextFeastTimerIndex][1] - currentHour) * 60 +
      (DragonflightHelper.Events.IskaaraFeast[self.nextFeastTimerIndex][2] - currentMinute)

  local feastDisplay

  if self.minutesUntilFeast > 15 then
    feastDisplay = SecondsToTime(self.minutesUntilFeast * 60)
  elseif self.minutesUntilFeast <= 15 then
    feastDisplay = "Meal Prep - " .. SecondsToTime(self.minutesUntilFeast * 60)
  elseif self.minutesUntilFeast > -16 then
    feastDisplay = "ACTIVE - " .. SecondsToTime((15 - self.minutesUntilFeast) * 60)
  else
    self:FindEventTimes()
  end

  if self.minutesUntilSiege < 0 then
    self:FindEventTimes()
  end

  self.Container.FeastTimer:SetDescription(feastDisplay)
  self.Container.FeastTimer:SetValue(math.abs(self.minutesUntilFeast))
  self.Container.SiegeTimer:SetDescription(SecondsToTime(self.minutesUntilSiege * 60))
  self.Container.SiegeTimer:SetValue(self.minutesUntilSiege)
end
