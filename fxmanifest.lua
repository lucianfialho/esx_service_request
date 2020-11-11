-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Lucian Fialho'
description 'Services requests'
version '1.0.0'

-- What to run
client_scripts {
    'config.lua',
    'client/main.lua'
}

server_script {
    'server/main.lua'
}