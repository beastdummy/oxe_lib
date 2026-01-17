---qs-smartphone-pro bridge
local bridge = {}

---Send phone notification
---@param data table
function bridge.Notify(data)
    if IsDuplicityVersion() then
        return
    else
        local notification = {
            title = data.title or 'Notification',
            message = data.description or data.message or '',
            icon = data.icon or 'bell',
            timeout = data.duration or 5000
        }
        exports['qs-smartphone-pro']:SendNotification(notification)
    end
end

---Send phone message
---@param number string
---@param message string
function bridge.SendMessage(number, message)
    if IsDuplicityVersion() then
        return
    else
        TriggerServerEvent('qs-smartphone:server:SendMessage', number, message)
    end
end

return bridge
