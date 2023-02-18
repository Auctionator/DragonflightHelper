DragonflightHelperProfessionTodosMixin = CreateFromMixins(ProfessionLookupMixin)

function DragonflightHelperProfessionTodosMixin:OnLoad()
  ProfessionLookupMixin.OnLoad(self)

  if self.hasFirstProfession then
    self.ProfessionOneTitle:SetTitle(self.professionInfo[1].name)
  end

  if self.hasSecondProfession then
    self.ProfessionTwoTitle:SetTitle(self.professionInfo[2].name)
  end
end

-- TODO Is there a way to detect recipes that would be First Time Crafted?
-- TODO Is there a way to detect First Time Gathers?

-- Profession Masters
-- Blacksmithing 70250
-- Alchemy 70247
-- Enchanting 70260
-- Engineering 70252
-- Herbalism 70253
-- Inscription 70254
-- Jewelcrafting 70255
-- Leatherworking 70256
-- Mining 70258
-- Skinning 70259
-- Tailoring 70260
