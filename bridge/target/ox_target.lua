---ox_target bridge
local bridge = {}

local zones = {}

---Add target zone
---@param data table
function bridge.AddZone(data)
    if IsDuplicityVersion() then
        return
    end
    
    local id = data.id or data.name
    if not id then
        print('[oxe_lib] Target zone requires an id or name')
        return
    end
    
    local options = {}
    if data.options then
        for _, option in ipairs(data.options) do
            table.insert(options, {
                name = option.name or option.label,
                label = option.label,
                icon = option.icon or 'fa-solid fa-hand',
                distance = option.distance or 2.5,
                onSelect = option.onSelect or option.action,
                canInteract = option.canInteract
            })
        end
    end
    
    if data.coords then
        zones[id] = exports.ox_target:addSphereZone({
            coords = data.coords,
            radius = data.radius or 1.0,
            debug = data.debug or false,
            options = options
        })
    elseif data.entity then
        zones[id] = exports.ox_target:addLocalEntity(data.entity, options)
    end
end

---Remove target zone
---@param id string
function bridge.RemoveZone(id)
    if IsDuplicityVersion() then
        return
    end
    
    if zones[id] then
        exports.ox_target:removeZone(zones[id])
        zones[id] = nil
    end
end

return bridge
