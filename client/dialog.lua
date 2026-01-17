-- Dialog/Input wrapper for ox_lib
OXE.Dialog = function(data)
    if not data then
        return nil
    end
    
    return lib.inputDialog(data.heading or 'Input', data.rows or data)
end

OXE.InputDialog = function(heading, rows)
    return lib.inputDialog(heading, rows)
end

OXE.AlertDialog = function(data)
    if type(data) == 'string' then
        data = { content = data }
    end
    
    return lib.alertDialog(data)
end

OXE.Callback = function(data, cb)
    if not data then
        return
    end
    
    -- For async callbacks
    local result = lib.inputDialog(data.heading or 'Input', data.rows or data)
    if cb then
        cb(result)
    end
    return result
end

-- Exports
exports('dialog', OXE.Dialog)
exports('inputDialog', OXE.InputDialog)
exports('alertDialog', OXE.AlertDialog)
exports('callback', OXE.Callback)
