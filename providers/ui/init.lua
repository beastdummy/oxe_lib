-- UI Provider System
-- This file is loaded via 'files' directive and can be used to dynamically load UI providers

OXE = OXE or {}
OXE.Providers = OXE.Providers or {}
OXE.Providers.UI = {}

-- Base UI provider interface
local UIProvider = {}

function UIProvider:new(name)
    local obj = {
        name = name,
        loaded = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function UIProvider:load()
    self.loaded = true
    OXE.Debug('UI provider loaded:', self.name)
end

-- Register provider
OXE.Providers.UI.Register = function(name, provider)
    OXE.Providers.UI[name] = provider
    OXE.Debug('Registered UI provider:', name)
end

-- Get active provider
OXE.Providers.UI.GetActive = function()
    return OXE.Config.Providers.ui
end
