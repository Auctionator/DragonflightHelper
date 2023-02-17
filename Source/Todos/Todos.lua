DragonflightHelperTodosMixin = {}

function DragonflightHelperTodosMixin:OnLoad()
  -- print("DragonflightHelperTodosMixin:OnLoad()")

  local lastChild = nil

  for _, entry in ipairs(DragonflightHelper.Todos) do
    local child = CreateFrame("FRAME", "DFH_Todo_" .. entry.name, self, "DragonflightHelperTodoRowFrame")

    child:Init(entry)

    if lastChild == nil then
      child:SetPoint("TOPLEFT", self.Container, "TOPLEFT", 4, 0)
    else
      child:SetPoint("TOPLEFT", lastChild, "BOTTOMLEFT", 0, 0)
    end

    lastChild = child
  end

  local rows = #DragonflightHelper.Todos
  self:SetHeight(rows * 20)
end
