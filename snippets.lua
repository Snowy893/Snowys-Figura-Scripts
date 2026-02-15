---------------------------------------------------------------------

-- This is a snippet! Copy and paste it into your script!
-- Offset charged crossbow crouching rotation. (fix when the crossbow points downward when you crouch)

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

---------------------------------------------------------------------

-- This is a snippet! Copy and paste it into your script!
-- Manipulate vanilla items in first person.
--[[
    Make sure that:
    - You have a group called ItemRight and a group called ItemLeft in your model, both at position 0,0,0, and outside of your root folder (if applicable)
    - Each group has a cube with an invisible texture or with all faces removed (This is the only way block items work!)
]]

-- First person stuff can be host only!
if host:isHost() then
    local rightItemPart = models.model.ItemRight
    local leftItemPart = models.model.ItemLeft
    local rightItem = rightItemPart:newItem("rightItem")
        :setDisplayMode("FIRST_PERSON_RIGHT_HAND")
        :setRot(0, 180, 0)
    local leftItem = leftItemPart:newItem("leftItem")
        :setDisplayMode("FIRST_PERSON_LEFT_HAND")
        :setRot(0, 180, 0)

    -- Set the scale to what you want!
    rightItemPart:setScale(1, 1, 1)
    leftItemPart:setScale(1, 1, 1)

    -- Position and Rotation can be done in code, or through moving ItemRight and ItemLeft in Blockbench.
    rightItemPart:setPos(0, 0, 0)
    leftItemPart:setPos(0, 0, 0)
    rightItemPart:setRot(0, 0, 0)
    leftItemPart:setRot(0, 0, 0)

    function events.item_render(item, mode, pos, rot, scale, lefthanded)
        local isFirstPerson = mode:find("FIRST_PERSON")
        if not isFirstPerson then return end

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

-- (Version without left and right distinction) Manipulate vanilla items in first person!
--[[
    Make sure that:
    - You have a group called Item in your model at position 0,0,0, and outside of your root folder (if applicable)
    - The group has a cube with an invisible texture or with all faces removed (This is the only way block items work!)
]]

-- First person stuff can be host only!
if host:isHost() then
    local itemPart = models.model.Item
    local itemTask = itemPart:newItem("item"):setRot(0, 180, 0)

    -- Set the scale to what you want!
    itemPart:setScale(1, 1, 1)

    -- Position and Rotation can be done in code or through moving Item in Blockbench.
    itemPart:setPos(0, 0, 0)
    itemPart:setRot(0, 0, 0)

    function events.item_render(item, mode, pos, rot, scale, lefthanded)
        local isFirstPerson = mode:find("FIRST_PERSON")
        if not isFirstPerson then return end

        itemTask:setDisplayMode(mode)
        itemTask:setItem(item)

        return itemPart
    end
end

---------------------------------------------------------------------

-- Make yourself emit particles!
-- (combined with this snippet: https://discord.com/channels/1129805506354085959/1234218592187453452/1457850741212450928)
local particle = "minecraft:portal"
local offset = vec(0, 1, 0) -- the center from where the particles spawn, offset from the player position
local rate = 25 -- particles per second
local radius = 1 -- max distance from the player
local vel = 1 -- velocity

local countLeft = 0
function events.tick()
    countLeft = countLeft + rate / 20
    while countLeft > 0 do
        countLeft = countLeft - 1
        local pos = player:getPos():add(offset)
            :add(
                math.lerp(-radius, radius, math.random()),
                math.lerp(-radius, radius, math.random()),
                math.lerp(-radius, radius, math.random())
            )
        particles:newParticle(particle, pos, vec(
            math.lerp(-vel, vel, math.random()),
            math.lerp(-vel, vel, math.random()),
            math.lerp(-vel, vel, math.random())
        ))
    end
end

-- Alternate version for custom color:
local rgba = vec(50, 50, 50, 255) -- red, green, blue, alpha here (0-255)
local offset = vec(0, 1, 0) -- the center from where the particles spawn, offset from the player position
local rate = 25 -- particles per second
local radius = 2 -- max distance from the player
local vel = 1 -- velocity

local countLeft = 0
local particle = "dust "..tostring(rgba.x / 255).." "..tostring(rgba.y / 255).." "..tostring(rgba.z / 255).." "..tostring(rgba.w / 255)
function events.tick()
	countLeft = countLeft + rate / 20
	while countLeft > 0 do
		countLeft = countLeft - 1
		local pos = player:getPos():add(offset)
			:add(
				math.lerp(-radius, radius, math.random()),
				math.lerp(-radius, radius, math.random()),
				math.lerp(-radius, radius, math.random())
			)
		particles:newParticle(particle, pos, vec(
			math.lerp(-vel, vel, math.random()),
			math.lerp(-vel, vel, math.random()),
			math.lerp(-vel, vel, math.random())
		))
	end
end