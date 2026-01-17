---qs-inventory bridge
local bridge = {}

---Check if player has an item
---@param item string|table
---@param amount? number
---@return boolean
function bridge.HasItem(item, amount)
    if IsDuplicityVersion() then
        return false -- Must be called client-side
    else
        -- Client side
        if type(item) == 'table' then
            for _, itm in pairs(item) do
                local hasItem = exports['qs-inventory']:HasItem(itm, amount or 1)
                if hasItem then return true end
            end
            return false
        else
            return exports['qs-inventory']:HasItem(item, amount or 1)
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
        return false
    else
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
        return false
    else
        TriggerServerEvent('oxe_lib:removeItem', item, amount, metadata)
        return true
    end
end

return bridge
