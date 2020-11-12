ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Job = module(GetCurrentResourceName(), 'server/job')()
local Request = module(GetCurrentResourceName(), 'server/request')()

Job:setRequestMessages(Config.Jobs)

AddEventHandler('esx_request_service:requestService', function(playerId, jobName, cb)

    local xPlayer = ESX.GetPlayerFromId(playerId)
    local playersInService = Job:getPlayersInServiceByJob(jobName)
    
    if #playersInService < 1 then
        cb('Não existem médicos disponiveis no momento')
    end

    local job = Job:getJob(jobName)
    print(json.encode(playersInService), json.encode(job))
    local request = Request(playersInService, job)
        request:sendRequest()
end)


RegisterCommand("service", function(source, args, rawCommand)
    TriggerEvent('esx_request_service:requestService', source, args[1], function(status)
        print(status)
    end)
end)