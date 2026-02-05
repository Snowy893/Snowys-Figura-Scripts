-----------------------------------------------------------------------------

---Offset charged crossbow crouching rotation (fix when the crossbow points downward when you crouch!)

---@param itemStack ItemStack
---@return boolean
local function crossbowCharged(itemStack)
    local projectiles = itemStack:getTag().ChargedProjectiles
    return projectiles ~= nil and next(projectiles) ~= nil
end

function events.tick()
    local leftHanded = player:isLeftHanded()
    local rightItem = player:getHeldItem(leftHanded)
    local leftItem = player:getHeldItem(not leftHanded)
    local crouching = player:isCrouching()
    local charged = crossbowCharged(rightItem) or crossbowCharged(leftItem)

    local armRot = (crouching and charged) and 20 or nil
    vanilla_model.RIGHT_ARM:setOffsetRot(armRot)
    vanilla_model.LEFT_ARM:setOffsetRot(armRot)
end

-----------------------------------------------------------------------------

-- Manipulate vanilla items in first person!
-- (Make sure you have a part called ItemRight and a part called ItemLeft in your model and that they are both at position 0,0,0)

if host:isHost() then
    local rightItemPart = models.model.ItemRight
    local leftItemPart = models.model.ItemLeft
    local rightItem = rightItemPart:newItem("rightItem")
    local leftItem = leftItemPart:newItem("leftItem")

    -- Set the scale to what you want!
    rightItemPart:setScale(1, 1, 1)
    leftItemPart:setScale(1, 1, 1)

    -- Position and Rotation can be done in code, or through moving ItemRight and ItemLeft in BlockBench.
    rightItemPart:setPos(0, 0, 0)
    leftItemPart:setPos(0, 0, 0)
    rightItemPart:setRot(0, 0, 0)
    leftItemPart:setRot(0, 0, 0)

    function events.item_render(item, mode, pos, rot, scale, lefthanded)
        local isFirstPerson = mode:find("FIRST_PERSON")
        local isItem = item.id == "minecraft:grass_block" -- This can be any check you want!
        if not isFirstPerson or not isItem then return end

        local part
        if lefthanded then
            leftItem:setItem(item)
            part = leftItemPart
        else
            rightItem:setItem(item)
            part = rightItemPart
        end
        return part
    end
end

-----------------------------------------------------------------------------