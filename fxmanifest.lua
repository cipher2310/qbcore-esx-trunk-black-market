fx_version 'adamant'

game 'gta5'

description 'ftz-darkwebdealer'

version '1.0'

shared_scripts {
	'config.lua',
}

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

ui_page {
	'index.html'
}

files {
	'backend.js',
	'index.html',
	'*.css',
	'images/*.png'
}