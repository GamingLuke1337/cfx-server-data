-- This resource is part of the default Cfx.re asset pack (cfx-server-data)
-- Altering or recreating for local use only is strongly discouraged.

fx_version 'cerulean'
game 'common'

version '2.0.1'
author 'Cfx.re <root@cfx.re>'
description 'A GTA Online-styled theme for the chat resource.'
repository 'https://github.com/bitpredator/cfx-server-data'

files {
    'style.css',
    'shadow.js'
}

chat_theme("gtao")({
    styleSheet = "style.css",
    script = "shadow.js",
    msgTemplates = {
        default = "<b>{0}</b><span>{1}</span>",
    },
})
