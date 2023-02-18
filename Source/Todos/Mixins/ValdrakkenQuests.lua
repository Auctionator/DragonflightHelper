local Quests = {
  [171] = { 70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937 }, -- Alchemy
  [164] = { 66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211 }, -- Blacksmithing
  [333] = { 66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423 }, -- Enchanting
  [202] = { 72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539 }, -- Engineering
  [182] = { 70614, 70613, 70616 }, -- Herbalism
  [773] = { 66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438 }, -- Inscription
  [755] = { 66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562 }, -- Jewelcrafting
  [165] = { 66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363 }, -- Leatherworking
  [186] = { 70617, 70618, 72157, 72156 }, -- Mining
  [393] = { 70620, 72159, 70619 }, -- Skinning
  [197] = { 72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899 }, -- Tailoring
}

DragonflightHelperValdrakkenOneMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperValdrakkenOneMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)

  if self.hasFirstProfession and Quests[self.professionInfo[1].skillId] ~= nil then
    self:Init(Quests[self.professionInfo[1].skillId], self.professionInfo[1].name .. " Valdrakken weekly", 1)
  else
    self:Init({}, "No Valdrakken weekly for " .. self.professionInfo[1].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(220, 220, 220, 0)
  end
end

DragonflightHelperValdrakkenTwoMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperValdrakkenTwoMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)

  if self.hasSecondProfession and Quests[self.professionInfo[2].skillId] ~= nil then
    self:Init(Quests[self.professionInfo[2].skillId], self.professionInfo[2].name .. " Valdrakken weekly", 1)
  else
    self:Init({}, "No Valdrakken weekly for " .. self.professionInfo[2].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
  end
end
