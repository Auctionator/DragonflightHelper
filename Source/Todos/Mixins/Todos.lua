DragonflightHelperAidingTheAccordMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperAidingTheAccordMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 70750 })
end

DragonflightHelperRevivalCatalystMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperRevivalCatalystMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 72528 })
end

DragonflightHelperFeastTodoMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperFeastTodoMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 70893 })
end

DragonflightHelperSiegeTodoMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperSiegeTodoMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 70866 }, "Siege of Dragonscale Keep")
end

DragonflightHelperHuntTodoMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperHuntTodoMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 70906, 71136, 71137 }, "Grand Hunts")
end

DragonflightHelperTrialOfFloodMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperTrialOfFloodMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 71033 }, "Trial of Flood - Raging Torrent")
end

DragonflightHelperTrialOfElementsMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperTrialOfElementsMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 71995 }, "Trial of Elements - Therrocite")
end

DragonflightHelperWorldBossesMixin = CreateFromMixins(DragonflightHelperTodoMixin)

function DragonflightHelperWorldBossesMixin:OnLoad()
  DragonflightHelperTodoMixin.OnLoad(self)

  self:Init({ 69927, 69928, 69929, 69930 }, "World Bosses", 1)
end
