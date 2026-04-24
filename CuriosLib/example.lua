local curioslib = require "curioslib"

function events.tick()
    -- Gets the "necklace" slot
    local necklace = curioslib.getSlot("necklace")
    -- If the necklace slot exists and if something is being visibly worn in it
    if necklace and necklace.visible then
        log("Wearing a necklace!")
    end

    -- If you want to get multiple slots, it's more efficient to get the whole inventory
    local curiosInv = curioslib.getInventory()
    -- Check if the curios inventory has been retrieved
    if curiosInv then
        local back = curiosInv.back -- Gets the "back" slot
        local waist = curiosInv.waist -- Gets the "waist" slot

        local wearingGoldBackpack = false
        local wearingLantern = false
        
        -- If the back slot's visibility is on
        if back.visible then
            -- Loop through items
            for _, item in ipairs(back.items) do
                if item.id == "sophisticatedbackpacks:gold_backpack" then
                    wearingGoldBackpack = true
                end
            end
        end

        if waist.visible then
            for _, item in ipairs(waist.items) do
                if item.id == "minecraft:lantern" then
                    wearingLantern = true
                end
            end
        end

        if wearingGoldBackpack and wearingLantern then
            log("Ready for adventure!")
        end
    end

    local target = player:getTargetedEntity(10)
    if target then
        -- Get the target's curios inventory
        local targetCuriosInv = curioslib.getInventory(target)
        -- Get hands slot if targetCuriosInv exists
        local hands = targetCuriosInv and targetCuriosInv.hands

        -- If hands slot exists and hands slot is visible
        if hands and hands.visible then
            -- In this case, there are two hands slots.
            for i, item in ipairs(hands.items) do
                if item.id == "minecraft:totem_of_undying" then
                    -- This will log the target's name, the id of the item in that slot, and its index.
                    -- For example, if player "Snowy893" is wearing "artifacts:power_glove" in the first "hands" slot, this would be logged:
                    -- Snowy893 is wearing "artifacts:power_glove" in hand slot [1]!
                    log(target:getName().." is wearing \""..item.id.."\" in hand slot ["..tostring(i).."]!")
                end
            end
        end
    end
end