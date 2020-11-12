  
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_request_service:SendRequesToPlayerInService')
AddEventHandler('esx_request_service:SendRequesToPlayerInService', function()
    local PlayerPed = PlayerPedId()

    ESX.ShowNotification("asd")

end)