ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('gps:requestCheck')
AddEventHandler('gps:requestCheck', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local itemGPS = xPlayer.getInventoryItem(Config.GPSItem)
        local itemGPS2 = xPlayer.getInventoryItem(Config.GPSItem2)
        
        local hasGPS = (itemGPS and itemGPS.count > 0)
        local hasGPS2 = (itemGPS2 and itemGPS2.count > 0)
        
        TriggerClientEvent('gps:checkItem', _source, hasGPS, hasGPS2)
    end
end)