ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
SERVICE_REQUEST = {}
local Job = module(GetCurrentResourceName(), 'server/job')()
local Request = module(GetCurrentResourceName(), 'server/request')
REQUESTERS = {}
Job:setRequestMessages(Config.Jobs)

AddEventHandler('esx_request_service:requestService', function(playerId, jobName, cb)
    
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local playersInService = Job:getPlayersInServiceByJob(jobName)

    local job = Job:getJob(jobName)

    if #playersInService < 1 then
        cb(job.jobConfig.haveNobodyInService)
    end

    local service = Request(playersInService, job, playerId)

        -- Inserindo request na tabela
        SERVICE_REQUEST[service.request.id] = service.request
        -- Disparando informações para os clientes das pessoas de serviço
        service:sendRequest(service.request)
end)


RegisterCommand('service', function(source, args, rawCommand)
    -- Anti flood verificando os arrombados que ficam flodando com comandos
    if REQUESTERS[source] == true  then

        TriggerClientEvent('chat:addMessage', source, {
            args = {
                'Antiflood:',
                'Wait to get new service'
            },
            color = { 5, 255, 255 }
        })
        
        ESX.SetTimeout(5000, function()
            REQUESTERS[source] = false
        end)
        
        return
    end

    -- Setando o anti flood
    REQUESTERS[source] = true

    if(args[1] == nil) then
        TriggerClientEvent('chat:addMessage', source, {
            args = {
                GetPlayerName(source),
                'Service is required!'
            },
            color = { 5, 255, 255 }
        })
        return
    end

    TriggerEvent('esx_request_service:requestService', source, args[1], function(status)
        print(status)
    end)


end)


ESX.RegisterServerCallback('esx_request_service:acceptService', function(playerId, cb, requestId)
    
    local request = SERVICE_REQUEST[requestId]
    if request == nil then
        TriggerClientEvent('chat:addMessage', playerId, {
            args = {
                GetPlayerName(playerId),
                'Esse chamado já foi atendido'
            },
            color = { 5, 255, 255 }
        })
        return 
    end

    local xPlayer = ESX.GetPlayerFromId(playerId)
    -- Early return to unemployed players
    if xPlayer.getJob == 'unemployed' then return end

    if not xPlayer.getJob == request.job then
        TriggerClientEvent('chat:addMessage', playerId, {
            args = {
                GetPlayerName(playerId),
                'You are not allowed to get this service'
            },
            color = { 5, 255, 255 }
        })

        return
    end

    if request ~= nil then
        request.receiver = playerId

        -- Puxa as informações do player solicitante e envia callback
        local xPlayerRequester = ESX.GetPlayerFromId(request.requester)
        xPlayerRequester.triggerEvent('esx_request_service:SendCallbackToRequester')

        -- Puxa posição atual do player solicitante e envia para o receiver para setar o job
        local position = xPlayerRequester.getCoords(true)

        xPlayer.triggerEvent('esx_request_service:SetService', position)

        SERVICE_REQUEST[requestId] = nil

        cb({
            success = true
        })
    end
end)


