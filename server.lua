ESX = nil


if Config.qbcore then
    local QBCore = exports[Config.FrameworkName]:GetCoreObject()

RegisterServerEvent('removeitemqb')
AddEventHandler('removeitemqb', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.RemoveItem(Config.RequiredItemName, Config.AmountOfItemToRemove)
end)

    QBCore.Functions.CreateUseableItem(Config.RequiredItemName, function(source)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
            -- Player.Functions.RemoveItem(Config.RequiredItemName, Config.AmountOfItemToRemove)
            TriggerClientEvent('ftz-darkwebdealer:usetablet', source)
    end)

end

if Config.esx then

TriggerEvent(Config.ESXObject, function(obj) ESX = obj end)

RegisterServerEvent('removeitemesx')
AddEventHandler('removeitemesx', function()
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(Config.RequiredItemName, Config.AmountOfItemToRemove)
end)


ESX.RegisterUsableItem(Config.RequiredItemName, function(source)

	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(Config.RequiredItemName, Config.AmountOfItemToRemove)

    TriggerClientEvent('ftz-darkwebdealer:usetablet', source)

end)

RegisterServerEvent('ftz-darkwebdealer:purchase')
AddEventHandler('ftz-darkwebdealer:purchase', function(itemName, amount, price, type)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	amount = ESX.Math.Round(amount)


		price = price * amount
	    -- can the player afford this item?
		if xPlayer.getMoney() >= price then
			-- can the player carry the said amount of x item?

			if xPlayer.canCarryItem(itemName, amount) then
				xPlayer.removeMoney(price)
                if type == "item" then
				xPlayer.addInventoryItem(itemName, amount)
                else
                xPlayer.addWeapon(itemName, 1)
                end
			else
				xPlayer.showNotification(Config.FullInventory)
			end
		else
			local missingMoney = price - xPlayer.getMoney()
			xPlayer.showNotification(Config.NotEnoughMoney, ESX.Math.GroupDigits(missingMoney))
		end



end)
end