VehicleFinder = {}
function getScriptEnd(file)
  local tmp, endPos = fileGetPos(file)
	while not fileIsEOF(file) do    
		fileRead(file, 500)                      
	end
  endPos = fileGetPos(file)
  fileSetPos(file, tmp)
  return endPos
end


function openFraktionMenu_func ( player )
	local fraktion = getPlayerFaction ( player )
	if fraktion >= 1 then
	triggerClientEvent ( player, "openFraktionMenu", getRootElement() )

	end
end
addCommandHandler("fraktion", openFraktionMenu_func)

function loadFraktionMember ( player )
    local pname = getPlayerName( player )
    local fraktion = getPlayerFaction ( player )
    local result = dbQuery ( handler, "SELECT ??, ??, ?? FROM ?? WHERE ??=?", "Name", "FraktionsRang", "LastLogin","userdata", "Fraktion", fraktion )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local Name = rows.Name
                local Rang = rows.FraktionsRang
				if getPlayerFromName ( Name ) then
					Status = "on"
				else
					Status =  rows.LastLogin
				end
                triggerClientEvent ( player, "loadFraktionMember", getRootElement(), Name, Rang, Status)
                --	triggerClientEvent(player, "LoadFraktionsGridUser",player,Name,Frak,Rang,RangName,Gehalt,"Offline",LastLogin)
            end
        end
    end
end
addEvent ( "loadFraktionMember", true )
addEventHandler ( "loadFraktionMember", getRootElement(),  loadFraktionMember )        

function loadFraktionVehicles ( player )
    local pname = getPlayerName( player )
    local fraktion = getPlayerFaction ( player )
	local result = dbQuery ( handler, "SELECT * FROM fraktionen_vehicle WHERE ??=?", "OwnerID", fraktion )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
				 local id = rows.ID
                local model = rows.Modell
                local Rang = rows.Rang
				local Level = tonumber(rows.Aufwertung)
                local SX = tonumber(rows.X)
                local SY = tonumber(rows.Y)
                local SZ = tonumber(rows.Z)
                local SXR = tonumber(rows.XR)
                local SYR = tonumber(rows.YR)
                local SZR = tonumber(rows.ZR) 
			
				
				
                triggerClientEvent ( player, "loadFraktionVehicles", getRootElement(), id, model, Rang, Level, SX, SY, SZ, SXR, SYR, SZR)
                --	triggerClientEvent(player, "LoadFraktionsGridUser",player,Name,Frak,Rang,RangName,Gehalt,"Offline",LastLogin)
            end
        end
    end
end
addEvent ( "loadFraktionVehicles", true )
addEventHandler ( "loadFraktionVehicles", getRootElement(),  loadFraktionVehicles )  



function loadWarns ( player )
    local pname = getPlayerName( player )
    local fraktion = getPlayerFaction ( player )
	local result = dbQuery ( handler, "SELECT * FROM fraktionen_warns WHERE ??=?", "Fraktion", fraktion )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
				 local id = rows.ID
				  local UID = rows.UID 
                local reason = rows.reason
                local expirationdate = rows.ExpirationDate	
				local expiration = rows.Expiration
            

				
				
                triggerClientEvent ( player, "loadWarns", getRootElement(), id, playerUIDName[UID], reason, expirationdate, expiration)
                --	triggerClientEvent(player, "LoadFraktionsGridUser",player,Name,Frak,Rang,RangName,Gehalt,"Offline",LastLogin)
            end
        end
    end
end
addEvent ( "loadWarns", true )
addEventHandler ( "loadWarns", getRootElement(),  loadWarns )  
 
function fraktionsMenu_setRang ( target, rang )
    local faction = getPlayerFaction ( client )
    local targetpl = getPlayerFromName ( target )
    local rank = getPlayerRank ( client )
    if isElement ( targetpl ) then
        local targetrank = getPlayerRank ( targetpl )
        local targetfaction = getPlayerFaction ( targetpl )
        if faction >= 1 and rank >= 4 and faction == targetfaction and rank > rang then
            if rang < 5 and rang >= 0 then
				outputLog ( "[RANG] Der Rang von "..getPlayerName(targetpl).." wurde von "..getPlayerName ( client ).." auf "..factionRankNames[faction][rang].." ( "..rang.." ) gesetzt.", "fraktion"..faction  )
                if rang > targetrank then
                    outputChatBox ( "Glückwunsch, du wurdest soeben von "..getPlayerName ( client ).." zum "..factionRankNames[faction][rang].." befördert!", targetpl, 0, 125, 0 )
                    outputChatBox ( "Du hast "..getPlayerName(targetpl).." soeben Rang "..factionRankNames[faction][rang].." ( "..rang.." ) gegeben!", client, 0, 125, 0 )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", rang, "UID", playerUID[target] )
                    vioSetElementData ( targetpl, "rang", rang )
                else
                    outputChatBox ( "Du wurdest soeben von "..getPlayerName ( client ).." zum "..factionRankNames[faction][rang].." degradiert!", targetpl, 125, 0, 0 )
                    outputChatBox ( "Du hast "..getPlayerName(targetpl).." soeben Rang "..factionRankNames[faction][rang].." ( "..rang.." ) gegeben!", client, 0, 125, 0 )
					 dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", rang, "UID", playerUID[target] )
                    vioSetElementData ( targetpl, "rang", rang )
                end

 

            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Rang des\nSpieler ist höher!", 5000, 125, 0, 0 )
        end
    elseif playerUID[target] then
        if rank >= 4 and rank > rang then
            local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Fraktion", "FraktionsRang", "userdata", "UID", playerUID[target] ), -1 )
            if result and result[1] and tonumber ( result[1]["Fraktion"] ) == faction then
                if tonumber ( result[1]["FraktionsRang"] ) < rank then
					outputLog ( "[RANG] Der Rang von "..target.." wurde von "..getPlayerName ( client ).." auf "..factionRankNames[faction][rang].." ( "..rang.." ) gesetzt.", "fraktion"..faction )
                    outputChatBox ( "Du hast "..target.." soeben Rang "..factionRankNames[faction][rang].." ( "..rang.." ) gegeben!", client, 0, 125, 0 )
                    if rang > result[1]["FraktionsRang"] then
                        offlinemsg ( "Glückwunsch, du wurdest soeben von "..getPlayerName ( client ).." zum "..factionRankNames[faction][rang].." befördert!", "Fraktionssystem", target )
                        dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", rang, "UID", playerUID[target] )
                        outputChatBox ( "Du hast "..target.." soeben Rang "..factionRankNames[faction][rang].." ( "..rang.." ) gegeben!", client, 0, 125, 0 )
                    else
                        offlinemsg ( "Du wurdest soeben von "..getPlayerName ( client ).." zum "..factionRankNames[faction][rang].." degradiert!", "Fraktionssystem", target )
                        dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", rang, "UID", playerUID[target] )
                        outputChatBox ( "Du hast "..target.." soeben Rang "..factionRankNames[faction][rang].." ( "..rang.." ) gegeben!", client, 0, 125, 0 )
                    end
                else
                    triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Rang des\nSpieler ist höher!", 5000, 125, 0, 0 )
                end
            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Spieler ist\nnicht in deiner Fraktion!", 5000, 125, 0, 0 )
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fraktionsMenu_setRang", true )
addEventHandler ( "fraktionsMenu_setRang", getRootElement(), fraktionsMenu_setRang )  
 
function fraktionsMenu_uninvite ( target)				

	local faction = getPlayerFaction ( client )
	local rank = getPlayerRank ( client )
	if faction > 0 and rank >= 5 then
		local targetpl = getPlayerFromName ( target )
		if isElement ( targetpl ) then		
			if faction == getPlayerFaction( targetpl ) and getPlayerRank ( targetpl ) <= 4 then			
				local model = malehomeless[math.random ( 1, 5 )]
				setElementModel ( targetpl, model )
				vioSetElementData ( targetpl, "skinid", model )
				vioSetElementData ( targetpl, "rang", 0 )
				vioSetElementData ( targetpl, "FraktionenVerlassen", vioGetElementData ( targetpl, "FraktionenVerlassen" ) + 1 )
				vioSetElementData ( targetpl, "fraktion", 0 )
				outputChatBox ( "Du wurdest soeben aus deiner Fraktion geworfen!", targetpl, 0, 125, 0 )
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical (), "UID", playerUID[getPlayerName(targetpl)] )
				outputChatBox ( "Du hast den Spieler "..getPlayerName(targetpl).." aus deiner Fraktion entfernt!", client, 0, 125, 0 )				
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Fraktion", 0, "UID", playerUID[target] )
				dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", 0, "UID", playerUID[target] )
				outputLog ( "[UNINVITE] "..getPlayerName ( client ).."  hat "..getPlayerName(targetpl).." aus der Fraktion entfernt.", "fraktion"..faction )
			else
				triggerClientEvent ( client, "infobox_start", getRootElement(), "Du kannst den\nSpieler nicht aus\nder Fraktion\nentfernen!", 5000, 125, 0, 0 )
			end			
		elseif playerUID[target] then
			local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Fraktion", "FraktionsRang", "userdata", "UID", playerUID[target] ), -1 )
			if result and result[1] and tonumber ( result[1]["Fraktion"] ) == faction then
				if tonumber ( result[1]["FraktionsRang"] ) <= 4 then
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Fraktion", 0, "UID", playerUID[target] )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "FraktionsRang", 0, "UID", playerUID[target] )
					outputChatBox ( "Du hast den Spieler "..target.." aus deine Fraktion uninvitet!", client, 0, 125, 0 )
					offlinemsg ( "Du wurdest von "..getPlayerName(client).." aus der Fraktion "..fraktionNames[faction].." uninvitet!", "Fraktionssystem", target )
					dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical (), "UID", playerUID[target] )
					outputLog ( "[UNINVITE] "..getPlayerName ( client ).."  hat "..target.." aus der Fraktion entfernt.", "fraktion"..faction )
				else
					triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu kannst einen\nLeader nicht uninviten!", 5000, 125, 0, 0 )
				end
			else
				triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Spieler ist\nnicht in deiner Fraktion!", 5000, 125, 0, 0 )	
			end
		else		
			triggerClientEvent ( client, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )			
		end		
	else	
		triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )		
	end
end 
addEvent ( "fraktionsMenu_uninvite", true )
addEventHandler ( "fraktionsMenu_uninvite", getRootElement(), fraktionsMenu_uninvite )  

function fraktionsMenu_warn ( target, time, ...)
	local rt = getRealTime ()
	local timesamp = rt.timestamp
	local reason = table.concat( {...}, " " )
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    if faction > 0 and rank >= 5 then
        if tonumber(time) >= 1 then
			local reason = table.concat( {...}, " " )
            local targetpl = getPlayerFromName ( target )
            if isElement ( targetpl ) then
                if faction == getPlayerFaction( targetpl ) and getPlayerRank ( targetpl ) <= 4 then
                    outputChatBox ( "Du hast eine Fraktions-Verwarnung von "..getPlayerName(client).." erhalten. (Grund: "..reason..", Zeit: "..time.." Tage)", targetpl, 0, 125, 0 )
                    dbExec ( handler, "INSERT INTO fraktionen_warns (UID, Fraktion, reason, ExpirationDate) VALUES (?, ?, ?, ?)", playerUID[target], faction, tostring(reason), math.floor(time*86400)+timesamp  )
                    outputChatBox ( "Du hast den Spieler "..getPlayerName(targetpl).." verwarnt. (Grund: "..tostring(reason)..", Zeit: "..time.." Tage)", client, 0, 125, 0 )
					outputLog ( "[WARN] "..getPlayerName ( client ).."  hat "..target.." verwarnt  (Grund: "..tostring(reason)..", Zeit: "..time.." Tage)", "fraktion"..faction )
                else
                    triggerClientEvent ( client, "infobox_start", getRootElement(), "Du kannst den\nSpieler nicht verwarnen", 5000, 125, 0, 0 )
                end
            elseif playerUID[target] then
                local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "Fraktion", "FraktionsRang", "userdata", "UID", playerUID[target] ), -1 )
                if result and result[1] and tonumber ( result[1]["Fraktion"] ) == faction then
                    if tonumber ( result[1]["FraktionsRang"] ) <= 4 then
                        dbExec ( handler, "INSERT INTO fraktionen_warns (UID, Fraktion, reason, ExpirationDate) VALUES (?, ?, ?, ?)", playerUID[target], faction, tostring(reason), math.floor(time*86400)+timesamp  )
                        outputChatBox ( "Du hast den Spieler "..target.." verwarnt. (Grund: "..tostring(reason)..", Zeit: "..time.." Tage)", client, 0, 125, 0 )
                        offlinemsg ( "Du hast eine Fraktions-Verwarnung von "..getPlayerName(client).." erhalten. (Grund: "..tostring(reason)..", Zeit: "..time.." Tage)", "Fraktionssystem", target )
						outputLog ( "[WARN] "..getPlayerName ( client ).."  hat "..target.." verwarnt  (Grund: "..tostring(reason)..", Zeit: "..time.." Tage)", "fraktion"..faction )
                    else
                        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu kannst einen\nLeader nicht verwarnen!", 5000, 125, 0, 0 )
                    end
                else
                    triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Spieler ist\nnicht in deiner Fraktion!", 5000, 125, 0, 0 )
                end
            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nFalscher Grund\noder Zeit.!", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fraktionsMenu_warn", true )
addEventHandler ( "fraktionsMenu_warn", getRootElement(),  fraktionsMenu_warn )

function fraktionsMenu_invite ( target )
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    local targetpl = getPlayerFromName ( target )
    if rank >= 4 then
        if isElement ( targetpl ) then
            local targetfaction = getPlayerFaction ( targetpl )
            if targetfaction == 0 then
                vioSetElementData ( targetpl, "fraktion", faction )
                vioSetElementData ( targetpl, "rang", 0 )
                vioSetElementData ( targetpl, "FraktionenBetreten", vioGetElementData ( targetpl, "FraktionenBetreten" ) + 1 )
                fraktionMembers[faction][targetpl] = faction
                triggerClientEvent ( targetpl, "triggeredBlacklist", targetpl, blacklistPlayers[faction] )
                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "LastFactionChange", timestampOptical(), "UID", playerUID[getPlayerName(targetpl)] )
                outputChatBox ( "Du wurdest soeben in eine Fraktion aufgenommen! Tippe /t [Text] für den Chat und F1, um mehr zu erfahren!", targetpl, 0, 125, 0 )
                outputChatBox ( "Du hast den Spieler "..target.." in deine Fraktion aufgenommen!", client, 0, 125, 0 )
				outputLog ( "[INVITE] "..getPlayerName ( client ).."  hat "..target.." in die Fraktion aufgenommen.", "fraktion"..faction )
                if faction == 1 or faction == 6 or faction == 8 then
                    bindKey ( targetpl, "y", "down", "chatbox", "t" )
                end

            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "Der Spieler\nist in einer Fraktion!", 5000, 125, 0, 0 )
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nUngueltiger\nSpieler!", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fraktionsMenu_invite", true )
addEventHandler ( "fraktionsMenu_invite", getRootElement(), fraktionsMenu_invite )

function fraktionsMenu_setCarRang ( id, rang, carname )
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    if rank >= 4 then
        if rang <= 5 then
            for veh, _ in pairs ( factionVehicles[faction] ) do
                if getElementData ( veh, "ID") == tonumber(id) then
                    setElementData(veh, "Rang", rang)
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "fraktionen_vehicle", "Rang", rang, "ID", id )
                    outputChatBox ( "Du hast benötigten Rang von "..carname.." (ID: "..id..") auf "..rang.." gesetzt. ", client, 0, 125, 0 )
                end
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDer Rang ist\nzu hoch.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fraktionsMenu_setCarRang", true )
addEventHandler ( "fraktionsMenu_setCarRang", getRootElement(), fraktionsMenu_setCarRang )

function fraktionsMenu_sellCar (id, carname)
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    if rank >= 4 then
        local result = dbQuery ( handler, "SELECT * FROM fraktionen_vehicle WHERE ??=?", "ID", id )
        if dbExist ( "fraktionen_vehicle", "ID LIKE '"..id.."'") then
            local model = getVehicleModelFromName(carname)
			
            local result = dbQuery ( handler, "SELECT * FROM fraktionen WHERE ??=?", "ID", faction)
            if result then
                local rows, numrows = dbPoll(result, -1)
                if(numrows > 0) then
                    for k, rows in ipairs(rows) do
                        DepotGeld = tonumber(rows.DepotGeld)
                    end
                end
            end
            local result = dbQuery ( handler, "SELECT * FROM fraktionen_buy_vehicle WHERE ??=?", "Modell", model )
            if result then
                local rows, numrows = dbPoll(result, -1)
                if(numrows > 0) then
                    for k, rows in ipairs(rows) do
                        local preis = tonumber(rows.Preis)
                        local moneyback = math.floor(preis/2)
						for veh, _ in pairs ( factionVehicles[faction] ) do
							if getElementData ( veh, "ID") == tonumber(id) then
								destroyElement(veh)
							end
						end
                        dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "fraktionen_vehicle", "ID", id )
                     --   dbExec ( handler, "UPDATE ?? SET ??=? WHERE ?? = ?", "fraktionen", "DepotGeld", DepotGeld+moneyback,  "ID", faction )
						factionDepotData["money"][faction] = factionDepotData["money"][faction] + moneyback
						triggerClientEvent ( client, "infobox_start", getRootElement(), carname.." für\n"..moneyback.."$ verkauft.", 5000, 125, 0, 0 )
						outputLog ( "[CAR-Sell] "..getPlayerName ( client ).."  hat "..carname.." für "..moneyback.."$ verkauft.", "fraktion"..faction )
                    end
                end
            end
        end
    end
end
addEvent ( "fraktionsMenu_sellCar", true )
addEventHandler ( "fraktionsMenu_sellCar", getRootElement(), fraktionsMenu_sellCar )

function fraktionsMenu_orten ( id )
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    if rank >= 0 then
        if not VehicleFinder[client] then
            for veh, _ in pairs ( factionVehicles[faction] ) do
                if getElementData ( veh, "ID") == tonumber(id) then
                    VehicleFinder[client]  = createBlipAttachedTo(veh, 0, 3 )
					setElementVisibleTo ( VehicleFinder[client], root, false )
					setElementVisibleTo(VehicleFinder[client], client, true)
                    local driver = getVehicleOccupant ( veh ,0 )
                    if driver then
                        triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Fahrer heißt: "..getPlayerName(driver), 5000, 255, 0, 0 )
                    end
                    setTimer ( function()
                        destroyElement(VehicleFinder[client])
                        VehicleFinder[client]  = nil
                    end, 15000, 1 )
                end
            end
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "\nEin Blip ist\nnoch vorhanden!", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )

    end
end
addEvent ( "fraktionsMenu_orten", true )
addEventHandler ( "fraktionsMenu_orten", getRootElement(), fraktionsMenu_orten  )
 
 
function fraktionsMenu_deleteWarn ( id )
    local faction = getPlayerFaction ( client )
    local rank = getPlayerRank ( client )
    if rank == 5 then
		 triggerClientEvent ( client, "infobox_start", getRootElement(), "\nWarn gelöscht.", 5000, 125, 0, 0 )
	   	dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "fraktionen_warns", "ID", id )
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fraktionsMenu_deleteWarn", true )
addEventHandler ( "fraktionsMenu_deleteWarn", getRootElement(), fraktionsMenu_deleteWarn  )

function loadLog()
	local faction = getPlayerFaction ( client )
	local file = fileOpen(":vio_stored_files/logs/fraktion"..faction..".log", true)
	if (file) then
		local text = fileRead(file, getScriptEnd(file))
		triggerClientEvent(client, "loadLog", client, text)
		fileClose(file)
  end    
end
addEvent("loadLog", true) 
addEventHandler("loadLog", getRootElement(), loadLog)



function loadMemo ()
    local faction = getPlayerFaction ( client )
    local result = dbQuery ( handler, "SELECT * FROM fraktionen WHERE ??=?", "ID", faction )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                triggerClientEvent ( client, "setMemo", getRootElement(), rows.Notiz)
            end
        end
    end
end
addEvent ( "loadMemo", true )
addEventHandler ( "loadMemo", getRootElement(), loadMemo  )

function setMemo (text)
		local faction = getPlayerFaction ( client )
		dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "fraktionen", "Notiz", text, "ID", faction )
end
addEvent ( "setMemo", true )
addEventHandler ( "setMemo", getRootElement(), setMemo  )


