DragonflightHelperProfessionTodosMixin = CreateFromMixins(DragonflightHelperProfessionBaseMixin)

function DragonflightHelperProfessionTodosMixin:OnLoad()
  DragonflightHelperProfessionBaseMixin.OnLoad(self)
end

function DragonflightHelperProfessionTodosMixin:Init()
  DragonflightHelperProfessionBaseMixin.Init(self)

  if self.hasFirstProfession then
    self.ProfessionOneTitle:SetTitle(self.professionInfo[1].name)
  end

  if self.hasSecondProfession then
    self.ProfessionTwoTitle:SetTitle(self.professionInfo[2].name)
  end
end
