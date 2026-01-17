fx_version 'cerulean'
game 'gta5'

name 'oxe_lib_example'
author 'oxe_lib'
version '1.0.0'
description 'Example resource demonstrating oxe_lib usage'

lua54 'yes'

shared_scripts {
    '@oxe_lib/shared/convars.lua'
}

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'oxe_lib',
    'ox_lib',
    'ox_core'
}
