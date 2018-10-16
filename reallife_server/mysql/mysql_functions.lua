function getCarslotUpdate ( name )
	local result = dbPoll ( dbQuery ( handler, "SELECT CarslotUpdate5, CarslotUpdate4, CarslotUpdate3, CarslotUpdate2, CarslotUpgrades FROM bonustable WHERE UID = ?", playerUID[name] ), -1 )
	if result then
		return tonumber ( result[1]["CarslotUpdate5"] ), tonumber ( result[1]["CarslotUpdate4"] ), tonumber ( result[1]["CarslotUpdate3"] ), tonumber ( result[1]["CarslotUpdate2"] ), result[1]["CarslotUpgrades"]
	end
	outputDebugString ( "[getCarslotUpdate] Error executing the query" )
	return false
end


function setBizDataSQL ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT * from biz" ), -1 )
	if result then
		for i=1, #result do
			local dsatz = result[i]
			bizArray[dsatz["Biz"]] = {
				["biz"] = dsatz["Biz"],
				["name"] = dsatz["Name"],
				["kasse"] = tonumber ( dsatz["Kasse"] ),
				["inhaber"] = playerUIDName[tonumber(dsatz["UID"])],
				["preis"] = tonumber ( dsatz["Preis"] ) }
			if biz == "WellStackedPizza" then
				bizArray[i]["inhaber"] = "Mafia"
				bizArray[i]["preis"] = 99999999
			end
		end
		return true
	end
	outputDebugString ( "[setBizDataSQL] Error executing the query" )
	return false
end


function loadPlayingTimeForSleeplessAchiev ( player, pname )
	local result = dbPoll ( dbQuery ( handler, "SELECT Time from playingtime WHERE UID = ?", playerUID[pname] ), -1 )
	local time = 0
	if result and result[1] then
		time = tonumber ( result[1]["Time"] )
	else
		if not dbExec ( handler, "INSERT INTO playingtime ( UID ) VALUES (?)", playerUID[pname] ) then
			outputDebugString ( "[loadPlayingTimeForSleeplessAchiev] Error executing the query" )
		end
	end
	vioSetElementData ( player, "timePlayedToday", time )
end


function savePlayingTimeForSleeplessAchiev ( player, pname )
	local time = vioGetElementData ( player, "timePlayedToday" )
	dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "playingtime", "Time", time, "UID", playerUID[pname] )
end


function playingTimeResetAtMidnight ()
	dbExec ( handler, "TRUNCATE TABLE playingtime" )
	local players = getElementsByType ( "player" ) 
	for i=1, #players do
		if vioGetElementData ( players[i], "loggedin" ) then
			loadPlayingTimeForSleeplessAchiev ( players[i], getPlayerName ( players[i] ) )
		end
	end
end


function bonusLoad ( player )
	local pname = getPlayerName ( player )
	local dsatz = dbPoll ( dbQuery ( handler, "SELECT * FROM bonustable WHERE UID = ?", playerUID[pname] ), -1 )
	
	if not dsatz or not dsatz[1] then
		if not dbExec ( handler, "INSERT INTO bonustable (UID, Lungenvolumen, Muskeln, Kondition, Boxen, KungFu, Streetfighting, CurStyle, PistolenSkill, DeagleSkill, ShotgunSkill, AssaultSkill) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)", playerUID[pname], 'none', 'none', 'none', 'none', 'none', 'none', '4', 'none', 'none', 'none', 'none' ) then
			outputDebugString ( "[bonusLoad 1] Error executing the query" )
			return false
		end
		dsatz = dbPoll ( dbQuery ( handler, "SELECT * FROM bonustable WHERE UID = ?", playerUID[pname] ), -1 )
	end	
	
	if dsatz and dsatz[1] then
		dsatz = dsatz[1]
		local Lungenvolumen = dsatz["Lungenvolumen"]
		vioSetElementData ( player, "lungenvol", Lungenvolumen )
		if Lungenvolumen ~= "none" then
			setPedStat ( player, 225, 500 )
		end
		local Muskeln = dsatz["Muskeln"]
		vioSetElementData ( player, "muscle", Muskeln )
		if Muskeln ~= "none" then
			setPedStat ( player, 23, 500 )
		end
		local Kondition = dsatz["Kondition"]
		vioSetElementData ( player, "stamina", Kondition )
		if Kondition ~= "none" then
			setPedStat ( player, 22, 500 )
		end
		local PistolenSkill = dsatz["PistolenSkill"]
		vioSetElementData ( player, "pistolskill", PistolenSkill )
		if PistolenSkill ~= "none" then
			setPedStat ( player, 69, 900 )
			setPedStat ( player, 70, 999 )
		end
		local DeagleSkill = dsatz["DeagleSkill"]
		vioSetElementData ( player, "deagleskill", DeagleSkill )
		if DeagleSkill ~= "none" then
			setPedStat ( player, 71, 999 )
		end
		local ShotgunSkill = dsatz["ShotgunSkill"]
		vioSetElementData ( player, "shotgunskill", ShotgunSkill )
		if ShotgunSkill ~= "none" then
			setPedStat ( player, 72, 999 )
			setPedStat ( player, 74, 999 )
		end
		local AssaultSkill = dsatz["AssaultSkill"]
		vioSetElementData ( player, "assaultskill", AssaultSkill )
		if AssaultSkill ~= "none" then
			setPedStat ( player, 77, 999 )
			setPedStat ( player, 78, 999 )
		end
		local MP5Skill = dsatz["MP5Skills"]
		vioSetElementData ( player, "mp5skill", MP5Skill )
		if MP5Skill ~= "none" then
			setPedStat ( player, 76, 999 )
		end
		
		vioSetElementData ( player, "boxen", dsatz["Boxen"] )
		vioSetElementData ( player, "kungfu", dsatz["KungFu"] )
		vioSetElementData ( player, "streetfighting", dsatz["Streetfighting"] )
		setPedFightingStyle ( player, tonumber ( dsatz["CurStyle"] ) )
		vioSetElementData ( player, "vortex", dsatz["Vortex"] )
		vioSetElementData ( player, "quad", dsatz["Quad"] )
		vioSetElementData ( player, "skimmer", tonumber ( dsatz["Skimmer"] ) )
		vioSetElementData ( player, "romero", tonumber ( dsatz["Leichenwagen"] ) )
		vioSetElementData ( player, "carslotupgrade", dsatz["CarslotUpgrades"] )
		vioSetElementData ( player, "bonusskin1", dsatz["BonusSkin1"] )
		vioSetElementData ( player, "chess", dsatz["Schach"] == "1" )
		vioSetElementData ( player, "golfcart", dsatz["Caddy"] == "1" )
		vioSetElementData ( player, "fglass", dsatz["fglass"] == "1" )
		vioSetElementData ( player, "doubleSMG", dsatz["uzi"] == "1" )
		if vioGetElementData ( player, "doubleSMG" ) then
			setPedStat ( player, 75, 999 )
		else
			setPedStat ( player, 75, 600 )
		end
	else
		outputDebugString ( "[bonusLoad 2] Error executing the query" )
		return false
	end
end


function packageLoad ( player )
	local pname = getPlayerName ( player )
	local number = 0
	vioSetElementData ( player, "foundpackages", number )
	local dsatz = dbPoll ( dbQuery ( handler, "SELECT * FROM packages WHERE UID = ?", playerUID[pname] ), -1 )
	if not dsatz then
		if not dbExec ( handler, "INSERT INTO packages (UID, Paket1, Paket2, Paket3, Paket4, Paket5, Paket6, Paket7, Paket8, Paket9, Paket10, Paket11, Paket12, Paket13, Paket14, Paket15, Paket16, Paket17, Paket18, Paket19, Paket20, Paket21, Paket22, Paket23, Paket24, Paket25) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", playerUID[pname],'0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' ) then
			outputDebugString ( "[packageLoad 1] Error executing the query" )
			return false
		end
		dsatz = dbPoll ( dbQuery ( handler, "SELECT * FROM packages WHERE UID = ?", playerUID[pname] ), -1 )
	end
	
	if dsatz and dsatz[1] then
		dsatz = dsatz[1]
		local hasToBeHidden = {}
		for i = 1, #packages do
			local paket = tonumber ( dsatz["Paket"..i] )
			vioSetElementData ( player, "package"..i, paket )
			if paket == 1 then
				number = number + 1
				hasToBeHidden[number] = packages[i]
			end
		end
		vioSetElementData ( player, "foundpackages", number )
		if number > 0 then
			triggerClientEvent ( player, "hidePackagesArray", player, hasToBeHidden )
		end
		return true
	else
		outputDebugString ( "[packageLoad 2] Error executing the query" )
	end
end





function privVeh_spawning ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM vehicles" ), -1 )
	if result then
		if #result > 0 then
			mySQLCarCreate ( result )
		else
			outputServerLog ( "Es wurden keine Autos gefunden" )
		end
	else
		outputDebugString ( "[privVeh_spawning] Error executing the query" )
	end
end


function createCarhouses ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM carhouses_icons" ), -1 )
	if result then
		if #result > 0 then
			mySQLCarhouseCreate ( result )
		else
			outputServerLog ( "Es wurden keine Autohäuser gefunden" )
		end
	else
		outputDebugString ( "[createCarhouses] Error executing the query" )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, createCarhouses )


addEventHandler ( "onResourceStart", resourceRoot, function ()
	local result = dbPoll ( dbQuery ( handler, "SELECT Name, Fraktion, FraktionsRang, LastFactionChange FROM userdata WHERE Fraktion > 0" ), -1 )
	if result then
		for i=1, #result do
			local name = result[i]["Name"]
			local frac = tonumber ( result[i]["Fraktion"] )
			fraktionMemberList[frac][name] = result[i]["FraktionsRang"]
			fraktionMemberListInvite[frac][name] = result[i]["LastFactionChange"]
		end
	end	
end )


function checkBlackListEntrys ()
	local time = getSecTime ( 0 )
	dbExec ( handler, "DELETE FROM ?? WHERE ?? > ?", "blacklist", "Eintragungsdatum", time-14 * 24 * 60 * 60 )
end
addEventHandler ( "onResourceStart", resourceRoot, checkBlackListEntrys )


function getLottoJackpotWinnerMySQL ( l1, l2, l3 )
	local result = dbPoll ( dbQuery ( handler, "SELECT id, UID FROM lotto WHERE z1 = '"..l1.."' AND z2 = '"..l2.."' AND z3 = '"..l3.."'" ), -1 )
	if result then
		local amount = #result
		if amount > 0 then
			local array = {}
			for i=1, amount do
				array[i] = { ["name"] = playerUIDName[tonumber(result[i]["UID"])], ["id"] = result[i]["id"] }
			end
			return array
		end
		return false
	end
	return false
end


function createWeedPlants ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM weed" ), -1 )
	if result and result[1] then
		local amount = #result
		for i=1, amount do
			local id = result[i]["id"]
			local x = result[i]["x"]
			local y = result[i]["y"]
			local z = result[i]["z"]
			local time = result[i]["time"]
			local name = result[i]["name"]
			
			addWeed ( id, x, y, z, time, name )
		end
		outputServerLog ( "Es wurden "..amount.." Hanfpflanzen gefunden!" )
	end
end


function checkForOldMails ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM email" ), -1 )
	if result then
		if result[1] then
			mySQLMailCheck ( result )
		else
			outputServerLog("Es wurden keine Mails gefunden")
		end
	else
		outputDebugString ( "[checkForOldMails] Error executing the query" )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, checkForOldMails )


function mySQLMailCheck ( array )
	local amount = #array
	local deletedMails = 0
	for i=1, #amount do
		if isMailingDateOld ( array[i]["Yearday"], array[i]["Year"] ) then
			dbExec ( handler, "DELETE FROM ?? WHERE ??=? AND ?? LIKE ?", "email", "EmpfaengerUID", playerUID[array[i]["Empfaenger"]], "Text", array[i]["Text"] )
			deletedMails = deletedMails + 1
		end
	end
	outputServerLog("Es wurden "..amount.." E-Mails gefunden und "..deletedMails.." alte Mails geloescht.")
end


function loadOffers ()
	curDrugOffers = 0
	curMatsOffers = 0
	curVehOffers = 0
	curHousesOffers = 0
	curPrestigeOffers = 0
	curGaragesOffers = 0
	curSpecialOffers = 0
	
	DrugOffers = {}
	MatsOffers = {}
	VehOffers = {}
	HousesOffers = {}
	PrestigeOffers = {}
	GaragesOffers = {}
	SpecialOffers = {}
	
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM buyit" ), -1 )
	if result then
		if result[1] then
			for i=1, #result do
				local ID = tonumber ( result[i]["ID"] )
				usedAuktionIDs[ID] = true
				local Typ = result[i]["Typ"]
				_G["cur"..Typ.."Offers"] = _G["cur"..Typ.."Offers"] + 1
				local Anbieter = result[i]["Anbieter"]
				local Hoechstbietender = result[i]["Hoechstbietender"]
				local Hoechstgebot = result[i]["Hoechstgebot"]
				local LaeuftBis = result[i]["LaeuftBis"]
				local Beschreibung = result[i]["Beschreibung"]
				local OptischesDatum = result[i]["OptischesDatum"]
				local Anzahl = result[i]["Anzahl"]
				
				_G[Typ.."Offers"][ID] = ID
				_G[Typ.."Offers"][ID] = {}
				_G[Typ.."Offers"][ID]["Typ"] = Typ
				_G[Typ.."Offers"][ID]["Anbieter"] = Anbieter
				_G[Typ.."Offers"][ID]["Hoechstbietender"] = Hoechstbietender
				_G[Typ.."Offers"][ID]["Hoechstgebot"] = Hoechstgebot
				_G[Typ.."Offers"][ID]["LaeuftBis"] = LaeuftBis
				_G[Typ.."Offers"][ID]["Beschreibung"] = Beschreibung
				_G[Typ.."Offers"][ID]["OptischesDatum"] = OptischesDatum
				_G[Typ.."Offers"][ID]["Anzahl"] = Anzahl
			end
		end
	else
		outputDebugString ( "[loadOffers] Error executing the query" )
	end		
	globalBuyItCheck ()
end
addEventHandler ( "onResourceStart", resourceRoot, loadOffers )


function createSaveAblePlacedObjects ()
	dbExec ( handler, "DELETE FROM object WHERE deleteTime < '"..getMinTime ().."'" )
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM object" ), -1 )
	if result then
		if result[1] then
			for i=1, #result do
				createNextPlaceableObject ( result[i] )
			end
		else
			outputServerLog ( "Es wurden keine platzierbaren Objekte gefunden." )
		end
	else
		outputDebugString ( "[createSaveAblePlacedObjects] Error executing the query" )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, createSaveAblePlacedObjects )


function initTetrisHighscores ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM blocks" ), -1 )
	if result then
		if result[1] then
			mySQLBlocksCreate ( result )
		else
			outputServerLog ( "Es wurden keine Highscores" )
		end
	else
		outputDebugString ( "[initTetrisHighscores] Error executing the query" )
	end
end
addEventHandler ( "onResourceStart", resourceRoot, initTetrisHighscores )


function offlinemsg ( msg, sender, empfaenger )
	local datum = timestamp()
	outputDebugString ( "offlinemsg: "..playerUID[empfaenger] )
	if not dbExec ( handler, "INSERT INTO pm (Sender, EmpfaengerUID, Text, Datum) VALUES (?,?,?,?)", sender, playerUID[empfaenger], msg, datum ) then
		outputDebugString ( "[offlinemsg] Error executing the query" )
		return false
	end
	return true
end


function insertPlayerIntoLoggedIn ( name, ip, serial )
	if not dbExec ( handler, "INSERT INTO loggedin (UID,Serial,IP) VALUES (?,?,?)", playerUID[name], serial, ip ) then
		outputDebugString ( "[insertPlayerIntoLoggedIn] Error executing the query" )
		return false
	end
	return true
end


local wasOnlineToday = {}
local weekdayName = { [0] = "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag", "Sonntag", "Sonntag" }
function loadPlayerStatisticsMySQL ( player )
	local pname = getPlayerName ( player )
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM statistics WHERE UID = ?", playerUID[pname] ), -1 )
	if result and result[1] then
		for column, value in pairs ( result[1] ) do
			vioSetElementData ( player, column, tonumber ( value ) )
		end
		vioSetElementData ( player, "Eingeloggt", vioGetElementData ( player, "Eingeloggt" ) + 1 )
		local realtime = getRealTime()
		local weekday = realtime.weekday
		if not wasOnlineToday[pname] then
			vioSetElementData ( player, weekdayName[weekday].."Spielzeit", realtime.timestamp )
			wasOnlineToday[pname] = true
		else
			local minuten = vioGetElementData ( player, weekdayName[weekday].."Spielzeit" )
			vioSetElementData ( player, weekdayName[weekday].."Spielzeit", realtime.timestamp - minuten * 60 )
		end
		return true
	end
	return false
end


function saveStatisticsMySQL ( player )
	if vioGetElementData ( player, "loggedin" ) == 1 then
		local pname = getPlayerName ( player )
		local ids = {}
		local number = 0
		local result = dbPoll ( dbQuery ( handler, "SELECT * FROM statistics WHERE UID = ?", playerUID[pname] ), -1 )
		if result and result[1] then
			for _, row in pairs ( result ) do
				for column, _ in pairs ( row ) do
					if column ~= "Name" and column ~= "UID" then      -- ÄNDERN - Name Unnötig!
						number = number + 1
						ids[number] = column
					end
				end
			end
		else
			outputDebugString ( pname.." konnte Statistik nicht speichern" )
			return
		end
		if gangAreaUnderAttack then
			if playerData[getPlayerName(player)] then
				vioSetElementData ( player, "AnzahlGangwarsVerloren", vioGetElementData ( player, "AnzahlGangwarsVerloren" ) + 1 )
			end
		end
		local realtime = getRealTime()
		local weekday = realtime.weekday
		local newtime = math.floor ( ( realtime.timestamp - ( vioGetElementData ( player, weekdayName[weekday].."Spielzeit" ) or 0 ) ) / 60 )
		vioSetElementData ( player, weekdayName[weekday].."Spielzeit", newtime )
		if weekday == 1 and not wasOnlineToday[pname] then
			local wochenzeit = 0
			for i=1, 7 do
				wochenzeit = wochenzeit + vioGetElementData ( player, weekdayName[weekday].."Spielzeit" )
			end
			vioSetElementData ( player, "LetzteWocheSpielzeit", wochenzeit )
		end
		if dbExec ( handler, "UPDATE statistics SET ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=?, ??=? WHERE ??=?", ids[1], vioGetElementData ( player, ids[1] ), ids[2], vioGetElementData ( player, ids[2] ), ids[3], vioGetElementData ( player, ids[3] ), ids[4], vioGetElementData ( player, ids[4] ), ids[5], vioGetElementData ( player, ids[5] ), ids[6], vioGetElementData ( player, ids[6] ), ids[7], vioGetElementData ( player, ids[7] ), ids[8], vioGetElementData ( player, ids[8] ), ids[9], vioGetElementData ( player, ids[9] ), ids[10], vioGetElementData ( player, ids[10] ), ids[11], vioGetElementData ( player, ids[11] ), ids[12], vioGetElementData ( player, ids[12] ), ids[13], vioGetElementData ( player, ids[13] ), ids[14], vioGetElementData ( player, ids[14] ), ids[15], vioGetElementData ( player, ids[15] ), ids[16], vioGetElementData ( player, ids[16] ), ids[17], vioGetElementData ( player, ids[17] ), ids[18], vioGetElementData ( player, ids[18] ), ids[19], vioGetElementData ( player, ids[19] ), ids[20], vioGetElementData ( player, ids[20] ), ids[21], vioGetElementData ( player, ids[21] ), ids[22], vioGetElementData ( player, ids[22] ), ids[23], vioGetElementData ( player, ids[23] ), ids[24], vioGetElementData ( player, ids[24] ), ids[25], vioGetElementData ( player, ids[25] ), ids[26], vioGetElementData ( player, ids[26] ), ids[27], vioGetElementData ( player, ids[27] ), "UID", playerUID[pname] ) then
			outputDebugString ( "Statistiken von "..pname.." gespeichert!" )
		end
	end
end




















