local _, ns = ...

local constants = ns.constants.professions
local count_completed = ns.constants.professions.helpers.count_completed
local notify_update_description = ns.constants.professions.helpers.notify_update_description
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS

local GATHERING_PROFESSIONS = {
  [SKILL_IDS.Herbalism] = true,
  [SKILL_IDS.Mining] = true,
  [SKILL_IDS.Skinning] = true,
}

local GATHERING = {
  [SKILL_IDS.Herbalism] = {
    title = "Dreambloom",
    { quest_id = 71857 }, { quest_id = 71858 }, { quest_id = 71859 },
    { quest_id = 71860 }, { quest_id = 71861 }, { quest_id = 71864 } },
  [SKILL_IDS.Mining] = {
    title = "Iridescent Ore",
    { quest_id = 72160 }, { quest_id = 72161 }, { quest_id = 72162 },
    { quest_id = 72163 }, { quest_id = 72164 }, { quest_id = 72165 } },
  [SKILL_IDS.Skinning] = {
    title = "Curious Hide",
    { quest_id = 70381 }, { quest_id = 70383 }, { quest_id = 70384 },
    { quest_id = 70385 }, { quest_id = 70386 }, { quest_id = 70389 } },
  [SKILL_IDS.Alchemy] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66373, item = 193891 }, { quest_id = 66374, item = 193897 }, },
  [SKILL_IDS.Blacksmithing] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66381, item = 192131 }, { quest_id = 66382, item = 192132 }, },
  [SKILL_IDS.Enchanting] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66377, item = 193900 }, { quest_id = 66378, item = 193901 }, },
  [SKILL_IDS.Engineering] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66379, item = 193902 }, { quest_id = 66380, item = 193903 }, },
  [SKILL_IDS.Inscription] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66375, item = 193904 }, { quest_id = 66376, item = 193905 }, },
  [SKILL_IDS.Jewelcrafting] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66388, item = 193907 }, { quest_id = 66389, item = 193909 }, },
  [SKILL_IDS.Leatherworking] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66384, item = 193910 }, { quest_id = 66385, item = 193913 }, },
  [SKILL_IDS.Tailoring] = {
    title = "Disturbed Dirt or Scout's Pack",
    { quest_id = 66386, item = 193899 }, { quest_id = 66387, item = 193898 }, },
}

local setup_gathering = function(profession_data)
  local config = GATHERING[profession_data.skill_id]
  local max = #config
  local is_gathering_profession = GATHERING_PROFESSIONS[profession_data.skill_id]

  local function tooltip(parent)
    if is_gathering_profession then
      return
    end

    local completion_count, items = count_completed(config)

    GameTooltip:SetOwner(parent, "ANCHOR_RIGHT")

    GameTooltip_SetTitle(GameTooltip,
      config.title .. " (" .. profession_data.name .. ")",
      HIGHLIGHT_FONT_COLOR)

    GameTooltip_AddBlankLineToTooltip(GameTooltip)

    for _, item_id in ipairs(items) do
      local item = Item:CreateFromItemID(item_id)

      item:ContinueOnItemLoad(function()
        local itemName = item:GetItemName();

        GameTooltip:AddLine(
          CreateSimpleTextureMarkup(item:GetItemIcon(), 25, 25) .. "  " .. itemName
        )
        GameTooltip:Show()
      end)
    end

    if completion_count == max then
      GameTooltip_AddHighlightLine(GameTooltip, "All items found this week")
    end

    GameTooltip:Show()
  end

  local initial_count_completed, _, _, _ = count_completed(config)

  return {
    is_valid_subsection = true,
    title = config.title,
    max = max,
    completed_count = initial_count_completed,
    events = { "QUEST_TURNED_IN", "ENCOUNTER_LOOT_RECEIVED" },
    notify_function = notify_update_description(config),
    tooltip_function = tooltip,
    click_function = nil,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.Gathering] = setup_gathering
