---Example utilities module
---This demonstrates how modules can be added and lazy-loaded
local utils = {}

---Format currency amount
---@param amount number
---@return string
function utils.formatCurrency(amount)
    local settings = require 'src.settings'
    local currency = settings.currency or 'USD'
    
    local symbols = {
        USD = '$',
        EUR = '€',
        GBP = '£',
        JPY = '¥'
    }
    
    local symbol = symbols[currency] or currency
    
    -- Format with thousands separator and 2 decimal places
    local formatted = string.format('%.2f', amount)
    local int_part, dec_part = formatted:match('([^%.]+)%.(.+)')
    
    -- Add thousands separators
    local reversed = int_part:reverse()
    local with_commas = reversed:gsub('(%d%d%d)', '%1,')
    int_part = with_commas:reverse():gsub('^,', '')
    
    return ('%s%s.%s'):format(symbol, int_part, dec_part)
end

---Get distance between two coordinates
---@param coords1 vector3
---@param coords2 vector3
---@return number
function utils.getDistance(coords1, coords2)
    return #(coords1 - coords2)
end

---Round number to decimal places
---@param num number
---@param decimals? number
---@return number
function utils.round(num, decimals)
    decimals = decimals or 0
    local mult = 10^decimals
    return math.floor(num * mult + 0.5) / mult
end

return utils
