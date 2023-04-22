local _, ns = ...
local event_manager = ns.events.manager
local custom_events = ns.events.custom
local media = ns.media

DFH_Mixin = {};

SLASH_DFH_TOGGLE1 = "/dfh"

function DFH_Mixin:OnLoad()
  self:RegisterForDrag("LeftButton")

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

  event_manager:subscribe(self, { custom_events.FONT_CHANGED, custom_events.THEME_LOADED }, "DFH_Main_Frame")
  event_manager:handle(custom_events.MAIN_FRAME_LOADED, self)
end

function DFH_Mixin:notify(event_name, ...)
  if event_name == custom_events.THEME_LOADED then
    local font = ...
    self.Title:SetFontObject(media:get_font_object(font))
  elseif event_name == custom_events.FONT_CHANGED then
    local _, font_object = ...
    self.Title:SetFontObject(font_object)
  end

  for _, section in ipairs(self.sections) do
    section.Title:notify(event_name, ...)
  end
end

function DFH_Mixin:hideFrames()
  for _, frame in ipairs(self.sections) do
    frame:Hide()
  end

  self:SetHeight(26)
  self.showing = not self.showing
end

function DFH_Mixin:showFrames()
  for _, frame in ipairs(self.sections) do
    frame:Show()
  end

  self:SetHeight(self.openHeight)
  self.showing = not self.showing
end

function DFH_Mixin:OnClick()
  if self.showing then
    self:hideFrames()
  else
    self:showFrames()
  end
end

function DFH_Mixin:OnShow()
  event_manager:handle(custom_events.MAIN_FRAME_SHOWN, self)
  local children = self:GetChildren()
  local total = 0

  for _, child in ipairs(children) do
    total = total + child:GetHeight()
  end

  -- self:SetHeight(total)
end

function DFH_Mixin:OnHide()
end

function DFH_Mixin:OnMouseUp()
  self:StopMovingOrSizing()
end

function DFH_Mixin:OnMouseDown()
  -- self:StartSizing("BOTTOMRIGHT");
end

function DFH_Mixin:OnDragStart()
  if IsShiftKeyDown() then
    self:StartSizing("BOTTOMRIGHT")
  else
    self:StartMoving()
  end
end

function DFH_Mixin:OnDragStop()
  self:StopMovingOrSizing()
end

DFH_ButtonMixin = {}

function DFH_ButtonMixin:OnClick()
  self:GetParent():OnClick()
end

DFH_ConfigButtonMixin = {}

function DFH_ConfigButtonMixin:OnClick()
  event_manager:handle("OPEN_CONFIG", self:GetParent())
end
