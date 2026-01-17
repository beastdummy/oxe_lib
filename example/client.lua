-- Example client script demonstrating oxe_lib usage

-- Wait for resource to be ready
CreateThread(function()
    Wait(1000)
    print('^2[OXE_LIB EXAMPLE]^7 Client initialized')
end)

-- Example: Using notify
RegisterCommand('oxe_notify', function()
    exports.oxe_lib:notify({
        title = 'Example Notification',
        description = 'This is a test notification using oxe_lib!',
        type = 'success'
    })
end, false)

-- Example: Using progress bar
RegisterCommand('oxe_progress', function()
    local success = exports.oxe_lib:progress({
        duration = 5000,
        label = 'Doing something...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    })
    
    if success then
        exports.oxe_lib:notify({
            title = 'Complete',
            description = 'Progress completed!',
            type = 'success'
        })
    else
        exports.oxe_lib:notify({
            title = 'Cancelled',
            description = 'Progress was cancelled',
            type = 'error'
        })
    end
end, false)

-- Example: Using TextUI
RegisterCommand('oxe_textui', function()
    exports.oxe_lib:showTextUI('[E] Interact with something')
    
    Wait(5000)
    
    exports.oxe_lib:hideTextUI()
end, false)

-- Example: Using context menu
RegisterCommand('oxe_context', function()
    exports.oxe_lib:context({
        id = 'example_menu',
        title = 'Example Menu',
        options = {
            {
                title = 'Option 1',
                description = 'This is the first option',
                icon = 'fas fa-circle',
                onSelect = function()
                    exports.oxe_lib:notify('You selected option 1')
                end
            },
            {
                title = 'Option 2',
                description = 'This is the second option',
                icon = 'fas fa-square',
                onSelect = function()
                    exports.oxe_lib:notify('You selected option 2')
                end
            },
            {
                title = 'Close',
                description = 'Close this menu',
                icon = 'fas fa-times',
                onSelect = function()
                    exports.oxe_lib:hideContext()
                end
            }
        }
    })
end, false)

-- Example: Using input dialog
RegisterCommand('oxe_input', function()
    local input = exports.oxe_lib:inputDialog('Example Input', {
        {
            type = 'input',
            label = 'Your Name',
            description = 'Enter your character name',
            required = true,
            min = 3,
            max = 50
        },
        {
            type = 'number',
            label = 'Your Age',
            description = 'Enter your age',
            required = true,
            min = 18,
            max = 100
        },
        {
            type = 'checkbox',
            label = 'Accept Terms',
            description = 'Do you accept the terms?'
        }
    })
    
    if input then
        exports.oxe_lib:notify({
            title = 'Input Received',
            description = ('Name: %s, Age: %d'):format(input[1], input[2]),
            type = 'success'
        })
    end
end, false)

-- Example: Using dashboard
RegisterCommand('oxe_dashboard', function()
    exports.oxe_lib:openDashboard({
        title = 'Quick Actions',
        items = {
            {
                label = 'Action 1',
                description = 'First quick action',
                icon = 'fas fa-bolt',
                onSelect = function()
                    exports.oxe_lib:notify('Action 1 executed')
                end
            },
            {
                label = 'Action 2',
                description = 'Second quick action',
                icon = 'fas fa-star',
                onSelect = function()
                    exports.oxe_lib:notify('Action 2 executed')
                end
            }
        }
    })
end, false)

-- Print available commands
print('^3[OXE_LIB EXAMPLE]^7 Available commands:')
print('  ^2/oxe_notify^7 - Show notification')
print('  ^2/oxe_progress^7 - Show progress bar')
print('  ^2/oxe_textui^7 - Show text UI')
print('  ^2/oxe_context^7 - Show context menu')
print('  ^2/oxe_input^7 - Show input dialog')
print('  ^2/oxe_dashboard^7 - Show dashboard')
