



function getDataForTeam_func ()

    local fraktion = vioGetElementData ( client, "fraktion" )
	
	local dataString = ""
    local result = dbQuery ( handler, "SELECT * FROM userdata  WHERE Adminlevel NOT LIKE '0'")
    if result then
       row, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, row in ipairs(row) do
				if tonumber(row["Adminlevel"]) == 1 then
                    adminlvl = "Clanmember"
                elseif tonumber(row["Adminlevel"]) == 2 then
                    adminlvl = "Ticketbeauftragter"
                elseif tonumber(row["Adminlevel"]) == 3 then
                    adminlvl = "Supporter"
                elseif tonumber(row["Adminlevel"]) == 4 then
                    adminlvl = "Moderator"
                elseif tonumber(row["Adminlevel"]) == 5 then
                    adminlvl = "Administrator"
                elseif tonumber(row["Adminlevel"]) == 6 then
                    adminlvl = "Administrator M.v"
                elseif tonumber(row["Adminlevel"]) == 7 then
                    adminlvl = "Stv. Projektleiter"
                elseif tonumber(row["Adminlevel"]) >= 8 then
                    adminlvl = "Projektleiter"
                end
				if getPlayerFromName(row["Name"]) then
					dataString = dataString.."|"..row["Name"].."|"..adminlvl.."|"..row["LastLogin"].."|1|~"
				else
					dataString = dataString.."|"..row["Name"].."|"..adminlvl.."|"..row["LastLogin"].."|0|~"
				end
            end
        end
    end
    triggerClientEvent ( client, "faq_addTeam", getRootElement(), numrows, dataString, fraktion )
end
addEvent ( "getDataForTeam", true )
addEventHandler ( "getDataForTeam", getRootElement(), getDataForTeam_func )

function getDataForLeaders_func ()

    local fraktion = vioGetElementData ( client, "fraktion" )
    local dataString = ""
    local result = dbQuery ( handler, "SELECT * FROM userdata WHERE FraktionsRang='5' AND Fraktion NOT LIKE '0' ")
    if result then
        row, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, row in ipairs(row) do
                if getPlayerFromName(row["Name"]) then
                    dataString = dataString.."|"..row["Name"].."|"..fraktionNames[tonumber(row["Fraktion"])].."|"..row["LastLogin"].."|1|~"
                else
                    dataString = dataString.."|"..row["Name"].."|"..fraktionNames[tonumber(row["Fraktion"])].."|"..row["LastLogin"].."|0|~"
                end

            end
        end
    end
    triggerClientEvent ( client, "faq_addLeader", getRootElement(), numrows, dataString, fraktion )
end
addEvent ( "getDataForLeaders", true )
addEventHandler ( "getDataForLeaders", getRootElement(), getDataForLeaders_func )


function getDataForBans_func ()

	local fraktion = vioGetElementData ( client, "fraktion" )
	
	local dataString = ""	
	local sql = mysql_query ( handler, "SELECT * FROM ban" )
	mitglieder = mysql_num_rows(sql)
	
	for i, row in mysql_rows_assoc(sql) do
		local bantimex = math.floor ( ( (row["STime"]- getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
		if tonumber(bantimex) > 0 then
		bantime = bantimex
		else
		bantime = "Permanent"
		end
		dataString = dataString.."|"..row["ID"].."|"..row["Name"].."|"..row["Grund"].."|"..row["Datum"].."|"..bantime.."|"..row["Admin"].."|~"
		
	end
	
	triggerClientEvent ( client, "faq_addBans", getRootElement(), mitglieder, dataString, fraktion )
end
addEvent ( "getDataForBans", true )
addEventHandler ( "getDataForBans", getRootElement(), getDataForBans_func )