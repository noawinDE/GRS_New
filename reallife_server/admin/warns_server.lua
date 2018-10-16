
function getTimestamp ()

	local time = getRealTime()
	return time.timestamp
end


function getData (timestamp)

	local time = getRealTime(timestamp,true)
	local year = tostring( time.year + 1900 )
	local month = tostring( time.month + 1 )
	local day = tostring( time.monthday )
	local hour = tostring( time.hour )
	local minute = tostring( time.minute )
	local second = tostring ( time.second + 1 )
	if  #month == 13 then
		month = 1
	end
	if #month == 1 then
		month = "0"..month
	end
	if #day == 1 then
		day = "0"..day
	end
	if #hour == 1 then
		hour = "0"..hour
	end
	if #minute == 1 then
		minute = "0"..minute
	end
	if #second == 1 then
		second = "0"..second
	end
	local data = day.."."..month..","..year.." "..hour..":"..minute..":"..second
	return data
end

function getPlayerWarns ( name ) 
	local result = dbPoll ( dbQuery ( handler, "SELECT adminUID, reason, time, date, Abgelaufen FROM warns WHERE UID = ?", playerUID[name]), -1 )
	if result then
		local count = #result
		if count > 0 and tonumber(result[i]["Abgelaufen"]) == 0 then
			local array = {}
			for i = 1, count do
			
				array[i] = { ["adminUID"] = result[i]["adminUID"], ["date"] = result[i]["date"], ["reason"] = result[i]["reason"], ["time"] = result[i]["time"] }
				
			end
			return array
		end
		return 0
	end
	return 0
end

function getPlayerWarnCount ( name )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=? AND WHERE ?? NOT LIKE ?", "UID",  "warns", "UID", playerUID[name], "Abgelaufen", 0 ), -1 )
	local count = 0
	if result and result[1] then
		count = #result
	end
	return count
end

function checkExpiredWarns ( player )
	local pname = getPlayerName ( player )
    local result = dbPoll ( dbQuery ( handler, "SELECT ??,??, ??, ??, ?? FROM ?? WHERE ??=? ", "time", "adminUID", "id", "date","Abgelaufen", "warns", "UID", playerUID[pname] ), -1 )
    local rt = getRealTime ()
    local timesamp = rt.timestamp

    if result and result[1] and tonumber(result[1]["Abgelaufen"]) == 0  then
        local warntime = tonumber( result[1]["time"] )
        if warntime < timesamp then
            outputChatBox ( "Die Verwarnung vom "..getData(result[1]["date"]).." von "..playerUIDName[result[1]["adminUID"]].." ist abgelaufen. ID: "..result[1]["id"], player, 255, 0, 0 )
            dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "warns", "id", result[1]["id"] )
			dbExec ( handler, "UPDATE ?? SET ??=?, ??=?, ??=? WHERE ??=?", "warns", "Abgelaufen", getData ( getTimestamp () ), "id", result[1]["id"] )
            outputDebugString("[WARNSYSTEM] Der Warn von "..pname.." ist abgelaufen.")
			outputLog ( "Der Warn von "..pname.." ist abgelaufen.", "warn" )
			checkExpiredWarns ( player )
        end
	end
end


			
		
function getLowestWarnExtensionTime ( name )
	local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=? AND ?? NOT LIKE ? ORDER BY time ASC LIMIT 1", "time", "warns", "UID", playerUID[name], "Abgelaufen", 0 ), -1 )
	if result and result[1] then
		return getData(result[1]["time"])
	end
	return false
end

function outputPlayerWarns ( name, reader )
	local array = getPlayerWarns ( name ) 
	local count = type ( array ) == "number" and 0 or #array
	outputChatBox ( "Warns: "..count, reader, 200, 200, 0 )
	if count > 0 then
		for i = 1, count do
			outputChatBox ( "Warn "..i..":", reader, 255, 0, 0 )
			outputChatBox ( "Von: "..playerUIDName[array[i].adminUID].." ( "..getData(array[i].date).." ), Grund: "..array[i].reason, reader, 255, 0, 0 )
			outputChatBox ( "Ablaufdatum: "..getData(array[i].time), reader, 255, 0, 0 )
		end
	end
end
addCommandHandler ( "warns", function ( player )
	outputPlayerWarns ( getPlayerName ( player ), player )
end )
addCommandHandler ( "checkwarns", function ( player, cmd, name )
	outputPlayerWarns ( name, player )
end )
addEvent ( "checkwarns", true )
addEventHandler ( "checkwarns", root, function ( name )
	outputPlayerWarns ( name, client )
end )


function warn_func ( player, cmd, name, extends, ... )

	if getElementType ( player ) == "console" or vioGetElementData ( player, "adminlvl" ) >= 3 and ( not client or client == player ) then
		local suspect = findPlayerByName ( name )
		local playerexists = false
		if not suspect then
			if playerUID[name] then
				suspect = name
			end
		end
		if suspect then
			local reason = {...}
			reason = table.concat( reason, " " )		
			if extends and tonumber(extends) ~= nil then
				local extends = math.abs ( math.floor ( tonumber ( extends ) ) )
				if extends and extends > 0 then -- and extends <= 365 then
					local admin = getPlayerName ( player )
					local rt = getRealTime ()
					local month = rt.month + 1
					local day = rt.monthday
					local year = rt.year+1970
					local timesamp = rt.timestamp -- + (30 * 86400)
				
					dbExec ( handler, "INSERT INTO ?? ( ??,??,??,??,??) VALUES (?,?,?,?,?)", "warns", "UID", "adminUID", "reason", "time", "date", playerUID[name], playerUID[admin], reason, timesamp + extends*60 , timesamp )
					if isElement ( suspect ) then
						vioSetElementData ( suspect, "warns", vioGetElementData ( suspect, "warns" ) + 1 )
						if getPlayerWarnCount ( name ) == 3 then
							kickPlayer ( suspect, "Von: "..admin..", Grund: "..reason.." (Gebannt, 3 Verwarnungen)" )
						else
							if extends == 1 then
								praefix = "Tag"
							else
								praefix = "Tage"
							end
							outputChatBox ( "Du wurdest von "..admin.." verwarnt! Grund: "..reason..", Ablaufzeit: "..extends.." "..praefix.."!", suspect, 255, 0, 0 )
							outputChatBox ( "Beim dritten Warn wirst du automatisch gebannt. Tippe /warns, um deine Verwarnungen einzusehen.", suspect, 255, 0, 0 )
						end
					else
						offlinemsg ( "Du wurdest von "..admin.." verwarnt; Grund: "..reason, "Server", name )
					end
					outputChatBox ( "Du hast "..name.." verwarnt!", player, 0, 200, 0 )
				else
					infobox ( player, "Gebrauch:\n/warn [Name]\n[1-365]\n[Grund]", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "Gebrauch:\n/warn [Name]\n[Dauer in Tagen]\n[Grund]", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "Der Spieler\nexistiert nicht!", 5000, 125, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
	end
end
addCommandHandler ( "warn", warn_func )
addEvent ( "warn", true )
addEventHandler ( "warn", getRootElement(),
	function ( name, extends, reason )
		warn_func ( client, "warn", name, extends, reason )
	end
)


function deletewarn_func ( player, cmd, target )
    if vioGetElementData ( player, "adminlvl" ) >= 5 then
		if target and playerUID[target] then
			local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "UID", "warns", "UID", playerUID[target] ), -1 )
			if result and result[1] then
				dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "warns", "UID", playerUID[target] )
				outputChatBox ( "Die Warns von "..target.." wurde erfolgreich gelöscht", player, 0, 125, 0 )
				outputAdminLog ( getPlayerName ( player ).." hat die Warns von "..target.." gelöscht." )
				local targetpl = getPlayerFromName ( target )
				if isElement ( targetpl ) then
					vioSetElementData ( targetpl, "warns", vioGetElementData ( targetpl, "warns" ) + 1 )
				end
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "Gebrauch:\n/deletewarn NAME", 5000, 255, 0, 0 )
		end
	else
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht authorisiert,\ndiesen Befehl zu nutzen.", 5000, 255, 0, 0 )
    end
end
addCommandHandler ( "deletewarn", deletewarn_func )