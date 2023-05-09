fx_version 'adamant'

game 'gta5'

description 'ftz-darkwebdealer'

version '1.0'

shared_scripts {
	'config.lua',
}

server_scripts {
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}

ui_page {
	'ui/index.html'
}

files {
	'ui/backend.js',
	'ui/index.html',
	'ui/*.css',
	'ui/images/*.png'
}