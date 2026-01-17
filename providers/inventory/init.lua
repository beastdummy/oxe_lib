-- Inventory Provider System
-- This file is loaded via 'files' directive and can be used to dynamically load inventory providers

OXE = OXE or {}
OXE.Providers = OXE.Providers or {}
OXE.Providers.Inventory = {}

-- Base inventory provider interface
local InventoryProvider = {}

function InventoryProvider:new(name)
    local obj = {
        name = name,
        loaded = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function InventoryProvider:load()
    self.loaded = true
    OXE.Debug('Inventory provider loaded:', self.name)
end

-- Register provider
OXE.Providers.Inventory.Register = function(name, provider)
    OXE.Providers.Inventory[name] = provider
    OXE.Debug('Registered inventory provider:', name)
end

-- Get active provider
OXE.Providers.Inventory.GetActive = function()
    return OXE.Config.Providers.inventory
end
