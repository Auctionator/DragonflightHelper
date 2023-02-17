DragonflightHelper.Events = {}
DragonflightHelper.Events.SiegeOnDragonbaneKeep = {}
DragonflightHelper.Events.IskaaraFeast = {}

-- Happens every 2 hours, starting at midnight
-- TODO: Do time zones change this?
for i = 0, 25, 2 do
  table.insert(
    DragonflightHelper.Events.SiegeOnDragonbaneKeep, { i, 0 }
  )
end

-- Happens every 1.5 hours, starting at 1am
-- TODO: Do time zones change this?
for i = 1, 24, 1.5 do
  table.insert(
    DragonflightHelper.Events.IskaaraFeast, { math.floor(i), (i % 1) * 60 }
  )
end
