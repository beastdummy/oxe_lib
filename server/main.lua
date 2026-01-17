-- Server initialization
CreateThread(function()
    OXE.Debug('OXE_LIB Server initialized')
    OXE.Debug('Active providers:', json.encode(OXE.Config.Providers))
    
    -- Initialize inventory provider
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        OXE.Debug('Using ox_inventory provider')
    end
end)
