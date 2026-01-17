---qs-vehiclekeys bridge
local bridge = {}

---Check if player has vehicle key
---@param vehicle number|string
---@return boolean
function bridge.HasKey(vehicle)
    if IsDuplicityVersion() then
        return false
    else
        local plate = type(vehicle) == 'number' and GetVehicleNumberPlateText(vehicle) or vehicle
        return exports['qs-vehiclekeys']:HasKey(plate)
    end
end

---Lock vehicle
---@param vehicle number
---@return boolean
function bridge.Lock(vehicle)
    if IsDuplicityVersion() then
        return false
    else
        local plate = GetVehicleNumberPlateText(vehicle)
        if bridge.HasKey(vehicle) then
            SetVehicleDoorsLocked(vehicle, 2)
            exports['qs-vehiclekeys']:SetLockStatus(plate, 2)
            return true
        end
        return false
    end
end

---Unlock vehicle
---@param vehicle number
---@return boolean
function bridge.Unlock(vehicle)
    if IsDuplicityVersion() then
        return false
    else
        local plate = GetVehicleNumberPlateText(vehicle)
        if bridge.HasKey(vehicle) then
            SetVehicleDoorsLocked(vehicle, 1)
            exports['qs-vehiclekeys']:SetLockStatus(plate, 1)
            return true
        end
        return false
    end
end

return bridge
