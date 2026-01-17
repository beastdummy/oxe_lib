-- Client initialization
CreateThread(function()
    OXE.Debug('OXE_LIB Client initialized')
    OXE.Debug('Active providers:', json.encode(OXE.Config.Providers))
    
    -- Load providers
    if OXE.Config.Providers.keys ~= 'none' then
        local success, err = pcall(function()
            local provider = ('providers/keys/%s.lua'):format(OXE.Config.Providers.keys)
            OXE.Debug('Loading keys provider:', provider)
        end)
        if not success then
            print('[OXE_LIB ERROR] Failed to load keys provider:', err)
        end
    end
    
    if OXE.Config.Providers.phone ~= 'none' then
        local success, err = pcall(function()
            local provider = ('providers/phone/%s.lua'):format(OXE.Config.Providers.phone)
            OXE.Debug('Loading phone provider:', provider)
        end)
        if not success then
            print('[OXE_LIB ERROR] Failed to load phone provider:', err)
        end
    end
end)
