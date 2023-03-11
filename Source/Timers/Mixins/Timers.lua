DFH_TimerMixin = {}

function DFH_TimerMixin:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)

  self.color = ITEM_QUALITY_COLORS[self.colorIndex]
  self.thresholdColor = ITEM_QUALITY_COLORS[2]

  self:SetTitle(self.title)
  self:SetReverseFill()
  self:SetMinMaxValues(0, self.frequency * 60)
  self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
end

function DFH_TimerMixin:OnShow()
  self:Update()
  self.timer = C_Timer.NewTicker(10, function() self:Update() end)
end

function DFH_TimerMixin:OnHide()
  if self.timer ~= nil then
    self.timer:Cancel()
    self.timer = nil
  end
end

function DFH_TimerMixin:Update()
  local hour, minute = GetGameTime()
  local currentTime = (hour * 60) + minute

  local howManyToday = math.floor((currentTime - (self.startTime * 60)) / (self.frequency * 60))
  local lastStartTime = howManyToday * self.frequency * 60 + self.startTime * 60
  local diff = currentTime - lastStartTime
  local untilNext = self.frequency * 60 - diff
  local aboutToStart = untilNext <= self.activeThreshold
  local inProgress = diff < self.activeThreshold
  -- DFH_Utilities.dump({
  --   frequency = self.frequency,
  --   howManyToday = howManyToday,
  --   lastStartTime = lastStartTime,
  --   diff = diff,
  --   untilNext = untilNext,
  --   aboutToStart = untilNext < 15 and "yes" or "no",
  --   inProgress = diff < self.frequency * 60 - 15 and "yes" or "no",
  --   remaining = self.frequency * 60 - diff
  -- }, self.title)


  if aboutToStart then
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, self.frequency * 60)
    self:SetValue(untilNext)
    self:SetDescription("About to start - " .. SecondsToTime(untilNext * 60))
  elseif inProgress then
    self:SetForegroundColor(self.thresholdColor.r, self.thresholdColor.g, self.thresholdColor.b)
    self:SetMinMaxValues(0, self.activeThreshold)
    self:SetValue(self.activeThreshold - diff)
    self:SetDescription("Active - " .. SecondsToTime((self.activeThreshold - diff) * 60))
  else
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, self.frequency * 60)
    self:SetValue(untilNext)
    self:SetDescription(SecondsToTime(untilNext * 60))
  end
end

DFH_FeastTimerMixin = CreateFromMixins(DFH_TimerMixin)
DFH_SiegeTimerMixin = CreateFromMixins(DFH_TimerMixin)
