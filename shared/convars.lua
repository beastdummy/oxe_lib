OXE = OXE or {}
OXE.Config = {}

-- Provider Configuration via ConVars
OXE.Config.Providers = {
    inventory = GetConvar('oxe:provider:inventory', 'ox_inventory'),
    target = GetConvar('oxe:provider:target', 'ox_target'),
    ui = GetConvar('oxe:provider:ui', 'ox_lib'),
    keys = GetConvar('oxe:provider:keys', 'none'), -- Options: none, qs-vehiclekeys, wasabi_carlock
    phone = GetConvar('oxe:provider:phone', 'none') -- Options: none, qs-smartphone-pro, lb-phone
}

-- Debug mode
OXE.Config.Debug = GetConvarInt('oxe:debug', 0) == 1

-- Locale
OXE.Config.Locale = GetConvar('oxe:locale', 'en')

function OXE.Debug(...)
    if OXE.Config.Debug then
        print('[OXE_LIB DEBUG]', ...)
    end
end

OXE.Debug('Loaded configuration with providers:', json.encode(OXE.Config.Providers))
