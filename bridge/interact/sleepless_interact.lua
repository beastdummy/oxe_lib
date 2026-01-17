---sleepless_interact bridge
local bridge = {}

local points = {}

---Add interact point
---@param data table
function bridge.AddPoint(data)
    if IsDuplicityVersion() then
        return
    end
    
    local id = data.id or data.name
    if not id then
        print('[oxe_lib] Interact point requires an id or name')
        return
    end
    
    local options = {}
    if data.options then
        for _, option in ipairs(data.options) do
            table.insert(options, {
                label = option.label,
                action = option.onSelect or option.action,
                canInteract = option.canInteract
            })
        end
    end
    
    points[id] = exports.sleepless_interact:AddInteraction({
        coords = data.coords,
        distance = data.distance or 2.0,
        interactDst = data.interactDst or 2.0,
        id = id,
        options = options
    })
end

---Remove interact point
---@param id string
function bridge.RemovePoint(id)
    if IsDuplicityVersion() then
        return
    end
    
    if points[id] then
        exports.sleepless_interact:RemoveInteraction(id)
        points[id] = nil
    end
end

return bridge
