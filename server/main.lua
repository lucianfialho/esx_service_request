ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Job = module(GetCurrentResourceName(), 'server/job')()
local Request = module(GetCurrentResourceName(), 'server/request')

Job:setRequestMessages(Config.Jobs)

AddEventHandler('esx_request_service:requestService', function(playerId, jobName, cb)
    
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local playersInService = Job:getPlayersInServiceByJob(jobName)
    local job = Job:getJob(jobName)

    if #playersInService < 1 then
        cb(job.jobConfig.haveNobodyInService)
    end

    local request = Request(playersInService, job)
        request:sendRequest()
end)


RegisterCommand('service', function(source, args, rawCommand)
    if(args[1] == nil) then
        TriggerClientEvent('chat:addMessage', -1, {
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