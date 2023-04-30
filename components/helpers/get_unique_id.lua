local _, ns = ...

local unique_id = 0
local function get_id()
  unique_id = unique_id + 1
  return unique_id
end

ns.components.helpers.get_id = get_id
