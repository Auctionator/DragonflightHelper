local addon, ns = ...

local components = ns.components
local theme = ns.theme
local media = ns.media
local constants = ns.constants
local helpers = ns.constants.professions.helpers

local todos = CreateFrame("Frame", string.format("%s_todos_frame", addon))

function todos:init(parent)
  self:SetParent(parent)

  self.title = components.helpers:create_title_string(
    self,
    media:get_font_object(theme:get_font()),
    "Todos"
  )
  self.previous = self.title

  self:SetHeight(self.title:GetStringHeight() + 3)

  self:initialize_todos()

  return self
end

function todos:recalculate_height()
  local selected_todos = theme:get_section(constants.SECTIONS.TODOS)

  self:SetHeight(self.title:GetStringHeight())

  local count = 0

  for key, spec in pairs(selected_todos.subsections) do
    if spec.display then
      self:SetHeight(self:GetHeight() + self.todo_bars[key]:GetHeight() + 3)
      count = count + 1
    end
  end

  if count > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

function todos:initialize_todos()
  self.todo_bars = {}

  local todos = theme:get_section(constants.SECTIONS.TODOS)
  local statusbar_texture = theme:get_statusbar()
  local font_object = media:get_font_object(theme:get_font())
  local bars_showing = 0

  for key, subsection in pairs(todos.subsections) do
    local completed_count, _, _, is_on_quest = helpers.count_completed(constants.todos[key], key)
    local max                                = constants.todos[key].max or #constants.todos[key]

    local bar                                = components.helpers:create_status_bar({
      parent = self,
      font_object = font_object,
      statusbar_texture = statusbar_texture,
      visible = subsection.display,
      title = constants.todos[key].title,
      events = { "QUEST_TURNED_IN", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_DATA_LOAD_RESULT" },
      max = max,
      value = completed_count,
      description = ("%d/%d"):format(math.min(completed_count, max), max),
      notify = helpers.notify_update_description(constants.todos[key], "Weekly Todo " .. key),
      color = theme:get_completed_quest_color(),
      background_color = is_on_quest and theme:get_accepted_quest_color() or theme:get_incomplete_quest_color(),
    })

    if key == constants.TODO_SECTIONS.Aiding then
      bar.button:SetScript("OnEnter", helpers.quest_tooltip(constants.todos[key]))
      bar.button:SetScript("OnLeave", function()
        GameTooltip:Hide()
      end)
    end

    if subsection.display then
      bar:ClearAllPoints()
      bar:SetPoint("TOPLEFT", self.previous, "BOTTOMLEFT", 0, -2)
      bar:SetPoint("RIGHT", self, "RIGHT", -2)
      self:SetHeight(self:GetHeight() + bar:GetHeight() + 3)

      bar:Show()
      bars_showing = bars_showing + 1
    end

    self.todo_bars[key] = bar
    self.previous = bar
  end

  if bars_showing > 0 then
    self:SetHeight(self:GetHeight() + 2)
  end
end

ns.panels.todos = todos
