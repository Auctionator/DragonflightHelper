local addon, ns = ...

local initialized = false

local function initialize()
  local dlapi_format = {
    colName = { "ID", "Time", "Event", "Message", "Detail_1", "Detail_2" },
    colWidth = { 0.05, 0.15, 0.2, 0.2, 0.2, 0.2 },
    colFlex = { "flex", "flex", "drop", "search", "flex", "flex" },
    statusText = { "Sort ID", "Sort Time", "Sort Event", "Sort Message", "Sort Detail_1", "Sort Detail_2" }
  }

  DLAPI.RegisterFormat(addon, dlapi_format)
end

local function log(status, from, verbosity, category, message, ...)
  if not DLAPI then
    return
  end

  if not initialized and DLAPI then
    initialize()
  end

  if DLAPI.GetFormat(from) == "default" then
    DLAPI.SetFormat(from, addon)
  end

  local debug_message = {}
  if status then
    table.insert(debug_message, status)
  end

  table.insert(debug_message, category or "")
  table.insert(debug_message, verbosity or 1)

  if type(message) == "boolean" then
    table.insert(debug_message, (message and "true" or "false"))
  else
    table.insert(debug_message, message or "")
  end

  DLAPI.DebugLog(from or "?", table.concat(debug_message, "~"), ...)
end

ns.debug.log = log
