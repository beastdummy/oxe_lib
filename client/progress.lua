-- Progress bar wrapper for ox_lib
OXE.Progress = function(data)
    if not data then
        return false
    end
    
    -- Apply theme defaults
    local theme = OXE.GetTheme()
    data.position = data.position or theme.progressBar.position
    
    return lib.progressBar(data)
end

OXE.ProgressCircle = function(data)
    if not data then
        return false
    end
    
    return lib.progressCircle(data)
end

OXE.ProgressActive = function()
    return lib.progressActive()
end

OXE.CancelProgress = function()
    lib.cancelProgress()
end

-- Exports
exports('progress', OXE.Progress)
exports('progressCircle', OXE.ProgressCircle)
exports('progressActive', OXE.ProgressActive)
exports('cancelProgress', OXE.CancelProgress)
