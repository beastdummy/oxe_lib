-- Context menu wrapper for ox_lib
OXE.Context = function(data)
    if not data or not data.id then
        return false
    end
    
    -- Apply theme defaults
    local theme = OXE.GetTheme()
    data.position = data.position or theme.contextMenu.position
    
    lib.registerContext(data)
    lib.showContext(data.id)
    
    return true
end

OXE.ShowContext = function(id)
    if not id then
        return false
    end
    
    lib.showContext(id)
    return true
end

OXE.HideContext = function(onExit)
    lib.hideContext(onExit)
end

OXE.RegisterContext = function(data)
    if not data or not data.id then
        return false
    end
    
    lib.registerContext(data)
    return true
end

OXE.GetCurrentContext = function()
    return lib.getOpenContextMenu()
end

-- Exports
exports('context', OXE.Context)
exports('showContext', OXE.ShowContext)
exports('hideContext', OXE.HideContext)
exports('registerContext', OXE.RegisterContext)
exports('getCurrentContext', OXE.GetCurrentContext)
