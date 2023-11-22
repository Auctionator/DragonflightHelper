local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local SKILL_IDS = ns.constants.professions.SKILL_IDS
local log = ns.debug.log

local MOB_DROPS = {
  title = "Weekly Mob Drops",
  [SKILL_IDS.Alchemy] = {
    {
      quest_id = 70511,
      item = 198964,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 52.2 / 100,
        y = 56.2 / 100,
        options = {
          title = "Encroaching Downpour (Elementious Splinter)" }
      },
    },
    {
      quest_id = 70504,
      item = 198963,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 17.78 / 100,
        y = 39.22 / 100,
        options = {
          title = "Brakenhide Rotflinger (Decaying Phlegm)" }
      }
    },
  },
  [SKILL_IDS.Leatherworking] = {
    {
      quest_id = 70522,
      item = 198975,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 80 / 100,
        y = 24 / 100,
        options = {
          title = "Primal Proto-Drakes (Ossified Hide)" }
      },
    },
    {
      quest_id = 70523,
      item = 198976,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 15.72 / 100,
        y = 25.89 / 100,
        options = {
          title = "Vorquin (Exceedingly Soft Skin)" }
      }
    },
  },
  [SKILL_IDS.Tailoring] = {
    {
      quest_id = 70524,
      item = 198977,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 84 / 100,
        y = 56 / 100,
        options = { title = "Farm Spot (Ohn'ahran Weave)" }
      }
    },
    {
      quest_id = 70525,
      item = 198978,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 33.84 / 100,
        y = 47.22 / 100,
        options = {
          title = "Gnolls (Stupidly Effective Stitchery)" }
      },
    },
  },
  [SKILL_IDS.Jewelcrafting] = {
    {
      quest_id = 70521,
      item = 198974,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 45 / 100,
        y = 55.4 / 100,
        options = {
          title = "Rebel Bruisers (Elegantly Engraved Embellishment)" }
      },
    },
    {
      quest_id = 70520,
      item = 198973,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 52.3 / 100,
        y = 32.5 / 100,
        options = { title = "Crushing Elementals (Icandescent Curio)" }
      }
    },
  },
  [SKILL_IDS.Blacksmithing] = {
    {
      quest_id = 70513,
      item = 198966,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 37.8 / 100,
        y = 73.0 / 100,
        options = { title = "Blazing Manifestation (Molten Globule)" }
      },
    },
    {
      quest_id = 70512,
      item = 198965,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 46.25 / 100,
        y = 37.26 / 100,
        options = {
          title = "Crushing Elemental (Primeval Earth Fragment)" }
      }
    },
  },
  [SKILL_IDS.Engineering] = {
    {
      quest_id = 70516,
      item = 198969,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 57.0 / 100,
        y = 59.2 / 100,
        options = { title = "Titan Defense Matrix (Keeper's Mark)" }
      },
    },
    {
      quest_id = 70517,
      item = 198970,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 45.8 / 100,
        y = 58.2 / 100,
        options = {
          title = "Rebel Bruiser (Infinitely Attachable Pair o' Docks)" }
      }
    },
  },
  [SKILL_IDS.Inscription] = {
    {
      quest_id = 70518,
      item = 198971,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 37.2 / 100,
        y = 63.4 / 100,
        options = {
          title = "Qalashi Necksnapper (Curious Djaradin Rune)" }
      },
    },
    {
      quest_id = 70519,
      item = 198972,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 66.4 / 100,
        y = 59.4 / 100,
        options = {
          title = "Arcane Manipulators (Draconic Glamour)" }
      }
    },
  },
  [SKILL_IDS.Enchanting] = {
    {
      quest_id = 70514,
      item = 198967,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 39.2 / 100,
        y = 64.0 / 100,
        options = {
          title = "Mana Wyrmling, Stabilized Elementals (Primordial Aether)" }
      },
    },
    {
      quest_id = 70515,
      item = 198968,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 53.2 / 100,
        y = 65.6 / 100,
        options = { title = "Earthshaker Marauder (Primalist Charm)" }
      }
    },

  },
}

local setup_mob_drops = function(profession_data)
  local config = MOB_DROPS[profession_data.skill_id]

  if config == nil then
    return {
      is_valid_subsection = false
    }
  end

  local max = #config

  local function tooltip(parent)
    local completion_count, items = profession_helpers.count_completed(config,
      string.format("%s, %s", "Mob drops tooltip", profession_data.name))

    GameTooltip:SetOwner(parent, "ANCHOR_RIGHT")

    GameTooltip_SetTitle(GameTooltip,
      MOB_DROPS.title .. " (" .. profession_data.name .. ")",
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
    elseif TomTom ~= nil then
      GameTooltip_AddBlankLineToTooltip(GameTooltip)
      GameTooltip_AddNormalLine(GameTooltip, "Click for tomtom waypoints")
    end

    GameTooltip:Show()
  end

  local initial_count_completed, _, _, is_on_quest = profession_helpers.count_completed(config,
    string.format("%s, %s", "Mob drops", profession_data.name))

  local function click_handler()
    local _, _, remaining_waypoints = profession_helpers.count_completed(config,
      string.format("%s, %s", "Mob drops click", profession_data.name))

    if #remaining_waypoints > 0 then
      for _, waypoint in ipairs(remaining_waypoints) do
        log(nil, "mob_drops", 1, "waypoint", string.format("%d (%f, %f)", waypoint.map, waypoint.x, waypoint.y))

        TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
      end
    end
  end

  return {
    is_valid_subsection = true,
    title = MOB_DROPS.title,
    max = max,
    completed_count = initial_count_completed,
    events = { "QUEST_TURNED_IN" },
    notify_function = profession_helpers.notify_update_description(config, "Mob drops"),
    tooltip_function = tooltip,
    click_function = click_handler,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.MobDrops] = setup_mob_drops
