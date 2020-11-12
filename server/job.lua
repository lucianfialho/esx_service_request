local Class = module('esx_service_request', 'utils/class')
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Job = Class.new(function(self) 
    self.xPlayersByJob = {}
    self.jobs = ESX.Jobs
end)

function Job:getJob(jobName)
    print(json.encode(self.jobs[jobName]))
    return self.jobs[jobName]
end

function Job:setRequestMessages(jobConfig)
    
    for k,v in pairs(self.jobs) do
        if jobConfig[k] then
            self.jobs[k]["jobConfig"] = jobConfig[k]
        end
    end
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
