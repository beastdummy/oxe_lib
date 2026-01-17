---@class OxeSettings
---@field language string
---@field debug boolean
---@field currency string
---@field serverName string
---@field logo string
---@field primaryColor string
---@field primaryShade number
---@field customTheme table|nil
---@field inventory string
---@field keys string
---@field phone string
---@field target string
---@field interact string

local settings = {
    language = GetConvar('oxe_lib:language', 'en'),
    debug = GetConvarInt('oxe_lib:debug', 0) == 1,
    currency = GetConvar('oxe_lib:currency', 'USD'),
    serverName = GetConvar('oxe_lib:serverName', 'My Server'),
    logo = GetConvar('oxe_lib:logo', ''),
    primaryColor = GetConvar('oxe_lib:primaryColor', '#3b82f6'),
    primaryShade = GetConvarInt('oxe_lib:primaryShade', 500),
    customTheme = nil, -- Can be set programmatically
    inventory = GetConvar('oxe_lib:inventory', 'ox_inventory'),
    keys = GetConvar('oxe_lib:keys', 'none'),
    phone = GetConvar('oxe_lib:phone', 'none'),
    target = GetConvar('oxe_lib:target', 'ox_target'),
    interact = GetConvar('oxe_lib:interact', 'none'),
}

-- Parse custom theme if provided
local customThemeConvar = GetConvar('oxe_lib:customTheme', '')
if customThemeConvar ~= '' then
    local success, theme = pcall(json.decode, customThemeConvar)
    if success then
        settings.customTheme = theme
    else
        print('[oxe_lib] Warning: Invalid JSON in customTheme convar')
    end
end

return settings
