-- Inventory wrappers for ox_inventory
OXE.Inventory = {}

-- Get item from inventory
OXE.Inventory.GetItem = function(source, item, metadata)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:GetItem(source, item, metadata)
    end
    return nil
end

-- Get items from inventory
OXE.Inventory.GetInventory = function(source)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:GetInventory(source)
    end
    return {}
end

-- Add item to inventory
OXE.Inventory.AddItem = function(source, item, count, metadata)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        local success = exports.ox_inventory:AddItem(source, item, count, metadata)
        if success then
            OXE.Debug('Added item:', item, 'x', count, 'to player', source)
        end
        return success
    end
    return false
end

-- Remove item from inventory
OXE.Inventory.RemoveItem = function(source, item, count, metadata)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        local success = exports.ox_inventory:RemoveItem(source, item, count, metadata)
        if success then
            OXE.Debug('Removed item:', item, 'x', count, 'from player', source)
        end
        return success
    end
    return false
end

-- Check if player has item
OXE.Inventory.HasItem = function(source, item, count)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        local itemData = exports.ox_inventory:GetItem(source, item)
        if itemData then
            return itemData.count >= (count or 1)
        end
    end
    return false
end

-- Get item count
OXE.Inventory.GetItemCount = function(source, item)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        local itemData = exports.ox_inventory:GetItem(source, item)
        if itemData then
            return itemData.count
        end
    end
    return 0
end

-- Can carry item
OXE.Inventory.CanCarryItem = function(source, item, count)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:CanCarryItem(source, item, count)
    end
    return false
end

-- Set item metadata
OXE.Inventory.SetMetadata = function(source, slot, metadata)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:SetMetadata(source, slot, metadata)
    end
    return false
end

-- Get slot with item
OXE.Inventory.GetSlotWithItem = function(source, item, metadata)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:GetSlotWithItem(source, item, metadata)
    end
    return nil
end

-- Register usable item
OXE.Inventory.RegisterUsableItem = function(item, cb)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        exports.ox_inventory:RegisterUsableItem(item, cb)
        OXE.Debug('Registered usable item:', item)
        return true
    end
    return false
end

-- Confiscate inventory
OXE.Inventory.ConfiscateInventory = function(source)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:ConfiscateInventory(source)
    end
    return {}
end

-- Return confiscated inventory
OXE.Inventory.ReturnInventory = function(source, inventory)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        return exports.ox_inventory:ReturnInventory(source, inventory)
    end
    return false
end

-- Create stash
OXE.Inventory.RegisterStash = function(id, label, slots, weight, owner)
    if OXE.Config.Providers.inventory == 'ox_inventory' then
        exports.ox_inventory:RegisterStash(id, label, slots, weight, owner)
        OXE.Debug('Registered stash:', id)
        return true
    end
    return false
end

-- Exports
exports('getItem', OXE.Inventory.GetItem)
exports('getInventory', OXE.Inventory.GetInventory)
exports('addItem', OXE.Inventory.AddItem)
exports('removeItem', OXE.Inventory.RemoveItem)
exports('hasItem', OXE.Inventory.HasItem)
exports('getItemCount', OXE.Inventory.GetItemCount)
exports('canCarryItem', OXE.Inventory.CanCarryItem)
exports('setMetadata', OXE.Inventory.SetMetadata)
exports('getSlotWithItem', OXE.Inventory.GetSlotWithItem)
exports('registerUsableItem', OXE.Inventory.RegisterUsableItem)
exports('confiscateInventory', OXE.Inventory.ConfiscateInventory)
exports('returnInventory', OXE.Inventory.ReturnInventory)
exports('registerStash', OXE.Inventory.RegisterStash)
