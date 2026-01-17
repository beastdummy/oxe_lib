-- Notification wrapper for ox_lib
OXE.Notify = function(data)
    if type(data) == 'string' then
        data = { description = data }
    end
    
    -- Apply theme if not specified
    data.type = data.type or 'info'
    data.position = data.position or 'top-right'
    
    lib.notify(data)
end

-- Export the notify function
exports('notify', OXE.Notify)

-- Backwards compatibility exports
exports('Notify', OXE.Notify)
exports('showNotification', OXE.Notify)
