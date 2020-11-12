local Class = module(GetCurrentResourceName(), 'utils/class')

local Request = Class.new(function(self, xPlayersInService, job)
    self.playersInService = xPlayersInService
    self.message =  job
end)


function Request:sendRequest()
    for k, xPlayer in ipairs(self.playersInService) do
        xPlayer.triggerEvent('esx_request_service:SendRequesToPlayerInService')
    end
end

return Request

