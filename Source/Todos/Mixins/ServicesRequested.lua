local ServicesRequested = {
  [165] = { 70594 }, -- Leatherworking
  [197] = { 70595 }, -- Tailoring
  [755] = { 70593 }, -- Jewelcrafting
  [164] = { 70589 }, -- Blacksmithing
  [202] = { 70591 }, -- Engineering
  [773] = { 70592 }, -- Inscription
}

DragonflightHelperServicesOneMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperServicesOneMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)

  if self.hasFirstProfession and ServicesRequested[self.professionInfo[1].skillId] ~= nil then
    self:Init(ServicesRequested[self.professionInfo[1].skillId])
  else
    self:Init({}, "No weekly for " .. self.professionInfo[1].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(220, 220, 220, 0)
  end
end

DragonflightHelperServicesTwoMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperServicesTwoMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)

  if self.hasSecondProfession and ServicesRequested[self.professionInfo[2].skillId] ~= nil then
    self:Init(ServicesRequested[self.professionInfo[2].skillId])
  else
    self:Init({}, "No weekly for " .. self.professionInfo[2].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
  end
end
