fx_version 'cerulean'
game 'gta5'

name 'oxe_lib'
author 'oxe_lib'
version '1.0.0'
description 'Modular library for ox_core/ox_lib with configurable providers'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/convars.lua',
    'shared/theme.lua',
    'shared/locale.lua'
}

client_scripts {
    'client/main.lua',
    'client/notify.lua',
    'client/progress.lua',
    'client/textui.lua',
    'client/context.lua',
    'client/dialog.lua',
    'client/dashboard.lua'
}

server_scripts {
    'server/main.lua',
    'server/inventory.lua'
}

files {
    'providers/**/*.lua'
}

dependencies {
    'ox_lib',
    'ox_core'
}
