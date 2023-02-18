DragonflightHelperSectionTitleMixin = {}

function DragonflightHelperSectionTitleMixin:OnLoad()
  if self.title == nil then
    self.title = ""
  end

  self:SetTitle(self.title)
end

function DragonflightHelperSectionTitleMixin:SetTitle(title)
  self.title = title

  self.Title:SetText(self.title)
end
