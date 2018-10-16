
GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
buyablevehlist = {}

function showFactionCarBuyPanel ()
        GUIEditor.window[1] = guiCreateWindow(0.38, 0.27, 0.25, 0.45, "Fraktions-Fahrzeuge kaufen", true)
        guiWindowSetMovable(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.gridlist[1] = guiCreateGridList(0.02, 0.05, 0.57, 0.93, true, GUIEditor.window[1])
       buyablevehsid = guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.3)
        buyablevehsmodel = guiGridListAddColumn(GUIEditor.gridlist[1], "Fahrzeug", 0.3)
        buyablevehspreis = guiGridListAddColumn(GUIEditor.gridlist[1], "Preis", 0.3)
        GUIEditor.label[1] = guiCreateLabel(0.63, 0.05, 0.35, 0.06, "      Fahrzeuginformationen\n-------------------------------------------", true, GUIEditor.window[1])
        infos = guiCreateLabel(0.63, 0.11, 0.35, 0.17, "Kosten:\n\nGeschwindichkeit:\n\nSitzplätze:\n-------------------------------------------", true, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[2], "clear-normal")
        GUIEditor.button[1] = guiCreateButton(0.63, 0.30, 0.35, 0.08, "Fahrzeug kaufen", true, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(0.63, 0.90, 0.35, 0.08, "Zurück", true, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(0.63, 0.86, 0.35, 0.03, "-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(0.63, 0.43, 0.35, 0.06, "            Administration\n-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(0.63, 0.39, 0.35, 0.03, "-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(0.63, 0.51, 0.35, 0.08, "Fahrzeug erstellen", true, GUIEditor.window[1])
        GUIEditor.edit[1] = guiCreateEdit(0.63, 0.60, 0.16, 0.07, "Modell", true, GUIEditor.window[1])
        GUIEditor.edit[2] = guiCreateEdit(0.81, 0.60, 0.16, 0.07, "Preis", true, GUIEditor.window[1])
        GUIEditor.edit[3] = guiCreateEdit(0.72, 0.67, 0.16, 0.07, "Fraktion", true, GUIEditor.window[1])
        GUIEditor.button[4] = guiCreateButton(0.63, 0.76, 0.35, 0.08, "Ausgewähltes\nlöschen", true, GUIEditor.window[1])    
		refreshBuyableVehs ()
		setButtonsRights()
		addEventHandler("onClientGUIClick", GUIEditor.gridlist[1], SubmitGridClickFVEH, true)
		addEventHandler("onClientGUIClick", GUIEditor.button[2], function()
			guiSetVisible(GUIEditor.window[1], false)
			setElementClicked ( false )
			openFraktionMenu ()
    end, false)
		addEventHandler("onClientGUIClick", GUIEditor.button[3], function()
			local model = guiGetText(GUIEditor.edit[1])
			local price = guiGetText(GUIEditor.edit[2])
			local faction = guiGetText(GUIEditor.edit[3])
			triggerServerEvent("makeNewBuyableCar",getRootElement(),getLocalPlayer(), model, price, faction)
			refreshBuyableVehs ()
    end, false)

	addEventHandler("onClientGUIClick",  GUIEditor.button[1], function()
			local model = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1]), 2 )
			local price = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1]), 3 )
			triggerServerEvent("buyNewFactionCar",getRootElement(),getLocalPlayer(), model, price)
    end, false)
	
	addEventHandler("onClientGUIClick",  GUIEditor.button[4], function()
			local id = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1]), 1 )
			triggerServerEvent("deleteBuyableCar",getRootElement(),getLocalPlayer(), id)
			refreshBuyableVehs ()
    end, false)
	
    end


function setButtonsRights()
	local adminlvl = getElementData (lp, "adminlvlShow")
	if adminlvl >= 7 then
		guiSetEnabled(GUIEditor.button[3], true)
		guiSetEnabled(GUIEditor.button[4], true)
	else
		guiSetEnabled(GUIEditor.button[3], false)
		guiSetEnabled(GUIEditor.button[4], false)
	end
end

function SubmitGridClickFVEH( button )

	if button == "left" then
		local model = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1]), 2 )
		local prize = guiGridListGetItemText ( GUIEditor.gridlist[1], guiGridListGetSelectedItem ( GUIEditor.gridlist[1]), 3 )
		--local geschw = tonumber ( getVehicleHandling(getVehicleModelFromName(model),"maxVelocity" )
	--	local seats = tonumber ( getVehicleMaxPassengers(getVehicleModelFromName(model) )
		local geschw = 1
		local seats = 1
		guiSetText(infos,"Kosten: "..prize.." $\n\nGeschwindichkeit: N.a\n\nSitzplätze: N.a\n-------------------------------------------")
		
	end
end
	
function refreshBuyableVehs ()
	guiGridListClear (GUIEditor.gridlist[1])
	triggerServerEvent("loadBuyableCars",getRootElement(),getLocalPlayer())
end

function loadBuyableCars (id, model, price)

	

	buyablevehlist[id] = guiGridListAddRow(GUIEditor.gridlist[1])
	
	guiGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id], buyablevehsid, id, false, false)
	guiGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id],  buyablevehsmodel, getVehicleNameFromModel(model), false, false)
	guiGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id], buyablevehspreis, price, false, false)

	

	
end
addEvent( "loadBuyableCars", true )
addEventHandler( "loadBuyableCars", getRootElement(), loadBuyableCars )