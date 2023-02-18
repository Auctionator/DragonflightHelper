DragonflightHelperMixin = {};

function DragonflightHelperMixin:OnLoad()
  self:RegisterForDrag("RightButton")

  local texture = self:CreateTexture()
  texture:SetAllPoints()
  texture:SetColorTexture(0, 0, 0, 0.5)

  self:RegisterEvent("PLAYER_ALIVE")
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

function DragonflightHelperMixin:OnEvent(event, ...)
  if event == "PLAYER_ALIVE" then
    self:UnregisterEvent("PLAYER_ALIVE")

    self.Todos:Show()
    self.ProfessionTodos:Show()
  end
end
