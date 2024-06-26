local HC = exports.hc_core.GetHC()

-- Constants
local fruitHash = -845035989 -- Pineapple model hash
local spawnPos = vector3(340.0, 6522.0, 28.0) -- Fixed spawn position
local spawnRadius = 20.0
local maxFruits = 100

-- Function to load model
function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end
end

-- Function to spawn a fruit near the spawn position
function spawnFruitNearPosition()
    local angle = math.random() * math.pi * 2
    local radius = math.random() * spawnRadius
    local x = spawnPos.x + radius * math.cos(angle)
    local y = spawnPos.y + radius * math.sin(angle)

    local z = spawnPos.z

    local fruit = CreateObjectNoOffset(fruitHash, x, y, z, true, true, false)
    
    --this does not want to work---
    --TriggerClientEvent('hc:ff:disableCollision', -1, NetworkGetNetworkIdFromEntity(fruit))

    --PlaceObjectOnGroundProperly(fruit)
    return fruit
end


-- Global table to keep track of spawned fruits
local spawnedFruits = {}

-- Main thread for spawning fruits
CreateThread(function()
    while true do
        Wait(500)  -- Wait one second between spawns
        if #spawnedFruits < maxFruits then
            local newFruit = spawnFruitNearPosition()
            table.insert(spawnedFruits, newFruit)
        end
    end
end)

-- Function to check if a player is near a fruit and collect it
function checkAndCollectFruit(playerId)
    local playerPos = GetEntityCoords(GetPlayerPed(playerId))

    for i, fruit in ipairs(spawnedFruits) do
        local fruitPos = GetEntityCoords(fruit)
        if #(playerPos - fruitPos) < 3 then  -- If player is close enough to collect the fruit
            -- Add the fruit to the player's inventory
            local added = HC.Inventory.AddItem(playerId, 'pineapple', 1)

            if added then
                -- Delete the fruit
                DeleteEntity(fruit)
                
                TriggerClientEvent('hc:ff:FruitCollected', playerId, NetworkGetNetworkIdFromEntity(fruit))
                
                table.remove(spawnedFruits, i)
            else
                print("inventory full")
                --TriggerClientEvent('hc:ff:FruitCollected', playerId, NetworkGetNetworkIdFromEntity(fruit))
            end
            break  -- Exit the loop once a fruit is collected
        end
    end
end

-- Thread to check if players are near fruits and collect them
CreateThread(function()
    while true do
        Wait(100)  -- Check every 500ms
        for _, playerId in ipairs(GetPlayers()) do
            checkAndCollectFruit(playerId)
        end
    end
end)