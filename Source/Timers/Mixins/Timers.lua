DragonflightHelperTimerMixin = {}

function DragonflightHelperTimerMixin:OnLoad()
  DragonflightHelperStatusBarMixin.OnLoad(self)

  self.color = ITEM_QUALITY_COLORS[self.colorIndex]
  self.thresholdColor = ITEM_QUALITY_COLORS[2]

  self:SetTitle(self.title)
  self:SetReverseFill()
  self:SetMinMaxValues(0, self.frequency * 60)
  self:SetForegroundColor(self.color.r, self.color.g, self.color.b)

  self:InitializeTimes()
end

function DragonflightHelperTimerMixin:InitializeTimes()
  self.times = {}

  for i = self.startTime, self.endTime, self.frequency do
    table.insert(self.times, i * 60)
  end
end

function DragonflightHelperTimerMixin:OnShow()
  self:FindNextTime()
  self:Update()
  self.timer = C_Timer.NewTicker(30, function() self:Update() end)
end

function DragonflightHelperTimerMixin:OnHide()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
end

function DragonflightHelperTimerMixin:FindNextTime()
  local hour, minute = GetGameTime()
  local compareValue = hour * 60 + minute

  if self.nextTime ~= nil and compareValue > self.nextTime and self.nextTime == self.times[#self.times] then
    self.nextTime = self.times[1]
    return
  end

  self.nextTime = self.times[1]

  for i = 1, #self.times do
    if self.nextTime < compareValue then
      self.nextTime = self.times[i]
    end
  end
end

function DragonflightHelperTimerMixin:Update()
  local hour, minute = GetGameTime()
  local currentTime = hour * 60 + minute

  if currentTime > self.nextTime and self.nextTime ~= self.times[1] then
    self:FindNextTime()
  end

  -- if currentTime is still greater than nextTime here, it means we wrapped around
  if currentTime > self.nextTime then
    -- set it to be relative to tomorrow
    currentTime = currentTime - (24 * 60)
  end

  local thresholdTime = math.abs(self.nextTime - currentTime - (self.frequency * 60))

  if thresholdTime <= self.activeThreshold or self.nextTime - currentTime == 0 then
    self:SetForegroundColor(self.thresholdColor.r, self.thresholdColor.g, self.thresholdColor.b)
    self:SetMinMaxValues(0, self.activeThreshold)
    self:SetValue(self.activeThreshold - thresholdTime)
    self:SetDescription("Active - " .. SecondsToTime((self.activeThreshold - thresholdTime) * 60))
  else
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, self.frequency * 60)
    self:SetValue(self.nextTime - currentTime)
    self:SetDescription(SecondsToTime((self.nextTime - currentTime) * 60))
  end

  -- DragonflightHelper.Utilities.info(
  --   "Siege Timer Debugging",
  --   self.title,
  --   self.activeThreshold,
  --   currentTime,
  --   self.nextTime,
  --   thresholdTime
  -- )
end

DragonflightHelperFeastTimerMixin = CreateFromMixins(DragonflightHelperTimerMixin)
DragonflightHelperSiegeTimerMixin = CreateFromMixins(DragonflightHelperTimerMixin)
