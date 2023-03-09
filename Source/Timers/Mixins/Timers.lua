DFH_TimerMixin = {}

function DFH_TimerMixin:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)

  self.color = ITEM_QUALITY_COLORS[self.colorIndex]
  self.thresholdColor = ITEM_QUALITY_COLORS[2]

  self:SetTitle(self.title)
  self:SetReverseFill()
  self:SetMinMaxValues(0, self.frequency * 60)
  self:SetForegroundColor(self.color.r, self.color.g, self.color.b)

  self:InitializeTimes()
end

function DFH_TimerMixin:InitializeTimes()
  self.times = {}

  for i = self.startTime, self.endTime, self.frequency do
    table.insert(self.times, i * 60)
  end
end

function DFH_TimerMixin:OnShow()
  self:FindNextTime()
  self:Update()
  self.timer = C_Timer.NewTicker(30, function() self:Update() end)
end

function DFH_TimerMixin:OnHide()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
end

function DFH_TimerMixin:FindNextTime()
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

function DFH_TimerMixin:Update()
  local hour, minute = GetGameTime()
  local currentTime = hour * 60 + minute + 24 * 60

  -- Add one day to current time to avoid negative numbers
  -- Divide by frequency in minutes (yields # of events "today")
  -- Quantity times frequency in minutes to get number of "event minutes" elapsed in "day"
  local eventMinutesInDay =
      math.floor((currentTime + self.startTime * 60) / (self.frequency * 60)) *
      (self.frequency * 60)
  -- Add one day to current time to avoid negative numbers
  -- Offset by start time in the day
  -- subtract number of event minutes elapsed; gives time since last event
  local timeSinceLast = currentTime - eventMinutesInDay
  local timeUntilNext = (self.frequency * 60) - timeSinceLast
  local eventOccurringNow = timeSinceLast < self.activeThreshold

  DFH_Utilities.info(self.title, timeSinceLast, timeUntilNext)

  if eventOccurringNow then
    self:SetForegroundColor(self.thresholdColor.r, self.thresholdColor.g, self.thresholdColor.b)
    self:SetMinMaxValues(0, self.activeThreshold)
    self:SetValue(timeSinceLast)
    self:SetDescription("Active - " .. SecondsToTime(timeSinceLast * 60))
  else
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, self.frequency * 60)
    self:SetValue(timeUntilNext)
    self:SetDescription(SecondsToTime(timeUntilNext * 60))
  end
end

DFH_FeastTimerMixin = CreateFromMixins(DFH_TimerMixin)
DFH_SiegeTimerMixin = CreateFromMixins(DFH_TimerMixin)
