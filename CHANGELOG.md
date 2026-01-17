# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-17

### Added
- Initial release of oxe_lib
- Convar-driven configuration system
- Bridge system architecture for multiple providers
- Lazy-loading module system
- Inventory bridges: ox_inventory, qs-inventory
- Keys bridges: qs-vehiclekeys, wasabi_carlock
- Phone bridges: qs-smartphone-pro, lb-phone
- Target bridge: ox_target
- Interact bridge: sleepless_interact
- Unified API exports for inventory operations (HasItem, AddItem, RemoveItem)
- Unified API exports for keys operations (HasKey, Lock, Unlock)
- Unified API exports for UI operations (Notify, Progress, ShowTextUI, HideTextUI, Context, Dialog)
- Phone helper functions (PhoneNotify, PhoneSendMessage)
- Target helper functions (AddTargetZone, RemoveTargetZone)
- Interact helper functions (AddInteractPoint, RemoveInteractPoint)
- English (en) locale
- Spanish (es) locale
- Comprehensive README with usage examples
- Example utilities module
- Detailed examples documentation

### Configuration
- `oxe_lib:language` - Set interface language
- `oxe_lib:debug` - Enable debug logging
- `oxe_lib:currency` - Set currency symbol
- `oxe_lib:serverName` - Set server name
- `oxe_lib:logo` - Set server logo URL
- `oxe_lib:primaryColor` - Set primary theme color
- `oxe_lib:primaryShade` - Set primary color shade
- `oxe_lib:customTheme` - Set custom theme (JSON)
- `oxe_lib:inventory` - Select inventory system
- `oxe_lib:keys` - Select keys system
- `oxe_lib:phone` - Select phone system
- `oxe_lib:target` - Select target system
- `oxe_lib:interact` - Select interact system
