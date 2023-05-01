local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local helpers = ns.components.helpers

local section_selector = CreateFrame(
  "Frame",
  addon .. "_SectionSelectorFrame"
)

function section_selector:init(parent, current_sections)
  self:SetParent(parent)

  local title = self:CreateFontString(nil, "OVERLAY", "GameTooltipText")
  title:SetText("Select Sections")
  title:SetJustifyH("CENTER")
  title:SetPoint("TOPLEFT")
  title:SetPoint("RIGHT")

  self:SetHeight(title:GetStringHeight())

  local previous = title

  for section, enabled in pairs(current_sections) do
    local section_selector = helpers:create_checkbox({
      parent = self,
      text = section:sub(1, 1) .. section:sub(2, section:len()):lower(),
      checked = enabled,
      handler = function(checked)
        event_manager:handle(custom_events.SECTION_SELECTION_CHANGED, section, checked)
      end
    })

    section_selector:SetPoint("TOPLEFT", previous, "BOTTOMLEFT")
    section_selector:SetPoint("RIGHT", self, "RIGHT")
    previous = section_selector

    self:SetHeight(section_selector:GetHeight() + self:GetHeight())
  end

  return self
end

ns.config.section_selector = section_selector
