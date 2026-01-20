local loadedPings = require "loadedpings"

function loadedPings.squeak()
    sounds:playSound("minecraft:entity.bat.hurt", player:getPos())
end

local page = action_wheel:newPage()

action_wheel:setPage(page)

page:newAction()
    :title("Action")
    :onLeftClick(loadedPings.squeak)
