# oxe_lib

A modular FiveM library designed specifically for ox_core and ox_lib, providing a unified interface for common game mechanics with configurable provider support.

## Features

- 🎨 **ox_lib Integration** - Full wrapper implementations for notify, progress, textui, context, dialog, and dashboard
- 📦 **ox_inventory Wrappers** - Complete server-side inventory management functions
- 🔧 **Modular Provider System** - Configurable providers via ConVars for inventory, target, UI, vehicle keys, and phone systems
- 🔑 **Vehicle Keys Support** - Stubs for qs-vehiclekeys and wasabi_carlock (with TODO markers for implementation)
- 📱 **Phone System Support** - Stubs for qs-smartphone-pro and lb-phone (with TODO markers for implementation)
- 🌍 **Localization** - Built-in locale system for multi-language support
- 🎨 **Theme Support** - Customizable themes for UI components
- 📊 **Debug Mode** - ConVar-based debug logging

## Installation

1. Clone or download this resource to your FiveM server's resources folder
2. Add `ensure oxe_lib` to your server.cfg
3. Configure providers via ConVars (see Configuration section)

### Dependencies

- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_core](https://github.com/overextended/ox_core)

## Folder Structure

```
oxe_lib/
├── shared/              # Shared configuration
│   ├── convars.lua      # ConVar-based configuration
│   ├── theme.lua        # Theme settings
│   └── locale.lua       # Localization system
├── client/              # Client-side wrappers
│   ├── main.lua         # Client initialization
│   ├── notify.lua       # Notification wrapper
│   ├── progress.lua     # Progress bar wrapper
│   ├── textui.lua       # TextUI wrapper
│   ├── context.lua      # Context menu wrapper
│   ├── dialog.lua       # Dialog/Input wrapper
│   └── dashboard.lua    # Dashboard wrapper
├── server/              # Server-side functionality
│   ├── main.lua         # Server initialization
│   └── inventory.lua    # Inventory wrappers
├── providers/           # Provider system
│   ├── inventory/       # Inventory providers
│   ├── target/          # Target system providers
│   ├── ui/              # UI providers
│   ├── keys/            # Vehicle keys providers
│   │   ├── qs-vehiclekeys.lua
│   │   └── wasabi_carlock.lua
│   └── phone/           # Phone system providers
│       ├── qs-smartphone-pro.lua
│       └── lb-phone.lua
└── example/             # Example resource
    ├── fxmanifest.lua
    ├── client.lua
    └── server.lua
```

## Configuration

Configure providers via ConVars in your server.cfg:

```cfg
# Provider Configuration
set oxe:provider:inventory "ox_inventory"
set oxe:provider:target "ox_target"
set oxe:provider:ui "ox_lib"
set oxe:provider:keys "none"           # Options: none, qs-vehiclekeys, wasabi_carlock
set oxe:provider:phone "none"          # Options: none, qs-smartphone-pro, lb-phone

# Debug Mode
set oxe:debug 0                        # Set to 1 to enable debug logging

# Locale
set oxe:locale "en"
```

## Usage

### Client-Side

#### Notifications

```lua
-- Simple notification
exports.oxe_lib:notify('Hello World!')

-- Advanced notification
exports.oxe_lib:notify({
    title = 'Success',
    description = 'Action completed successfully',
    type = 'success',
    position = 'top-right'
})
```

#### Progress Bars

```lua
-- Progress bar
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
    print('Progress completed!')
end
```

#### TextUI

```lua
-- Show TextUI
exports.oxe_lib:showTextUI('[E] Interact')

-- Hide TextUI
exports.oxe_lib:hideTextUI()

-- Check if open
local isOpen = exports.oxe_lib:isTextUIOpen()
```

#### Context Menu

```lua
exports.oxe_lib:context({
    id = 'my_menu',
    title = 'Menu Title',
    options = {
        {
            title = 'Option 1',
            description = 'Description here',
            icon = 'fas fa-circle',
            onSelect = function()
                print('Option 1 selected')
            end
        },
        {
            title = 'Option 2',
            icon = 'fas fa-square',
            onSelect = function()
                print('Option 2 selected')
            end
        }
    }
})
```

#### Input Dialog

```lua
local input = exports.oxe_lib:inputDialog('Enter Information', {
    {
        type = 'input',
        label = 'Name',
        description = 'Enter your name',
        required = true
    },
    {
        type = 'number',
        label = 'Age',
        description = 'Enter your age',
        min = 18,
        max = 100
    },
    {
        type = 'checkbox',
        label = 'Accept Terms'
    }
})

if input then
    print('Name:', input[1])
    print('Age:', input[2])
    print('Accepted:', input[3])
end
```

#### Dashboard

```lua
exports.oxe_lib:openDashboard({
    title = 'Quick Actions',
    items = {
        {
            label = 'Action 1',
            description = 'First action',
            icon = 'fas fa-bolt',
            onSelect = function()
                print('Action 1')
            end
        }
    }
})
```

### Server-Side

#### Inventory Functions

```lua
-- Add item
exports.oxe_lib:addItem(source, 'water', 5)

-- Remove item
exports.oxe_lib:removeItem(source, 'water', 1)

-- Check if has item
local hasItem = exports.oxe_lib:hasItem(source, 'water', 1)

-- Get item count
local count = exports.oxe_lib:getItemCount(source, 'water')

-- Can carry item
local canCarry = exports.oxe_lib:canCarryItem(source, 'water', 10)

-- Register usable item
exports.oxe_lib:registerUsableItem('water', function(source, slot, metadata)
    print('Player used water')
    exports.oxe_lib:removeItem(source, 'water', 1)
end)

-- Register stash
exports.oxe_lib:registerStash('my_stash', 'My Storage', 50, 100000, false)
```

## Provider Stubs

The library includes stub implementations for vehicle keys and phone systems that can be extended:

### Vehicle Keys Providers

- **qs-vehiclekeys**: Stub with TODO markers for QS Vehicle Keys integration
- **wasabi_carlock**: Stub with TODO markers for Wasabi Car Lock integration

### Phone Providers

- **qs-smartphone-pro**: Stub with TODO markers for QS Smartphone Pro integration
- **lb-phone**: Stub with TODO markers for LB Phone integration

To implement these providers, edit the corresponding files in `/providers/keys/` or `/providers/phone/` and follow the TODO comments.

## Example Resource

An example resource is included in the `/example` folder demonstrating all features. To use it:

1. Copy the `/example` folder to your resources directory
2. Rename it (e.g., `oxe_lib_example`)
3. Add `ensure oxe_lib_example` to your server.cfg
4. Use the in-game commands to test features:
   - `/oxe_notify` - Test notifications
   - `/oxe_progress` - Test progress bars
   - `/oxe_textui` - Test TextUI
   - `/oxe_context` - Test context menu
   - `/oxe_input` - Test input dialog
   - `/oxe_dashboard` - Test dashboard
   - `/oxe_additem [item] [count]` - Add item to inventory
   - `/oxe_hasitem [item]` - Check item count

## Available Exports

### Client Exports

- `notify(data)` - Show notification
- `progress(data)` - Show progress bar
- `progressCircle(data)` - Show circular progress
- `progressActive()` - Check if progress is active
- `cancelProgress()` - Cancel active progress
- `textUI(data)` / `showTextUI(data)` - Show TextUI
- `hideTextUI()` - Hide TextUI
- `isTextUIOpen()` - Check if TextUI is open
- `context(data)` - Show context menu
- `showContext(id)` - Show registered context
- `hideContext()` - Hide context menu
- `registerContext(data)` - Register context menu
- `getCurrentContext()` - Get current context
- `dialog(data)` - Show input dialog
- `inputDialog(heading, rows)` - Show input dialog
- `alertDialog(data)` - Show alert dialog
- `openDashboard(data)` - Open dashboard
- `closeDashboard()` - Close dashboard

### Server Exports

- `getItem(source, item, metadata)` - Get item data
- `getInventory(source)` - Get full inventory
- `addItem(source, item, count, metadata)` - Add item
- `removeItem(source, item, count, metadata)` - Remove item
- `hasItem(source, item, count)` - Check if has item
- `getItemCount(source, item)` - Get item count
- `canCarryItem(source, item, count)` - Check if can carry
- `setMetadata(source, slot, metadata)` - Set item metadata
- `getSlotWithItem(source, item, metadata)` - Get slot with item
- `registerUsableItem(item, callback)` - Register usable item
- `confiscateInventory(source)` - Confiscate inventory
- `returnInventory(source, inventory)` - Return inventory
- `registerStash(id, label, slots, weight, owner)` - Register stash

## Theme Customization

You can customize the theme by editing `/shared/theme.lua`:

```lua
OXE.Theme = {
    primary = '#3b82f6',
    secondary = '#64748b',
    success = '#10b981',
    warning = '#f59e0b',
    error = '#ef4444',
    info = '#06b6d4',
    -- ... more theme options
}
```

## Localization

Add or modify locales in `/shared/locale.lua`:

```lua
OXE.Locales = {
    en = {
        notify_title = 'Notification',
        -- ... more translations
    },
    es = {
        notify_title = 'Notificación',
        -- ... Spanish translations
    }
}
```

## Development

### Debug Mode

Enable debug mode to see detailed logs:

```cfg
set oxe:debug 1
```

### Creating Custom Providers

To create a custom provider, follow the pattern in existing provider files:

1. Create a new file in the appropriate `/providers/` subfolder
2. Implement the required interface methods
3. Register the provider using `OXE.Providers.[Type].Register()`
4. Update ConVars to use your provider

## License

This resource is provided as-is for use with ox_core and ox_lib based FiveM servers.

## Contributing

Contributions are welcome! Please ensure:
- Code follows the existing structure
- Provider stubs include clear TODO markers
- All exports are documented
- Changes are tested with ox_core and ox_lib

## Support

For issues or questions:
- Check the example resource for usage patterns
- Review the ox_lib documentation
- Enable debug mode for troubleshooting