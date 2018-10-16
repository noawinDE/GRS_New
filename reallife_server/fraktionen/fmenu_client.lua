-- fraktionsNamen

FrakiGui = {
    tab = {},
    label = {},
    tabpanel = {},
    edit = {},
    gridlist = {},
    window = {},
    button = {},
    memo = {}
}
lastText = {}
memberlist = {}
vehiclelist = {}
warnlist = {}
loglist = {}
cityabk = {
["San Fierro"] = ", SF",
["Los Santos"] = ", LS",
["Las Venturas"] = ", LV",
["Whetstone"] = ", WS",
["Flint Count"] = ", FC",
["Red Country"] = ", RC"
}


function openFraktionMenu ()
if getElementClicked() == false then
	showCursor(true)
	local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
	local rang = tonumber ( getElementData ( lp, "rang" ) )
	if rang == 4 then
		rang = "Co-Leader (4)"
    end
    if rang == 5 then
        rang = "Leader (5)"
    end
	setElementClicked ( true )
	FrakiGui.window[1] = guiCreateWindow(0.35, 0.28, 0.31, 0.45, "", true)
    guiWindowSetMovable(FrakiGui.window[1], false)
    guiWindowSetSizable(FrakiGui.window[1], false)
	close = guiCreateButton(0.93, 0.05, 0.05, 0.05, "X", true, FrakiGui.window[1])    
    FrakiGui.tabpanel[1] = guiCreateTabPanel(0.02, 0.07, 0.96, 0.92, true, FrakiGui.window[1])
 
    FrakiGui.tab[1] = guiCreateTab("Übersicht", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[1] = guiCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[1])
    membersname = guiGridListAddColumn(FrakiGui.gridlist[1], "Name", 0.3)
    membersrang = guiGridListAddColumn(FrakiGui.gridlist[1], "Rang", 0.3)
    membersstatus = guiGridListAddColumn(FrakiGui.gridlist[1], "Letzter Login", 0.3)
  --  memberswarns = guiGridListAddColumn(FrakiGui.gridlist[1], "Verwarnungen", 0.2)
    FrakiGui.label[1] = guiCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[1])
    FrakiGui.button[1] = guiCreateButton(0.74, 0.11, 0.14, 0.09, "Rang setzen", true, FrakiGui.tab[1])
    FrakiGui.edit[1] = guiCreateEdit(0.90, 0.11, 0.08, 0.08, "", true, FrakiGui.tab[1])
    FrakiGui.button[2] = guiCreateButton(0.74, 0.21, 0.24, 0.09, "Uninviten", true, FrakiGui.tab[1])
    FrakiGui.button[3] = guiCreateButton(0.74, 0.32, 0.24, 0.09, "Verwarnen", true, FrakiGui.tab[1])
    FrakiGui.edit[2] = guiCreateEdit(0.74, 0.42, 0.24, 0.08, "Grund", true, FrakiGui.tab[1])
    FrakiGui.edit[3] = guiCreateEdit(0.74, 0.53, 0.24, 0.08, "Zeit in Tagen (0=un.)", true, FrakiGui.tab[1])
    FrakiGui.label[2] = guiCreateLabel(0.74, 0.62, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[1])
    FrakiGui.button[4] = guiCreateButton(0.74, 0.67, 0.24, 0.09, "Inviten", true, FrakiGui.tab[1])
    FrakiGui.edit[4] = guiCreateEdit(0.74, 0.78, 0.24, 0.08, "Name", true, FrakiGui.tab[1])
    FrakiGui.button[5] = guiCreateButton(0.74, 0.89, 0.24, 0.09, "Aktualisieren", true, FrakiGui.tab[1])
    FrakiGui.label[3] = guiCreateLabel(0.74, 0.85, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[1])

    FrakiGui.tab[2] = guiCreateTab("Fahrzeuge", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[2] = guiCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[2])
	
	
	vehiclesid =  guiGridListAddColumn(FrakiGui.gridlist[2], "ID", 0.2)
    vehiclesveh =  guiGridListAddColumn(FrakiGui.gridlist[2], "Fahrzeug", 0.2)
    vehiclesrang =  guiGridListAddColumn(FrakiGui.gridlist[2], "Rang", 0.2)
    vehiclesgps =  guiGridListAddColumn(FrakiGui.gridlist[2], "Ort", 0.3)
	
    FrakiGui.label[4] = guiCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[2])
    FrakiGui.button[6] = guiCreateButton(0.74, 0.11, 0.14, 0.09, "Rang setzen", true, FrakiGui.tab[2])
    FrakiGui.edit[5] = guiCreateEdit(0.90, 0.11, 0.08, 0.08, "", true, FrakiGui.tab[2])
    FrakiGui.button[7] = guiCreateButton(0.74, 0.21, 0.24, 0.09, "Orten", true, FrakiGui.tab[2])
    FrakiGui.button[8] = guiCreateButton(0.74, 0.32, 0.24, 0.09, "Verkaufen", true, FrakiGui.tab[2])
    FrakiGui.label[5] = guiCreateLabel(0.74, 0.85, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[2])
    FrakiGui.button[9] = guiCreateButton(0.74, 0.89, 0.24, 0.09, "Fahrzeuge kaufen", true, FrakiGui.tab[2])

    FrakiGui.tab[3] = guiCreateTab("Notiz", FrakiGui.tabpanel[1])

    FrakiGui.button[10] = guiCreateButton(0.02, 0.89, 0.20, 0.09, "Bearbeiten", true, FrakiGui.tab[3])
    FrakiGui.button[11] = guiCreateButton(0.78, 0.89, 0.20, 0.09, "Speichern", true, FrakiGui.tab[3])
    FrakiGui.memo[1] = guiCreateMemo(0.02, 0.02, 0.97, 0.85, "", true, FrakiGui.tab[3])
    FrakiGui.button[12] = guiCreateButton(0.40, 0.89, 0.20, 0.09, "Löschen", true, FrakiGui.tab[3])

    FrakiGui.tab[4] = guiCreateTab("Verwarnungen", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[3] = guiCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[4])
    warnsid = guiGridListAddColumn(FrakiGui.gridlist[3], "ID", 0.2)
    warnsname = guiGridListAddColumn(FrakiGui.gridlist[3], "Name", 0.2)
    warnsreason = guiGridListAddColumn(FrakiGui.gridlist[3], "Grund", 0.2)
	warnsexpiration = guiGridListAddColumn(FrakiGui.gridlist[3], "Ablaufzeitpunkt", 0.3)
	
    FrakiGui.label[6] = guiCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[4])
    FrakiGui.button[13] = guiCreateButton(0.74, 0.11, 0.24, 0.09, "Löschen", true, FrakiGui.tab[4])
    FrakiGui.label[7] = guiCreateLabel(0.73, 0.90, 0.24, 0.08, "----------------------------------\nVerwarnen -> Übersicht", true, FrakiGui.tab[4])

    FrakiGui.tab[5] = guiCreateTab("Log", FrakiGui.tabpanel[1])

	logtext = guiCreateMemo(0.02, 0.01, 0.96, 0.80,"",true,FrakiGui.tab[5])
	guiGridListClear (FrakiGui.gridlist[3])
	guiGridListClear (FrakiGui.gridlist[2])
	onlyAllowedButtons()
	refreshLog ()
	refreshMembers ()
	refreshVehicles ()
	refreshMemo ()
	refreshWarns ()
	guiSetInputEnabled ( false )
	guiMemoSetReadOnly( FrakiGui.memo[1], true )
	guiMemoSetReadOnly(logtext, true)
	addEventHandler("onClientGUIClick", close, function()
        guiSetVisible(FrakiGui.window[1], false)
        showCursor(false)
		setElementClicked ( false )
		guiSetInputEnabled ( true )
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[5], function()
			refreshMembers ()
			refreshVehicles ()
			refreshMemo ()
			refreshWarns ()
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[1], function()
        local name = guiGridListGetItemText(FrakiGui.gridlist[1], guiGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
		if name then
			local rang = tonumber(guiGetText(FrakiGui.edit[1]))
			triggerServerEvent("fraktionsMenu_setRang", getLocalPlayer(), name, rang)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[2], function()
		local name = guiGridListGetItemText(FrakiGui.gridlist[1], guiGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
		if name then
			triggerServerEvent("fraktionsMenu_uninvite", getLocalPlayer(), name)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[3], function()
        local name = guiGridListGetItemText(FrakiGui.gridlist[1], guiGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
        local time = tonumber(guiGetText(FrakiGui.edit[3]))
		local grund = guiGetText(FrakiGui.edit[2])
		if name then
			triggerServerEvent("fraktionsMenu_warn", getLocalPlayer(), name, time, grund)
			refreshMembers ()
		--	refreshWarns ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[4], function()
        local name = guiGetText(FrakiGui.edit[4])
		if name then
			triggerServerEvent("fraktionsMenu_invite", getLocalPlayer(), name)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[6], function()
        local id = guiGridListGetItemText(FrakiGui.gridlist[2], guiGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
		local carname = guiGridListGetItemText(FrakiGui.gridlist[2], guiGridListGetSelectedItem(FrakiGui.gridlist[2]), 2)
		if id then
			local rang = tonumber(guiGetText(FrakiGui.edit[5]))
			triggerServerEvent("fraktionsMenu_setCarRang", getLocalPlayer(), id, rang, carname )
			refreshVehicles ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[7], function()
        local id = guiGridListGetItemText(FrakiGui.gridlist[2], guiGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
		if id then
			triggerServerEvent("fraktionsMenu_orten", getLocalPlayer(), id )
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[10], function()
		if guiGetText(FrakiGui.button[10]) == "Bearbeiten" then
			lastText[FrakiGui.memo[1]] = guiGetText(FrakiGui.memo[1])
			guiMemoSetReadOnly( FrakiGui.memo[1], false )
			guiSetEnabled(FrakiGui.button[11], true)
			guiSetText(FrakiGui.button[10],"Abbrechen")
		else
			guiMemoSetReadOnly( FrakiGui.memo[1], true )
			guiSetEnabled(FrakiGui.button[11], false)
			guiSetText(FrakiGui.button[10],"Bearbeiten")
			guiSetText(FrakiGui.memo[1],"")
			guiSetText(FrakiGui.memo[1],lastText[FrakiGui.memo[1]])
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[11], function()
		
			triggerServerEvent("setMemo", getLocalPlayer(), guiGetText(FrakiGui.memo[1]))
			guiMemoSetReadOnly( FrakiGui.memo[1], true )
			guiSetEnabled(FrakiGui.button[11], false)
			guiSetText(FrakiGui.button[10],"Bearbeiten")
			lastText[FrakiGui.memo[1]] = nil
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[13], function()
		
		
        local id = guiGridListGetItemText(FrakiGui.gridlist[3], guiGridListGetSelectedItem(FrakiGui.gridlist[3]), 1)
		if id then
			
			triggerServerEvent("fraktionsMenu_deleteWarn", getLocalPlayer(), id )
			refreshWarns ()
		end
    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[9], function()
			guiSetVisible(FrakiGui.window[1], false)
			showFactionCarBuyPanel ()

    end, false)
	
	addEventHandler("onClientGUIClick", FrakiGui.button[8], function()
			local id = guiGridListGetItemText(FrakiGui.gridlist[2], guiGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
			local carname = guiGridListGetItemText(FrakiGui.gridlist[2], guiGridListGetSelectedItem(FrakiGui.gridlist[2]), 2)
			if id then

				triggerServerEvent("fraktionsMenu_sellCar", getLocalPlayer(), id, carname )
				refreshVehicles ()
				
		end

    end, false)
	end
end
addEvent( "openFraktionMenu", true )
addEventHandler( "openFraktionMenu", getRootElement(), openFraktionMenu )


function refreshMemo ()
	guiSetText(FrakiGui.memo[1],"")
	triggerServerEvent("loadMemo",getRootElement(),getLocalPlayer())
end

function refreshLog ()
	guiSetText(logtext,"")
	triggerServerEvent("loadLog",getRootElement(),getLocalPlayer())

end


function refreshVehicles ()
	guiGridListClear (FrakiGui.gridlist[2])
	triggerServerEvent("loadFraktionVehicles",getRootElement(),getLocalPlayer())
end

function refreshMembers ()
	guiGridListClear (FrakiGui.gridlist[1])
	triggerServerEvent("loadFraktionMember",getRootElement(),getLocalPlayer())
end

function refreshWarns ()
	guiGridListClear (FrakiGui.gridlist[3])
	triggerServerEvent("loadWarns",getRootElement(),getLocalPlayer())
end

function onlyAllowedButtons()
	local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
	local rang = tonumber ( getElementData ( lp, "rang" ) )
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[1], true)
	else
		guiSetEnabled(FrakiGui.button[1], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[2], true)
	else
		guiSetEnabled(FrakiGui.button[2], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[3], true)
	else
		guiSetEnabled(FrakiGui.button[3], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[4], true)
	else
		guiSetEnabled(FrakiGui.button[4], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[8], true)
	else
		guiSetEnabled(FrakiGui.button[8], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[6], true)
	else
		guiSetEnabled(FrakiGui.button[6], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[9], true)
	else
		guiSetEnabled(FrakiGui.button[9], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[10], true)
	else
		guiSetEnabled(FrakiGui.button[10], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[11], false)
	else
		guiSetEnabled(FrakiGui.button[11], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.button[12], true)
	else
		guiSetEnabled(FrakiGui.button[12], false)
	end
	if rang >= 4 then
		guiSetEnabled(FrakiGui.tab[5], true)
	else
		guiSetEnabled(FrakiGui.tab[5], false)
	end
end

function loadLog (text)

	
	guiSetText(logtext,text)
	
	
end
addEvent( "loadLog", true )
addEventHandler( "loadLog", getRootElement(), loadLog )

function loadFraktionMember (name, rang, status)
	
	memberlist[name] = guiGridListAddRow(FrakiGui.gridlist[1])
	guiGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersname, name, false, false)
	guiGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersrang, rang, false, true)
	if status == "on" then
		guiGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersstatus, "Online", false, true)
		guiGridListSetItemColor ( FrakiGui.gridlist[1], memberlist[name], membersstatus, 75,242,24 )
	else
		guiGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersstatus, getData(status), false, true)
		guiGridListSetItemColor ( FrakiGui.gridlist[1], memberlist[name], membersstatus, 250,19,19 )
	end

	
end
addEvent( "loadFraktionMember", true )
addEventHandler( "loadFraktionMember", getRootElement(), loadFraktionMember )

function loadFraktionVehicles (id, model, Rang, Level, SX, SY, SZ, SXR, SYR, SZR)

	local zone = getZoneName ( SX, SY, SZ )
	local city = getZoneName ( SX, SY, SZ, true )
	local location = zone..(cityabk[city] or "")
	vehiclelist[id] = guiGridListAddRow(FrakiGui.gridlist[2])
	
	guiGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesid, id, false, false)
	guiGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesveh, getVehicleNameFromModel(model), false, false)
	guiGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesrang, Rang, false, true)
	guiGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesgps, location, false, true)
	
end
addEvent( "loadFraktionVehicles", true )
addEventHandler( "loadFraktionVehicles", getRootElement(), loadFraktionVehicles )

function loadWarns (id, name, reason, ExpirationDate, Expiration)

	

	warnlist[id] = guiGridListAddRow(FrakiGui.gridlist[3])
	
	guiGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsid, id, false, false)
	guiGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsname, name, false, false)
	guiGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsreason, reason, false, true)
	if tonumber(Expiration) == 0 then
		guiGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsexpiration, getData (ExpirationDate), false, true)
	else
		guiGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsexpiration, "Abgelaufen", false, true)
		guiGridListSetItemColor ( FrakiGui.gridlist[3], warnlist[id], warnsexpiration, 250,19,19 )
	end
	

	
end
addEvent( "loadWarns", true )
addEventHandler( "loadWarns", getRootElement(), loadWarns )

function setMemo (text)

	guiSetText(FrakiGui.memo[1],text)
end
addEvent( "setMemo", true )
addEventHandler( "setMemo", getRootElement(), setMemo )