DFH_ProfessionLoader = {}

function DFH_ProfessionLoader:LoadProfessions()
  if self.professionsInitialized then
    -- already loaded; singleton would be nice here
    return
  end
  -- I tried watching the PLAYER_ALIVE event but it wasnt working,
  -- so fuck it:
  self.ticker = C_Timer.NewTicker(1, function()
    self:CheckForProfessions()
  end)
end

function DFH_ProfessionLoader:CheckForProfessions()
  local firstProfession, secondProfession = GetProfessions()

  if firstProfession ~= nil or secondProfession ~= nil then
    self.ticker:Cancel()
    self:InitializeProfessions()
  else
    return
  end
end

function DFH_ProfessionLoader:InitializeProfessions()
  if self.Update == nil then
    print("DFH_ProfessionLoader: No Update method found for this entry")
    return
  end

  local firstProfession, secondProfession = GetProfessions()

  self.professionInfo = {
    { name = "None", skillId = 0, professionId = firstProfession,  initialized = firstProfession ~= nil },
    { name = "None", skillId = 0, professionId = secondProfession, initialized = secondProfession ~= nil }
  }

  if self:hasProfession(1) then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(firstProfession)
    self.professionInfo[1].name = name
    self.professionInfo[1].skillId = skillLine
  end

  if self:hasProfession(2) then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(secondProfession)
    self.professionInfo[2].name = name
    self.professionInfo[2].skillId = skillLine
  end

  self:Update()
end

function DFH_ProfessionLoader:hasProfession(professionIndex)
  return self.professionInfo ~= nil and self.professionInfo[professionIndex] ~= nil and
      self.professionInfo[professionIndex].initialized
end

function DFH_ProfessionLoader:getName(professionIndex)
  if self.professionInfo == nil or self.professionInfo[professionIndex] == nil or not
      self.professionInfo[professionIndex].initialized then
    return ""
  end

  return self.professionInfo[professionIndex].name
end

function DFH_ProfessionLoader:getId(professionIndex)
  if self.professionInfo == nil or self.professionInfo[professionIndex] == nil or not
      self.professionInfo[professionIndex].skillId then
    return nil
  end

  return self.professionInfo[professionIndex].skillId
end
