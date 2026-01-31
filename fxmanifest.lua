fx_version 'cerulean'
game 'gta5'

author 'YourName'
description 'Standalone LEO Core System (ox_lib)'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'locales/*.lua',
    'shared/utils.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}
