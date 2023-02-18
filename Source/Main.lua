DragonflightHelperMixin = {};

function DragonflightHelperMixin:OnLoad()
  self:RegisterForDrag("RightButton")

  local texture = self:CreateTexture()
  texture:SetAllPoints()
  texture:SetColorTexture(0, 0, 0, 0.5)
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
