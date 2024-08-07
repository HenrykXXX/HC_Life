fx_version 'bodacious'
game 'gta5'

author 'HenrykXXX'
version '1.0.0'

client_scripts {
    '@mysql-async/lib/MySQL.lua',
    
    'client/main.lua',

    --inventory--
    'inventory/client.lua',

    --time--
    'time/client.lua',

    --mapmanager--
    'mapmanager/client.lua',

    --vehicles--
    'vehicles/client.lua',

    'utils/client.lua',

    'player/client.lua'
}

server_scripts {
    'server/main.lua',
    'db/server.lua',

    "server/events.lua",


    --configuration--
    "config/vehicles.lua",
    'config/items.lua',
    'config/shops.lua',
    'config/mines.lua',
    'config/processing.lua',

    --inventory--
    'inventory/server.lua',

    --vehicles--
    'vehicles/server.lua',

    --bank--
    'bank/server.lua',

    --time--
    'time/server.lua',

    'player/server.lua'
}

dependencies = {
    "mysql-async",
    'skinchanger',
    'hc_clothing'
}

