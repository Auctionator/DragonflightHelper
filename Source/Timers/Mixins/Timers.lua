DFH_TimerMixin = {}

function DFH_TimerMixin:OnLoad()
  DFH_StatusBarMixin.OnLoad(self)

  self.color = ITEM_QUALITY_COLORS[self.colorIndex]
  self.thresholdColor = ITEM_QUALITY_COLORS[2]

  self:SetTitle(self.title)
  self:SetReverseFill()
  self:SetMinMaxValues(0, self.frequency * 60 * 60)
  self:SetForegroundColor(self.color.r, self.color.g, self.color.b, 1)

  local waypoint = {
    map = self.tt_map,
    x = self.tt_x / 100,
    y = self.tt_y / 100,
    options = { title = self.tt_title }
  }

  self:SetClickCallback(function()
    if TomTom == nil then
      DFH_Utilities.error("TomTom required to use this functionality")
    end

    TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
  end)
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

-- Stealing logic from https://wago.io/fVZJC8tik (remember to credit)
-- Mon Nov 21 2022 00:00:00 GMT+0100 (Central European Standard Time)
local REGIONAL_WEEKLY_START = 1668981600
local regionId = GetCurrentRegion()

if regionId == 1 then
  -- US (includes Brazil and Oceania)
  REGIONAL_WEEKLY_START = REGIONAL_WEEKLY_START - 3 * 60 * 60
elseif regionId == 2 then
  -- Korea
  REGIONAL_WEEKLY_START = REGIONAL_WEEKLY_START - 2 * 60 * 60
elseif regionId == 3 then
  -- Europe (includes Russia) - here for completeness
elseif regionId == 4 then
  -- Taiwan
elseif regionId == 5 then
  -- China
end

function DFH_TimerMixin:Update()
  local eventIntervalInSeconds = self.frequency * 60 * 60
  local secondsUntilNextEvent = (GetServerTime() - REGIONAL_WEEKLY_START) % eventIntervalInSeconds

  local aboutToStart = secondsUntilNextEvent <= 15 * 60
  local inProgress = (eventIntervalInSeconds - secondsUntilNextEvent) <= 15 * 60

  -- local hour, minute = GetGameTime()
  -- local currentTime = (hour * 60) + minute

  -- local howManyToday = math.floor((currentTime - (self.startTime * 60)) / (self.frequency * 60))
  -- local lastStartTime = howManyToday * self.frequency * 60 + self.startTime * 60
  -- local diff = currentTime - lastStartTime
  -- local untilNext = self.frequency * 60 - diff
  -- local aboutToStart = untilNext <= self.activeThreshold
  -- local inProgress = diff < self.activeThreshold
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
    self:SetValue(secondsUntilNextEvent)
    self:SetDescription("About to start - " .. SecondsToTime(secondsUntilNextEvent))
  elseif inProgress then
    self:SetForegroundColor(self.thresholdColor.r, self.thresholdColor.g, self.thresholdColor.b)
    self:SetMinMaxValues(0, self.activeThreshold * 60)
    self:SetValue(self.activeThreshold * 60 - (eventIntervalInSeconds - secondsUntilNextEvent))
    self:SetDescription("Active - " ..
      SecondsToTime((self.activeThreshold * 60 - (eventIntervalInSeconds - secondsUntilNextEvent)) * 60))
  else
    self:SetForegroundColor(self.color.r, self.color.g, self.color.b)
    self:SetMinMaxValues(0, self.frequency * 60)
    self:SetValue(secondsUntilNextEvent)
    self:SetDescription(SecondsToTime(secondsUntilNextEvent))
  end
end

DFH_FeastTimerMixin = CreateFromMixins(DFH_TimerMixin)
DFH_SiegeTimerMixin = CreateFromMixins(DFH_TimerMixin)
