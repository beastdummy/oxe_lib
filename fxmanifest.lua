fx_version 'cerulean'
game 'gta5'

name 'oxe_lib'
author 'oxe_lib'
version '1.0.0'
description 'Overextended FiveM library resource with unified bridge system'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'init.lua'
}

files {
    'locales/*.json',
    'modules/**/*.lua',
    'bridge/**/*.lua',
    'src/**/*.lua'
}
