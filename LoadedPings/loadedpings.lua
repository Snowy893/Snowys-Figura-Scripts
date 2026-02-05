---@class LoadedPings
local loadedPings = {}
local _loadedPings = {}

setmetatable(loadedPings, {
    __newindex = function(_, index, value)
        pings[index] = value
        local function func(...)
            if player:isLoaded() then
                pings[index](...)
            end
        end
        rawset(_loadedPings, #_loadedPings+1, func)
    end
})

return loadedPings
