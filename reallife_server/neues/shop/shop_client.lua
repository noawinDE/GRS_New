shopItems = {}
itemCounter = 0
local itemFilePath = ":vio_stored_files/items.xml"

function setShopItemClientData (name,preis,text)
	itemCounter = itemCounter + 1
	shopItems[itemCounter] = {name = name, preis = preis, text=text}
end
addEvent ( "setShopItemClientData", true )
addEventHandler ( "setShopItemClientData", getRootElement(), setShopItemClientData )



function testData (player, cmd, id)
	local id = tonumber(id)
	prinnt(id)
	print(shopItems[id].name)
	print(shopItems[id].preis)
	print(shopItems[id].text)
end
addCommandHandler("td",testData)
--[[
shopItems = {}
shopItems[1] = {name = "Paket 1", preis = "5", text="Paket I-Features\n\n-Premium Bronze für 30 Tage\n-1 Premiumfahrzeug\n-Status und Nummer monatlich änderbar\n-50% mehr Geld im Payday"}
shopItems[2] = {name = "Paket 2", preis = "10", text="Paket II-Features\n\n-Premium Silber für 30 Tage\n-3 Premiumfahrzeug\n-Status und Nummer jede 3. Woche änderbar\n-100% mehr Geld im Payday\n-2% Zivizeitreduktion"}
shopItems[3] = {name = "Paket 3", preis = "15", text="Paket III-Features\n\n-Premium Gold für 30 Tage\n-5 Premiumfahrzeug\n-Status und Nummer jede 2. Woche änderbar\n-150% mehr Geld im Payday\n-5% Zivizeitreduktion"}
shopItems[4] = {name = "Paket 4", preis = "20", text="Paket IV-Features\n\n-Premium Platin für 30 Tage\n-7 Premiumfahrzeug\n-Status und Nummer jede Woche änderbar\n-200% mehr Geld im Payday\n-7% Zivizeitreduktion"}

shopItems[1].values = {}
shopItems[1].values = {["PremiumData"]=100000, ["PremiumCars"]=2 }
shopItems[2].values = {["PremiumData"]=200000, ["PremiumCars"]=3 }

local number = 2
for var, val in pairs(shopItems[number].values) do 
	print( var, val )
end
--]]


-- Item Warenkorb
function findItemOrdes ()
	itemFile = xmlLoadFile ( itemFilePath )
	if itemFile then
		-- Items durchgehen ob vorhanden
		 local itemsNow = xmlNodeGetChildren(itemFile, 1) 
		 for i,node in ipairs(item) do              
			local itemNum = xmlNodeGetName(node)  
			print(node)
			--if shopItems[itemNum] then
			--	print("Item "..itemNum.." ("..shopItems[itemNum].name..") ist da.")
		--	end
         end
	else
		print("File net da")
		itemFile = xmlCreateFile(itemFilePath,"shopping_cart")
		xmlNodeSetValue (xmlCreateChild ( itemFile, "last_update"), "Heute" )
		local items = xmlCreateChild ( itemFile, "Items" )
		xmlNodeSetValue (xmlCreateChild ( items, shopItems[1].name), 2 )
		xmlSaveFile(itemFile)
		xmlUnloadFile(itemFile)
	end
end
findItemOrdes ()