local _, ns = ...

local info = {}

function info:attach(container, frequency, active_threshold, color, threshold_color, waypoint)
  function container:update()
    local interval = frequency * 60 * 60
    local seconds_until_next_event = (C_DateAndTime.GetSecondsUntilDailyReset() / interval) % 1 * interval

    local about_to_start = seconds_until_next_event <= (10 * 60)
    local in_progress = (interval - seconds_until_next_event) <= (active_threshold * 60)

    if about_to_start then
      container.foreground:SetStatusBarColor(color.r, color.g, color.b, 0.7)
      container.foreground:SetMinMaxValues(0, 10 * 60)
      container.foreground:SetValue(seconds_until_next_event)
      container.description:SetText("Starting in " .. SecondsToTime(seconds_until_next_event))
      C_Timer.NewTimer(1, function() container:update() end)
    elseif in_progress then
      container.foreground:SetStatusBarColor(threshold_color.r, threshold_color.g, threshold_color.b, 0.7)
      container.foreground:SetMinMaxValues(0, active_threshold * 60)
      container.foreground:SetValue(interval - seconds_until_next_event)
      container.description:SetText("Active - " .. SecondsToTime((interval - seconds_until_next_event), true))
      C_Timer.NewTimer(30, function() container:update() end)
    else
      container.foreground:SetStatusBarColor(color.r, color.g, color.b, 0.7)
      container.foreground:SetMinMaxValues(0, interval)
      container.foreground:SetValue(seconds_until_next_event)
      container.description:SetText(SecondsToTime(seconds_until_next_event, true))
      C_Timer.NewTimer(30, function() container:update() end)
    end
  end

  if waypoint and TomTom ~= nil then
    container:SetScript("OnMouseDown", function()
      TomTom:AddWaypoint(waypoint.map, waypoint.x / 100, waypoint.y / 100, { title = waypoint.title })
    end)
  end

  container.foreground:SetReverseFill(true)
  container:update()
  C_Timer.NewTimer(30, function() container:update() end)
end

ns.timers.info = info
