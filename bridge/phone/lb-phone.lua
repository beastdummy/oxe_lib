---lb-phone bridge
local bridge = {}

---Send phone notification
---@param data table
function bridge.Notify(data)
    if IsDuplicityVersion() then
        return
    else
        local notification = {
            title = data.title or 'Notification',
            content = data.description or data.message or '',
            icon = data.icon or 'bell'
        }
        exports['lb-phone']:SendNotification(notification)
    end
end

---Send phone message
---@param number string
---@param message string
function bridge.SendMessage(number, message)
    if IsDuplicityVersion() then
        return
    else
        -- lb-phone message sending
        TriggerServerEvent('lb-phone:sendMessage', number, message)
    end
end

return bridge
