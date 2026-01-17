-- Keys Provider System
-- This file is loaded via 'files' directive and can be used to dynamically load vehicle keys providers

OXE = OXE or {}
OXE.Providers = OXE.Providers or {}
OXE.Providers.Keys = {}

-- Base keys provider interface
local KeysProvider = {}

function KeysProvider:new(name)
    local obj = {
        name = name,
        loaded = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function KeysProvider:load()
    self.loaded = true
    OXE.Debug('Keys provider loaded:', self.name)
end

function KeysProvider:giveKeys(playerId, vehicle)
    OXE.Debug('KeysProvider:giveKeys not implemented for', self.name)
end

function KeysProvider:removeKeys(playerId, vehicle)
    OXE.Debug('KeysProvider:removeKeys not implemented for', self.name)
end

function KeysProvider:hasKeys(playerId, vehicle)
    OXE.Debug('KeysProvider:hasKeys not implemented for', self.name)
    return false
end

-- Register provider
OXE.Providers.Keys.Register = function(name, provider)
    OXE.Providers.Keys[name] = provider
    OXE.Debug('Registered keys provider:', name)
end

-- Get active provider
OXE.Providers.Keys.GetActive = function()
    return OXE.Config.Providers.keys
end
