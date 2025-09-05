fx_version 'cerulean'
game 'gta5'

name "wll_bossmenu"
description "Player management menu, build with react and tailwindcss, + framer for animations."
author "Hatcyk, Logerys"
version "1.0.0"

dependencies {
	'es_extended',
	'ox_lib',
	'ox_target'
}

shared_scripts {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

ui_page 'ui/dist/index.html'

files {
	'ui/dist/**/*'
}
