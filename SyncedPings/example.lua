local syncedpings = require "syncedpings"

local page = action_wheel:newPage()

action_wheel:setPage(page)

function pings.myPing(state)
    log(state)
end

local mySyncedPing = syncedpings:new(pings.myPing, true)

page:newAction()
    :title("Action")
    :onToggle(mySyncedPing)

-- passing it directly is also an option!
page:newAction()
    :title("Action")
    :onToggle(syncedpings:new(pings.myPing, true))