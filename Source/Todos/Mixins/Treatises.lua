local Treatises = {
  [171] = { 74108 }, -- Alchemy
  [164] = { 74109 }, -- Blacksmithing
  [333] = { 74110 }, -- Enchanting
  [202] = { 74111 }, -- Engineering
  [182] = { 74107 }, -- Herbalism
  [773] = { 74105 }, -- Inscription
  [755] = { 74112 }, -- Jewelcrafting
  [165] = { 74113 }, -- Leatherworking
  [186] = { 74106 }, -- Mining
  [393] = { 74114 }, -- Skinning
  [197] = { 74115 }, -- Tailoring
}

DragonflightHelperTreatiseOneMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperTreatiseOneMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)
end

function DragonflightHelperTreatiseOneMixin:Init()
  DragonflightHelperProfessionBaseMixin.Init(self)

  if self.hasFirstProfession then
    DragonflightHelperProfessionTodoItemMixin.Init(
      self,
      Treatises[self.professionInfo[1].skillId],
      self.professionInfo[1].name .. " Treatise"
    )
  else
    DragonflightHelperProfessionTodoItemMixin.Init(self, {}, self.professionInfo[1].name .. " Treatise")
  end
end

DragonflightHelperTreatiseTwoMixin = CreateFromMixins(DragonflightHelperProfessionTodoItemMixin)

function DragonflightHelperTreatiseTwoMixin:OnLoad()
  DragonflightHelperProfessionTodoItemMixin.OnLoad(self)
end

function DragonflightHelperTreatiseTwoMixin:Init()
  DragonflightHelperProfessionBaseMixin.Init(self)

  if self.hasSecondProfession then
    DragonflightHelperProfessionTodoItemMixin.Init(
      self,
      Treatises[self.professionInfo[2].skillId],
      self.professionInfo[2].name .. " Treatise"
    )
  else
    DragonflightHelperProfessionTodoItemMixin.Init(self, {}, self.professionInfo[2].name .. " Treatise")
  end
end
