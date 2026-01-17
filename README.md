# oxe_lib

A unified FiveM library resource for Overextended (ox_core + ox_lib) with bridge system for multiple providers.

## Features

- **Convar-driven configuration** - Configure everything through server.cfg
- **Bridge system** - Support for multiple inventory, keys, phone, target, and interact systems
- **Lazy loading** - Modules and bridges load only when needed
- **Unified API** - Consistent exports regardless of underlying system
- **ox_lib integration** - Built on top of ox_lib for UI components
- **Multi-language support** - English and Spanish locales included

## Installation

1. Ensure you have `ox_lib` installed and started before oxe_lib
2. Add `ensure oxe_lib` to your server.cfg
3. Configure convars as needed (see Configuration section)

## Configuration

Add these convars to your `server.cfg` to configure oxe_lib:

```bash
# Language (en, es)
setr oxe_lib:language "en"

# Debug mode (0 = off, 1 = on)
setr oxe_lib:debug "0"

# Currency
setr oxe_lib:currency "USD"

# Server name
setr oxe_lib:serverName "My Server"

# Server logo URL
setr oxe_lib:logo "https://example.com/logo.png"

# Primary color (hex)
setr oxe_lib:primaryColor "#3b82f6"

# Primary shade (100-900)
setr oxe_lib:primaryShade "500"

# Custom theme (JSON object, optional)
# setr oxe_lib:customTheme "{\"background\":\"#1a1a1a\"}"

# Inventory system (ox_inventory, qs-inventory)
setr oxe_lib:inventory "ox_inventory"

# Keys system (none, qs-vehiclekeys, wasabi_carlock)
setr oxe_lib:keys "none"

# Phone system (none, qs-smartphone-pro, lb-phone)
setr oxe_lib:phone "none"

# Target system (ox_target)
setr oxe_lib:target "ox_target"

# Interact system (none, sleepless_interact)
setr oxe_lib:interact "none"
```

## Supported Systems

### Inventory
- `ox_inventory` (default)
- `qs-inventory`

### Keys
- `qs-vehiclekeys`
- `wasabi_carlock`
- `none` (no keys system)

### Phone
- `qs-smartphone-pro`
- `lb-phone`
- `none` (no phone system)

### Target
- `ox_target` (default)

### Interact
- `sleepless_interact`
- `none` (no interact system)

## Usage Examples

### Inventory

```lua
-- Client side
local hasWater = exports.oxe_lib:HasItem('water', 1)

-- Add item (triggers server event)
exports.oxe_lib:AddItem('bread', 1)

-- Remove item (triggers server event)
exports.oxe_lib:RemoveItem('water', 1)

-- Using the global oxe object
if oxe.HasItem('phone') then
    print('Player has a phone')
end
```

### Vehicle Keys

```lua
-- Check if player has key
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
if exports.oxe_lib:HasKey(vehicle) then
    print('You have the key')
end

-- Lock vehicle
local success = exports.oxe_lib:Lock(vehicle)

-- Unlock vehicle
local success = exports.oxe_lib:Unlock(vehicle)
```

### Notifications and UI

```lua
-- Show notification
exports.oxe_lib:Notify({
    title = 'Success',
    description = 'Action completed successfully',
    type = 'success'
})

-- Simple notification
exports.oxe_lib:Notify('This is a simple notification')

-- Progress bar
local success = exports.oxe_lib:Progress({
    duration = 5000,
    label = 'Doing something...',
    useWhileDead = false,
    canCancel = true,
    disable = {
        car = true,
        move = true
    }
})

-- Show text UI
exports.oxe_lib:ShowTextUI('Press [E] to interact')

-- Hide text UI
exports.oxe_lib:HideTextUI()

-- Context menu
exports.oxe_lib:Context({
    id = 'example_menu',
    title = 'Example Menu',
    options = {
        {
            title = 'Option 1',
            description = 'First option',
            onSelect = function()
                print('Option 1 selected')
            end
        },
        {
            title = 'Option 2',
            description = 'Second option',
            onSelect = function()
                print('Option 2 selected')
            end
        }
    }
})

-- Input dialog
local input = exports.oxe_lib:Dialog({
    title = 'Enter Information',
    rows = {
        {
            type = 'input',
            label = 'Name',
            placeholder = 'John Doe'
        },
        {
            type = 'number',
            label = 'Age',
            placeholder = '25'
        }
    }
})

if input then
    print('Name:', input[1])
    print('Age:', input[2])
end
```

### Phone (if configured)

```lua
-- Send phone notification
exports.oxe_lib:PhoneNotify({
    title = 'New Message',
    description = 'You have a new message',
    icon = 'message'
})

-- Send phone message
exports.oxe_lib:PhoneSendMessage('555-0100', 'Hello!')
```

### Target Zones (if using ox_target)

```lua
-- Add target zone
exports.oxe_lib:AddTargetZone({
    id = 'my_zone',
    coords = vector3(0.0, 0.0, 0.0),
    radius = 2.0,
    options = {
        {
            label = 'Interact',
            icon = 'fa-hand',
            onSelect = function()
                print('Interacted!')
            end
        }
    }
})

-- Remove target zone
exports.oxe_lib:RemoveTargetZone('my_zone')
```

### Interact Points (if using sleepless_interact)

```lua
-- Add interact point
exports.oxe_lib:AddInteractPoint({
    id = 'my_point',
    coords = vector3(0.0, 0.0, 0.0),
    distance = 2.0,
    options = {
        {
            label = 'Do Something',
            action = function()
                print('Action triggered!')
            end
        }
    }
})

-- Remove interact point
exports.oxe_lib:RemoveInteractPoint('my_point')
```

### Settings

```lua
-- Get all settings
local settings = exports.oxe_lib:getSettings()
print('Language:', settings.language)

-- Get specific setting
local currency = exports.oxe_lib:getSetting('currency')
print('Currency:', currency)
```

## API Reference

### Inventory Exports

- `HasItem(item: string|table, amount?: number): boolean`
- `AddItem(item: string, amount: number, metadata?: table): boolean`
- `RemoveItem(item: string, amount: number, metadata?: table): boolean`

### Keys Exports

- `HasKey(vehicle: number|string): boolean`
- `Lock(vehicle: number): boolean`
- `Unlock(vehicle: number): boolean`

### UI Exports

- `Notify(data: table|string): void`
- `Progress(data: table): boolean`
- `ShowTextUI(data: table|string): void`
- `HideTextUI(): void`
- `Context(data: table): void`
- `Dialog(data: table): table|nil`

### Phone Exports

- `PhoneNotify(data: table): void`
- `PhoneSendMessage(number: string, message: string): void`

### Target Exports

- `AddTargetZone(data: table): void`
- `RemoveTargetZone(id: string): void`

### Interact Exports

- `AddInteractPoint(data: table): void`
- `RemoveInteractPoint(id: string): void`

### Settings Exports

- `getSettings(): OxeSettings`
- `getSetting(key: string): any`

## Architecture

```
oxe_lib/
├── init.lua              # Main loader with lazy loading
├── fxmanifest.lua        # FiveM resource manifest
├── src/
│   └── settings.lua      # Convar-driven settings
├── modules/              # Custom modules (lazy-loaded)
├── bridge/               # Provider bridges
│   ├── inventory/
│   │   ├── ox_inventory.lua
│   │   └── qs-inventory.lua
│   ├── keys/
│   │   ├── qs-vehiclekeys.lua
│   │   └── wasabi_carlock.lua
│   ├── phone/
│   │   ├── qs-smartphone-pro.lua
│   │   └── lb-phone.lua
│   ├── target/
│   │   └── ox_target.lua
│   └── interact/
│       └── sleepless_interact.lua
└── locales/
    ├── en.json
    └── es.json
```

## License

MIT

## Credits

Built for Overextended framework with inspiration from various community libraries.