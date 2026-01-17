-- Dashboard/Radial Menu wrapper for ox_lib (if available in ox_lib)
-- This provides a wrapper for radial menu or custom dashboard features

OXE.Dashboard = {}

OXE.Dashboard.Open = function(data)
    -- This is a placeholder for dashboard functionality
    -- ox_lib doesn't have a built-in dashboard, but this can be extended
    OXE.Debug('Dashboard.Open called with data:', json.encode(data))
    
    -- Could integrate with ox_lib's radial menu if needed
    if lib.radialMenu then
        lib.radialMenu.open(data)
        return true
    end
    
    -- Fallback to context menu for dashboard-like functionality
    if data and data.items then
        local contextData = {
            id = 'oxe_dashboard',
            title = data.title or 'Dashboard',
            options = {}
        }
        
        for i, item in ipairs(data.items) do
            table.insert(contextData.options, {
                title = item.label or item.title,
                description = item.description,
                icon = item.icon,
                onSelect = item.onSelect or item.action
            })
        end
        
        OXE.Context(contextData)
        return true
    end
    
    return false
end

OXE.Dashboard.Close = function()
    OXE.Debug('Dashboard.Close called')
    
    if lib.radialMenu then
        lib.radialMenu.close()
    else
        OXE.HideContext()
    end
end

-- Exports
exports('openDashboard', OXE.Dashboard.Open)
exports('closeDashboard', OXE.Dashboard.Close)
