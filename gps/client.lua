ESX = exports["es_extended"]:getSharedObject()
local minimapEnabled = false
local lastGPSState = nil
local hasGPS, hasGPS2 = false, false

RegisterNetEvent('gps:checkItem')
AddEventHandler('gps:checkItem', function(gps, gps2)
    hasGPS, hasGPS2 = gps, gps2
    
    if lastGPSState ~= (hasGPS or hasGPS2) then
        minimapEnabled = hasGPS or hasGPS2
        DisplayRadar(minimapEnabled)
        
        if hasGPS and not hasGPS2 then
            ESX.ShowNotification("Votre GPS est activé, mais il semble en mauvais état. ~n~ Procurez-vous un meilleur GPS.", 'info', 3000)

        elseif hasGPS2 then
            ESX.ShowNotification("Vous avez activé un GPS de meilleure qualité.", 'info', 3000)
        elseif not hasGPS and not hasGPS2 then
            ESX.ShowNotification("Vous n'avez pas de GPS active", 'info', 3000)
        end
        
        lastGPSState = hasGPS or hasGPS2
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000) -- Vérification toutes les 5 secondes
        TriggerServerEvent('gps:requestCheck')
    end
end)

-- Effet de GPS de mauvaise qualité
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.GPSInterferenceTime)
        
        if hasGPS and not hasGPS2 then
            ESX.ShowNotification("Le GPS rencontre des interférences...", 'info', 3000)
            DisplayRadar(false)
            Citizen.Wait(math.random(Config.GPSInterferenceDurationMin, Config.GPSInterferenceDurationMax)) -- Clignotement rapide
            DisplayRadar(true)
        end
    end
end)
