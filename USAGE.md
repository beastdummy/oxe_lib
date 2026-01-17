# OXE_LIB Usage Guide

This guide provides practical examples and best practices for using oxe_lib in your FiveM resources.

## Table of Contents

1. [Installation](#installation)
2. [Client-Side Features](#client-side-features)
3. [Server-Side Features](#server-side-features)
4. [Provider System](#provider-system)
5. [Best Practices](#best-practices)
6. [Troubleshooting](#troubleshooting)

## Installation

### Step 1: Install Dependencies

Ensure you have the required dependencies installed:
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_core](https://github.com/overextended/ox_core)

### Step 2: Install oxe_lib

1. Download or clone oxe_lib to your resources folder
2. Add to your server.cfg:

```cfg
ensure ox_lib
ensure ox_core
ensure oxe_lib
```

### Step 3: Configure (Optional)

Copy settings from `config.cfg` to your server.cfg:

```cfg
set oxe:provider:inventory "ox_inventory"
set oxe:provider:target "ox_target"
set oxe:provider:ui "ox_lib"
set oxe:provider:keys "none"
set oxe:provider:phone "none"
set oxe:debug 0
set oxe:locale "en"
```

## Client-Side Features

### Notifications

#### Basic Notification
```lua
exports.oxe_lib:notify('Simple message')
```

#### Advanced Notification
```lua
exports.oxe_lib:notify({
    title = 'Payment Received',
    description = 'You received $5000',
    type = 'success',  -- success, error, warning, info
    position = 'top-right',
    duration = 5000
})
```

#### Notification Types
```lua
-- Success
exports.oxe_lib:notify({
    title = 'Success',
    description = 'Action completed',
    type = 'success'
})

-- Error
exports.oxe_lib:notify({
    title = 'Error',
    description = 'Something went wrong',
    type = 'error'
})

-- Warning
exports.oxe_lib:notify({
    title = 'Warning',
    description = 'Be careful!',
    type = 'warning'
})

-- Info
exports.oxe_lib:notify({
    title = 'Information',
    description = 'Did you know?',
    type = 'info'
})
```

### Progress Bars

#### Simple Progress
```lua
local success = exports.oxe_lib:progress({
    duration = 5000,
    label = 'Picking lock...'
})

if success then
    print('Lock picked!')
else
    print('Failed or cancelled')
end
```

#### Progress with Options
```lua
local success = exports.oxe_lib:progress({
    duration = 10000,
    label = 'Repairing vehicle...',
    useWhileDead = false,
    canCancel = true,
    disable = {
        car = true,
        move = true,
        combat = true,
        sprint = true
    },
    anim = {
        dict = 'mini@repair',
        clip = 'fixing_a_player'
    }
})
```

#### Circle Progress
```lua
local success = exports.oxe_lib:progressCircle({
    duration = 5000,
    label = 'Hacking...',
    position = 'middle'
})
```

#### Check Progress Status
```lua
if exports.oxe_lib:progressActive() then
    print('Progress is running')
end
```

#### Cancel Progress
```lua
exports.oxe_lib:cancelProgress()
```

### TextUI

#### Show TextUI
```lua
-- Simple
exports.oxe_lib:showTextUI('[E] Open Door')

-- With options
exports.oxe_lib:textUI({
    text = '[E] Search Container',
    position = 'right-center',
    icon = 'fas fa-search'
})
```

#### Hide TextUI
```lua
exports.oxe_lib:hideTextUI()
```

#### Check if TextUI is Open
```lua
if exports.oxe_lib:isTextUIOpen() then
    print('TextUI is showing')
end
```

#### Practical Example
```lua
CreateThread(function()
    local showingUI = false
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        -- Check if near a location
        if #(coords - vector3(100.0, 100.0, 100.0)) < 3.0 then
            sleep = 0
            if not showingUI then
                exports.oxe_lib:showTextUI('[E] Access Storage')
                showingUI = true
            end
            
            if IsControlJustPressed(0, 38) then -- E key
                -- Do something
                exports.oxe_lib:hideTextUI()
                showingUI = false
            end
        else
            if showingUI then
                exports.oxe_lib:hideTextUI()
                showingUI = false
            end
        end
        
        Wait(sleep)
    end
end)
```

### Context Menu

#### Simple Menu
```lua
exports.oxe_lib:context({
    id = 'simple_menu',
    title = 'Actions',
    options = {
        {
            title = 'Option 1',
            onSelect = function()
                print('Selected option 1')
            end
        },
        {
            title = 'Option 2',
            onSelect = function()
                print('Selected option 2')
            end
        }
    }
})
```

#### Advanced Menu with Icons and Descriptions
```lua
exports.oxe_lib:context({
    id = 'vehicle_menu',
    title = 'Vehicle Actions',
    options = {
        {
            title = 'Lock Vehicle',
            description = 'Lock or unlock your vehicle',
            icon = 'fas fa-lock',
            onSelect = function()
                -- Lock vehicle logic
            end
        },
        {
            title = 'Engine',
            description = 'Toggle engine on/off',
            icon = 'fas fa-power-off',
            onSelect = function()
                -- Engine logic
            end
        },
        {
            title = 'Give Keys',
            description = 'Give keys to nearest player',
            icon = 'fas fa-key',
            iconColor = '#f59e0b',
            onSelect = function()
                -- Give keys logic
            end
        }
    }
})
```

#### Nested Menus
```lua
exports.oxe_lib:registerContext({
    id = 'main_menu',
    title = 'Main Menu',
    options = {
        {
            title = 'Submenu',
            description = 'Open a submenu',
            icon = 'fas fa-arrow-right',
            menu = 'sub_menu'
        }
    }
})

exports.oxe_lib:registerContext({
    id = 'sub_menu',
    title = 'Sub Menu',
    menu = 'main_menu', -- Back button
    options = {
        {
            title = 'Action',
            onSelect = function()
                print('Submenu action')
            end
        }
    }
})

exports.oxe_lib:showContext('main_menu')
```

### Input Dialogs

#### Simple Input
```lua
local input = exports.oxe_lib:inputDialog('Enter Name', {
    {
        type = 'input',
        label = 'Name',
        placeholder = 'John Doe',
        required = true
    }
})

if input then
    print('Name entered:', input[1])
end
```

#### Multiple Inputs
```lua
local input = exports.oxe_lib:inputDialog('Vehicle Registration', {
    {
        type = 'input',
        label = 'Plate',
        description = 'Vehicle plate number',
        required = true,
        min = 1,
        max = 8
    },
    {
        type = 'number',
        label = 'Price',
        description = 'Purchase price',
        icon = 'dollar-sign',
        required = true,
        min = 1000,
        max = 1000000
    },
    {
        type = 'select',
        label = 'Color',
        options = {
            { value = 'red', label = 'Red' },
            { value = 'blue', label = 'Blue' },
            { value = 'green', label = 'Green' }
        }
    },
    {
        type = 'checkbox',
        label = 'Insurance',
        checked = false
    }
})

if input then
    local plate = input[1]
    local price = input[2]
    local color = input[3]
    local hasInsurance = input[4]
end
```

#### Alert Dialog
```lua
local confirmed = exports.oxe_lib:alertDialog({
    header = 'Confirm Purchase',
    content = 'Are you sure you want to buy this vehicle for $50,000?',
    centered = true,
    cancel = true
})

if confirmed == 'confirm' then
    print('Purchase confirmed')
end
```

## Server-Side Features

### Inventory Management

#### Add Item
```lua
-- Simple
exports.oxe_lib:addItem(source, 'water', 5)

-- With metadata
exports.oxe_lib:addItem(source, 'phone', 1, {
    number = '555-1234',
    owner = 'John Doe'
})
```

#### Remove Item
```lua
exports.oxe_lib:removeItem(source, 'water', 1)
```

#### Check Inventory
```lua
-- Check if has item
if exports.oxe_lib:hasItem(source, 'water', 5) then
    print('Player has at least 5 water')
end

-- Get item count
local count = exports.oxe_lib:getItemCount(source, 'water')
print('Player has', count, 'water')

-- Can carry item
if exports.oxe_lib:canCarryItem(source, 'water', 10) then
    exports.oxe_lib:addItem(source, 'water', 10)
else
    -- Notify player inventory full
end
```

#### Get Item Data
```lua
local itemData = exports.oxe_lib:getItem(source, 'phone')
if itemData then
    print('Metadata:', json.encode(itemData.metadata))
end
```

#### Register Usable Item
```lua
exports.oxe_lib:registerUsableItem('lockpick', function(source, slot, metadata)
    print('Player', source, 'used lockpick from slot', slot)
    
    -- Start lockpicking
    TriggerClientEvent('myresource:startLockpick', source)
    
    -- Example: 50% chance to break
    if math.random(1, 100) <= 50 then
        exports.oxe_lib:removeItem(source, 'lockpick', 1)
    end
end)
```

#### Create Stash
```lua
-- Create a stash
exports.oxe_lib:registerStash(
    'police_locker_1',  -- Unique ID
    'Police Locker #1',  -- Label
    50,                  -- Slots
    100000,              -- Weight (grams)
    false                -- Owner (false = shared)
)

-- Player-owned stash
local playerId = 'ABC123'
exports.oxe_lib:registerStash(
    'trunk_' .. plate,
    'Vehicle Trunk',
    25,
    50000,
    playerId
)
```

## Provider System

### Understanding Providers

Providers allow you to swap out different implementations for vehicle keys, phones, etc.

### Vehicle Keys Provider

Configure in server.cfg:
```cfg
set oxe:provider:keys "qs-vehiclekeys"  # or wasabi_carlock
```

The providers are stubs with TODO markers. To implement:

1. Edit `/providers/keys/qs-vehiclekeys.lua` or `/providers/keys/wasabi_carlock.lua`
2. Replace TODO comments with actual integration code
3. Reference the export functions from the actual script

Example implementation (in the provider file):
```lua
function QSVehicleKeys:giveKeys(playerId, vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    exports['qs-vehiclekeys']:GiveKeys(playerId, plate)
end
```

### Phone Provider

Similar to keys, configure:
```cfg
set oxe:provider:phone "lb-phone"  # or qs-smartphone-pro
```

Implement in `/providers/phone/` files.

## Best Practices

### 1. Error Handling
```lua
-- Always check return values
local success = exports.oxe_lib:progress({
    duration = 5000,
    label = 'Processing...'
})

if not success then
    -- Handle cancellation or failure
    exports.oxe_lib:notify({
        title = 'Cancelled',
        description = 'Action was cancelled',
        type = 'error'
    })
    return
end
```

### 2. Resource Cleanup
```lua
-- Always hide UI when done
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        exports.oxe_lib:hideTextUI()
        exports.oxe_lib:hideContext()
    end
end)
```

### 3. Inventory Operations
```lua
-- Check before adding
if exports.oxe_lib:canCarryItem(source, 'item', count) then
    exports.oxe_lib:addItem(source, 'item', count)
else
    TriggerClientEvent('ox_lib:notify', source, {
        type = 'error',
        description = 'Inventory full'
    })
end
```

## Troubleshooting

### Common Issues

#### 1. "attempt to call nil value"
- Ensure ox_lib and ox_core are started before oxe_lib
- Check server.cfg order

#### 2. Inventory functions not working
- Verify ox_inventory is installed and running
- Check provider configuration: `set oxe:provider:inventory "ox_inventory"`

#### 3. UI not showing
- Make sure ox_lib UI is enabled
- Check browser console (F8) for errors

#### 4. Debug logging
Enable debug mode:
```cfg
set oxe:debug 1
```

Then check server/client console for `[OXE_LIB DEBUG]` messages.

### Getting Help

1. Enable debug mode
2. Check server/client console for errors
3. Verify all dependencies are installed
4. Review the example resource for working code

## Additional Resources

- [ox_lib Documentation](https://overextended.dev/ox_lib)
- [ox_core Documentation](https://overextended.dev/ox_core)
- [ox_inventory Documentation](https://overextended.dev/ox_inventory)

## Example Resources

Check the `/example` folder for a complete working example demonstrating all features.
