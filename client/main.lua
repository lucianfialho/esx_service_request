  
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


RegisterNetEvent('esx_request_service:SendRequesToPlayerInService')
AddEventHandler('esx_request_service:SendRequesToPlayerInService', function(request, requestConfig)
	local PlayerPed = PlayerPedId()
	
    SendNUIMessage({
		type = 'request',
		request = request,
		requestConfig = requestConfig
	})
	
	local disableKeyMapping = false
	
	Citizen.CreateThread( function()
		while not disableKeyMapping do
			Citizen.Wait(0)
			-- checks if "Y" has just been released
			if IsControlJustReleased(0--[[input group]],  246--[[control index]]) then
				ESX.TriggerServerCallback('esx_request_service:acceptService', function(status)
					if not status.success then ESX.ShowNotification('Demorou demais otário!')  end
					
					disableKeyMapping = true

					SendNUIMessage({
						type = 'remove',
						request = request
					})
				end, request.id)
			end
		end
		
	end)
end)


RegisterNetEvent('esx_request_service:SendCallbackToRequester')
AddEventHandler('esx_request_service:SendCallbackToRequester', function()
	
    ESX.ShowNotification("Seu pedido foi atendido com sucesso, aguarde alguns momentos")
	
end)


RegisterNetEvent('esx_request_service:SetService')
AddEventHandler('esx_request_service:SetService', function(position)
    SetNewWaypoint(position.x --[[ number ]], position.y --[[ number ]])
end)
