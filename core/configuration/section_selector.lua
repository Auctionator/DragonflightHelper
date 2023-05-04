local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local helpers = ns.components.helpers
local media = ns.media
local theme = ns.theme


local section_selector = CreateFrame(
  "Frame",
  addon .. "_SectionSelectorFrame"
)

function section_selector:init(parent)
  self:SetParent(parent)

  local title = helpers:create_title_string(self, media:get_font_object(theme:get_font()), "Select Sections")
  title:SetPoint("TOPLEFT")
  title:SetPoint("RIGHT")

  self:SetHeight(title:GetStringHeight() + 3)

  local previous = title

  for _, section in ipairs(theme:get_sections()) do
    local section_selector = helpers:create_checkbox({
      parent = self,
      text = section.name,
      checked = section.display,
      handler = function(checked)
        event_manager:handle(custom_events.SECTION_SELECTION_CHANGED, section, checked)
      end
    })

    section_selector:SetPoint("TOP", previous, "BOTTOM", 0, -5)
    section_selector:SetPoint("LEFT", previous, "LEFT", 0)
    section_selector:SetPoint("RIGHT", self, "RIGHT")
    self:SetHeight(section_selector:GetHeight() + self:GetHeight())

    previous = section_selector

    for id, subsection in pairs(section.subsections) do
      local subsection_selector = helpers:create_checkbox({
        parent = self,
        text = id,
        checked = subsection.display,
        handler = function(checked)
          event_manager:handle(custom_events.SUBSECTION_SELECTION_CHANGED, section, id, checked)
        end
      })

      subsection_selector:ClearAllPoints()
      subsection_selector:SetPoint("TOP", previous, "BOTTOM", 0, -5)
      subsection_selector:SetPoint("LEFT", self, "LEFT", 10)
      subsection_selector:SetPoint("RIGHT", self, "RIGHT")
      self:SetHeight(subsection_selector:GetHeight() + self:GetHeight())

      previous = subsection_selector
    end
  end

  return self
end

ns.config.section_selector = section_selector
