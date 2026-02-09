local syncedPings = require "syncedpings"

local page = action_wheel:newPage()

action_wheel:setPage(page)

function pings.myPing(state)
    log(state)
end

local mySyncedPing = syncedPings:new(pings.myPing, "TICK", true)

page:newAction()
    :title("Action")
    :onToggle(mySyncedPing)

-- passing it directly is also an option!
page:newAction()
    :title("Action")
    :onToggle(syncedPings:new(pings.myPing, true))
