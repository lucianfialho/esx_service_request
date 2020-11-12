local Class = module('esx_service_request', 'utils/class')
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Job = Class.new(function(self) 
    self.xPlayersByJob = {}
    self.jobs = ESX.Jobs
end)

function Job:getJob(jobName)
    return self.jobs[jobName]
end

function Job:setRequestMessages(jobConfig)
    print(json.encode(jobConfig['ambulance']), "asd")
    for k,v in pairs(self.jobs) do
        if jobConfig[k] then
            print(json.encode(self.jobs[k]))
            table.insert(self.jobs[k], jobConfig[k][1])
        end
    end

    -- print(json.encode(self.jobs))
end

function Job:getPlayersInServiceByJob(jobName)

    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
        if xPlayer.getJob() == jobName then
            table.insert( self.xPlayersByJob, xPlayer )
        end
    end

    return self.xPlayersByJob
end


return Job
