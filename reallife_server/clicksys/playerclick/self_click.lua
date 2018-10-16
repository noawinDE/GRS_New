local resourceName = getResourceName(getThisResource())
local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
local dr,dg,db, sdr, sdg, sdb, cdr, cdg, cdb = 0, 84, 5, 4, 170, 4, 17, 153, 7 -- Wenn es AN ist
local ar,ag,ab, sar, sag, sab, car, cag, cab = 95, 96, 96, 13, 112, 6, 168, 173, 173 -- Wenn es AUS ist
local oneTabIsOpen = false
local clickFixer = false
local itemText = {}

function showSelfMenu ()
--    self = DGS:dgsDxCreateWindow(787*sx, 0*sy, 346*sx, 108*sy, "", false)
	self = DGS:dgsDxCreateWindow(787*sx, -75, 346*sx, 108*sy, "", false)
	DGS:dgsMoveTo(self,787, 0,false,false,"OutQuad",500)
	DGS:dgsDxWindowSetMovable ( self, false )
    DGS:dgsDxWindowSetSizable ( self, false )

    local info = DGS:dgsDxCreateImage(24*sx, (30-23)*sy, 62*sx, 66*sy, ":reallife_server/images/self/info.png", false, self)
    local settings = DGS:dgsDxCreateImage(100*sx, (30-23)*sy, 73*sx, 68*sy, ":reallife_server/images/self/settings.png", false, self)
    local admin = DGS:dgsDxCreateImage(260*sx, (30-23)*sy, 62*sx, 66*sy, ":reallife_server/images/self/admin.png", false, self)
    local shop = DGS:dgsDxCreateImage(187*sx, (30-23)*sy, 62*sx, 66*sy, ":reallife_server/images/self/shop.png", false, self)
    setElementClicked ( true )
    showCursor(true)

    -- // Events //
    addEventHandler("onClientDgsDxWindowClose", self,closeSelfMenu)
    addEventHandler ( "onClientDgsDxMouseClick", info, showInfoWindow )
    addEventHandler ( "onClientDgsDxMouseClick", settings,  showSettingsWindow )
	addEventHandler ( "onClientDgsDxMouseClick", shop,  showShopWindow )
	

end
addEvent ( "ShowSelfClickMenue", true)
addEventHandler ( "ShowSelfClickMenue", getLocalPlayer(),  showSelfMenu)

function closeSelfMenu ()
    setElementClicked ( false )
    showCursor(false)

end

function oneTabClose ()
    oneTabIsOpen = false
	DGS:dgsDxWindowSetCloseButtonEnabled(self, true)
	if source == infoWindow then
		killTimer(refreshBar)
	end
	if shopDesc then
		DGS:dgsDxGUICloseWindow(shopDesc)
		shopDesc = nil
	end
	if isTimer(autoUpdater) then
		killTimer(autoUpdater)
	end
end

function showInfoWindow ()
    if oneTabIsOpen == false then
		infoWindow = DGS:dgsDxCreateWindow(0.38, 0.12, 0.24, 0.33, "", true)
		DGS:dgsDxWindowSetMovable ( infoWindow, false )
		DGS:dgsDxWindowSetSizable ( infoWindow, false )
		DGS:dgsDxWindowSetCloseButtonEnabled(self, false)
        addEventHandler("onClientDgsDxWindowClose", infoWindow,oneTabClose)
        local infoTabMenuMain = DGS:dgsDxCreateTabPanel(0.03, 0.08, 0.95, 0.90, true, infoWindow)
        local infoTabMenuMainPlayer = DGS:dgsDxCreateTab("Informationen",infoTabMenuMain)
        oneTabIsOpen = true
        -- // Daten zeigen //
			local licenseState = {}
			licenseState[1] = {name = "Personalausweis", elementName = "perso"}
			licenseState[2] = {name = "Führerschein", elementName = "carlicense"}
			licenseState[3] = {name = "Motorradschein", elementName = "bikelicense"}
			licenseState[4] = {name = "Fischer-Schein", elementName = "fishinglicense"}
			licenseState[5] = {name = "LKW-Schein", elementName = "lkwlicense"}
			licenseState[6] = {name = "Waffenschein", elementName = "gunlicense"}
			licenseState[7] = {name = "Motorbootschein", elementName = "motorbootlicense"}
			licenseState[8] = {name = "Segelbootschein", elementName = "segellicense"}
			licenseState[9] = {name = "Flugschein B", elementName = "planelicenseb"}
			licenseState[10] = {name = "Flugschein A", elementName = "planelicensea"}
			licenseState[11] = {name = "Helikopter-Lizens", elementName = "helilicense"}

        local job = jobNames[vioClientGetElementData ( "job" )]
        local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
        local fraktion = fraktionsNamen[fraktion]
        if not fraktion then
            fraktion = "Zivilist"
        end
        if not job then
            job = "Arbeitslos"
        end
        local playtime = getElementData ( lp, "playingtime" )
        local playtimehours = math.floor(playtime/60)
        local playtimeminutes = playtime-playtimehours*60
        if playtimeminutes < 10 then
            playtimeminutes = "0"..playtimeminutes
        end
        local playtime = playtimehours..":"..playtimeminutes
        local gwd = vioClientGetElementData ( "armyperm10" )
        if not gwd then
            gwd = "0 %"
        else
            gwd = gwd.." %"
        end
        DGS:dgsDxCreateLabel(0.02, 0.03, 0.48, 0.94, "Spielzeit: "..playtime.."\n\nFraktion: "..fraktion.."\n\nStatus:\n\nJob: "..job.."\n\nGWD: "..gwd.."\n\nGeld(Bar/Bank): "..mymoney.."/"..vioClientGetElementData("bankmoney").." $", true, infoTabMenuMainPlayer)
        local licenseList = DGS:dgsDxCreateGridList(0.52, 0.02, 0.46, 0.94, true, infoTabMenuMainPlayer)
        local licenseListLicense = DGS:dgsDxGridListAddColumn( licenseList, "Schein", 0.7 )
        local licenseListState = DGS:dgsDxGridListAddColumn( licenseList, "Status", 0.2 )
        for var, license in ipairs(licenseState) do
            local row = DGS:dgsDxGridListAddRow ( licenseList )
            if vioClientGetElementData ( license.elementName ) == 1 then
                state = "[x]"
            else
                state = "[_]"
            end
            DGS:dgsDxGridListSetItemText ( licenseList, row, licenseListLicense, license.name , false, false )
            DGS:dgsDxGridListSetItemText ( licenseList, row, licenseListState, state , false, false )
        end
		local level = getElementData ( getLocalPlayer(), "MainLevel")
		local infoTabMenuLevel = DGS:dgsDxCreateTab("Level",infoTabMenuMain)
		local levelInfo = DGS:dgsDxCreateProgressBar(0.02, 0.05, 0.95, 0.11, true, infoTabMenuLevel)  
		if level < 30 then
			xpRelativ = getElementData(getLocalPlayer(),"MainXP")/levelSys[level +1]*100
		else
			xpRelativ = 100
		end
		DGS:dgsDxProgressBarSetProgress(levelInfo,xpRelativ)
		if level < 30 then
			levelReal = level
		else
			levelReal = "//"
		end
		DGS:dgsDxCreateLabel(0.36, 0.19, 0.29, 0.12, "Fortschritt bis Level "..levelReal, true, infoTabMenuLevel)
		local prestigeInfo = DGS:dgsDxCreateProgressBar(0.02, 0.34, 0.95, 0.11, true, infoTabMenuLevel ) 
		if level < 30 then		
		--	DGS:dgsDxProgressBarSetProgress(prestigeInfo,level/maxlevel*100-100)
			local wert1 = ((level/maxlevel*100) - 100) + 100
			DGS:dgsDxProgressBarSetProgress(prestigeInfo,wert1)
		else
			DGS:dgsDxProgressBarSetProgress(prestigeInfo,100)
		end
		local goPrestigeButton = DGS:dgsDxCreateButton(0.34, 0.48, 0.32, 0.11, "Prestige "..(getElementData ( player, "pLevel")+1).." gehen", true,  infoTabMenuLevel, nil, nil, nil, nil, nil, nil, tocolor(dr,dg,db),tocolor(sdr, sdg, sdb),tocolor(cdr, cdg, cdb))
		addEventHandler ( "onClientDgsDxMouseClick", goPrestigeButton, goPrestige )
		DGS:dgsDxCreateLabel(0.02, 0.62, 0.38, 0.25, "Nächste Prestige Belohnung:", true, infoTabMenuLevel)    
		if level == maxlevel then
			DGS:dgsDxGUISetEnabled(goPrestigeButton, true)
		else
			DGS:dgsDxGUISetEnabled(goPrestigeButton, false)
		end
		local infoTabMenuSupport = DGS:dgsDxCreateTab("Support",infoTabMenuMain)
		
		
		DGS:dgsDxCreateLabel(0.32, 0.03, 0.36, 0.07, "Permanenter Supporttoken: ", true, infoTabMenuSupport)
        permToken = DGS:dgsDxCreateLabel(0.44, 0.14, 0.10, 0.07, "nil", true, infoTabMenuSupport)
		triggerServerEvent ( "getSecturityToken", getLocalPlayer() )
        copyPermToken = DGS:dgsDxCreateButton(0.41, 0.25, 0.16, 0.09, "Kopieren", true, infoTabMenuSupport)
        DGS:dgsDxCreateLabel(0.31, 0.37, 0.36, 0.07, "Temporärer Supporttoken:", true, infoTabMenuSupport)
		tempToken = DGS:dgsDxCreateLabel(0.43, 0.47, 0.10, 0.07, playerTempToken, true, infoTabMenuSupport)
        copyTempToken = DGS:dgsDxCreateButton(0.41, 0.58, 0.16, 0.09, "Kopieren", true, infoTabMenuSupport)
        nextTempToken = DGS:dgsDxCreateProgressBar(0.02, 0.83, 0.95, 0.12, true, infoTabMenuSupport)
        DGS:dgsDxCreateLabel(0.02, 0.72, 0.47, 0.07, "Nächster temporärer Supporttoken:", true, infoTabMenuSupport)    
		
		addEventHandler("onClientDgsDxMouseClick", copyPermToken,
	    function ()
			setClipboard(DGS:dgsDxGUIGetText(permToken))
	    end
		)
		
		addEventHandler("onClientDgsDxMouseClick", copyTempToken,
		function ()
			setClipboard(DGS:dgsDxGUIGetText(tempToken))
		end
		)
		refreshBar = setTimer ( function()
			local remaining, executesRemaining, totalExecutes = getTimerDetails(resetToken)
			local remainTime = (60000*60)/remaining*100
			DGS:dgsDxProgressBarSetProgress(nextTempToken,remainTime)
		end, 1000, 0 )
    end
end

function showSettingsWindow ()
    if oneTabIsOpen == false then

		local settingsTab = nil
        local settingsWindow = DGS:dgsDxCreateWindow(0.38, 0.12, 0.24, 0.33, "Einstellung", true)
		DGS:dgsDxWindowSetMovable ( settingsWindow, false )
		DGS:dgsDxWindowSetSizable ( settingsWindow, false )
		DGS:dgsDxWindowSetCloseButtonEnabled(self, false)
        addEventHandler("onClientDgsDxWindowClose", settingsWindow,oneTabClose)
        oneTabIsOpen = true
		local settingsList = DGS:dgsDxCreateGridList(0.02, 0.06, 0.30, 0.91, true, settingsWindow, 0.04)
		DGS:dgsSetProperty(settingsList,"rowHeight",25)
		local column = DGS:dgsGridListAddColumn( settingsList, "", 0.98 )
		local settingsListTable = { [1] = "HUD-Optionen", [2] = "Einstellungen", [3] = "Kontoverwaltung", [4] = "Tastenzuweisung", [5] = "Spawnauswahl"}
		for var, option in ipairs(settingsListTable) do
            local row = DGS:dgsDxGridListAddRow ( settingsList )
            DGS:dgsDxGridListSetItemText ( settingsList, row, column, option , false, false )
        end
		
		settingsElements = {}
		settingsElements.IDs = {}
		local settingsScrollPane = DGS:dgsCreateScrollPane(0.33, 0.07, 0.65, 0.90,true,settingsWindow)
		local settingsScrollBar = DGS:dgsCreateScrollBar(0.95, 0.01, 0.05, 0.99, false, true,settingsScrollPane )
		
		
		


  


      
		addEventHandler ( "onClientDgsDxMouseClick", root, function (cmd, state)
			if source == settingsList then 
				if state == "down" then
					local Selected = DGS:dgsGridListGetSelectedItem(settingsList)
					if Selected ~= -1 then 
						local name = DGS:dgsGridListGetItemText(settingsList,Selected, 1)
						for var, data in ipairs(settingsElements) do 
							destroyElement(settingsElements[var])
							settingsElements[var] = nil
						end
						if isTimer(autoUpdater) then
							killTimer(autoUpdater)
						end
						if name == "HUD-Optionen" then
							
		
						elseif name == "Einstellungen" then
							settingsElements[1] =	DGS:dgsDxCreateLabel(0.03, 0.05, 0.26, 0.07,"Joinmessage:",true,settingsScrollPane)
							settingsElements[2] =	DGS:dgsDxCreateLabel(0.03, 0.16, 0.54, 0.07, "Experimenteller Map Stream:",true,settingsScrollPane)
							settingsElements[3] =	DGS:dgsDxCreateLabel(0.03, 0.26, 0.23, 0.07, "Sichtweite:",true,settingsScrollPane)
							settingsElements[4] =	DGS:dgsDxCreateLabel(0.03, 0.35, 0.37, 0.06, "Render-Reichweite:",true,settingsScrollPane)
							settingsElements[5] =	DGS:dgsDxCreateLabel(0.03, 0.44, 0.30, 0.07, "FPS: (max. 65):",true,settingsScrollPane)
							settingsElements[6] =	DGS:dgsDxCreateLabel(0.03, 0.64, 0.46, 0.07, "Foren Register anzeigen:",true,settingsScrollPane)
							settingsElements[7] =	DGS:dgsDxCreateLabel(0.03, 0.73, 0.17, 0.07, "Wolken:",true,settingsScrollPane)
							settingsElements[8] =	DGS:dgsDxCreateButton(0.32, 0.04, 0.16, 0.09, "join", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) ) -- Joinmessage
							settingsElements[9] =	DGS:dgsDxCreateButton(0.61, 0.15, 0.16, 0.09, "map", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) ) -- Mapstream
							settingsElements[10] =	DGS:dgsDxCreateButton(0.54, 0.63, 0.16, 0.09, "forenreg", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) ) -- Hitmarker
							settingsElements[11] =	DGS:dgsDxCreateButton(0.33, 0.53, 0.16, 0.09, "hit", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) ) -- Hitmarker
							settingsElements[12] =	DGS:dgsDxCreateButton(0.23, 0.72, 0.16, 0.09, "wolke", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) ) -- Wolken
							settingsElements[13] =	DGS:dgsCreateEdit( 0.29, 0.26, 0.20, 0.06, "", true, settingsScrollPane ) -- Sichtweite
							settingsElements[14] =	DGS:dgsCreateEdit( 0.44, 0.35, 0.20, 0.06, "", true, settingsScrollPane ) -- Render
							settingsElements[15] =	DGS:dgsCreateEdit( 0.37, 0.45, 0.20, 0.06, "", true, settingsScrollPane ) -- FPS
							settingsElements[16] =	DGS:dgsDxCreateLabel(0.03, 0.54, 0.27, 0.07, "GW-Hitmarker:",true,settingsScrollPane)
							
							-- ID's der Buttons
							settingsElements.IDs[8] = 1
							settingsElements.IDs[9] = 3
							settingsElements.IDs[10] = 10
							settingsElements.IDs[11] = 9
							settingsElements.IDs[12] = 5

							autoUpdater = setTimer ( autoUpdateSettings, 1000, 0 )
							checkSettingStates ()
							addEventHandler("onDgsTextChange", settingsElements[15], function() 
								if tonumber(DGS:dgsGetText(settingsElements[15])) <= 65 then
									setFPSLimit(DGS:dgsGetText(settingsElements[15]))
									print("Change")
									else
									print("nChange")
								end
							end)
							
							-- Clickbar machen
							for var, button in pairs(settingsElements) do
								if tonumber(settingsElements.IDs[var]) then
									
									addEventHandler ( "onClientDgsDxMouseClick", settingsElements[var], function (cmd, state)
										if state == "down" then
											if name == "Einstellungen" then
												local v = getSetting (tonumber(settingsElements.IDs[var]), 1)
												if v == 1 then
													changeSetting (settingsElements.IDs[var], 1, 0)
												else 
													changeSetting (settingsElements.IDs[var], 1, 1)
												end
												checkSettingStates ()
											else
											end
										end
									end ) 
								end
							end
						elseif name == "Kontoverwaltung" then
							settingsElements[1] =	DGS:dgsDxCreateLabel(0.01, 0.01, 0.95, 0.10,"Passwort\n----------------------------------------------------------------------",true,settingsScrollPane)
							settingsElements[2] =	DGS:dgsDxCreateLabel(0.01, 0.13, 0.32, 0.05,"Neues Passwort:",true,settingsScrollPane)
							settingsElements[3] =	DGS:dgsDxCreateLabel(0.01, 0.22, 0.43, 0.05,"Neues Passwort Wdh.:",true,settingsScrollPane)
							settingsElements[4] = 	DGS:dgsDxCreateLabel(0.01, 0.30, 0.32, 0.05,"Aktu. Passwort:",true,settingsScrollPane)
							settingsElements[5] = 	DGS:dgsCreateEdit( 0.49, 0.14, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[6] = 	DGS:dgsCreateEdit( 0.49, 0.22, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[7] = 	DGS:dgsCreateEdit( 0.49, 0.30, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[8] = 	DGS:dgsDxCreateButton(0.30, 0.38, 0.37, 0.06, "Passwort ändern", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) )	
							-- Daten
							settingsElements[9]	=	DGS:dgsDxCreateLabel(0.01, 0.43, 0.95, 0.15,"Persönliche Daten\n----------------------------------------------------------------------\nWerden auch zur Authentifizierung verwendet!",true,settingsScrollPane)
							settingsElements[10] = 	DGS:dgsDxCreateLabel(0.01, 0.61, 0.19, 0.05,"Wohnort:",true,settingsScrollPane)
							settingsElements[11] = 	DGS:dgsDxCreateLabel(0.01, 0.70, 0.23, 0.05,"Postleitzahl:",true,settingsScrollPane)
							settingsElements[12] =	DGS:dgsDxCreateLabel(0.01, 0.78, 0.34, 0.05,"Telefonnummber:",true,settingsScrollPane)
							settingsElements[13] = 	DGS:dgsCreateEdit( 0.38, 0.61, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[14] = 	DGS:dgsCreateEdit( 0.38, 0.70, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[15] = 	DGS:dgsCreateEdit( 0.38, 0.79, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[16] = 	DGS:dgsDxCreateButton(0.34, 0.87, 0.31, 0.06, "Speichern", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) )								
							
							
							
						elseif name == "Tastenzuweisung" then
							
						end
						

					end
				end
			end
		end )
	end
end


function showShopWindow () 
	if oneTabIsOpen == false then
		oneTabIsOpen = true
	--	local coins, premTime, pack, prem = triggerServerEvent ( "getPremiumData", getLocalPlayer(), getLocalPlayer() )
		local coins, premTime, pack, prem = 1, 1530840713, 4, true
		local shopWindow = DGS:dgsDxCreateWindow(0.37, 0.12, 0.25, 0.32, "Shop", true)
		DGS:dgsDxWindowSetMovable ( shopWindow, false )
		DGS:dgsDxWindowSetSizable ( shopWindow, false )
		DGS:dgsDxWindowSetCloseButtonEnabled(self, false)
		DGS:dgsDxCreateLabel(0.03, 0.02, 0.19, 0.06, "Deine Coins: "..coins, true, shopWindow)
		if prem == false then
			premState = "Nicht aktiv"
		else
			premState = pack.." bis zum "..getData(premTime)
		end
		DGS:dgsDxCreateLabel(0.48, 0.02, 0.50, 0.06, "Premium-Status: "..premState, true, shopWindow)
		local shopWindowTab = DGS:dgsDxCreateTabPanel(0.03, 0.11, 0.95, 0.80, true, shopWindow)
        local shopWindowTabItems1 = DGS:dgsDxCreateTab("Items",shopWindowTab)
		local premiumAuto = DGS:dgsCreateCheckBox(0.02, 0.03, 0.96, 0.11, "Premium-Paket ggf automatich nach Ablauf verlängern",false,true,shopWindowTabItems1)
		addEventHandler("onClientDgsDxWindowClose", shopWindow, oneTabClose)
		
		if getSetting (7, 1) == 1 then
			DGS:dgsCheckBoxSetSelected(premiumAuto,true)
		end
		
		local items = DGS:dgsCreateGridList (0.02, 0.14, 0.96, 0.79, true, shopWindowTabItems1  )
		local id = DGS:dgsGridListAddColumn( items, "ID", 0.2 ) 
		local name = DGS:dgsGridListAddColumn( items, "Name", 0.4 ) 
		local preis = DGS:dgsGridListAddColumn( items, "Preis", 0.3 ) 
		
		for var, item in ipairs(shopItems) do
            local row = DGS:dgsDxGridListAddRow ( items )
			DGS:dgsDxGridListSetItemText ( items, row, id, var , false, false )
            DGS:dgsDxGridListSetItemText ( items, row, name, item.name , false, false )
            DGS:dgsDxGridListSetItemText ( items, row, preis, item.preis , false, false )
			itemText[tonumber(var)] = tostring(item.text)
        end
		
		
		-- Item
		shopDesc = DGS:dgsDxCreateWindow(0.20, 0.19, 0.15, 0.22, "Beschreibung", true)
		DGS:dgsDxWindowSetMovable ( shopDesc, false )
		DGS:dgsDxWindowSetSizable ( shopDesc, false )
		desc = DGS:dgsCreateMemo(0.06, 0.11, 0.88, 0.71,"",true,shopDesc)
		DGS:dgsMemoSetReadOnly(desc, true )
		DGS:dgsDxCreateButton(0.06, 0.86, 0.31, 0.09, "Hinzufügen", true, shopDesc, nil, nil, nil, nil, nil, nil, tocolor(1,223,1), tocolor(4,170,4), tocolor(4,170,4) )  
		DGS:dgsWindowSetCloseButtonEnabled(shopDesc,false)
		addEventHandler ( "onClientDgsDxMouseClick", root, function (cmd, state)
			if source == items then 
				if state == "down" then
					local Selected = DGS:dgsGridListGetSelectedItem(items)
					if Selected ~= -1 then 
						local id = DGS:dgsGridListGetItemText(items,Selected, 1)
						DGS:dgsClear(desc)
						DGS:dgsSetText(desc,itemText[tonumber(id)])
					end
				end
			end
		end )

		addEventHandler( "onDgsCheckBoxChange", premiumAuto,
		function ( current, previous )
			if current == true then
				changeSetting (7, 1, 1)
			else
				changeSetting (7, 1, 0)
			end
		end
		)

		-- getSetting (id, typ)
	end
end



function autoUpdateSettings ()
	local renderDistance = DGS:dgsGetText(settingsElements[14])
	local distance = DGS:dgsGetText(settingsElements[13])
	local fps = DGS:dgsGetText(settingsElements[15])
	if tonumber(renderDistance) then
		changeSetting (6, 1, renderDistance)
	end
	if tonumber(distance) then
		changeSetting (4, 1, distance)
	end
	if tonumber(fps) <= 65 and tonumber(fps) >= 10 then
		changeSetting (12, 1, fps)
	end
end
function checkSettingStates ()
	-- Edits
	 DGS:dgsSetText(settingsElements[13], getSetting (4, 1))
	 DGS:dgsSetText(settingsElements[14], getSetting (6, 1)) 
	 DGS:dgsSetText(settingsElements[15], getSetting (12, 1))
	-- Buttons
	for var, button in pairs(settingsElements) do
            if tonumber(settingsElements.IDs[var]) then
                local v = getSetting (settingsElements.IDs[var], 1)
                if tonumber(v) == 1 then
                   DGS:dgsDxGUISetProperty(settingsElements[var],"color", {tocolor( dr,dg,db ), tocolor( sdr, sdg, sdb ), tocolor( cdr, cdg, cdb )} )
				   DGS:dgsSetText(settingsElements[var], "An")
                else
                   DGS:dgsDxGUISetProperty(settingsElements[var],"color", {tocolor( ar,ag,ab ), tocolor( sar, sag, sab ), tocolor( car, cag, cab )} )
				   DGS:dgsSetText(settingsElements[var], "Aus")
                end
				
            end
        end	
	end
	
function changeSettingButton (button, state)
	if state == "down" then
		local var = getSetting (tonumber(settingsButton.settingID[source]), 1)
		if var == 1 then
			newstate = 0
		else
			newstate = 1 
		end
		changeSetting (tonumber(settingsButton.settingID[source]), 1, newstate)
		checkSettingStates ()

	end
end
		
function goPrestige (button, state)
	if state == "down" then
		if triggerServerEvent ( "goPrestige", resourceRoot) == true then
			DGS:dgsDxGUICloseWindow(infoWindow)
		else
			print("Error")
		end
	end
end


function setPermToken (token)
	DGS:dgsDxGUISetText(permToken, token)
end
addEvent ( "setPermToken", true )
addEventHandler ( "setPermToken", getRootElement(), setPermToken )