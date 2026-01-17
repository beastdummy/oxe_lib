-- Target Provider System
-- This file is loaded via 'files' directive and can be used to dynamically load target providers

OXE = OXE or {}
OXE.Providers = OXE.Providers or {}
OXE.Providers.Target = {}

-- Base target provider interface
local TargetProvider = {}

function TargetProvider:new(name)
    local obj = {
        name = name,
        loaded = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function TargetProvider:load()
    self.loaded = true
    OXE.Debug('Target provider loaded:', self.name)
end

-- Register provider
OXE.Providers.Target.Register = function(name, provider)
    OXE.Providers.Target[name] = provider
    OXE.Debug('Registered target provider:', name)
end

-- Get active provider
OXE.Providers.Target.GetActive = function()
    return OXE.Config.Providers.target
end
