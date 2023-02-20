DFH_TodoUpdate = CreateFromMixins(DFH_GenericUpdate)

local WeeklyQuests = {
  ["Aiding the Accord"] = { quests = { 70750, 72068, 72374, 72373, 72375 }, completionCount = 1 },
  ["Revival Catalyst"] = { quests = { 72528 } },
  ["Iskaara Tuskarr Feast"] = { quests = { 70893 } },
  ["Siege on Dragonbane Keep"] = { quests = { 70866 }, title = "Siege on Dragonbane Keep" },
  ["Grand Hunts"] = { quests = { 70906, 71136, 71137 }, title = "Grand Hunts" },
  ["Trial of Flood"] = { quests = { 71033 }, title = "Trial of Flood - Raging Torrent" },
  ["Trial of Elements"] = { quests = { 71995 }, title = "Trial of Elements - Therrocite" },
  ["World Bosses"] = { quests = { 69927, 69928, 69929, 69930 }, title = "World Bosses", completionCount = 1 }
}

function DFH_TodoUpdate:Update()
  if self.weeklyIndex == nil then
    DragonflightHelper.Utilities.error("[INCORRECT USAGE]", "DFH_TodoUpdate: A weeklyIndex must be provided")
    self:SetTitle("Unknown weekly")
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  local entry = WeeklyQuests[self.weeklyIndex]

  if entry == nil then
    self:SetTitle("No entries found for " .. self.weeklyIndex)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  DFH_GenericUpdate.update(self, entry)
end
