# Example Usage Scripts

Here are some practical examples showing how to use oxe_lib in your FiveM resources.

## Basic Client Script Example

Create a file `client.lua` in your resource:

```lua
-- Example 1: Check for item and notify
RegisterCommand('checkwater', function()
    if exports.oxe_lib:HasItem('water', 1) then
        exports.oxe_lib:Notify({
            title = 'Inventory',
            description = 'You have water!',
            type = 'success'
        })
    else
        exports.oxe_lib:Notify({
            title = 'Inventory',
            description = 'You don\'t have water!',
            type = 'error'
        })
    end
end)

-- Example 2: Progress bar with action
RegisterCommand('drink', function()
    if not exports.oxe_lib:HasItem('water') then
        exports.oxe_lib:Notify('You don\'t have any water!')
        return
    end
    
    local success = exports.oxe_lib:Progress({
        duration = 3000,
        label = 'Drinking water...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true
        },
        anim = {
            dict = 'mp_player_intdrink',
            clip = 'loop_bottle'
        }
    })
    
    if success then
        exports.oxe_lib:RemoveItem('water', 1)
        exports.oxe_lib:Notify({
            description = 'You drank some water',
            type = 'success'
        })
    end
end)

-- Example 3: Context menu
RegisterCommand('examplemenu', function()
    exports.oxe_lib:Context({
        id = 'example_menu',
        title = 'Example Menu',
        options = {
            {
                title = 'Check Items',
                description = 'Check your inventory',
                icon = 'fa-solid fa-box',
                onSelect = function()
                    local hasPhone = exports.oxe_lib:HasItem('phone')
                    local hasKeys = exports.oxe_lib:HasItem('keys')
                    
                    exports.oxe_lib:Notify({
                        description = ('Phone: %s, Keys: %s'):format(
                            hasPhone and 'Yes' or 'No',
                            hasKeys and 'Yes' or 'No'
                        )
                    })
                end
            },
            {
                title = 'Lock/Unlock Vehicle',
                description = 'Toggle vehicle lock',
                icon = 'fa-solid fa-key',
                onSelect = function()
                    local ped = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    
                    if vehicle == 0 then
                        vehicle = lib.getClosestVehicle(GetEntityCoords(ped), 5.0, false)
                    end
                    
                    if vehicle and vehicle ~= 0 then
                        if exports.oxe_lib:HasKey(vehicle) then
                            local locked = GetVehicleDoorLockStatus(vehicle)
                            if locked == 1 or locked == 0 then
                                exports.oxe_lib:Lock(vehicle)
                                exports.oxe_lib:Notify('Vehicle locked')
                            else
                                exports.oxe_lib:Unlock(vehicle)
                                exports.oxe_lib:Notify('Vehicle unlocked')
                            end
                        else
                            exports.oxe_lib:Notify({
                                description = 'You don\'t have the keys!',
                                type = 'error'
                            })
                        end
                    else
                        exports.oxe_lib:Notify({
                            description = 'No vehicle nearby',
                            type = 'error'
                        })
                    end
                end
            }
        }
    })
end)

-- Example 4: Input dialog
RegisterCommand('sendmoney', function()
    local input = exports.oxe_lib:Dialog({
        title = 'Send Money',
        rows = {
            {
                type = 'number',
                label = 'Player ID',
                placeholder = '1',
                required = true
            },
            {
                type = 'number',
                label = 'Amount',
                placeholder = '100',
                required = true,
                min = 1
            }
        }
    })
    
    if input then
        local targetId = tonumber(input[1])
        local amount = tonumber(input[2])
        
        exports.oxe_lib:Notify({
            title = 'Money Sent',
            description = ('Sent $%d to player %d'):format(amount, targetId),
            type = 'success'
        })
        
        -- Here you would trigger a server event to actually send the money
        -- TriggerServerEvent('myscript:sendMoney', targetId, amount)
    end
end)

-- Example 5: Target zone (if ox_target is configured)
CreateThread(function()
    -- Add a target zone at a specific location
    exports.oxe_lib:AddTargetZone({
        id = 'example_shop',
        coords = vector3(25.74, -1347.03, 29.49), -- Example coords
        radius = 2.0,
        debug = false,
        options = {
            {
                label = 'Open Shop',
                icon = 'fa-solid fa-shopping-cart',
                onSelect = function()
                    exports.oxe_lib:Notify('Shop opened!')
                    -- Open your shop UI here
                end
            },
            {
                label = 'Talk to Clerk',
                icon = 'fa-solid fa-comments',
                onSelect = function()
                    exports.oxe_lib:Notify('Hello! How can I help you?')
                end
            }
        }
    })
end)

-- Example 6: Text UI
CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local shopCoords = vector3(25.74, -1347.03, 29.49) -- Example coords
        local dist = #(coords - shopCoords)
        
        if dist < 3.0 then
            sleep = 0
            exports.oxe_lib:ShowTextUI('[E] Open Shop')
            
            if IsControlJustPressed(0, 38) then -- E key
                exports.oxe_lib:Notify('Shop opened!')
            end
        else
            exports.oxe_lib:HideTextUI()
        end
        
        Wait(sleep)
    end
end)
```

## Server Script Example

Create a file `server.lua` in your resource:

```lua
-- Handle add item request from client
RegisterNetEvent('oxe_lib:addItem', function(item, amount, metadata)
    local source = source
    
    -- Use your inventory system's server-side function
    -- This is just an example
    local success = exports.ox_inventory:AddItem(source, item, amount, metadata)
    
    if success then
        TriggerClientEvent('ox_lib:notify', source, {
            description = ('Added %dx %s'):format(amount, item),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            description = 'Could not add item',
            type = 'error'
        })
    end
end)

-- Handle remove item request from client
RegisterNetEvent('oxe_lib:removeItem', function(item, amount, metadata)
    local source = source
    
    -- Use your inventory system's server-side function
    local success = exports.ox_inventory:RemoveItem(source, item, amount, metadata)
    
    if success then
        TriggerClientEvent('ox_lib:notify', source, {
            description = ('Removed %dx %s'):format(amount, item),
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            description = 'Could not remove item',
            type = 'error'
        })
    end
end)

-- Example command to give item
RegisterCommand('giveitem', function(source, args)
    if source == 0 then return end -- Console check
    
    local item = args[1]
    local amount = tonumber(args[2]) or 1
    
    if not item then
        TriggerClientEvent('ox_lib:notify', source, {
            description = 'Usage: /giveitem <item> [amount]',
            type = 'error'
        })
        return
    end
    
    local success = exports.ox_inventory:AddItem(source, item, amount)
    
    if success then
        TriggerClientEvent('ox_lib:notify', source, {
            description = ('Added %dx %s'):format(amount, item),
            type = 'success'
        })
    end
end)
```

## Your fxmanifest.lua

```lua
fx_version 'cerulean'
game 'gta5'

lua54 'yes'

shared_scripts {
    '@oxe_lib/init.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}
```

## Notes

1. Make sure `oxe_lib` is started **before** your resource in `server.cfg`
2. Configure the convars in `server.cfg` before starting the server
3. The examples assume you have `ox_inventory` configured - adjust for your inventory system
4. Always check return values and handle errors appropriately
5. Use the global `oxe` object or exports - both work the same way
