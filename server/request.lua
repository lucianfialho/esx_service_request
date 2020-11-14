local Class = module(GetCurrentResourceName(), 'utils/class')
local uuid = module(GetCurrentResourceName(), 'utils/uuid')

local Request = Class.new(function(self, xPlayersInService, job, requester)
    self.playersInService = xPlayersInService
    
    self.job =  job 
    
    self.request = {
        ['id'] = uuid(),
        ['job'] = job.name,
        ['requester'] = requester,
        ['receiver'] = false
    }
end)

function Request:sendRequest(request)
    local requestConfig = {
        ['title'] = self.job.jobConfig.title,
        ['message'] = self.job.jobConfig.messageRequest,
        ['icon'] = self.job.jobConfig.icon,
        ['requester'] = self.receiver
    }

    request['config'] = requestConfig
    print(json.encode(#self.playersInService, {indent = true}))

    for k, xPlayer in ipairs(self.playersInService) do
        xPlayer.triggerEvent('esx_request_service:SendRequesToPlayerInService', request)
    end
end

return Request