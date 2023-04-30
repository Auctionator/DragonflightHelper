local addon, ns = ...

local function log(status, from, verbosity, category, message, ...)
  if DLAPI then
    local debug_message = ""

    if status then
      debug_message = status .. "~"
    end

    debug_message = debug_message .. (category or "") .. "~"
    debug_message = debug_message .. (verbosity or 1) .. "~"
    debug_message = debug_message .. message

    DLAPI.DebugLog(
      addon .. (from and "_" .. from or ""), debug_message, ...)
  end
end

ns.debug.log = log
