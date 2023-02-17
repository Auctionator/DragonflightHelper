DragonflightHelperStatusBarMixin = {}

function DragonflightHelperStatusBarMixin:OnLoad()
  -- print("DragonflightHelperStatusBarMixin:OnLoad()")

  self.description = ""
  self.rolloverDescription = nil

  self.enterCallback = function()
    -- no op by default
  end
  self.leaveCallback = function()
    -- no op by default
  end

  local color = ITEM_QUALITY_COLORS[3]
  self.StatusBarBackground:SetStatusBarColor(220, 220, 220, 0.2)
  self:SetForegroundColor(color.r, color.g, color.b, 1)
end

function DragonflightHelperStatusBarMixin:OnShow()
end

function DragonflightHelperStatusBarMixin:OnHide()
end

function DragonflightHelperStatusBarMixin:SetTitle(title)
  self.Container.Title:SetText(title)
end

function DragonflightHelperStatusBarMixin:SetDescription(description)
  self.description = description

  self.Container.Description:SetText(description)
end

function DragonflightHelperStatusBarMixin:SetRolloverDescription(rolloverDescription)
  self.rolloverDescription = rolloverDescription
end

function DragonflightHelperStatusBarMixin:OnEnter()
  if self.rolloverDescription ~= nil then
    self.Container.Description:SetText(self.rolloverDescription)
  end

  self.enterCallback()
end

function DragonflightHelperStatusBarMixin:OnLeave()
  self.Container.Description:SetText(self.description)
  self.leaveCallback()
end

function DragonflightHelperStatusBarMixin:SetValue(value)
  self.StatusBarForeground:SetValue(value)
end

function DragonflightHelperStatusBarMixin:SetMinMaxValues(minimum, maximum)
  self.StatusBarForeground:SetMinMaxValues(minimum, maximum)
  self.StatusBarBackground:SetMinMaxValues(minimum, maximum)
end

function DragonflightHelperStatusBarMixin:SetForegroundColor(r, g, b, a)
  self.StatusBarForeground:SetStatusBarColor(r, g, b, a)
end

function DragonflightHelperStatusBarMixin:SetBackgroundColor(r, g, b, a)
  self.StatusBarBackground:SetStatusBarColor(r, g, b, a)
end

function DragonflightHelperStatusBarMixin:SetReverseFill()
  self.StatusBarForeground:SetReverseFill(true)
end
