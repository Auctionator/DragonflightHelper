local SkillIds = DFH_Constants.SkillIds

DFH_Constants.ProfessionQuests.WeeklyProfession = {
  title = "Valdrakken Weekly Profession",
  [SkillIds.Alchemy] = { completionCount = 1, quests = {
    -- Dhurrel <Trade Liaison>
    72427, 66940, 66938,
    -- Dothenos <Trade Coordinator>
    66937
  } },
  [SkillIds.Leatherworking] = { completionCount = 1, quests = {
    -- Dhurrel <Trade Liaison>
    66363,
    -- Temnaayu <Trade Negotiator>
    66951, 72407, 66364
  } },
  [SkillIds.Blacksmithing] = { completionCount = 1, quests = {
    -- Dhurrel <Trade Liaison>
    66517, 66897, 66941
  } },
  [SkillIds.Jewelcrafting] = { completionCount = 1, quests = {
    -- Temnaayu <Trade Negotiator>
    66950, 66949,
    -- Gnoklin Quirkcoil <Requisitions Officer>
    72428, 66516
  } },
  [SkillIds.Enchanting] = { completionCount = 1, quests = {
    -- Temnaayu <Trade Negotiator>
    66900, 66884, 72423,
    -- Gnoklin Quirkcoil <Requisitions Officer>
    66935
  } },
  [SkillIds.Tailoring] = { completionCount = 1, quests = {
    -- Dothenos <Trade Coordinator>
    66952,
    -- Gnoklin Quirkcoil <Requisitions Officer>
    72410
  } },
  [SkillIds.Engineering] = { completionCount = 1, quests = {
    -- Dothenos <Trade Coordinator>
    72396, 66890,
    -- Gnoklin Quirkcoil <Requisitions Officer>
    66942, 66891
  } },
  [SkillIds.Inscription] = { completionCount = 1, quests = {
    -- Dothenos <Trade Coordinator>
    66945, 72438, 66943,
    -- Gnoklin Quirkcoil <Requisitions Officer>
    66944
  } },
}
