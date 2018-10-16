
boosterXP = {}

function checkPlayerLevelUP (player)
    local xp		= tonumber(vioGetElementData ( player, "MainXP" ))
    local level	= tonumber(vioGetElementData ( player, "MainLevel" ))
    local nextLVLXP = levelSys[level]
    if xp >= tonumber(nextLVLXP) then
        vioSetElementData ( player, "MainLevel", level + 1)
        level = tonumber(vioGetElementData ( player, "MainLevel" ))
        outputChatBox("[Levelsystem] Du bist soeben auf Level #FFFFFF"..level.."#3ADF00 aufgestiegen.",player,58,223,0,true)
        triggerClientEvent ( player, "drawLevelUP", getRootElement() )
        if dbExist ( "advertisedPlayers", "geworbenerUID LIKE '".. playerUID[getPlayerName(player)].."'") then
			local pname = getPlayerName(player)
			local werberDB = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "werberUID", "advertisedPlayers", "geworbenerUID", playerUID[pname] ), -1 )
            werber = playerUIDName[werberDB[1]["werberUID"]]
         
			local werbeData = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "PremiumCars","Bankgeld", "userdata", "UID", playerUID[werber] ), -1 )
			if not werbeData then
			--	print("NE DAS GIBTS NET")
			end
            if level == 10 then
                outputChatBox("[Werbesystem] Du hast soeben 50.000$ erhalten, da du von "..werber.."  geworben wurdest und Level 10 erreicht hast.",player,58,223,0,true)
                vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney") + 50000)
                if getPlayerFromName (werber) then
                    outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 10 erreicht hast, erhältst du 100.000$.", werber, 125, 0, 0 )
                    vioSetElementData ( getPlayerFromName (werber), "bankmoney", vioGetElementData ( getPlayerFromName (werber), "bankmoney") + 50000)
                else
                    offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 10 erreicht hast, erhältst du 100.000$.", "Werbesystem",werber )
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Bankgeld", tonumber(werbeData[1]["Bankgeld"]) + 100000, "UID", werberDB[1]["werberUID"] )
                end
            elseif level == 20 then
                outputChatBox("[Werbesystem] Du hast soeben 100.000$ erhalten, da du von "..werber.."  geworben wurdest und Level 20 erreicht hast.",player,58,223,0,true)
                vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney") + 100000)
                if getPlayerFromName (werber) then
                    outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 20 erreicht hast, erhältst du eine Premium Fahrzeug Setzung.", getPlayerFromName (werber), 125, 0, 0 )
                    vioSetElementData ( getPlayerFromName (werber), "PremiumCars", vioGetElementData ( getPlayerFromName (werber), "PremiumCars") + 1)
                else
                    offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 20 erreicht hast, erhältst du eine Premium Fahrzeug Setzung.", "Werbesystem",werber )
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "PremiumCars",  tonumber(werbeData[1]["PremiumCars"]) + 1, "UID", werberDB[1]["werberUID"] )
                end
            elseif level == 30 then
                if getPlayerFromName (werber) then
                    outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 30 erreicht hast, erhältst du zwei Premium Fahrzeug Setzung.", getPlayerFromName (werber), 125, 0, 0 )
                    vioSetElementData ( getPlayerFromName (werber), "PremiumCars", vioGetElementData ( getPlayerFromName (werber), "PremiumCars") + 2)
                else
                    offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 30 erreicht hast, du zwei Premium Fahrzeug Setzung.", "Werbesystem",werber )
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "PremiumCars",  tonumber(werbeData[1]["PremiumCars"]) +2, "UID", werberDB[1]["werberUID"] )
                end
            end
        end
    end
end
addEvent("checkPlayerLevelUP", true)
addEventHandler("checkPlayerLevelUP", getRootElement(), checkPlayerLevelUP)





local function testNewLevelSys (player)
    local level	= tonumber(vioGetElementData ( player, "MainLevel" ))
    outputChatBox(levelSys[level])
end
addCommandHandler("testNewLevelSys", testNewLevelSys)




function givePlayerXP(player,xp)
    boosterXP[getPlayerName(player)] = 1
        local result = dbPoll ( dbQuery ( handler, "SELECT  ??, ??, ?? FROM ?? WHERE ??=? ","date", "type", "id", "booster", "UID", playerUID[getPlayerName(player)] ), -1 )
        local rt = getRealTime ()
        local timesamp = rt.timestamp
        if result and result[1] then
            if tonumber( result[1]["type"] ) == 1 then
                boosterXP[getPlayerName(player)] = 2
          --      outputChatBox ( "Durch einen XP Booster wurde deine Erfahrung verdoppelt. ", player, 0, 125, 0 )
            end
        end
			 local mxp = (xp * boosterXP[getPlayerName(player)]) * tonumber(DoubleXP)
			vioSetElementData ( player, "MainXP", mxp + vioGetElementData ( player, "MainXP" ) )
            triggerClientEvent ( player, "showLevel", getRootElement() )
          
            outputChatBox ( "Du hast "..mxp.." XP erhalten, du hast nun "..vioGetElementData ( player, "MainXP" ).." XP. ", player, 0, 125, 0 )
      --  end
end

function goPrestige ()
	print("Trigger2")
	local player = client
    local level	= tonumber(vioGetElementData ( player, "MainLevel" ))
	local pLevel = vioGetElementData ( player, "pLevel")
	if level == maxlevel then
		vioSetElementData ( player, "pLevel", pLevel + 1 )
		vioSetElementData ( player, "MainXP", 0 )
		vioSetElementData ( player, "MainLevel", 1 )
		print("Prestige "..(pLevel+1).." erreicht.")
		return true
	else
		return false
	end
end
addEvent("goPrestige", true)
addEventHandler("goPrestige", getRootElement(), goPrestige)