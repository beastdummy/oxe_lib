-- Phone Provider System
-- This file is loaded via 'files' directive and can be used to dynamically load phone providers

OXE = OXE or {}
OXE.Providers = OXE.Providers or {}
OXE.Providers.Phone = {}

-- Base phone provider interface
local PhoneProvider = {}

function PhoneProvider:new(name)
    local obj = {
        name = name,
        loaded = false
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function PhoneProvider:load()
    self.loaded = true
    OXE.Debug('Phone provider loaded:', self.name)
end

function PhoneProvider:sendNotification(playerId, data)
    OXE.Debug('PhoneProvider:sendNotification not implemented for', self.name)
end

function PhoneProvider:openApp(playerId, app)
    OXE.Debug('PhoneProvider:openApp not implemented for', self.name)
end

-- Register provider
OXE.Providers.Phone.Register = function(name, provider)
    OXE.Providers.Phone[name] = provider
    OXE.Debug('Registered phone provider:', name)
end

-- Get active provider
OXE.Providers.Phone.GetActive = function()
    return OXE.Config.Providers.phone
end
