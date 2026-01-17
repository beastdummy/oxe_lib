-- TextUI wrapper for ox_lib
OXE.TextUI = function(data)
    if type(data) == 'string' then
        data = { text = data }
    end
    
    -- Apply theme defaults
    local theme = OXE.GetTheme()
    data.position = data.position or theme.textUI.position
    data.icon = data.icon or theme.textUI.icon
    
    lib.showTextUI(data.text, data)
end

OXE.HideTextUI = function()
    lib.hideTextUI()
end

OXE.IsTextUIOpen = function()
    return lib.isTextUIOpen()
end

-- Exports
exports('textUI', OXE.TextUI)
exports('showTextUI', OXE.TextUI)
exports('hideTextUI', OXE.HideTextUI)
exports('isTextUIOpen', OXE.IsTextUIOpen)
