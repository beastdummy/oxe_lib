-- Example server script demonstrating oxe_lib usage

print('^2[OXE_LIB EXAMPLE]^7 Server initialized')

-- Example: Register a usable item (requires ox_inventory)
CreateThread(function()
    Wait(1000)
    
    -- Register an example usable item
    local success = exports.oxe_lib:registerUsableItem('water', function(source, slot, metadata)
        print(('Player %d used water from slot %d'):format(source, slot))
        
        -- Remove the item
        if exports.oxe_lib:removeItem(source, 'water', 1) then
            -- Notify the player
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Hydration',
                description = 'You drank some water',
                type = 'success'
            })
        end
    end)
    
    if success then
        print('^2[OXE_LIB EXAMPLE]^7 Registered usable item: water')
    end
end)

-- Example: Add item command
RegisterCommand('oxe_additem', function(source, args, rawCommand)
    if source == 0 then
        print('This command can only be used in-game')
        return
    end
    
    local item = args[1] or 'water'
    local count = tonumber(args[2]) or 1
    
    if exports.oxe_lib:canCarryItem(source, item, count) then
        if exports.oxe_lib:addItem(source, item, count) then
            TriggerClientEvent('ox_lib:notify', source, {
                title = 'Item Added',
                description = ('Added %s x%d'):format(item, count),
                type = 'success'
            })
        end
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Error',
            description = 'Not enough inventory space',
            type = 'error'
        })
    end
end, false)

-- Example: Check item command
RegisterCommand('oxe_hasitem', function(source, args, rawCommand)
    if source == 0 then
        print('This command can only be used in-game')
        return
    end
    
    local item = args[1] or 'water'
    local count = exports.oxe_lib:getItemCount(source, item)
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Item Count',
        description = ('You have %s x%d'):format(item, count),
        type = 'info'
    })
end, false)

-- Example: Register a stash
CreateThread(function()
    Wait(1000)
    
    local success = exports.oxe_lib:registerStash(
        'example_stash',
        'Example Storage',
        50, -- slots
        100000, -- weight in grams
        false -- not owned by specific player
    )
    
    if success then
        print('^2[OXE_LIB EXAMPLE]^7 Registered stash: example_stash')
    end
end)

print('^3[OXE_LIB EXAMPLE]^7 Available commands:')
print('  ^2/oxe_additem [item] [count]^7 - Add item to inventory')
print('  ^2/oxe_hasitem [item]^7 - Check item count')
