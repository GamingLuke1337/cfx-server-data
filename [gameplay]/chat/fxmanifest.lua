-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

<<<<<<< Updated upstream
=======
fx_version 'cerulean'
games {'gta5', 'rdr3'}

>>>>>>> Stashed changes
version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'Provides baseline chat functionality using a NUI-based interface.'
repository 'https://github.com/bitpredator/cfx-server-data'

ui_page 'dist/ui.html'

client_script 'cl_chat.lua'
server_script 'sv_chat.lua'

files {
  'dist/ui.html',
  'dist/index.css',
  'html/vendor/*.css',
  'html/vendor/fonts/*.woff2',
}

<<<<<<< Updated upstream
fx_version 'cerulean'
games { 'gta5' }

=======
>>>>>>> Stashed changes
dependencies {
  'yarn',
  'webpack'
}

webpack_config 'webpack.config.js'
