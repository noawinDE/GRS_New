swtData={}
swt = {}

-- Start
swtData["sx"],swtData["sy"],swtData["sz"] = 1599.3000488281,  -1634.6999511719, 12.900000190735
swtData["vehx"],swtData["vehy"], swtData["vehz"], swtData["vehrz"] = 1596.4000244141, -1628.9000244141, 13.699999809265, 90
swtData["model"] = 428 -- Secuicar
swtData["startBlip"] = createBlip (swtData["sx"], swtData["sy"], swtData["sz"], 18, 0.7, 255, 0, 0, 255, 0, 200, getRootElement() )
swtData["startMarker"] = createMarker (swtData["sx"],swtData["sy"],swtData["sz"], "cylinder", 0.9, 255, 0, 0, 150)

-- Abgabe I Area 51
swtData["dx1"],swtData["dy1"],swtData["dz1"] = 118.80000305176, 1902.0999755859, 18.60000038147


-- Abgabe II SFPD
swtData["dx2"], swtData["dy2"], swtData["dz2"] = -1629.5, 660.70001220703, 7.1999998092651



swtData["number"] = 0
swtData["swtInGange"] = 0
swtData["resetTimer"] = false




function hitSWTMarker_func (player)
    local rank = getPlayerRank ( player )
    if getElementType(player) == "player" and getElementDimension(player) == 0 then
        if isPedInVehicle ( player ) == false then
            -- if isOnStateDuty(player) and isStateFaction(player) then
            if isStateFaction(player) then
                if swtData["swtInGange"] == 0 then
                    if rank >= 2 then
                        triggerClientEvent ( player, "showSWTGUI", getRootElement())
                    else
                        triggerClientEvent ( source, "infobox_start", getRootElement(), "Du bist nicht Befugt.", 5000, 255, 0, 0 )
                    end
                else
                    triggerClientEvent ( source, "infobox_start", getRootElement(), "Es ist momentan ein SWT in Gange.", 5000, 255, 0, 0 )
                end
            else
                triggerClientEvent ( source, "infobox_start", getRootElement(), "Du bist in keiner Staatsfraktion / nicht im Dienst!", 5000, 255, 0, 0 )

            end
        end
    end
end

function loadSWT (player, wsets, ssets, time)
    local pname = getPlayerName(player)
    local price = (wsets*50)+(ssets*100)
    if aktionlaeuft == false then
        if factionDepotData["money"][1] >= tonumber(price) then
            triggerClientEvent ( player, "renterSWTText", getRootElement())
            swt["vehicle"] = createVehicle ( swtData["model"], swtData["vehx"], swtData["vehy"], swtData["vehz"], 0, 0, swtData["vehrz"] )
            local msg = "[Staatswaffentruck] Es wird ein SWT in "..getZoneName(swtData["vehx"], swtData["vehy"], swtData["vehz"])..", "..getZoneName(swtData["vehx"], swtData["vehy"], swtData["vehz"],true).." beladen."
            sendMSGToAllFactions (msg,200,0,0)
			factionDepotData["money"][1] = factionDepotData["money"][1] -  tonumber(price)
            swtData[swt["vehicle"]] = {}
            swtData[swt["vehicle"]] = {} 
            swtData[swt["vehicle"]]["isSWT"] = true
            swtData[swt["vehicle"]]["WaffenSets"] = wsets
            swtData[swt["vehicle"]]["SWATSets"] = ssets
			swtData[swt["vehicle"]]["money"] = tonumber(price)
            outputChatBox(swtData[swt["vehicle"]]["WaffenSets"].."-"..swtData[swt["vehicle"]]["SWATSets"])
            setVehiclePaintjob ( swt["vehicle"], 2 )
            setVehicleColor ( swt["vehicle"], 0, 0, 0, 0, 0, 0, 0, 0, 0)
            setElementHealth ( swt["vehicle"], 2000 )
            warpPedIntoVehicle ( player, swt["vehicle"] )
            addEventHandler ( "onVehicleExplode", swt["vehicle"], destroySWT )
            swt["vehicleBlip"] = createBlipAttachedTo(swt["vehicle"] , 51)
            swtData["number"] = math.random (1,2)
            swtData["swtInGange"] = 1
			
            if tonumber(swtData["number"]) == 1 then

				swtData["deliverMarker"] = createMarker ( swtData["dx1"], swtData["dy1"], swtData["dz1"], "checkpoint", 7, 255, 0, 0, 150, getRootElement() )
				swtData["deliverBlip"]  = createBlip ( swtData["dx1"], swtData["dy1"], swtData["dz1"], 51, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
            elseif tonumber(swtData["number"]) == 2 then
				swtData["deliverMarker"] = createMarker ( swtData["dx2"], swtData["dy2"], swtData["dz2"], "checkpoint", 7, 255, 0, 0, 150, getRootElement() )
				swtData["deliverBlip"]  = createBlip ( swtData["dx2"], swtData["dy2"], swtData["dz2"], 51, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement() )
            end
			addEventHandler ( "onMarkerHit",  swtData["deliverMarker"],  giveSWTAway )
			setElementVisibleTo(swtData["deliverMarker"],player, true)
            setElementVisibleTo(swtData["deliverBlip"],player, true)
            local veh = swt["vehicle"]
            removeVehicleSirens(veh)
            addVehicleSirens(veh, 3, 2, false, true, true, false)
            setVehicleSirens(veh, 1, -1.2, 0.6, 1.3, 0, 0, 165.8, 198.9, 198.9)
            setVehicleSirens(veh, 2, 0, 1.3, 1.3, 142.8, 0, 0, 191.3, 198.9)
            setVehicleSirens(veh, 3, 1.1, 0, 1.3, 0, 0, 137.7, 191.3, 191.3)
            setElementHealth(veh, 2000)
            print("Cost: "..price)
            print(wsets..""..ssets)
            setElementFrozen(swt["vehicle"], true)

            aktionlaeuft = true
            swtFilled = setTimer ( function()
                setElementFrozen(swt["vehicle"], false)
                local msg = "[Staatswaffentruck] Der SWT wurde gestartet."
                sendMSGToAllFactions (msg,200,0,0)
                swtData["deleteSWTWarn"] =  setTimer(checkSWTThere5, 300000, 1)
                swtData["deleteSWT"] =  setTimer(checkSWTThere10, 300000*2, 1)
                if tonumber(swtData["number"]) == 1  then
                    local msg = "[Staatswaffentruck] Er fährt zur Area 51."
                    sendMSGToAllFactions (msg,200,0,0)
                elseif tonumber(swtData["number"]) == 2 then
                    local msg = "[Staatswaffentruck] Er fährt zum SFPD."
                    sendMSGToAllFactions (msg,200,0,0)
                end
            end, time, 1 )
 
        end
    end
end

addEvent( "loadSWT", true )
addEventHandler( "loadSWT", getRootElement(), loadSWT )

function giveSWTAway (player)
    local veh = getPedOccupiedVehicle ( player )
    if swtData[veh]["isSWT"] == true and swtData["swtInGange"] == 1 then
        if getElementModel ( veh ) == swtData["model"] then
            swtData["resetTimer"] =  setTimer(resetSWT, 3600000, 1)
            fraktionRearms["SWATSets"] = fraktionRearms["SWATSets"] + swtData[swt["vehicle"]]["SWATSets"]
            fraktionRearms["WeaponSets"] = fraktionRearms["WeaponSets"] + swtData[swt["vehicle"]]["WaffenSets"]
			factionDepotData["money"][1] = factionDepotData["money"][1] + swtData[swt["vehicle"]]["money"]
            local msg = "[Staatswaffentruck] Der SWT wurde abgegeben."
            sendMSGToAllFactions ("[Staatswaffentruck] Der SWT wurde abgegeben.",200,0,0)
            sendMSGToStateFactions ("[Staatswaffentruck] Ihr habt "..swtData[swt["vehicle"]]["WaffenSets"].." Waffen Sets und "..swtData[swt["vehicle"]]["SWATSets"].." SWAT Sets erhalten." ,0,205,0)
            destroyElement ( swt["vehicle"]  )
            destroyElement (swt["vehicleBlip"] )
            killTimer(swtData["deleteSWTWarn"])
            killTimer(swtData["deleteSWT"])
            swtData["swtInGange"] = 0
			destroyElement(swtData["deliverMarker"])
			destroyElement(swtData["deliverBlip"])

        else
       --     banVioShieldPlayer(player, "Manipulation des SWTs")
		print("Manipulation xd")
        end
		else
		print("kein swt")
		print(swtData["swtInGange"] )
		print(tostring(swtData[veh]["isSWT"]))
    end
end



function enterSWT (veh, seat)
    local driver = source
    if swtData["swtInGange"] == 1 then
        if veh == swt["vehicle"] then
            if getElementModel(veh) == swtData["model"] then
                if isOnStateDuty(driver) or isStateFaction(driver) and seat == 0 then
					setElementVisibleTo(swtData["deliverMarker"],driver, true)
                    setElementVisibleTo(swtData["deliverBlip"],driver, true)
                else
                    opticExitVehicle ( driver )
                end
            else
                banVioShieldPlayer(driver, "Manipulation des SWTs")
            end
        end
    end
end

function exitSWT (veh)
    local driver = source

    if veh == swt["vehicle"] then
        if swtData["swtInGange"] == 1 then
            if getElementModel(veh) == swtData["model"] then
                if isOnStateDuty(driver) or isStateFaction(driver) then
                    setElementVisibleTo(swtData["deliverMarker"],driver, false)
                    setElementVisibleTo(swtData["deliverBlip"],driver, false)
                else
                    opticExitVehicle ( driver )
                end
            else
                banVioShieldPlayer(driver, "Manipulation des SWTs")
            end
        end
    end
end


function resetSWT ()
    if isElement(swt["vehicle"]) then
        destroyElement ( swt["vehicle"]  )
        destroyElement (swt["vehicleBlip"] )
        swtData["number"] = 0
        swtData["swtInGange"] = 0
		destroyElement(swtData["deliverMarker"])
		destroyElement(swtData["deliverBlip"])
    end
end

function checkSWTThere5( player )
    sendMSGToAllFactions ("[Staatswaffentruck] Der SWT hat noch 5 Minuten das Ziel zu erreichen",200,0,0)

end

function checkSWTThere10( player )
    sendMSGToAllFactions ("[Staatswaffentruck] Der SWT wurde aufgrund von inaktivität gelöscht.",200,0,0)
    resetSWT ()
end

function destroySWT ()
    swtData["resetTimer"] =  setTimer(resetSWT, 3600000, 1)
    local x,y,z = getElementPosition( swt["vehicle"])
    local veh =  swt["vehicle"]
    setElementPosition ( veh, 999999, 999999, -50 )
    local msg = "[Staatswaffentruck] Der SWT ist explodiert! Sammel schnell die Waffenboxen auf!"
    sendMSGToAllFactions (msg,200,0,0)
    outputLog ( "[Staatswaffentruck] Der SWT ist explodiert!", "SWT" )
    for i = 1, 6  do
        local randomdata = math.random(1,7)
        local randomdata2 = math.random(1,8)
        swt["swtWeapon"..i] = createObject(3016,x+randomdata,y+randomdata2,z-0.9)

    end
    killTimer(swtData["deleteSWTWarn"])
    killTimer(swtData["deleteSWT"])
    removeEventHandler ( "onVehicleExplode", swt["vehicle"], destroySWT )
    destroyElement ( swt["vehicle"]  )
    destroyElement ( swt["vehicleBlip"] )
    aktionlaeuft = false
end

function swtClickBox ( source, theButton, player )

    if theButton == "left" then
        local mp5 = math.random(1,7)
        local mp5ammo = math.random(30,75)
        local m4 = math.random(1,6)
        local m4ammo = math.random(30,80)
        local sniper = math.random(1,5)
        local sniperammo = math.random(10,30)
        local x1,y1,z1 = getElementPosition(player)
        local x2,y2,z2 = getElementPosition(source)
        if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) <= 5 then
            if isStateFaction(player) then
                local WeaponSetsDrop = math.random (10,20)
                local SWATSetsDrop = math.random (5,15)
                sendMSGToStateFactions (getPlayerName(player).." hat durch das einsammeln einer Waffenbox "..WeaponSetsDrop.." Waffen Sets und "..SWATSetsDrop.." SWAT Sets erhalten." ,0,205,0)
                fraktionRearms["SWATSets"] = fraktionRearms["SWATSets"] + SWATSetsDrop
                fraktionRearms["WeaponSets"] = fraktionRearms["WeaponSets"] + WeaponSetsDrop
                destroyElement(source)
                givePlayerXP(player,2)

            elseif isMafia(player) then
				local mats =  math.random(100,200)
				factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] = factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] + mats
				sendMSGForFaction (getPlayerName(player).." hat eine Waffenbox aufgesammelt, sie enthielt "..mats.." Mats.", tonumber(vioGetElementData ( player, "fraktion" )),0,205,0 )
                destroyElement(source)
                givePlayerXP(player,2)

            elseif isTriad(player) then
				local mats =  math.random(100,200)
				factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] = factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] + mats
                sendMSGForFaction (getPlayerName(player).." hat eine Waffenbox aufgesammelt, sie enthielt "..mats.." Mats.", tonumber(vioGetElementData ( player, "fraktion" )),0,205,0 )
                destroyElement(source)
                givePlayerXP(player,2)
				
            elseif isBiker(player) then
				local mats =  math.random(100,200)
				factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] = factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] + mats
                sendMSGForFaction (getPlayerName(player).." hat "..mp5.." MP5(s) (Ammu:"..mp5ammo.."), "..m4.." M4(s) (Ammu:"..m4ammo..") und "..sniper.." Sniper (Ammu:"..sniperammo..") durch das Aufsammeln einer Waffenbox in das Waffenlager eingelagert.", tonumber(vioGetElementData ( player, "fraktion" )),0,205,0 )
                destroyElement(source)
                givePlayerXP(player,2)
            elseif isAztecas(player) then
				local mats =  math.random(100,200)
				factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] = factionDepotData["mats"][tonumber(vioGetElementData ( player, "fraktion" ))] + mats
				sendMSGForFaction (getPlayerName(player).." hat eine Waffenbox aufgesammelt, sie enthielt "..mats.." Mats.", tonumber(vioGetElementData ( player, "fraktion" )),0,205,0 )
                destroyElement(source)
                givePlayerXP(player,2)
            elseif isGrove(player) or isBallas(player) or ishit(player) or isss(player) or isTerror(player) then
                local money = math.random(10000,15000)
                sendMSGForFaction (getPlayerName(player).." hat beim aufheben einer Waffenbox, da es kein Waffenlager gibt, "..money.."$ bekommen, da er die Waffen verkauft hat. ", tonumber(vioGetElementData ( player, "fraktion" )),0,205,0 )
                local pmoney = tonumber ( vioGetElementData ( player, "money" ) )
                vioSetElementData ( player, "money", pmoney + money )
                destroyElement(source)
                givePlayerXP(player,2)
            else
                outputChatBox ( "Ungültige Fraktion!", player, 255, 0, 0 )
            end
        else
            outputChatBox ( "Zuweit entfernt", player, 255, 0, 0 )
        end
    end
end









function swtReset ()
    swtData["number"] = 0
    outputChatBox ( "[SWT] Es kann nun wieder ein SWT beladen werden!", root, 0, 200, 0 )
    if isElement(swt["vehicle"]) then
        destroyElement ( swt["vehicle"]  )
        destroyElement (swt["vehicleBlip"] )
    end
end

addEventHandler ( "onPlayerVehicleExit", root, exitSWT )
addEventHandler ( "onPlayerVehicleEnter", root, enterSWT )
addEventHandler ( "onMarkerHit",  swtData["startMarker"],  hitSWTMarker_func )
