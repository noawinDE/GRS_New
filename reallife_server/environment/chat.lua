allTeam = createTeam ( "ChatTeam", 255, 255, 255 )
playerHelpBlipTimerMechaniker = {}
playerHelpBlipTimerMedic = {}
playerHelpBlip = {}
chatHelpBlipMedic = {}
chatHelpBlipMechaniker = {}

function afind(message,symbol)
	stcounter=0
	x,y=string.find(message,symbol,1,true)
	if(x)then
		stcounter=stcounter+1
		n=0
		while n~=1 do
			x,y=string.find(message,symbol,y+1,true)
			if(x)then
				stcounter=stcounter+1
			else
				n=1
			end
		end
	end
	return stcounter



end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

function checkServerWerbung(thePlayer,Message)

	local newmessage=Message
	Message=string.lower(Message)
	local counter=0
	
	counter=counter+afind(Message,"reallife")
	counter=counter+afind(Message,"www.")
	counter=counter+afind(Message,"http")
	counter=counter+afind(Message,".de")
	counter=counter+afind(Message,".com")
	counter=counter+afind(Message,".net")
	counter=counter+afind(Message,".at")
	counter=counter+afind(Message,".org")
	counter=counter+afind(Message,".info")
	counter=counter+afind(Message,".biz")
	counter=counter+afind(Message,".eu")
	counter=counter+afind(Message,".name")
	counter=counter+afind(Message,".nl")
	counter=counter+afind(Message,".ch")
	counter=counter+afind(Message,".cz")
	counter=counter+afind(Message,".co")
	counter=counter+afind(Message,".me")
	counter=counter+afind(Message,".ru")
	counter=counter+afind(Message,"ilife")
	--counter=counter+afind(Message,"se")
	counter=counter+afind(Message,".ws")
	counter=counter+afind(Message,"vio")
	counter=counter+afind(Message,"exo")
	counter=counter+afind(Message,"eXo")
	counter=counter+afind(Message,"terratex")
	counter=counter+afind(Message,"skyline")
	counter=counter+afind(Message,"gaming")
	counter=counter+afind(Message,"ghost")

      
	
	for key,domain in ipairs(config["domains"])do
		if(afind(Message,domain)>0)then
			counter=0
		end
	end
	
	
	
	
	if(counter>0)then

			local pname = getPlayerName ( thePlayer )
					for playeritem, index in pairs(adminsIngame) do 
					outputChatBox ( "[SERVERWERBUNG VON "..pname.."] MESSAGE: "..newmessage.."", playeritem, 255, 255, 0 )
					end
					outputLog ( "[SERVERWERBUNG VON "..pname.."] MESSAGE: "..newmessage.."", "serverwerbung" )
					 
		
	end
end

function playerJoinTeam ()

	setPlayerTeam ( source, allTeam )
end
addEventHandler ( "onPlayerJoin", getRootElement(), playerJoinTeam )

function chatAble ( player )
	
	if vioGetElementData ( player, "loggedin" ) == 1 and not isPedDead ( player ) then
		return true
	end
	return false
end

function sendMessageToNearbyPlayers ( message, messageType )
	local pname = getPlayerName ( source )
	
	if messageType == 0 and chatAble ( source ) then
		if tonumber(vioGetElementData ( source, "muted" )) == 0 then
			local posX, posY, posZ = getElementPosition( source )
			local chatSphere = createColSphere( posX, posY, posZ, 10 )
			local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
			destroyElement( chatSphere )
			if vioGetElementData ( source, "isLive" ) then
				if isReporter ( source ) then name = "Reporter "..getPlayerName(source).." : " else name = "Gast "..getPlayerName(source).." : " end
				outputChatBox ( name..message, getRootElement(), 200, 150, 0 )
				checkServerWerbung(source,message)
			else
				local x1, y1, z1 = getElementPosition ( source)
				for i = 1, 3 do
					if isElement( _G["Wanze"..i] ) then
						local x2, y2, z2 = getElementPosition ( _G["Wanze"..i] )
						local x3, y3, z3 = getElementPosition ( FederalBoxville )
						local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
						if distance then
							if distance <= 10 then
								if getDistanceBetweenPoints3D ( x3, y3, z3, x2, y2, z2 ) <= wanzenrange then
									local msg = "Wanze "..i.." - "..getPlayerName(source)..": "..message
									sendMSGToBoxville ( msg )
								end
							end
						end
					end
				end
				outputLog ( pname.. " sagt: " ..message, "Chat" )
				
				for i=1, #nearbyPlayers do
					local nearbyPlayer = nearbyPlayers[i]
					local x2, y2, z2 = getElementPosition ( nearbyPlayer )
					local distance = getDistanceBetweenPoints3D ( x1,y1,z1,x2,y2,z2 )
					local rgb = 15 * distance - 125
					local rgb = math.abs ( rgb - 255 ) + 125
					if getElementDimension ( source ) == getElementDimension ( nearbyPlayer ) then
						if vioGetElementData ( source, "call" ) then
							if isElement ( nearbyPlayer ) then
								outputChatBox ( pname.. " (Handy) sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
								checkServerWerbung(source,message)
							end
						else
							if vioGetElementData ( source, "callswithpolice" ) == true then
								local taeter = getPlayerFromName ( message )
								if taeter then
									outputChatBox ( "Wir werden der Sache nachgehen.", source, 0, 0, 200 )
									crime = "none"
									if vioGetElementData ( taeter, "lastcrime" ) == "mord" then
										crime = "Mord"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drogen" then
										crime = "Drogennehmen"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "drugdealing" then
										crime = "Drogenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "mats" then
										crime = "Waffenhandel"
									elseif vioGetElementData ( taeter, "lastcrime" ) == "violance" then
										crime = "Körperverletzung"
									end
									if crime ~= "none" then
										outputChatBox ( "Du hast ein Verbrechen begangen: "..crime..", gemeldet von: "..getPlayerName(source), taeter, 0, 0, 150 )
										if vioGetElementData ( taeter, "wanteds" ) <= 5 then
											vioSetElementData ( taeter, "wanteds", vioGetElementData ( taeter, "wanteds" ) + 1 )
											setPlayerWantedLevel ( taeter, vioGetElementData ( taeter, "wanteds" ) )
										end
										vioSetElementData ( taeter, "lastcrime", "none" )
									end
								else
									outputChatBox ( "Es tut uns Leid Sir, der Täter ist uns unbekannt.", source, 0, 0, 200 )
								end
								vioSetElementData ( source, "callswithpolice", false )
							elseif vioGetElementData ( source, "callswithmedic" ) == true then
								vioSetElementData ( source, "callswithmedic", false )
								sendMSGForFaction ( "[ACHTUNG] "..getPlayerName(source).." braucht Hilfe: "..message, 10, 0, 255, 0 )
								sendMSGForFaction ( "Ihr könnt helfen mit \"/komme NAME\".", 10, 0, 255, 0 )
								outputChatBox ( "Bitte warten Sie an ihrer Position!", source, 200, 200, 200 )
								local x, y, z = getElementPosition ( source )
								chatHelpBlipMedic[source] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999, nil)
								setElementVisibleTo ( chatHelpBlipMedic[source], getRootElement(), false )
								for playeritem, key in pairs (fraktionMembers[10]) do
									setElementVisibleTo ( chatHelpBlipMedic[source], playeritem, true )
								end
								vioSetElementData ( source, "needhelpmedic", true )
								if isTimer(playerHelpBlipTimerMedic[source]) then
									killTimer ( playerHelpBlipTimerMedic[source] )
									if isElement(chatHelpBlipMedic[source]) then
										destroyElement ( chatHelpBlipMedic[source] )
									end
								end
								playerHelpBlipTimerMedic[source] = setTimer ( function(player) if isElement(chatHelpBlipMedic[player]) then destroyElement(chatHelpBlipMedic[player]) end end, 3*60*1000, 1, source )
							elseif vioGetElementData ( source, "callswithmechaniker" ) == true then
								vioSetElementData ( source, "callswithmechaniker", false )
								sendMSGForFaction ( "[ACHTUNG] "..getPlayerName(source).." braucht Hilfe: "..message, 11, 0, 255, 0 )
								sendMSGForFaction ( "Ihr könnt helfen mit \"/komme NAME\".", 11, 0, 255, 0 )
								outputChatBox ( "Bitte warten Sie an ihrer Position!", source, 200, 200, 200 )
								local x, y, z = getElementPosition ( source )
								chatHelpBlipMechaniker[source] = createBlip ( x, y, z, 0, 2, 255, 0, 0, 255, 0, 99999, nil)
								setElementVisibleTo ( chatHelpBlipMechaniker[source], getRootElement(), false )
								for playeritem, key in pairs (fraktionMembers[11]) do
									setElementVisibleTo ( chatHelpBlipMechaniker[source], playeritem, true )
								end
								vioSetElementData ( source, "needhelpmechaniker", true )
								if isTimer(playerHelpBlipTimerMechaniker[player]) then
									killTimer ( playerHelpBlipTimerMechaniker[player] )
									if isElement(chatHelpBlipMechaniker[player]) then
										destroyElement ( chatHelpBlipMechaniker[player] )
									end
								end
								playerHelpBlipTimerMechaniker[source] = setTimer ( function(player) if isElement(chatHelpBlipMechaniker[player]) then destroyElement(chatHelpBlipMechaniker[player]) end end, 3*60*1000, 1, source )
							else
								outputChatBox ( pname.. " sagt: " ..message, nearbyPlayer, rgb, rgb, rgb )
								checkServerWerbung(source,message)
								
							end
						end
					end
				end
			end
			if isElement ( vioGetElementData(source,"callswith") ) then
				local target = vioGetElementData(source,"callswith")
				outputChatBox ( pname.." am Handy: "..message, target, 200, 200, 50 )
				checkServerWerbung(source,Message)
			end
		else
			outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
		end
	else
		if messageType == 2 then
			executeCommandHandler ( "t", source, message )
		elseif messageType == 1 then
			if tonumber(vioGetElementData ( source, "muted" )) == 0 then
				local posX, posY, posZ = getElementPosition( source )
				local chatSphere = createColSphere( posX, posY, posZ, 20 )
				local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
				destroyElement( chatSphere )
				for i=1, #nearbyPlayers do
					local pname = getPlayerName ( source )
					outputChatBox ( pname.." "..message, nearbyPlayers[i], 100, 0, 200 )
					checkServerWerbung(source,Message)
				end
				outputLog (  pname.." "..message, "Chat" )
			else
				outputChatBox ( "Du bist gemuted und kannst deshalb nicht sprechen!", source, 125, 0, 0 )
			end
		end
	end
end
addEventHandler( "onPlayerChat", getRootElement(), sendMessageToNearbyPlayers )

function meCMD_func ( player, cmd, ... )
	local tb = {...}
	local msg = table.concat ( tb, " " )
	
	local pname = getPlayerName ( player )
	local posX, posY, posZ = getElementPosition ( player )
	local chatSphere = createColSphere( posX, posY, posZ, 20 )
	local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
	destroyElement( chatSphere )
	for i=1, #nearbyPlayers do
		local pname = getPlayerName ( player )
		outputChatBox ( pname.." "..msg, nearbyPlayers[i], 200, 0, 200 )
		checkServerWerbung(player,msg)
	end
	outputLog ( "meCMD"..pname.." "..msg, "Chat" )
end
addCommandHandler ( "meCMD", meCMD_func )

function blockmsg ( message, messageType )
	cancelEvent()
end
addEventHandler( "onPlayerChat", getRootElement(), blockmsg )

function s_func ( player, cmd, ... )
	if chatAble ( player ) then
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere( posX, posY, posZ, 20 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		local parametersTable = {...}
		local stringWithAllParameters = table.concat( parametersTable, " " )
		local pname = getPlayerName ( player )
		for i=1, #nearbyPlayers do
			outputChatBox ( pname.." schreit: "..stringWithAllParameters.."!!!", nearbyPlayers[i], 255, 255, 255 )
			checkServerWerbung(player,stringWithAllParameters)
		end
		outputLog ( pname.." schreit: "..stringWithAllParameters.."!!!", "Chat" )
	end
end
addCommandHandler ( "s", s_func )

function l_func ( player, cmd, ... )
	if chatAble ( player ) then
		local posX, posY, posZ = getElementPosition( player )
		local chatSphere = createColSphere( posX, posY, posZ, 3 )
		local nearbyPlayers = getElementsWithinColShape( chatSphere, "player" )
		destroyElement( chatSphere )
		local parametersTable = {...}
		local stringWithAllParameters = table.concat( parametersTable, " " )
		local pname = getPlayerName ( player )
		for i=1, #nearbyPlayers do
			outputChatBox ( pname.." fluestert: "..stringWithAllParameters.."...", nearbyPlayers[i], 150, 150, 150 )
			checkServerWerbung(player,stringWithAllParameters)
		end
		outputLog ( pname.." fluestert: "..stringWithAllParameters.."...", "Chat" )
	end
end
addCommandHandler ( "l", l_func )


function comeToHelp ( player, cmd, target )
	if target and findPlayerByName(target) then
		local targetpl = findPlayerByName(target)
		if isEmergencyOnDuty ( player ) then
			if isMedic ( player ) then
				if vioGetElementData ( targetpl, "needhelpmedic" ) then
					outputChatBox ( "Ein Sanitäter ist auf dem Weg zu dir!", targetpl, 0, 255, 0 )
					sendMSGForFaction ( getPlayerName(player).." hat den Auftrag von "..getPlayerName(targetpl).. " angenommen!", 10, 0, 0, 255 )
					vioSetElementData ( targetpl, "needhelpmedic", false )
					if isTimer(playerHelpBlipTimerMedic[targetpl]) then
						killTimer ( playerHelpBlipTimerMedic[targetpl] ) 
						playerHelpBlipTimerMedic[targetpl] = nil
					end
					if isElement(chatHelpBlipMedic[targetpl]) then
						destroyElement ( chatHelpBlipMedic[targetpl] )
					end
					local x, y, z = getElementPosition ( targetpl )
					chatHelpBlipMedic[targetpl] = createBlipAttachedTo ( targetpl, 0, 2, 255, 0, 0, 255, 0, 99999, player )
					playerHelpBlipTimerMedic[targetpl] = setTimer ( function (target) 
						if isTimer(playerHelpBlipTimerMedic[target]) then
							killTimer ( playerHelpBlipTimerMedic[target] ) 
							playerHelpBlipTimerMedic[target] = nil	
						end
						if isElement(chatHelpBlipMedic[target]) then
							destroyElement ( chatHelpBlipMedic[target] )
							chatHelpBlipMedic[target] = nil
						end
					end, 4*60*1000, 1, targetpl )
				else
					infobox ( player, "Der Spieler\nbraucht keine\nHilfe!", 5000, 125, 0, 0 )
				end
			elseif isMechaniker ( player ) then
				if vioGetElementData ( targetpl, "needhelpmechaniker" ) then
					outputChatBox ( "Ein Mechaniker ist auf dem Weg zu dir!", targetpl, 0, 255, 0 )
					sendMSGForFaction ( getPlayerName(player).." hat den Auftrag von "..getPlayerName(targetpl).. " angenommen!", 11, 0, 0, 255 )
					vioSetElementData ( targetpl, "needhelpmechaniker", false )
					if isTimer(playerHelpBlipTimerMechaniker[targetpl]) then
						killTimer ( playerHelpBlipTimerMechaniker[targetpl] )
						playerHelpBlipTimerMechaniker[targetpl] = nil					
					end
					if isElement(chatHelpBlipMechaniker[targetpl]) then
						destroyElement ( chatHelpBlipMechaniker[targetpl] )
					end
					local x, y, z = getElementPosition ( targetpl )
					chatHelpBlipMechaniker[targetpl] = createBlipAttachedTo ( targetpl, 0, 2, 0, 200, 200, 255, 0, 99999, player )
					setTimer ( function (target) 
						if isTimer(playerHelpBlipTimerMechaniker[targetpl]) then
							killTimer ( playerHelpBlipTimerMechaniker[targetpl] ) 
							playerHelpBlipTimerMechaniker[targetpl] = nil	
						end
						if isElement(chatHelpBlipMechaniker[targetpl]) then
							destroyElement ( chatHelpBlipMechaniker[targetpl] )
							chatHelpBlipMechaniker[targetpl] = nil
						end
					end, 4*60*1000, 1, targetpl )
				else
					infobox ( player, "Der Spieler\nbraucht keine\nHilfe!", 5000, 125, 0, 0 )
				end
			else
				infobox ( player, "\nDu gehörst nicht\nzur Emergency!", 5000, 125, 0, 0 )
			end
		else
			infobox ( player, "Du bist kein\nEmergency im\nDienst!", 5000, 125, 0, 0 )
		end
	else
		infobox ( player, "Der Spieler\nexistiert nicht\noder ist offline.", 5000, 125, 0, 0 )
	end
end
addCommandHandler ( "komme", comeToHelp )