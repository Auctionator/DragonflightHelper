local _, ns = ...

local TODO_SECTIONS = ns.constants.TODO_SECTIONS

ns.constants.todos = {
  -- https://www.wowhead.com/quest=70750/aiding-the-accord
  [TODO_SECTIONS.Aiding] = {
    title = "Aiding the Accord",
    max = 1,
    { quest_id = 70750 },
    { quest_id = 72068 }, -- A Feast for all
    { quest_id = 72374 }, -- Dragonbane Keep
    { quest_id = 72373 }, -- The Hunt is On
    { quest_id = 72375 }, -- The Isles Call
    { quest_id = 75860 }, -- Researchers Under Fire
    { quest_id = 75859 }, -- Sniffenseeking
    { quest_id = 75861 }, -- Suffusion Camp
    { quest_id = 75259 }, -- Zskera Vaults
    { quest_id = 77976 }, -- Dreamsurge
    { quest_id = 78447 }, -- Emerald Bounty
    { quest_id = 78446 }, -- Superbloom
    { quest_id = 77254 }, -- Time Rift
  },
  [TODO_SECTIONS.Catalyst] = { title = "Revival Catalyst", { quest_id = 72528 } },
  [TODO_SECTIONS.Feast] = { title = "Iskaara Tuskarr Feast", { quest_id = 70893 } },
  [TODO_SECTIONS.Siege] = { title = "Siege on Dragonbane Keep", { quest_id = 70866 } },
  [TODO_SECTIONS.Hunts] = { title = "Grand Hunts", { quest_id = 70906 }, { quest_id = 71136 }, { quest_id = 71137 } },
  [TODO_SECTIONS.Flood] = { title = "Trial of Flood - Raging Torrent", { quest_id = 71033 } },
  [TODO_SECTIONS.Elements] = { title = "Trial of Elements - Therrocite", { quest_id = 71995 } },
  -- https://www.wowhead.com/guide/world-bosses-dragonflight
  [TODO_SECTIONS.Bosses] = {
    title = "World Bosses",
    max = 1,
    { quest_id = 69927 }, -- Bazual
    { quest_id = 69928 }, -- Liskanoth
    { quest_id = 69929 }, -- Stunraan
    { quest_id = 69930 }, -- Basrikon
  },
}
