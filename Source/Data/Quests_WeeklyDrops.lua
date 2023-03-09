local SkillIds = DFH_Constants.SkillIds

DFH_Constants.ProfessionQuests.WeeklyDrops = {
  title = "Weekly Mob Drops",
  [SkillIds.Alchemy] = {
    quests = { 70511, 70504 },
    items = { 198964, 198963 },
    waypoints = {
      { map = 2022, x = 52.2 / 100,  y = 56.2 / 100,  options = { title = "Encroaching Downpour (Elementious Splinter)" } },
      { map = 2024, x = 17.78 / 100, y = 39.22 / 100, options = { title = "Brakenhide Rotflinger (Decaying Phlegm)" } }
    }
  },
  [SkillIds.Leatherworking] = {
    quests = { 70522, 70523 },
    items = { 198975, 198976 },
    waypoints = {
      { map = 2022, x = 80 / 100,    y = 24 / 100,    options = { title = "Primal Proto-Drakes (Ossified Hide)" } },
      { map = 2132, x = 15.72 / 100, y = 25.89 / 100, options = { title = "Vorquin (Exceedingly Soft Skin)" } }
    },
  },
  [SkillIds.Tailoring] = {
    quests = { 70524, 70525 },
    items = { 198977, 198978 },
    waypoints = {
      { map = 2129, x = 84 / 100,    y = 56 / 100,    options = { title = "Farm Spot (Ohn'ahran Weave)" } },
      { map = 2128, x = 33.84 / 100, y = 47.22 / 100, options = { title = "Gnolls (Stupidly Effective Stitchery)" } },
    }
  },
  [SkillIds.Jewelcrafting] = {
    quests = { 70521, 70520 },
    items = { 198974, 198973 },
    waypoints = {
      {
        map = 2025,
        x = 45 / 100,
        y = 55.4 / 100,
        options = {
          title = "Rebel Bruisers (Elegantly Engraved Embellishment)" }
      },
      { map = 2022, x = 52.3 / 100, y = 32.5 / 100, options = { title = "Crushing Elementals (Icandescent Curio)" } }
    }
  },
  [SkillIds.Blacksmithing] = {
    quests = { 70513, 70512 },
    items = { 198966, 198965 },
    waypoints = {
      { map = 2022, x = 37.8 / 100, y = 73.0 / 100, options = { title = "Blazing Manifestation (Molten Globule)" } },
      {
        map = 2022,
        x = 46.25 / 100,
        y = 37.26 / 100,
        options = {
          title = "Crushing Elemental (Primeval Earth Fragment)" }
      }
    }
  },
  [SkillIds.Engineering] = {
    quests = { 70516, 70517 },
    items = { 198969, 198970 },
    waypoints = {
      { map = 2025, x = 57.0 / 100, y = 59.2 / 100, options = { title = "Titan Defense Matrix (Keeper's Mark)" } },
      {
        map = 2025,
        x = 45.8 / 100,
        y = 58.2 / 100,
        options = {
          title = "Rebel Bruiser (Infinitely Attachable Pair o' Docks)" }
      }
    }
  },
  [SkillIds.Inscription] = {
    quests = { 70518, 70519 },
    items = { 198971, 198972 },
    waypoints = {
      { map = 2022, x = 37.2 / 100, y = 63.4 / 100, options = { title = "Qalashi Necksnapper (Curious Djaradin Rune)" } },
      { map = 2024, x = 66.4 / 100, y = 59.4 / 100, options = { title = "Arcane Manipulators (Draconic Glamour)" } }
    }
  },
  [SkillIds.Enchanting] = {
    quests = { 70514, 70515 },
    items = { 198967, 198968 },
    waypoints = {
      {
        map = 2024,
        x = 39.2 / 100,
        y = 64.0 / 100,
        options = {
          title = "Mana Wyrmling, Stabilized Elementals (Primordial Aether)" }
      },
      { map = 2025, x = 53.2 / 100, y = 65.6 / 100, options = { title = "Earthshaker Marauder (Primalist Charm)" } }
    }
  },
}
