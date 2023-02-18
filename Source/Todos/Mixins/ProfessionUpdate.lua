DFH_ProfessionUpdate = {}

local ProfessionQuests = {
  Treatise = {
    title = "Draconic Treatise",
    [171] = { quests = { 74108 } }, -- Alchemy
    [164] = { quests = { 74109 } }, -- Blacksmithing
    [333] = { quests = { 74110 } }, -- Enchanting
    [202] = { quests = { 74111 } }, -- Engineering
    [182] = { quests = { 74107 } }, -- Herbalism
    [773] = { quests = { 74105 } }, -- Inscription
    [755] = { quests = { 74112 } }, -- Jewelcrafting
    [165] = { quests = { 74113 } }, -- Leatherworking
    [186] = { quests = { 74106 } }, -- Mining
    [393] = { quests = { 74114 } }, -- Skinning
    [197] = { quests = { 74115 } }, -- Tailoring
  },
  Gathering = {
    [182] = { title = "Dreambloom", quests = { 71857, 71858, 71859, 71860, 71861, 71864 } }, -- Herbalism
    [186] = { title = "Iridescent Ore", quests = { 72160, 72161, 72162, 72163, 72164, 72165 } }, -- Mining
    [393] = { title = "Curious Hide", quests = { 70381, 70383, 70384, 70385, 70386, 70389 } }, -- Skinning
    [171] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66373, 66374 } }, -- Alchemy
    [164] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66381, 66382 } }, -- Blacksmithing
    [333] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66377, 66378 } }, -- Enchanting
    [202] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66379, 66380 } }, -- Engineering
    [773] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66375, 66376 } }, -- Inscription
    [755] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66388, 66389 } }, -- Jewelcrafting
    [165] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66384, 66385 } }, -- Leatherworking
    [197] = { title = "Disturbed Dirt or Scout's Pack", quests = { 66386, 66387 } }, -- Tailoring
  },
  Services = {
    title = "Profession Services",
    [165] = { quests = { 70594 } }, -- Leatherworking
    [197] = { quests = { 70595 } }, -- Tailoring
    [755] = { quests = { 70593 } }, -- Jewelcrafting
    [164] = { quests = { 70589 } }, -- Blacksmithing
    [202] = { quests = { 70591 } }, -- Engineering
    [773] = { quests = { 70592 } }, -- Inscription
  },
  Valdrakken = {
    title = "Valdrakken Quests",
    [171] = { completionCount = 1, quests = { 70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937 } }, -- Alchemy
    [164] = { completionCount = 1, quests = { 66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211 } }, -- Blacksmithing
    [333] = { completionCount = 1, quests = { 66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423 } }, -- Enchanting
    [202] = { completionCount = 1, quests = { 72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539 } }, -- Engineering
    [182] = { completionCount = 1, quests = { 70614, 70613, 70616 } }, -- Herbalism
    [773] = { completionCount = 1, quests = { 66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438 } }, -- Inscription
    [755] = { completionCount = 1, quests = { 66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562 } }, -- Jewelcrafting
    [165] = { completionCount = 1, quests = { 66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363 } }, -- Leatherworking
    [186] = { completionCount = 1, quests = { 70617, 70618, 72157, 72156 } }, -- Mining
    [393] = { completionCount = 1, quests = { 70620, 72159, 70619 } }, -- Skinning
    [197] = { completionCount = 1, quests = { 72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899 } }, -- Tailoring
  }
}

function DFH_ProfessionUpdate:Update()
  print("DFH_ProfessionUpdate:Update()")

  if self.professionIndex == nil then
    print("[INCORRECT USAGE] DFH_ProfessionUpdate: A professionIndex must be provided")
    self:SetTitle("Unknown profession")
    return
  end

  if not self:hasProfession(self.professionIndex) then
    self:SetTitle("No profession selected")
    return
  end

  if self.questTypeKey == nil then
    print("[INCORRECT USAGE] DFH_ProfessionUpdate: A questTypeKey object must be initialized")
    return
  end

  if ProfessionQuests[self.questTypeKey] == nil then
    self:SetTitle("No " .. self:getName(self.professionIndex) .. " " .. self.questTypeKey .. " quests")
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)] == nil then
    self:SetTitle(
      "No " .. self:getName(self.professionIndex) .. " " .. ProfessionQuests[self.questTypeKey].title
    )
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
    return
  end

  local completed = 0
  local entry = ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)]
  local completionCount = entry.completionCount

  if completionCount == nil then
    completionCount = #entry.quests
  end

  for _, questId in ipairs(entry.quests) do
    if C_QuestLog.IsQuestFlaggedCompleted(questId) then
      completed = completed + 1
    end
  end

  self:SetMinMaxValues(0, completionCount)

  if ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].title ~= nil then
    self:SetTitle(ProfessionQuests[self.questTypeKey][self:getId(self.professionIndex)].title)
  elseif ProfessionQuests[self.questTypeKey].title ~= nil then
    self:SetTitle(ProfessionQuests[self.questTypeKey].title .. " (" .. self:getName(self.professionIndex) .. ")")
  else
    self:SetTitle(C_QuestLog.GetTitleForQuestID(entry.quests[1]))
  end

  self:SetDescription(completed .. " / " .. completionCount)
  self:SetValue(completed)
end
