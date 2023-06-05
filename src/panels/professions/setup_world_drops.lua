local _, ns = ...

local profession_helpers = ns.constants.professions.helpers
local SKILL_IDS = ns.constants.professions.SKILL_IDS
local SKILL_SUBSECTIONS = ns.constants.SKILL_SUBSECTIONS
local log = ns.debug.log

local WORLD_DROPS = {
  title = "World Drops",
  [SKILL_IDS.Alchemy] = {
    {
      quest_id = 70289,
      item = 198685,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 25.1 / 100,
        y = 73.3 / 100,
        options = { title = "Well Insulated Mug" }
      },
    },
    {
      quest_id = 70274,
      item = 198663,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 55 / 100,
        y = 81 / 100,
        options = { title = "Frostforged Potion" }
      },
    },
    {
      quest_id = 70305,
      item = 198710,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 79.22 / 100,
        y = 83.71 / 100,
        options = { title = "Canteen of Suspicious Water" }
      },
    },
    {
      quest_id = 70208,
      item = 198599,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 16.4 / 100,
        y = 38.5 / 100,
        options = { title = "Experimental Decay Sample" }
      },
    },
    {
      quest_id = 70309,
      item = 198712,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 67 / 100,
        y = 13.2 / 100,
        options = { title = "Firewater Powder Sample" }
      },
    },
    {
      quest_id = 70278,
      item = 203471,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 55.2 / 100,
        y = 30.5 / 100,
        options = { title = "Tasty Candy" }
      },
    },
    {
      quest_id = 70301,
      item = 198697,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,

        x = 59.5 / 100,
        y = 38.4 / 100,
        options = { title = "Contraband Concoction" }
      },
    },
  },
  [SKILL_IDS.Blacksmithing] = {
    {
      quest_id = 70230,
      item = 198791,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 56.4 / 100,
        y = 19.5 / 100,
        options = { title = "Glimmer of Blacksmithing Wisdom (Take crafting mats for a primal alloy)" }
      }
    },
    {
      quest_id = 70246,
      item = 201007,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 22.0 / 100,
        y = 87.0 / 100,
        options = { title = "Ancient Monument" }
      },
    },
    {
      quest_id = 70312,
      item = 201005,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 65.5 / 100,
        y = 25.7 / 100,
        options = { title = "Curious Ingots" }
      }
    },
    {
      quest_id = 70296,
      item = 201008,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 35.5 / 100,
        y = 64.3 / 100,
        options = { title = "Molten Ingot" }
      }
    },
    {
      quest_id = 70310,
      item = 201010,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 34.5 / 100,
        y = 67.1 / 100,
        options = { title = "Qalashi Weapon Diagram" }
      },
    },
    {
      quest_id = 70313,
      item = 201004,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 81.1 / 100,
        y = 37.9 / 100,
        options = { title = "Ancient Spear Shards" }
      },
    },
    {
      quest_id = 70353,
      item = 201009,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 50.9 / 100,
        y = 66.5 / 100,
        options = { title = "Falconer Gauntlet Drawings" }
      },
    },
    {
      quest_id = 70314,
      item = 201011,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 53.1 / 100,
        y = 65.3 / 100,
        options = { title = "Spelltouched Tongs" }
      },
    },
    {
      quest_id = 70311,
      item = 201006,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 52.2 / 100,
        y = 80.5 / 100,
        options = { title = "Draconic Flux" }
      },
    }
  },
  [SKILL_IDS.Enchanting] = {
    -- TODO There is a bug that prevents this from being looted,
    -- commenting out for now
    {
      quest_id = 0,
      item = 198798,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 57.5 / 100,
        y = 83.6 / 100,
        options = { title = "Flashfrozen Scroll" }
      }
    },
    {
      quest_id = 70283,
      item = 198675,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 68.0 / 100,
        y = 26.8 / 100,
        options = { title = "Lava-Infused Seed" }
      }
    },
    {
      quest_id = 70272,
      item = 201012,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 57.5 / 100,
        y = 58.5 / 100,
        options = { title = "Enchanted Debris (Interact with disenchanted broom" }
      }
    },
    {
      quest_id = 70291,
      item = 198689,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 61.4 / 100,
        y = 67.6 / 100,
        options = { title = "Stormbound Horn" }
      }
    },
    {
      quest_id = 70336,
      item = 198799,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 38.5 / 100,
        y = 59.2 / 100,
        options = { title = "Forgotten Arcane Tome" }
      }
    },
    {
      quest_id = 70290,
      item = 201013,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 45.1 / 100,
        y = 61.2 / 100,
        options = { title = "Faintly Enchanted Remains" }
      }
    },
    {
      quest_id = 70298,
      item = 198694,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 21.55 / 100,
        y = 45.5 / 100,
        options = { title = "Enriched Earthen Shard" }
      }
    },
    {
      quest_id = 70342,
      item = 198800,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 59.9 / 100,
        y = 70.4 / 100,
        options = { title = "Fractured Titanic Sphere" }
      }
    },
  },
  [SKILL_IDS.Engineering] = {
    {
      quest_id = 70270,
      item = 201014,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 56.0 / 100,
        y = 44.9 / 100,
        options = { title = "Boomthyr Rocket" }
      },
    },
    {
      quest_id = 70275,
      item = 198789,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 49.09 / 100,
        y = 77.54 / 100,
        options = { title = "Intact Coil Capacitor" }
      },
    },
  },
  -- [SKILL_IDS.Herbalism] = { },
  [SKILL_IDS.Inscription] = {
    {
      quest_id = 70306,
      item = 198704,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 67.87 / 100,
        y = 57.96 / 100,
        options = { title = "Pulsing Earth Rune" }
      },
    },
    {
      quest_id = 70307,
      item = 198703,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 85.7 / 100,
        y = 25.2 / 100,
        options = { title = "Sign Language Reference Sheet" }
      },
    },
    -- {
    --   -- maybe: 70297
    --   quest_id = 0,
    --   item = 198693,
    --   waypoint = {
    --     map = ns.constants.map_ids.AzureSpan,
    --     x = 46.2 / 100,
    --     y = 23.9 / 100,
    --     options = { title = "Dusty Darkmoon Card" }
    --   },
    -- },
    {
      quest_id = 70293,
      item = 198686,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 43.7 / 100,
        y = 30.9 / 100,
        options = { title = "Frosted Parchment" }
      },
    },
    {
      quest_id = 70281,
      item = 198669,
      waypoint = {
        map = ns.constants.map_ids.Valdrakken,
        x = 13.2 / 100,
        y = 63.68 / 100,
        options = { title = "How to Train Your Whelpling (bugged; use bronze timelock, zone, return)" }
      },
    },
    {
      quest_id = 70264,
      item = 198659,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 56.29 / 100,
        y = 41.17 / 100,
        options = { title = "Forgetful Apprentice's Tome (2)" }
      },
    },
    {
      quest_id = 70248,
      item = 198659,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 47.24 / 100,
        y = 40.1 / 100,
        options = { title = "Forgetful Apprentice's Tome (1)" }
      },
    },
    {
      quest_id = 70287,
      item = 201015,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 56.1 / 100,
        y = 40.9 / 100,
        options = { title = "Counterfeit Darkmoon Deck" }
      },
    },
  },
  [SKILL_IDS.Jewelcrafting] = {
    {
      quest_id = 70292,
      item = 198687,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 50.4 / 100,
        y = 45.1 / 100,
        options = { title = "Closely Guarded Shiny" }
      },
    },
    {
      quest_id = 70273,
      item = 201017,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 33.9 / 100,
        y = 63.7 / 100,
        options = { title = "Igneous Gem" }
      },
    },
    {
      quest_id = 70282,
      item = 198670,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 25.2 / 100,
        y = 35.4 / 100,
        options = { title = "Lofty Malygite" }
      },
    },
    {
      quest_id = 70263,
      item = 198660,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 61.8 / 100,
        y = 13.0 / 100,
        options = { title = "Fragmented Key" }
      },
    },
    {
      quest_id = 70277,
      item = 198664,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 45.0 / 100,
        y = 61.3 / 100,
        options = { title = "Crystalline Overgrowth" }
      },
    },
    {
      quest_id = 70271,
      item = 201016,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 44.6 / 100,
        y = 61.2 / 100,
        options = { title = "Harmonic Crystal Harmonizer" }
      },
    },
    {
      quest_id = 70285,
      item = 198682,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 59.8 / 100,
        y = 65.2 / 100,
        options = { title = "Alexstraszite Cluster" }
      },
    },
    {
      quest_id = 70261,
      item = 198656,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 56.91 / 100,
        y = 43.72 / 100,
        options = { title = "Painter's Pretty Jewel" }
      },
    },
  },
  [SKILL_IDS.Leatherworking] = {
    {
      quest_id = 70308,
      item = 198711,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 39 / 100,
        y = 86 / 100,
        options = { title = "Poacher's Pack" }
      },
    },
    {
      quest_id = 70280,
      item = 198667,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 64.3 / 100,
        y = 25.4 / 100,
        options = { title = "Spare Djaradin Tools" }
      },
    },
    {
      quest_id = 70300,
      item = 198696,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 86.4 / 100,
        y = 53.7 / 100,
        options = { title = "Wind-Blessed Hide" }
      },
    },
    {
      quest_id = 70269,
      item = 201018,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 12.5 / 100,
        y = 49.4 / 100,
        options = { title = "Well-Danced Drum" }
      },
    },
    {
      quest_id = 70266,
      item = 198658,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 16.7 / 100,
        y = 38.8 / 100,
        options = { title = "Decay-Infused Tanning Oil" }
      },
    },
    {
      quest_id = 70286,
      item = 198683,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 57.5 / 100,
        y = 41.3 / 100,
        options = { title = "Treated Hides" }
      },
    },
    {
      quest_id = 70294,
      item = 198690,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 56.8 / 100,
        y = 30.5 / 100,
        options = { title = "Decayed Scales" }
      },
    },
  },
  -- [SKILL_IDS.Mining] = { },
  -- [SKILL_IDS.Skinning] = { },
  [SKILL_IDS.Tailoring] = {
    {
      quest_id = 70302,
      item = 198699,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 74.7 / 100,
        y = 37.9 / 100,
        options = { title = "Mysterious Banner" }
      },
    },
    {
      quest_id = 70304,
      item = 198702,
      waypoint = {
        map = ns.constants.map_ids.WakingShore,
        x = 24.9 / 100,
        y = 69.7 / 100,
        options = { title = "Itinerant Singed Fabric" }
      },
    },
    {
      quest_id = 70295,
      item = 198692,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 35.34 / 100,
        y = 40.12 / 100,
        options = { title = "Noteworthy Scrap of Carpet" }
      },
    },
    {
      quest_id = 70303,
      item = 201020,
      waypoint = {
        map = ns.constants.map_ids.OhnAhranPlains,
        x = 66.1 / 100,
        y = 52.9 / 100,
        options = { title = "Silky Surprise" }
      },
    },
    {
      -- Two quests completed at the same time, so not sure if this is the right
      -- quest id or not (the other was 70525)
      quest_id = 70284,
      item = 198680,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 16.2 / 100,
        y = 38.8 / 100,
        options = { title = "Decaying Brackenhide Blanket" }
      },
    },
    {
      quest_id = 70267,
      item = 198662,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 40.7 / 100,
        y = 54.5 / 100,
        options = { title = "Intriguing Bolt of Blue Cloth" }
      },
    },
    {
      quest_id = 70288,
      item = 198684,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 60.4 / 100,
        y = 79.7 / 100,
        options = { title = "Miniature Bronze Dragonflight Banner" }
      },
    },
    {
      quest_id = 70372,
      item = 201019,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,
        x = 58.6 / 100,
        y = 45.8 / 100,
        options = { title = "Ancient Dragonweave Bolt" }
      },
    },
  },
}

local setup_world_drops = function(profession_data)
  local config = WORLD_DROPS[profession_data.skill_id]

  if config == nil then
    return {
      is_valid_subsection = false
    }
  end

  local completed_count, _, remaining_waypoints = profession_helpers.count_completed(config,
    string.format("%s, %s", "World drops", profession_data.name))

  if #remaining_waypoints == 0 then
    return {
      is_valid_subsection = false
    }
  end

  local function click_handler()
    local _, _, remaining_waypoints = profession_helpers.count_completed(config,
      string.format("%s, %s", "World drops click", profession_data.name))

    if #remaining_waypoints > 0 then
      for _, waypoint in ipairs(remaining_waypoints) do
        TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
      end
    end
  end

  return {
    is_valid_subsection = true,
    title = WORLD_DROPS.title,
    max = #config,
    completed_count = completed_count,
    events = { "QUEST_TURNED_IN" },
    notify_function = profession_helpers.notify_update_description(config, "World drops"),
    click_function = click_handler,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.WorldDrops] = setup_world_drops
