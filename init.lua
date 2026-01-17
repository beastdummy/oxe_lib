---@class OxeLib
lib = lib or {}
local oxe = {}

-- Load settings
local settings = require 'src.settings'

-- Module cache for lazy loading
local modules = {}
local bridges = {}

---Load a module with lazy loading
---@param moduleName string
---@return table
local function loadModule(moduleName)
    if not modules[moduleName] then
        modules[moduleName] = require(('modules.%s'):format(moduleName))
        if settings.debug then
            print(('[oxe_lib] Loaded module: %s'):format(moduleName))
        end
    end
    return modules[moduleName]
end

---Load a bridge provider
---@param bridgeType string
---@param provider string
---@return table
local function loadBridge(bridgeType, provider)
    local key = ('%s.%s'):format(bridgeType, provider)
    if not bridges[key] then
        local success, bridge = pcall(require, ('bridge.%s.%s'):format(bridgeType, provider))
        if success then
            bridges[key] = bridge
            if settings.debug then
                print(('[oxe_lib] Loaded bridge: %s/%s'):format(bridgeType, provider))
            end
        else
            if settings.debug then
                print(('[oxe_lib] Failed to load bridge: %s/%s - %s'):format(bridgeType, provider, bridge))
            end
            bridges[key] = nil
            return nil
        end
    end
    return bridges[key]
end

-- Initialize bridges based on settings
local inventoryBridge = loadBridge('inventory', settings.inventory)
local keysBridge = settings.keys ~= 'none' and loadBridge('keys', settings.keys) or nil
local phoneBridge = settings.phone ~= 'none' and loadBridge('phone', settings.phone) or nil
local targetBridge = loadBridge('target', settings.target)
local interactBridge = settings.interact ~= 'none' and loadBridge('interact', settings.interact) or nil

---Get current settings
---@return OxeSettings
function oxe.getSettings()
    return settings
end

---Get a specific setting value
---@param key string
---@return any
function oxe.getSetting(key)
    return settings[key]
end

-- Inventory exports
---Check if player has an item
---@param item string|table
---@param amount? number
---@return boolean
function oxe.HasItem(item, amount)
    if not inventoryBridge then return false end
    return inventoryBridge.HasItem(item, amount)
end

---Add item to player inventory
---@param item string
---@param amount number
---@param metadata? table
---@return boolean
function oxe.AddItem(item, amount, metadata)
    if not inventoryBridge then return false end
    return inventoryBridge.AddItem(item, amount, metadata)
end

---Remove item from player inventory
---@param item string
---@param amount number
---@param metadata? table
---@return boolean
function oxe.RemoveItem(item, amount, metadata)
    if not inventoryBridge then return false end
    return inventoryBridge.RemoveItem(item, amount, metadata)
end

-- Keys exports
---Check if player has vehicle key
---@param vehicle number|string
---@return boolean
function oxe.HasKey(vehicle)
    if not keysBridge then return true end -- Default to true if no keys system
    return keysBridge.HasKey(vehicle)
end

---Lock vehicle
---@param vehicle number
---@return boolean
function oxe.Lock(vehicle)
    if not keysBridge then return false end
    return keysBridge.Lock(vehicle)
end

---Unlock vehicle
---@param vehicle number
---@return boolean
function oxe.Unlock(vehicle)
    if not keysBridge then return false end
    return keysBridge.Unlock(vehicle)
end

-- UI exports using ox_lib
---Show notification
---@param data table|string
function oxe.Notify(data)
    if type(data) == 'string' then
        data = { description = data }
    end
    lib.notify(data)
end

---Show progress bar
---@param data table
---@return boolean
function oxe.Progress(data)
    return lib.progressBar(data)
end

---Show text UI
---@param data table|string
function oxe.ShowTextUI(data)
    if type(data) == 'string' then
        lib.showTextUI(data, { position = 'right-center' })
    else
        local options = {}
        for k, v in pairs(data) do
            if k ~= 'description' then
                options[k] = v
            end
        end
        lib.showTextUI(data.description, options)
    end
end

---Hide text UI
function oxe.HideTextUI()
    lib.hideTextUI()
end

---Show context menu
---@param data table
function oxe.Context(data)
    lib.registerContext(data)
    lib.showContext(data.id)
end

---Show dialog input
---@param data table
---@return table|nil
function oxe.Dialog(data)
    return lib.inputDialog(data.title or 'Input', data.rows or {})
end

-- Phone helper stubs
---Send phone notification
---@param data table
function oxe.PhoneNotify(data)
    if phoneBridge and phoneBridge.Notify then
        phoneBridge.Notify(data)
    else
        -- Fallback to regular notification
        oxe.Notify(data)
    end
end

---Send phone message
---@param number string
---@param message string
function oxe.PhoneSendMessage(number, message)
    if phoneBridge and phoneBridge.SendMessage then
        phoneBridge.SendMessage(number, message)
    end
end

-- Target helper
---Add target zone
---@param data table
function oxe.AddTargetZone(data)
    if targetBridge and targetBridge.AddZone then
        targetBridge.AddZone(data)
    end
end

---Remove target zone
---@param id string
function oxe.RemoveTargetZone(id)
    if targetBridge and targetBridge.RemoveZone then
        targetBridge.RemoveZone(id)
    end
end

-- Interact helper
---Add interact point
---@param data table
function oxe.AddInteractPoint(data)
    if interactBridge and interactBridge.AddPoint then
        interactBridge.AddPoint(data)
    end
end

---Remove interact point
---@param id string
function oxe.RemoveInteractPoint(id)
    if interactBridge and interactBridge.RemovePoint then
        interactBridge.RemovePoint(id)
    end
end

-- Expose the library
_G.oxe = oxe

-- Register exports for other resources
for k, v in pairs(oxe) do
    exports(k, v)
end

if settings.debug then
    print('[oxe_lib] Library initialized successfully')
    print(('[oxe_lib] Inventory: %s, Keys: %s, Phone: %s, Target: %s, Interact: %s'):format(
        settings.inventory,
        settings.keys,
        settings.phone,
        settings.target,
        settings.interact
    ))
end

return oxe
