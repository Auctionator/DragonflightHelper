DragonflightHelper.Todos = {
    { name = "weeklyQuest", maximum = 1,
        quests = {
            { id = 70750, }, --Aiding the Accord--
        },
    },

    { name = "Catalyst", maximum = 1,
        quests = {
            { id = 72528, }, --revival-catalyst
        },
    },

    { name = "CommunityFeast", maximum = 1,
        quests = {
            { id = 70893, }, -- Hidden quest ID 70893--
        },
    },

    { name = "SoDK", maximum = 1,
        quests = {
            { id = 70866, }, -- confirm this Hidden ID72025 0r 70866--
        },
    },

    { name = "Hunt", maximum = 3,
        quests = {
            { id = 70906, },
            { id = 71136, },
            { id = 71137, },
        },
    },
    { name = "flood", maximum = 1,
        quests = {
            { id = 71033, }, --Raging Torrent mobID 197221 hidden ID 71033 --
        },
    },
    { name = "elements", maximum = 1,
        quests = {
            { id = 71995, }, --Therrocite mob id 197749--
        },
    },
    { name = "worldBoss", maximum = 1,
        quests = {
            { id = 69927, }, -- Bazual mobID 193532, hidden ID####--
            { id = 69928, }, -- Liskanoth  mobID 193533, hidden ID####--
            { id = 69929, }, -- Strunraan mobID 193534, hidden ID####--
            { id = 69930, }, -- Basrikron mobID 193535, hidden ID####--

        },
    },
    { name = "Chests", maximum = 1,
        quests = {
            { id = 72376, }, --Supply Chest (warmode)
        },
    },
    { name = "SparksOfLife", maximum = 1,
        quests = {
            { id = 72646, }, --Sparks of Life: The Waking Shores
            { id = 72647, }, --Sparks of Life: Ohn'ahran Plains
            { id = 72648, }, --Sparks of Life: The Azure Span
            { id = 72649, }, --Sparks of Life: Thaldraszus
        },
    },


}

-- Weekly Quests

-- Pre-level 70:
-- https://www.wowhead.com/quest=70750/aiding-the-accord

-- Level 70:
-- https://www.wowhead.com/quest=72374/aiding-the-accord-dragonbane-keep
-- https://www.wowhead.com/quest=72068/aiding-the-accord-a-feast-for-all
-- https://www.wowhead.com/quest=72373/aiding-the-accord-the-hunt-is-on
-- https://www.wowhead.com/quest=72375/aiding-the-accord-the-isles-call

-- https://www.wowhead.com/quest=72528/revival-catalyst
-- https://www.wowhead.com/quest=70893/community-feast

-- Weekly Profession Quests
-- https://www.wowhead.com/quest=70594/leatherworking-services-requested
-- https://www.wowhead.com/quest=70595/tailoring-services-requested
-- https://www.wowhead.com/quest=70593/jewelcrafting-services-requested
-- https://www.wowhead.com/quest=70589/blacksmithing-services-requested
-- https://www.wowhead.com/quest=70591/engineering-services-requested
-- https://www.wowhead.com/quest=70592/inscription-services-requested

-- TODO Is there a way to detect recipes that would be First Time Crafted?
-- TODO Is there a way to detect First Time Gathers?

-- Profession Masters
-- Blacksmithing 70250
-- Alchemy 70247
-- Enchanting 70260
-- Engineering 70252
-- Herbalism 70253
-- Inscription 70254
-- Jewelcrafting 70255
-- Leatherworking 70256
-- Mining 70258
-- Skinning 70259
-- Tailoring 70260

-- TODO Is there a way to detect if draconic treatises are usable?


-- local objectives = {
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Alchemy)",                              quests = { 66373, 66374 },                                           optionKey = "alchemy",        skillID = 171 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Blacksmithing)",                        quests = { 66381, 66382 },                                           optionKey = "blacksmithing",  skillID = 164 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Enchanting)",                           quests = { 66377, 66378 },                                           optionKey = "enchanting",     skillID = 333 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Engineering)",                          quests = { 66379, 66380 },                                           optionKey = "engineering",    skillID = 202 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Inscription)",                          quests = { 66375, 66376 },                                           optionKey = "inscription",    skillID = 773 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Jewelcrafting)",                        quests = { 66388, 66389 },                                           optionKey = "jewelcrafting",  skillID = 755 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Leatherworking)",                       quests = { 66384, 66385 },                                           optionKey = "leatherworking", skillID = 165 },
--     { name = "Disturbed Dirt or Expedition Scout's Pack (Tailoring)",                            quests = { 66386, 66387 },                                           optionKey = "tailoring",      skillID = 197 },
--     { name = "Elementious Splinter - Elemental Enemies (Alchemy)",                               quests = { 70511 },                                                  optionKey = "alchemy",        skillID = 171 },
--     { name = "Decaying Phlegm - Rousing Decay Enemies (Alchemy)",                                quests = { 70504 },                                                  optionKey = "alchemy",        skillID = 171 },
--     { name = "Molten Globule - Rousing Fire Enemies (Blacksmithing)",                            quests = { 70513 },                                                  optionKey = "blacksmithing",  skillID = 164 },
--     { name = "Primeval Earth Fragment - Rousing Earth Enemies (Blacksmithing)",                  quests = { 70512 },                                                  optionKey = "blacksmithing",  skillID = 164 },
--     { name = "Primalist Charm - Humanoid Primalist Enemies (Enchanting)",                        quests = { 70515 },                                                  optionKey = "enchanting",     skillID = 333 },
--     { name = "Primordial Aether - Arcane Enemies (Enchanting)",                                  quests = { 70514 },                                                  optionKey = "enchanting",     skillID = 333 },
--     { name = "Infinitely Attachable Pair o' Docks - Dragonkin Enemies (Engineering)",            quests = { 70517 },                                                  optionKey = "engineering",    skillID = 202 },
--     { name = "Keeper's Mark - Titan Enemies (Engineering)",                                      quests = { 70516 },                                                  optionKey = "engineering",    skillID = 202 },
--     { name = "Draconic Glamour - Dragonkin Enemies (Inscription)",                               quests = { 70519 },                                                  optionKey = "inscription",    skillID = 773 },
--     { name = "Curious Djaradin Rune - Djaradin Enemies (Inscription)",                           quests = { 70518 },                                                  optionKey = "inscription",    skillID = 773 },
--     { name = "Elegantly Engraved Embellishment - Nokhud/Sundered Flame Enemies (Jewelcrafting)", quests = { 70521 },                                                  optionKey = "jewelcrafting",  skillID = 755 },
--     { name = "Incandescent Curio - Elemental Enemies (Jewelcrafting)",                           quests = { 70520 },                                                  optionKey = "jewelcrafting",  skillID = 755 },
--     { name = "Exceedingly Soft Skin - Slyvern/Vorquin Enemies (Leatherworking)",                 quests = { 70523 },                                                  optionKey = "leatherworking", skillID = 165 },
--     { name = "Ossified Hide - Proto-drake or Proto-dragon Enemies (Leatherworking)",             quests = { 70522 },                                                  optionKey = "leatherworking", skillID = 165 },
--     { name = "Ohn'arhan Weave - Nokhud Enemies (Tailoring)",                                     quests = { 70524 },                                                  optionKey = "tailoring",      skillID = 197 },
--     { name = "Stupidly Effective Stitchery - Gnoll Enemies (Tailoring)",                         quests = { 70525 },                                                  optionKey = "tailoring",      skillID = 197 },
--     { name = "Dreambloom (Herbalism)",                                                           quests = { 71857, 71858, 71859, 71860, 71861, 71864 },               optionKey = "herbalism",      skillID = 182 },
--     { name = "Iridescent Ore (Mining)",                                                          quests = { 72160, 72161, 72162, 72163, 72164, 72165 },               optionKey = "mining",         skillID = 186 },
--     { name = "Curious Hide (Skinning)",                                                          quests = { 70381, 70383, 70384, 70385, 70386, 70389 },               optionKey = "skinning",       skillID = 393 },
--     { name = "Draconic Treatise (Alchemy)",                                                      quests = { 74108 },                                                  optionKey = "alchemy",        skillID = 171 },
--     { name = "Draconic Treatise (Blacksmithing)",                                                quests = { 74109 },                                                  optionKey = "blacksmithing",  skillID = 164 },
--     { name = "Draconic Treatise (Enchanting)",                                                   quests = { 74110 },                                                  optionKey = "enchanting",     skillID = 333 },
--     { name = "Draconic Treatise (Engineering)",                                                  quests = { 74111 },                                                  optionKey = "engineering",    skillID = 202 },
--     { name = "Draconic Treatise (Herbalism)",                                                    quests = { 74107 },                                                  optionKey = "herbalism",      skillID = 182 },
--     { name = "Draconic Treatise (Inscription)",                                                  quests = { 74105 },                                                  optionKey = "inscription",    skillID = 773 },
--     { name = "Draconic Treatise (Jewelcrafting)",                                                quests = { 74112 },                                                  optionKey = "jewelcrafting",  skillID = 755 },
--     { name = "Draconic Treatise (Leatherworking)",                                               quests = { 74113 },                                                  optionKey = "leatherworking", skillID = 165 },
--     { name = "Draconic Treatise (Mining)",                                                       quests = { 74106 },                                                  optionKey = "mining",         skillID = 186 },
--     { name = "Draconic Treatise (Skinning)",                                                     quests = { 74114 },                                                  optionKey = "skinning",       skillID = 393 },
--     { name = "Draconic Treatise (Tailoring)",                                                    quests = { 74115 },                                                  optionKey = "tailoring",      skillID = 197 },
--     { name = "Valdrakken Profession Quests (Alchemy)",                                           quests = { 70530, 66940, 66938, 72427, 70532, 70531, 70533, 66937 }, optionKey = "alchemy",        skillID = 171, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Blacksmithing)",                                     quests = { 66941, 70233, 66517, 66897, 70235, 72398, 70234, 70211 }, optionKey = "blacksmithing",  skillID = 164, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Enchanting)",                                        quests = { 66884, 66900, 66935, 72155, 72172, 72173, 72175, 72423 }, optionKey = "enchanting",     skillID = 333, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Engineering)",                                       quests = { 72396, 70545, 66891, 70540, 66890, 66942, 70557, 70539 }, optionKey = "engineering",    skillID = 202, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Herbalism)",                                         quests = { 70614, 70613, 70616 },                                    optionKey = "herbalism",      skillID = 182, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Inscription)",                                       quests = { 66943, 66944, 70559, 70561, 70558, 70560, 66945, 72438 }, optionKey = "inscription",    skillID = 773, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Jewelcrafting)",                                     quests = { 66516, 70565, 66950, 66949, 72428, 70564, 70563, 70562 }, optionKey = "jewelcrafting",  skillID = 755, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Leatherworking)",                                    quests = { 66364, 66951, 70569, 70568, 70567, 70571, 72407, 66363 }, optionKey = "leatherworking", skillID = 165, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Mining)",                                            quests = { 70617, 70618, 72157 },                                    optionKey = "mining",         skillID = 186, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Skinning)",                                          quests = { 70620, 72159, 70619 },                                    optionKey = "skinning",       skillID = 393, useWorldState = true },
--     { name = "Valdrakken Profession Quests (Tailoring)",                                         quests = { 72410, 70587, 66952, 70586, 70572, 70582, 66953, 66899 }, optionKey = "tailoring",      skillID = 197, useWorldState = true },
--     { name = "Crafting Order Quest (Blacksmithing)",                                             quests = { 70589 },                                                  optionKey = "blacksmithing",  skillID = 164 },
--     { name = "Crafting Order Quest (Engineering)",                                               quests = { 70591 },                                                  optionKey = "engineering",    skillID = 202 },
--     { name = "Crafting Order Quest (Inscription)",                                               quests = { 70592 },                                                  optionKey = "inscription",    skillID = 773 },
--     { name = "Crafting Order Quest (Jewelcrafting)",                                             quests = { 70593 },                                                  optionKey = "jewelcrafting",  skillID = 755 },
--     { name = "Crafting Order Quest (Leatherworking)",                                            quests = { 70594 },                                                  optionKey = "leatherworking", skillID = 165 },
--     { name = "Crafting Order Quest (Tailoring)",                                                 quests = { 70595 },                                                  optionKey = "tailoring",      skillID = 197 },
-- }

-- -- This returns true if at least one of the required quests is currently active.
-- local is_active = function(objective)
--     if not aura_env.config[objective.optionKey] then
--         return false
--     end
--     if not objective.required_quests then
--         return true
--     end
--     for _, q in ipairs(objective.required_quests) do
--         if C_TaskQuest.GetQuestTimeLeftSeconds(q) or C_QuestLog.IsQuestFlaggedCompleted(q) then
--             return true
--         end
--     end
-- end

-- -- This returns the number of quests that are not complete.
-- local remaining_quests = function(objective)
--     local c = #objective.quests
--     if objective.useWorldState then
--         c = 0
--         for _, q in ipairs(objective.quests) do
--             if C_TaskQuest.GetQuestTimeLeftSeconds(q) then
--                 c = c + 1
--             end
--         end
--     else
--         for _, q in ipairs(objective.quests) do
--             if C_QuestLog.IsQuestFlaggedCompleted(q) then
--                 c = c - 1
--             end
--         end
--     end
--     return c
-- end

-- local profession_known = function(objective)
--     local prof1, prof2 = GetProfessions()
--     local prof1SkillID, prof2SkillID, _
--     if (prof1 ~= nil) then
--         _, _, _, _, _, _, prof1SkillID = GetProfessionInfo(prof1)
--     end
--     if (prof2 ~= nil) then
--         _, _, _, _, _, _, prof2SkillID = GetProfessionInfo(prof2)
--     end
--     if (objective.skillID == prof1SkillID) or (objective.skillID == prof2SkillID) then
--         return true
--     else
--         if not aura_env.config["automaticDetection"] then
--             return true
--         else
--             return false
--         end
--     end
-- end

-- aura_env.update_display = function()
--     aura_env.text = nil
--     for _, objective in ipairs(objectives) do
--         if is_active(objective) and profession_known(objective) then
--             local c = remaining_quests(objective)
--             if c > 0 then
--                 if aura_env.text then
--                     aura_env.text = aura_env.text .. "\n" .. objective.name .. ": " .. c
--                 else
--                     aura_env.text = objective.name .. ": " .. c
--                 end
--             end
--         end
--     end
-- end

-- aura_env.update_display()
