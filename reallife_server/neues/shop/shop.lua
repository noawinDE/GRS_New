-- Pakete in den Clientfiles

shopItems = {}
shopItems = {}
shopItems[1] = {name = "Paket 1", preis = "5", text="Paket I-Features\n\n-Premium Bronze für 30 Tage\n-1 Premiumfahrzeug\n-Status und Nummer monatlich änderbar\n-50% mehr Geld im Payday"}
shopItems[2] = {name = "Paket 2", preis = "10", text="Paket II-Features\n\n-Premium Silber für 30 Tage\n-3 Premiumfahrzeug\n-Status und Nummer jede 3. Woche änderbar\n-100% mehr Geld im Payday\n-2% Zivizeitreduktion"}
shopItems[3] = {name = "Paket 3", preis = "15", text="Paket III-Features\n\n-Premium Gold für 30 Tage\n-5 Premiumfahrzeug\n-Status und Nummer jede 2. Woche änderbar\n-150% mehr Geld im Payday\n-5% Zivizeitreduktion"}
shopItems[4] = {name = "Paket 4", preis = "20", text="Paket IV-Features\n\n-Premium Platin für 30 Tage\n-7 Premiumfahrzeug\n-Status und Nummer jede Woche änderbar\n-200% mehr Geld im Payday\n-7% Zivizeitreduktion"}

shopItems[1].values = {}
shopItems[1].values = {["PremiumData"]=100000, ["PremiumCars"]=2 }
shopItems[2].values = {["PremiumData"]=200000, ["PremiumCars"]=3 }


function intShop (player)
	for i, var in pairs(shopItems) do 
		triggerClientEvent ( player, "setShopItemClientData", getRootElement(), var.name, var.preis, var.text )
	end
end

--[[
local number = 2
for var, val in pairs(shopItems[number].values) do 
	print( var, val )
end--]]