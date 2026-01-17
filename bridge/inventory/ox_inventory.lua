---ox_inventory bridge
local bridge = {}

---Check if player has an item
---@param item string|table
---@param amount? number
---@return boolean
function bridge.HasItem(item, amount)
    if IsDuplicityVersion() then
        -- Server side
        return false -- Must be called client-side or with source
    else
        -- Client side
        local items = exports.ox_inventory:Search('count', item)
        if type(item) == 'table' then
            local total = 0
            for _, itm in pairs(item) do
                total = total + (items[itm] or 0)
            end
            return total >= (amount or 1)
        else
            return (items or 0) >= (amount or 1)
        end
    end
end

---Add item to player inventory
---@param item string
---@param amount number
---@param metadata? table
---@return boolean
function bridge.AddItem(item, amount, metadata)
    if IsDuplicityVersion() then
        -- Server side - requires source
        return false
    else
        -- Client side - trigger server event
        TriggerServerEvent('oxe_lib:addItem', item, amount, metadata)
        return true
    end
end

---Remove item from player inventory
---@param item string
---@param amount number
---@param metadata? table
---@return boolean
function bridge.RemoveItem(item, amount, metadata)
    if IsDuplicityVersion() then
        -- Server side - requires source
        return false
    else
        -- Client side - trigger server event
        TriggerServerEvent('oxe_lib:removeItem', item, amount, metadata)
        return true
    end
end

return bridge
