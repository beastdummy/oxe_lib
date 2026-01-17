---wasabi_carlock bridge
local bridge = {}

---Check if player has vehicle key
---@param vehicle number|string
---@return boolean
function bridge.HasKey(vehicle)
    if IsDuplicityVersion() then
        return false
    end
    
    local plate = type(vehicle) == 'number' and GetVehicleNumberPlateText(vehicle) or vehicle
    return exports.wasabi_carlock:HasKey(plate)
end

---Lock vehicle
---@param vehicle number
---@return boolean
function bridge.Lock(vehicle)
    if IsDuplicityVersion() then
        return false
    end
    
    if bridge.HasKey(vehicle) then
        SetVehicleDoorsLocked(vehicle, 2)
        return true
    end
    return false
end

---Unlock vehicle
---@param vehicle number
---@return boolean
function bridge.Unlock(vehicle)
    if IsDuplicityVersion() then
        return false
    end
    
    if bridge.HasKey(vehicle) then
        SetVehicleDoorsLocked(vehicle, 1)
        return true
    end
    return false
end

return bridge
