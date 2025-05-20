local QBCore = exports['qb-core']:GetCoreObject()

local function IsJobAllowed(jobName)
    return Config.AllowedJobs[jobName] or false
end

CreateThread(function()
    while true do
        Wait(1500) -- Better performance
        local ped = PlayerPedId()
        if not IsPedInAnyVehicle(ped, false) then goto continue end
        local vehicle = GetVehiclePedIsIn(ped, false)
        if not vehicle or vehicle == 0 then goto continue end
        if Config.LockDoors and GetPedInVehicleSeat(vehicle, -1) == ped then
            SetVehicleDoorsLocked(vehicle, 2)
            if Config.Debug then print("[no_dragout] Vehículo bloqueado") end
        end
        local model = GetEntityModel(vehicle)
        local seatCount = GetVehicleModelNumberOfSeats(model)
        local playerData = QBCore.Functions.GetPlayerData()
        local jobName = playerData and playerData.job and playerData.job.name
        local allowed = jobName and IsJobAllowed(jobName)
        if not allowed then
            for seat = -1, seatCount - 2 do
                local seatPed = GetPedInVehicleSeat(vehicle, seat)
                if seatPed and seatPed ~= 0 then
                    SetPedCanBeDraggedOut(seatPed, false)
                    if Config.Debug then print("[no_dragout] Bloqueo de extracción en asiento", seat) end
                end
            end
        end
        ::continue::
    end
end)
