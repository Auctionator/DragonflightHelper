DragonflightHelperTodosMixin = {}

function DragonflightHelperTodosMixin:OnLoad()
  -- print("DragonflightHelperTodosMixin:OnLoad()")

  self.Container.Title:SetText("Todos")
  local lastChild = self.Container.Title;

  for _, entry in ipairs(DragonflightHelper.Todos) do
    local child = CreateFrame("FRAME", "DFH_Todo_" .. entry.name, self, "DragonflightHelperTodoRowFrame")

    child:Init(entry)

    if lastChild == self.Container.Title then
      child:SetPoint("TOPLEFT", lastChild, "BOTTOMLEFT", 4, 0)
    else
      child:SetPoint("TOPLEFT", lastChild, "BOTTOMLEFT", 0, 0)
    end

    lastChild = child
  end

  local rows = #DragonflightHelper.Todos
  self:SetHeight(rows * 20)
end
