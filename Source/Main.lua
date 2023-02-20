DragonflightHelperMixin = {};

SLASH_DFH_TOGGLE1 = "/dfh"

function DragonflightHelperMixin:OnLoad()
  self:RegisterForDrag("RightButton")

  local texture = self:CreateTexture()
  texture:SetAllPoints()
  texture:SetColorTexture(0, 0, 0, 0.5)

  self.showing = true
  self.openHeight = self:GetHeight()
  -- I'm sure there's a better way to do this but I want to go sit in raid finder
  self.sections = { self.Reputations, self.Timers, self.Todos, self.ProfessionTodos }

  SlashCmdList["DFH_TOGGLE"] = function()
    self:OnClick()
  end
end

function DragonflightHelperMixin:hideFrames()
  for _, frame in ipairs(self.sections) do
    frame:Hide()
  end

  self:SetHeight(26)
  self.showing = not self.showing
end

function DragonflightHelperMixin:showFrames()
  for _, frame in ipairs(self.sections) do
    frame:Show()
  end

  self:SetHeight(self.openHeight)
  self.showing = not self.showing
end

function DragonflightHelperMixin:OnClick()
  if self.showing then
    self:hideFrames()
  else
    self:showFrames()
  end
end

function DragonflightHelperMixin:OnShow()
end

function DragonflightHelperMixin:OnHide()
end

function DragonflightHelperMixin:OnDragStart()
  self:StartMoving()
end

function DragonflightHelperMixin:OnDragStop()
  self:StopMovingOrSizing()
end

DragonflightHelperButtonMixin = {}

function DragonflightHelperButtonMixin:OnClick()
  self:GetParent():OnClick()
end
