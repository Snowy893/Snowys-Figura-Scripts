-- This is a snippet! Copy and paste it into your script!
-- Offset charged crossbow crouching rotation (fix when the crossbow points downward when you crouch!)

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
