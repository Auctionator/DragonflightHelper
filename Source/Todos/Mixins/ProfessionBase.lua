DragonflightHelperProfessionBaseMixin = CreateFromMixins(DragonflightHelperStatusBarMixin)

function DragonflightHelperProfessionBaseMixin:OnLoad()
  -- I tried watching the PLAYER_ALIVE event but it wasnt working,
  -- so fuck it:
  self.fetchProfessionsTicker = C_Timer.NewTicker(1, function()
    self:CheckForProfessions()
  end)
end

function DragonflightHelperProfessionBaseMixin:CheckForProfessions()
  local firstProfession, secondProfession = GetProfessions()

  if firstProfession ~= nil or secondProfession ~= nil then
    self.fetchProfessionsTicker:Cancel()
    self:Init()
  else
    return
  end
end

function DragonflightHelperProfessionBaseMixin:Init()
  local firstProfession, secondProfession = GetProfessions()

  self.professionInfo = {
    { name = "None", skillId = 0 },
    { name = "None", skillId = 0 }
  }
  self.hasFirstProfession = firstProfession ~= nil
  self.hasSecondProfession = secondProfession ~= nil

  if self.hasFirstProfession ~= nil then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(firstProfession)
    self.professionInfo[1] = { name = name, skillId = skillLine }
  end

  if self.hasSecondProfession ~= nil then
    local name, _, _, _, _, _, skillLine = GetProfessionInfo(secondProfession)
    self.professionInfo[2] = { name = name, skillId = skillLine }
  end
end
