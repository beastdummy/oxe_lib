OXE.Theme = {
    -- Default theme colors for ox_lib components
    primary = '#3b82f6',
    secondary = '#64748b',
    success = '#10b981',
    warning = '#f59e0b',
    error = '#ef4444',
    info = '#06b6d4',
    
    -- Progress bar settings
    progressBar = {
        position = 'bottom',
        backgroundColor = 'rgba(0, 0, 0, 0.8)',
        color = '#3b82f6'
    },
    
    -- TextUI settings
    textUI = {
        position = 'right-center',
        icon = 'hand'
    },
    
    -- Context menu settings
    contextMenu = {
        position = 'top-right'
    }
}

function OXE.GetTheme()
    return OXE.Theme
end
