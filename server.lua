ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem("radio", function(source, item)
    TriggerClientEvent('qb-radio:use', source)
end)

ESX.RegisterServerCallback('qb-radio:server:GetItem', function(source, cb, item)
    local src = source
    local Player = ESX.GetPlayerFromId(src)
    if Player ~= nil then
        local RadioItem = Player.Functions.GetItemByName(item)
        if RadioItem ~= nil and not Player.PlayerData.metadata["isdead"] and
            not Player.PlayerData.metadata["inlaststand"] then
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

for channel, config in pairs(Config.RestrictedChannels) do
    exports['pma-voice']:addChannelCheck(channel, function(source)
        local Player = ESX.GetPlayerFromId(source)
        return config[Player.PlayerData.job.name] and Player.PlayerData.job.onduty
    end)
end
