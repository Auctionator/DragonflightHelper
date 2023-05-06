local addon, ns = ...

local function log(status, from, verbosity, category, message, ...)
  local debug_message = {}

  if status then
    table.insert(debug_message, status)
  end

  table.insert(debug_message, category or "")
  table.insert(debug_message, verbosity or 1)
  table.insert(debug_message, message or "")

  if DLAPI then
    DLAPI.DebugLog(
      addon .. (from and "_" .. from or ""), table.concat(debug_message, "~"), ...)
    -- else
    --   print(unpack(debug_message))
  end
end

ns.debug.log = log
