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
    'config.lua',
    'utils/module.lua',
    'server/main.lua'
}


ui_page 'service_request_hud/dist/index.html'

files {
	'service_request_hud/dist/index.html',
}


dependencies {
	'es_extended',
}