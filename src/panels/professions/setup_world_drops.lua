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
      quest_id = 75649,
      item = 205212,
      waypoint = {
        map = ns.constants.map_ids.Thaldraszus,

        x = 59.5 / 100,
        y = 38.4 / 100,
        options = { title = "Contraband Concoction" }
      },
    },
    {
      quest_id = 70301,
      item = 205212,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,

        x = 62.1 / 100,
        y = 41.12 / 100,
        options = { title = "Marrow-Ripened Slime" }
      }
    },
    {
      quest_id = 75646,
      item = 205211,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,

        x = 52.68 / 100,
        y = 18.30 / 100,
        options = { title = "Nutrient Diluted Protofluid" }
      },
    },
    {
      quest_id = 75651,
      item = 205213,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,

        x = 40.48 / 100,
        y = 59.18 / 100,
        options = { title = "Suspicious Mold" }
      }
    },
    {
      quest_id = 78269,
      item = 210185,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,

        x = 50.91 / 100,
        y = 49.43 / 100,
        options = { title = "Splash Potion of Narcolepsy" }
      }
    },
    {
      quest_id = 78264,
      item = 210184,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,

        x = 54.05 / 100,
        y = 32.64 / 100,
        options = { title = "Half-Filled Dreamless Sleep Potion" }
      },
    },
    {
      quest_id = 78275,
      item = 210190,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,

        x = 36.21 / 100,
        y = 46.63 / 100,
        options = { title = "Blazeroot" }
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
    },
    {
      quest_id = 76079,
      item = 205987,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 48.30 / 100,
        y = 21.95 / 100,
        options = { title = "Brimstone Rescue Ring" }
      },
    },
    {
      quest_id = 76078,
      item = 205986,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 57.15 / 100,
        y = 54.64 / 100,
        options = { title = "Well-Worn Kiln" }
      },
    },
    {
      quest_id = 76080,
      item = 205988,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 27.53 / 100,
        y = 42.87 / 100,
        options = { title = "Zaqali Elder Spear" }
      },
    },
    {
      quest_id = 78418,
      item = 210465,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 36.34 / 100,
        y = 46.79 / 100,
        options = { title = "Deathstalker Chassis" }
      },
    },
    {
      quest_id = 78419,
      item = 210466,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 37.29 / 100,
        y = 22.94 / 100,
        options = { title = "Flamesworn Render" }
      },
    },
    {
      quest_id = 78417,
      item = 210464,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 49.83 / 100,
        y = 62.99 / 100,
        options = { title = "Amirdrassil Defender's Shield" }
      },
    }
  },
  [SKILL_IDS.Enchanting] = {
    {
      quest_id = 70320,
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
    {
      quest_id = 75508,
      item = 204990,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 48.00 / 100,
        y = 17.00 / 100,
        options = { title = "Lava-Drenched Shadow Crystal (Please verify hidden quest id)" }
      }
    },
    {
      quest_id = 75510,
      item = 205001,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 36.66 / 100,
        y = 69.33 / 100,
        options = { title = "Resonating Arcane Crystal" }
      }
    },
    {
      quest_id = 75509,
      item = 204999,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 62.39 / 100,
        y = 53.80 / 100,
        options = { title = "Shimmering Aqueous Orb" }
      }
    },
    {
      quest_id = 78309,
      item = 210231,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 46.16 / 100,
        y = 20.51 / 100,
        options = { title = "Everburning Core" }
      }
    },
    {
      quest_id = 78308,
      item = 210228,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 38.37 / 100,
        y = 30.20 / 100,
        options = { title = "Pure Dream Water" }
      }
    },
    {
      quest_id = 78310,
      item = 210234,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 66.36 / 100,
        y = 74.20 / 100,
        options = { title = "Essence of Dreams" }
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
    {
      quest_id = 75186,
      item = 204475,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 37.82 / 100,
        y = 58.83 / 100,
        options = { title = "Busted Wyrmhole Generator" }
      }
    },
    {
      quest_id = 75184,
      item = 204471,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 50.51 / 100,
        y = 47.85 / 100,
        options = { title = "Defective Survival Pack" }
      }
    },
    {
      quest_id = 75431,
      item = 204853,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 49.44 / 100,
        y = 78.99 / 100,
        options = { title = "Discarded Dracothyst Drill " }
      }
    },
    {
      quest_id = 75430,
      item = 204850,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 57.65 / 100,
        y = 73.94 / 100,
        options = { title = "Handful of Khaz'gorite Bolts " }
      }
    },
    {
      quest_id = 75183,
      item = 204470,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 48.15 / 100,
        y = 27.99 / 100,
        options = { title = "Haphazardly Discarded Bomb" }
      }
    },
    {
      quest_id = 75188,
      item = 204480,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 49.87 / 100,
        y = 59.25 / 100,
        options = { title = "Inconspicuous Data Miner" }
      }
    },
    {
      quest_id = 75180,
      item = 204469,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 48.47 / 100,
        y = 48.61 / 100,
        options = { title = "Misplaced Aberrus Outflow Blueprints" }
      }
    },
    {
      quest_id = 75433,
      item = 204855,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 48.10 / 100,
        y = 16.59 / 100,
        options = { title = "Overclocked Determination Core " }
      }
    },
    {
      quest_id = 78279,
      item = 210194,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 40.49 / 100,
        y = 89.42 / 100,
        options = { title = "Insomniotron" }
      }
    },
    {
      quest_id = 78278,
      item = 210193,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 39.55 / 100,
        y = 52.28 / 100,
        options = { title = "Experimental Dreamcatcher" }
      }
    },
    {
      quest_id = 78281,
      item = 210197,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 62.66 / 100,
        y = 36.27 / 100,
        options = { title = "Unhatched Battery" }
      }
    },

  },
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
    {
      quest_id = 70297,
      item = 198693,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 46.2 / 100,
        y = 23.9 / 100,
        options = { title = "Dusty Darkmoon Card (Please verify hidden quest id)" }
      },
    },
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
    {
      quest_id = 76120,
      item = 206034,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 53.01 / 100,
        y = 74.27 / 100,
        options = { title = "Hissing Rune Draft" }
      }
    },
    {
      quest_id = 76121,
      item = 206035,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 54.57 / 100,
        y = 20.21 / 100,
        options = { title = "Ancient Research" }
      }
    },
    {
      quest_id = 76117,
      item = 206031,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 36.73 / 100,
        y = 46.32 / 100,
        options = { title = "Intricate Zaqali Runes" }
      }
    },
    {
      quest_id = 78411,
      item = 210458,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 55.64 / 100,
        y = 27.49 / 100,
        options = { title = "Winnie's Notes on Flora and Fauna" }
      }
    },
    {
      quest_id = 78413,
      item = 210460,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 36.04 / 100,
        y = 46.64 / 100,
        options = { title = "Primalist Shadowbinding Rune" }
      }
    },
    {
      quest_id = 78412,
      item = 210459,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 63.50 / 100,
        y = 71.52 / 100,
        options = { title = "Grove Keeper's Pillar" }
      }
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
    {
      quest_id = 75654,
      item = 205219,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 54.41 / 100,
        y = 32.47 / 100,
        options = { title = "Broken Barter Boulder" }
      }
    },
    {
      quest_id = 75653,
      item = 205216,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 34.47 / 100,
        y = 45.43 / 100,
        options = { title = "Gently Jostled Jewels" }
      }
    },
    {
      quest_id = 75652,
      item = 205214,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 40.37 / 100,
        y = 80.66 / 100,
        options = { title = "Snubbed Snail Shells" }
      }
    },
    {
      quest_id = 78282,
      item = 210200,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 33.23 / 100,
        y = 46.57 / 100,
        options = { title = "Petrified Hope" }
      }
    },
    {
      quest_id = 78283,
      item = 210201,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 43.51 / 100,
        y = 33.36 / 100,
        options = { title = "Handful of Pebbles" }
      }
    },
    {
      quest_id = 78285,
      item = 210202,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 58.95 / 100,
        y = 53.89 / 100,
        options = { title = "Coalesced Dreamstone" }
      }
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
    {
      quest_id = 75495,
      item = 204986,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 41.16 / 100,
        y = 48.81 / 100,
        options = { title = "Flame-Infused Scale Oil" }
      }
    },
    {
      quest_id = 75496,
      item = 204987,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 45.25 / 100,
        y = 21.12 / 100,
        options = { title = "Lava-Forged Leatherworker's Knife" }
      }
    },
    {
      quest_id = 75502,
      item = 204988,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 49.56 / 100,
        y = 54.80 / 100,
        options = { title = "Sulfur-Soaked Skins" }
      }
    },
    {
      quest_id = 78305,
      item = 210215,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 34.04 / 100,
        y = 29.65 / 100,
        options = { title = "Dreamtalon Claw" }
      }
    },
    {
      quest_id = 78298,
      item = 210208,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 41.75 / 100,
        y = 66.49 / 100,
        options = { title = "Tuft of Dreamsaber Fur" }
      }
    },
    {
      quest_id = 78299,
      item = 210211,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 37.45 / 100,
        y = 71.02 / 100,
        options = { title = "Molted Faerie Dragon Scales" }
      }
    },
  },
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
      quest_id = 70284,
      item = 198680,
      waypoint = {
        map = ns.constants.map_ids.AzureSpan,
        x = 16.2 / 100,
        y = 38.8 / 100,
        options = { title = "Decaying Brackenhide Blanket (Please verify hidden quest id)" }
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
    {
      quest_id = 76102,
      item = 206019,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 47.21 / 100,
        y = 48.55 / 100,
        options = { title = "Abandoned Reserve Chute" }
      }
    },
    {
      quest_id = 76116,
      item = 206030,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 44.52 / 100,
        y = 15.65 / 100,
        options = { title = "Exquisitely Embroidered Banner" }
      }
    },
    {
      quest_id = 76110,
      item = 206025,
      waypoint = {
        map = ns.constants.map_ids.ZaralekCavern,
        x = 59.11 / 100,
        y = 73.14 / 100,
        options = { title = "Used Medical Wrap Kit" }
      }
    },
    {
      quest_id = 78414,
      item = 210461,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 53.27 / 100,
        y = 27.92 / 100,
        options = { title = "Exceedingly Soft Wildercloth" }
      }
    },
    {
      quest_id = 78416,
      item = 210463,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 40.70 / 100,
        y = 86.16 / 100,
        options = { title = "Snuggle Buddy" }
      }
    },
    {
      quest_id = 78415,
      item = 210462,
      waypoint = {
        map = ns.constants.map_ids.EmeraldDream,
        x = 49.83 / 100,
        y = 61.48 / 100,
        options = { title = "Plush Pillow" }
      }
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
        log(nil, "world_drops", 1, "waypoint", string.format("%d (%f, %f)", waypoint.map, waypoint.x, waypoint.y))
        TomTom:AddWaypoint(waypoint.map, waypoint.x, waypoint.y, waypoint.options)
      end

      TomTom:ShowWaypoint()
    end
  end

  local function tooltip(parent)
    log(nil, "world_drops", 1, "tooltip", "show")

    local completion_count, items = profession_helpers.count_completed(config,
      string.format("%s, %s", "Gathering tooltip", profession_data.name))

    GameTooltip:SetOwner(parent, "ANCHOR_RIGHT")

    GameTooltip_SetTitle(GameTooltip,
      "World Drops (" .. profession_data.name .. ")",
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

    if TomTom ~= nil then
      GameTooltip_AddBlankLineToTooltip(GameTooltip)
      GameTooltip_AddNormalLine(GameTooltip, "Click for tomtom waypoints")
    end

    GameTooltip:Show()
  end

  return {
    is_valid_subsection = true,
    title = WORLD_DROPS.title,
    max = #config,
    completed_count = completed_count,
    events = { "QUEST_TURNED_IN", "ENCOUNTER_LOOT_RECEIVED" },
    notify_function = profession_helpers.notify_update_description(config, "World drops"),
    click_function = click_handler,
    tooltip_function = tooltip,
    currently_on_quest = function() return false end
  }
end

ns.professions.setup[SKILL_SUBSECTIONS.WorldDrops] = setup_world_drops
