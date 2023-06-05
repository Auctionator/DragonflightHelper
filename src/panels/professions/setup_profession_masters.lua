local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_IDS = ns.constants.professions.SKILL_IDS
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS

local PROFESSION_MASTERS = {
  title = "Profession Master",
  [SKILL_IDS.Alchemy] = {
    {
      quest_id = 70247,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 60.92 / 100,
        y = 75.84 / 100,
        options = {
          title = "Grigori Valtry"
        }
      }
    }
  },
  [SKILL_IDS.Blacksmithing] = {
    {
      quest_id = 70250,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 43.32 / 100,
        y = 66.60 / 100,
        options = {
          title = "Grekka Anvilsmash"
        }
      }
    }
  },
  [SKILL_IDS.Enchanting] = {
    {
      quest_id = 70251,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 62.42 / 100,
        y = 18.70 / 100,
        options = {
          title = "Shalasar Glimmerdusk"
        }
      }
    }
  },
  [SKILL_IDS.Engineering] = {
    {
      quest_id = 70252,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 17.8 / 100,
        y = 21.7 / 100,
        options = {
          title = "Frizz Buzzcrank"
        }
      }
    }
  },
  [SKILL_IDS.Herbalism] = {
    {
      quest_id = 70253,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 58.42 / 100,
        y = 50.04 / 100,
        options = {
          title = "Hua Greenpaw"
        }
      }
    }
  },
  [SKILL_IDS.Inscription] = {
    {
      quest_id = 70254,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 40.24 / 100,
        y = 64.3 / 100,
        options = {
          title = "Lydiara Whisperfeather"
        }
      }
    }
  },
  [SKILL_IDS.Jewelcrafting] = {
    {
      quest_id = 70255,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 46.23 / 100,
        y = 40.84 / 100,
        options = { title = "Pluutar" }
      }
    }
  },
  [SKILL_IDS.Leatherworking] = {
    {
      quest_id = 70256,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 82.45 / 100,
        y = 50.67 / 100,
        options = { title = "Erden" }
      }
    }
  },
  [SKILL_IDS.Mining] = {
    {
      quest_id = 70258,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 61.42 / 100,
        y = 76.95 / 100,
        options = { title = "Bridgette Holdug" }
      }
    }
  },
  [SKILL_IDS.Skinning] = {
    {
      quest_id = 70259,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 73.34 / 100,
        y = 69.72 / 100,
        options = { title = "Zenzi" }
      }
    }
  },
  [SKILL_IDS.Tailoring] = {
    {
      quest_id = 70260,
      waypoint = {
        map = ns.constants.map_ids.Valdrakken,
        x = 27.96 / 100,
        y = 45.79 / 100,
        options = { title = "Elysa Raywinder" }
      }
    }
  },
}

local setup_profession_masters = function(profession_data)
  local config = PROFESSION_MASTERS[profession_data.skill_id]

  if config == nil then
    return {
      is_valid_subsection = false
    }
  end

  local _, _, remaining_waypoints = profession_helpers.count_completed(config,
    string.format("%s, %s", "Profession master", profession_data.name))

  if #remaining_waypoints == 0 then
    return {
      is_valid_subsection = false
    }
  end

  local function click_handler()
    local _, _, remaining_waypoints = profession_helpers.count_completed(config,
      string.format("%s, %s", "Profession master click", profession_data.name))

    if #remaining_waypoints > 0 then
      for _, waypoint in ipairs(remaining_waypoints) do
        TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
      end
    end
  end

  return {
    is_valid_subsection = true,
    title = PROFESSION_MASTERS.title,
    max = 1,
    completed_count = 0,
    events = { "QUEST_TURNED_IN" },
    notify_function = profession_helpers.notify_update_description(config, "Profession Master"),
    click_function = click_handler,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.ProfessionMaster] = setup_profession_masters
