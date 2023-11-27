local addon, ns = ...

local event_manager = ns.events.manager
local custom_events = ns.events.custom
local helpers = ns.components.helpers
local media = ns.media
local theme = ns.theme
local log = ns.debug.log

local section_selector = CreateFrame(
  "Frame",
  addon .. "_section_selector_frame"
)

function section_selector:init(parent)
  log("OK", "section_selector", 1, "init", "Loading")
  self:SetParent(parent)

  local title = helpers:create_title_string(self, media:get_font_object(theme:get_font()), "Select Sections")
  title:SetPoint("TOPLEFT")
  title:SetPoint("RIGHT")

  self:SetHeight(math.ceil(title:GetStringHeight()) + 3)

  local previous = title

  for k, section in pairs(theme:get_sections()) do
    local new_section = self:add_section(section)

    new_section:ClearAllPoints()
    new_section:SetPoint("TOP", previous, "BOTTOM", 0, -5)
    new_section:SetPoint("LEFT", self, "LEFT")
    new_section:SetPoint("RIGHT", self, "RIGHT")

    previous = new_section
    self:SetHeight(self:GetHeight() + new_section:GetHeight() + 5)
  end

  return self
end

local section_count = 0

function section_selector:add_section(section)
  local section_container = CreateFrame(
    "Frame",
    ("%s_section_selector_%d_frame"):format(addon, section_count),
    self
  )
  section_container:SetHeight(3)

  if self.previous_section ~= nil then
    section_container:SetPoint("TOP", self.previous_section, "BOTTOM", 0)
  else
    section_container:SetPoint("TOPLEFT", self, "TOPLEFT", 0, -5)
  end
  section_container:SetPoint("LEFT")

  self.previous_section = section_container

  local section_checkbox = helpers:create_checkbox({
    parent = section_container,
    text = section.name,
    checked = section.display,
    handler = function(checked)
      event_manager:handle(custom_events.SECTION_SELECTION_CHANGED, section, checked)
    end
  })
  section_checkbox:SetPoint("TOPLEFT")
  section_checkbox:SetPoint("RIGHT", section_container, "CENTER")
  log("OK", "section_selector", 1, "section:" .. section_count .. ":" .. section.name, "Loading")

  section_container:SetHeight(math.ceil(section_checkbox:GetHeight()) + 3)
  log(nil, "section_selector", 2, "section height", section_container:GetHeight())

  local subsections_frame = self:add_subsections(section, section_container)
  section_count = section_count + 1

  -- section_container:SetHeight(subsections_frame:GetHeight())
  log(nil, "section_selector", 2, "section height w/ subs", section_container:GetHeight() or "?")

  return section_container
end

function section_selector:add_subsections(section, parent)
  local subsection_counter = 0

  local frame = CreateFrame(
    "Frame",
    ("%s_section_selector_%d_%d_frame"):format(addon, section_count, subsection_counter),
    parent
  )
  frame:SetPoint("TOP")
  frame:SetPoint("LEFT", parent, "CENTER")
  frame:SetPoint("RIGHT")
  frame:SetHeight(0)

  -- local previous = frame

  -- for id, subsection in pairs(section.subsections) do
  --   log(nil, "section_selector", 3, "sub", subsection)
  --   log(nil, "section_selector", 3, "sub", subsection.display)

  --   local subsection_selector = helpers:create_checkbox({
  --     parent = frame,
  --     text = id,
  --     checked = subsection.display,
  --     handler = function(checked)
  --       event_manager:handle(custom_events.SUBSECTION_SELECTION_CHANGED, section, id, checked)
  --     end
  --   })

  --   subsection_selector:ClearAllPoints()

  --   -- if previous ~= frame then
  --     subsection_selector:SetPoint("TOP", previous, "BOTTOM", 0, -5)
  --   -- else
  --   --   subsection_selector:SetPoint("TOP", frame, "TOP", 0)
  --   -- end

  --   subsection_selector:SetPoint("LEFT", frame, "LEFT", 10)
  --   subsection_selector:SetPoint("RIGHT", frame, "RIGHT")

  --   frame:SetHeight(subsection_selector:GetHeight() + frame:GetHeight() + 5)
  --   log(nil, "section_selector", 2, "sub section", frame:GetHeight())

  --   previous = subsection_selector
  -- end

  return frame
end

ns.config.section_selector = section_selector
