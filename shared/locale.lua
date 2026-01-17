OXE.Locales = {
    en = {
        notify_title = 'Notification',
        progress_title = 'Please wait...',
        error_occurred = 'An error occurred',
        success = 'Success',
        cancelled = 'Cancelled',
        -- Provider related
        provider_loading = 'Loading %s provider...',
        provider_loaded = '%s provider loaded',
        provider_not_found = 'Provider %s not found',
        -- Inventory
        item_added = 'Added %s x%d',
        item_removed = 'Removed %s x%d',
        insufficient_space = 'Insufficient inventory space',
        -- Keys
        keys_given = 'Vehicle keys given',
        keys_removed = 'Vehicle keys removed',
        -- Phone
        phone_notification = 'New notification',
    }
}

function OXE.Locale(key, ...)
    local locale = OXE.Locales[OXE.Config.Locale] or OXE.Locales.en
    local str = locale[key] or key
    return string.format(str, ...)
end
