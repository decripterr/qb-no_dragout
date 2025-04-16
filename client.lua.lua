local QBCore = exports['qb-core']:GetCoreObject()

-- Utility to check if the player has an allowed job
local function IsJobAllowed()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.job then return false end

    return Config.AllowedJobs[playerData.job.name] or false
end

-- Disable being dragged out of vehicle
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local ped = PlayerPedId()

        if IsPedInAnyVehicle(ped, false) then
            local vehicle = GetVehiclePedIsIn(ped, false)

            if Config.LockDoors and GetPedInVehicleSeat(vehicle, -1) == ped then
                SetVehicleDoorsLocked(vehicle, 2)
                if Config.Debug then print("[no_dragout] Vehicle doors locked") end
            end

            local seats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle))
            for i = -1, seats - 2 do
                local seatPed = GetPedInVehicleSeat(vehicle, i)
                if seatPed and seatPed ~= 0 then
                    if not IsJobAllowed() then
                        SetPedCanBeDraggedOut(seatPed, false)
                        if Config.Debug then print("[no_dragout] Prevented drag out for seat", i) end
                    end
                end
            end
        end
    end
end)
