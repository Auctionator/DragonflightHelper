local Gathering = {
  [182] = { 71857, 71858, 71859, 71860, 71861, 71864 }, -- Herbalism
  [186] = { 72160, 72161, 72162, 72163, 72164, 72165 }, -- Mining
  [393] = { 70381, 70383, 70384, 70385, 70386, 70389 } -- Skinning
}
local DirtOrPack = {
  [171] = { 66373, 66374 }, -- Alchemy
  [164] = { 66381, 66382 }, -- Blacksmithing
  [333] = { 66377, 66378 }, -- Enchanting
  [202] = { 66379, 66380 }, -- Engineering
  [773] = { 66375, 66376 }, -- Inscription
  [755] = { 66388, 66389 }, -- Jewelcrafting
  [165] = { 66384, 66385 }, -- Leatherworking
  [197] = { 66386, 66387 }, -- Tailoring
}

local GatheringItemNames = {
  [182] = "Dreambloom",
  [186] = "Iridescent Ore",
  [393] = "Curious Hide",
  [171] = "Disturbed Dirt or Scout's Pack",
  [164] = "Disturbed Dirt or Scout's Pack",
  [333] = "Disturbed Dirt or Scout's Pack",
  [202] = "Disturbed Dirt or Scout's Pack",
  [773] = "Disturbed Dirt or Scout's Pack",
  [755] = "Disturbed Dirt or Scout's Pack",
  [165] = "Disturbed Dirt or Scout's Pack",
  [197] = "Disturbed Dirt or Scout's Pack",
}

DragonflightHelperGatheringOneMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperGatheringOneMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)
end

function DragonflightHelperGatheringOneMixin:Init()
  DragonflightHelperProfessionBaseMixin.Init(self)

  if self.hasFirstProfession and Gathering[self.professionInfo[1].skillId] ~= nil then
    DragonflightHelperProfessionTodoItemMixin.Init(self, Gathering[self.professionInfo[1].skillId],
      GatheringItemNames[self.professionInfo[1].skillId])
  elseif self.hasFirstProfession and DirtOrPack[self.professionInfo[1].skillId] ~= nil then
    DragonflightHelperProfessionTodoItemMixin.Init(self, DirtOrPack[self.professionInfo[1].skillId],
      GatheringItemNames[self.professionInfo[1].skillId])
  else
    DragonflightHelperProfessionTodoItemMixin.Init(self, {}, "No gathering items for " .. self.professionInfo[1].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(220, 220, 220, 0)
  end
end

DragonflightHelperGatheringTwoMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperGatheringTwoMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)
end

function DragonflightHelperGatheringTwoMixin:Init()
  DragonflightHelperProfessionBaseMixin.Init(self)

  if self.hasSecondProfession and Gathering[self.professionInfo[2].skillId] ~= nil then
    DragonflightHelperProfessionTodoItemMixin.Init(self, Gathering[self.professionInfo[2].skillId],
      GatheringItemNames[self.professionInfo[2].skillId])
  elseif self.hasSecondProfession and DirtOrPack[self.professionInfo[2].skillId] ~= nil then
    DragonflightHelperProfessionTodoItemMixin.Init(self, DirtOrPack[self.professionInfo[2].skillId],
      GatheringItemNames[self.professionInfo[2].skillId])
  else
    DragonflightHelperProfessionTodoItemMixin.Init(self, {}, "No gathering items for " .. self.professionInfo[2].name)
    self:SetBackgroundColor(220, 220, 220, 0.3)
    self:SetForegroundColor(0, 0, 0, 0)
  end
end
