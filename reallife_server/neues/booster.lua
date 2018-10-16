local boosterType = { [1] = "XP", [2]="PayDay", [3]="Job"}

function giveBooster ( player, tage, type)

	if tonumber ( tage ) >= 1 then
		if tonumber ( type ) >= 1 then
			local rt = getRealTime ()
			local timesamp = rt.timestamp
			dbExec (handler, "INSERT INTO ?? (??, ??, ??) VALUES (?,?,?)", "booster", "UID", "type", "date", playerUID[getPlayerName(player)], type, timesamp + tage*86400 )			
			outputChatBox ("Du hast einen "..boosterType[type].." Booster erhalten. Haltbar bis: "..getData(timesamp + tage*86400),player, 0, 205, 0)
			
		end
	end
end

function showBooster ( player )

	if vioGetElementData ( player, "loggedin" ) == 1 then
		local pname = getPlayerName ( player )
		local result = dbPoll ( dbQuery ( handler, "SELECT  ??, ?? FROM ?? WHERE ??=? ","date", "type", "booster", "UID", playerUID[pname] ), -1 )
		local rt = getRealTime ()
		local timesamp = rt.timestamp
		if result then
			local count = #result
			if count > 0 then
				outputChatBox ( "Booster:", player, 0, 205, 0 ) 
				for i = 1, count do
					outputChatBox ( boosterType[result[i]["type"]].." Booster bis "..getData(result[i]["date"]), player, 0, 205, 0 ) 
				end
			else
				outputChatBox ( "Keine Booster vorhanden.", player, 255,0, 0 ) 
			end
		end
	end
end
addCommandHandler ( "showbooster" , showBooster)
addCommandHandler ( "booster" , showBooster)

function checkExpiredBooster ( player )
	local pname = getPlayerName ( player )
    local result = dbPoll ( dbQuery ( handler, "SELECT  ??, ??, ?? FROM ?? WHERE ??=? ","date", "type", "id", "booster", "UID", playerUID[pname] ), -1 )
    local rt = getRealTime ()
    local timesamp = rt.timestamp
    if result and result[1] then
        local date = tonumber( result[1]["date"] )
        if date < timesamp then
            outputChatBox ( "Der Booster "..boosterType[result[1]["type"]].." vom "..getData(result[1]["date"]).." ist abgelaufen. ID: "..result[1]["id"], player, 255, 0, 0 )
            outputDebugString("[BOOSTER] Der Booster "..boosterType[result[1]["type"]].." von "..pname.." ist abgelaufen.")
			outputLog ( "Der Booster "..boosterType[result[1]["type"]].." von "..pname.." ist abgelaufen.", "booster" )
			dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "booster", "id", result[1]["id"] )
			checkExpiredBooster ( player )
        end
	end
end
