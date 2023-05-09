local car = nil
local ESX = nil
local canstart = true
if Config.esx then
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.ESXObject, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)
end

if Config.qbcore then
local QBCore = exports[Config.FrameworkName]:GetCoreObject()
end

function isonroad()
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    if IsPedOnFoot(playerPed) then
        -- Get the street name at the player's location
        local streetName = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
    
        -- Check if the player is on a road and not in a crossing area
        if streetName ~= nil and IsPointOnRoad(playerCoords.x, playerCoords.y, playerCoords.z, playerPed) then
            return true
        else
            return false
        end
    end
end
function shownoti(minima)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(minima)
	EndTextCommandDisplayHelp(0, false, true, -1)
end



function createNPCDriver()
    -- --print('test')
   
    
        local model = GetHashKey(Config.vehiclename)
        RequestModel(model)
        while not HasModelLoaded(model) do
           Wait(1)
        end
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)

    

     if isonroad() then
        shownoti(Config.CalledNotification)
        -- Use GetSafeCoordForPed to find a safe coordinate near the random coordinate
        local nodeCoords, nodeHeading = GetClosestVehicleNodeWithHeading(playerCoords.x + 240 , playerCoords.y, playerCoords.z, 1, 3.0, 0)
        
        if nodeCoords ~= nil and nodeHeading ~= nil then
            spawnPoint = nodeCoords
            spawnHeading = nodeHeading
            nodeFound = true
        end
        -- --print(tosuecoords.x)
-- --print(spawnHeading)

        car = CreateVehicle(model, spawnHeading, true, false)
        SetVehicleOnGroundProperly(car)
        SetEntityAsMissionEntity(car, true, true)
        SetVehicleNumberPlateText(car, Config.carlicenseplate)

        SetVehicleOnGroundProperly(car)

        SetVehicleDoorsLocked(car, 2)
        SetVehicleEngineOn(car, true, true)
        SetVehicleUndriveable(car, true)
        SetVehicleTyresCanBurst(car, false)
        SetVehicleExtra(car, 1, true)


        RequestModel(GetHashKey(Config.npcmodel))
    
        while not HasModelLoaded(GetHashKey(Config.npcmodel)) do
           Wait(10)
        end
        npcDriver =  CreatePed('1', GetHashKey(Config.npcmodel), coordstousex, coordstousey , coordstousez, 90.0, true, false)
        SetEntityAsMissionEntity(npcDriver, true, true)
        SetPedKeepTask(npcDriver, true)
    
        -- Create the NPC driver vehicle
     
        SetEntityAsMissionEntity(car, true, true)
    
        -- Set the NPC driver as the driver of the vehicle
        SetPedIntoVehicle(npcDriver, car, -1)
    
        -- Set the vehicle to drive to the player's location
        TaskVehicleDriveToCoord(npcDriver, car, GetEntityCoords(PlayerPedId()), Config.CarSpeed, 1.0, GetHashKey(Config.vehiclename), Config.CarBehaviour, 10.0, true)
    else
        shownoti(Config.NotOnRoadNotification)
    end
end


RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        hide = true
    })
end)

RegisterNUICallback('start', function(data)

    SetNuiFocus(false, false)
    SendNUIMessage({
        hide = true
    })
    createNPCDriver()
end)

function startui()
    if isonroad() then
        if Config.qbcore then
        TriggerServerEvent("removeitemqb")
        else
        TriggerServerEvent("removeitemesx")
        end
        --print('test')
        SetNuiFocus(true, true)
        SendNUIMessage({
            hide = false
        })
    else
        shownoti(Config.NotOnRoadNotification)
    end
end

RegisterNetEvent('ftz-darkwebdealer:usetablet')
AddEventHandler('ftz-darkwebdealer:usetablet', function()
    if canstart and Config.UseCooldown then
        canstart = false
        startui()
        Citizen.SetTimeout(Config.TimeForCooldown, function()
            canstart = true
        end)
        elseif not Config.UseCooldown then
        startui()
    end
end)


RegisterCommand("testdriver", function()
    if canstart and Config.UseCooldown then
    canstart = false
    startui()
    Citizen.SetTimeout(Config.TimeForCooldown, function()
        canstart = true
    end)
    elseif not Config.UseCooldown then
    startui()
end
end)

-- draw the marker above the car
Citizen.CreateThread(function()
    while true do
        Wait(0)
                local coords = GetEntityCoords(car)
                if Config.drawmarker then
                DrawMarker(Config.marker.type, coords.x, coords.y, coords.z + 1.5, 0, 0, 0, 0, 0, 0, Config.marker.r, Config.marker.g, Config.marker.b, 10, 105, 0, 200, true, true, 2, nil, nil, true)
                end
                local playerPed = PlayerPedId()
                local vehicle = GetClosestVehicle(GetEntityCoords(playerPed), 5.0, 0, 71)
                local distance = #(GetEntityCoords(PlayerPedId()) - coords)
                if DoesEntityExist(vehicle) and distance < Config.DistanceOpen  then
          
                trunkPos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "boot"))
                shownoti(Config.Notification)
                
                
                if IsControlPressed(0, Config.OpenKey) then
                FreezeEntityPosition(playerPed, true)
                SetVehicleDoorsLockedForAllPlayers(vehicle, true)
                local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                SetCamActive(cam, true)
                SetCamCoord(cam, trunkPos.x +1, trunkPos.y , trunkPos.z + 0.4)
                SetCamRot(cam, -40.0, 0.0, 90.0)
                SetCamFov(cam, 100.0)
                SetCamActive(cam, true)
                RenderScriptCams(true, 400, 600, 300, 0)
                SetVehicleDoorOpen(car, 5, false, false)
                local ShopItems = {}
                ShopItems.label = Config.InventoryLabel
                ShopItems.items = Config.ItemsQB

                if Config.esx then
                    local elements = {}
                    for i=1, #ItemsESX, 1 do
                        local item = ItemsESX[i]
                
                        table.insert(elements, {
                            label      = item.label .. ' - <span style="color: green;">$' .. item.price .. '</span>',
                            label_real = item.label,
                            item       = item.item,
                            price      = item.price,
                
                            -- menu properties
                            value      = 1,
                            type       = 'slider',
                            min        = 1,
                            max        = 9999
                        })
                    end
                    ESX.UI.Menu.CloseAll()
                
                    ESX.UI.Menu.Open('default', GetCurrentResourceName(), Config.InventoryLabelESX, {
                        title    = Config.InventoryLabelESX,
                        align    = 'center',
                        elements = elements
                    }, function(data, menu)
                        TriggerServerEvent('esx_darkweb:buyItem', data.current.item, data.current.value, data.current.price , data.current.type)
				end, 'shop')
                end

                if Config.custominventory then
                    CustomBuyFunc()
                end
            
                if Config.qbcore then
                TriggerServerEvent("inventory:server:OpenInventory", "shop", "darkweb", ShopItems)
                end
                 end
                 
                 if IsControlPressed(0, Config.CloseKey) then
                    SetVehicleDoorsShut(vehicle,false)
                    SetVehicleDoorsLockedForAllPlayers(vehicle, true)
                    SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                    TaskVehicleDriveWander(npcDriver, vehicle, 10.0, 786603);
                    DestroyCam(cam, false)
                    RenderScriptCams(false, false, 1, true, true)
                    FreezeEntityPosition(playerPed, false)
                    Wait(Config.TimeToDeleteVehicle) --10000
                    DeleteVehicle(vehicle)
                    DeleteEntity(npcDriver)
                 end

        end
    end
end)