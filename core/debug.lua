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

-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

local function dump_chat(t, indent, done)
    done = done or {}
    indent = indent or 0

    done[t] = true

    for key, value in pairs(t) do
        print(string.rep("    ", indent))

        if type(value) == "table" and not done[value] then
            done[value] = true
            print(key, "")

            dump(value, indent + 2, done)
            done[value] = nil
        else
            print(key, "    =    ", value)
            print()
        end
    end
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
  elseif type(message) == "table" then
    table.insert(debug_message, dump(message))
    -- dump_chat(message)
  else
    table.insert(debug_message, message or "")
  end

  DLAPI.DebugLog(from or "?", table.concat(debug_message, "~"), ...)
end

ns.debug.log = log
ns.debug.dump_chat = dump_chat