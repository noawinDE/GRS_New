local gMysqlHost = "localhost"
local gMysqlUser = "root"
local gMysqlPass = ""
local gMysqlDatabase = "mta"

handler = nil
playerUID = {}
playerUIDName = {}
playerToken = {}
playerTempToken = {}
achievementID = {}
achievementName = {}
achievementDescription = {}
achievementGainXP = {}
achievementGainMoney = {}
achievementPic = {}
achievementSocialState = {}


socialStateID = {}
socialStateName = {}
socialStateDescription = {}
socialStateName[0] = "N.a."

function getMilliSecond ( number )
	if tonumber(number) then
		if number > 0 then
			return number*1000
		end
	end
end

function MySQL_Startup ( ) 
	handler = dbConnect ( "mysql", "dbname=".. gMysqlDatabase .. ";host="..gMysqlHost..";port=3306", gMysqlUser, gMysqlPass )
	if not handler then
		outputDebugString("[MySQL_Startup] Couldn't run query: Unable to connect to the MySQL server!")
		outputDebugString("[MySQL_Startup] Please shutdown the server and start the MySQL server!")
		return
	end	
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,??, ?? FROM ??", "UID", "Name", "permaSuppToken", "players" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["UID"] )
		local name = result[i]["Name"]
		local token = result[i]["permaSuppToken"]
		playerUID[name] = id
		playerUIDName[id] = name
		playerToken[name] = token
	end
	
	playerUIDName[0] = "none"
	playerUID["none"] = 0
end
MySQL_Startup()


function saveEverythingForScriptStop ( )
	saveDepotInDB()
	updateBizKasse()
end
addEventHandler ( "onResourceStop", resourceRoot, saveEverythingForScriptStop )

function dbExist(tablename, objekt)
	local result = dbQuery(handler,"SELECT * FROM "..tablename.." WHERE "..objekt)
	rows, numrows, err= dbPoll(result, -1)
		if rows[1] then
			return true
		else
			return false
		end
end




function loadSocialStats ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,??,?? FROM ??", "ID", "Name", "Description", "socialstatelist" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["ID"] )
		local name = result[i]["Name"]
		local desc = result[i]["Description"]
		socialStateID[id] = id
		socialStateName[id] = name
		socialStateDescription[id] = desc
		outputDebugString("["..id.."] State `"..name.." ("..id..")` loadet.")
	end
end

function loadAchievements ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,??,??,??,??,??, ?? FROM ??", "ID", "Name", "Description", "image", "GainXP", "GainMoney", "socialStateID", "achievementlist" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["ID"] )
		local name = result[i]["Name"]
		local desc = result[i]["Description"]
		local pic = tostring ( result[i]["image"] )
		local xp = tonumber ( result[i]["GainXP"] )
		local money = tonumber ( result[i]["GainMoney"] )
		local socialID = tonumber ( result[i]["socialStateID"] )
		
		achievementID[id] = id
		achievementName[id] = name
		achievementDescription[id] = desc
		achievementGainXP[id] = xp
		achievementGainMoney[id] = money
		achievementSocialState[id] = socialID

		if pic then
			achievementPic[id] = pic
		else
			achievementPic[id] = "error.png"
		end
	--	outputDebugString("["..id.."] Achievement `"..name.." ("..socialStateName[socialID]..")` loadet.")
	end
end



if handler then

	setTimer ( loadSocialStats, 500, 1 )
	setTimer ( loadAchievements, 500, 1 )
end

function getSecturityToken ()
	local player = client 
	print(playerToken[getPlayerName(player)])
	triggerClientEvent ( player, "setPermToken", getRootElement(), playerToken[getPlayerName(player)])
end
addEvent ( "getSecturityToken", true )
addEventHandler ( "getSecturityToken", getRootElement(), getSecturityToken )


function setTempToken (token)
	local player = client 
	playerTempToken[getPlayerName(player)] = token
end
addEvent ( "setTempToken", true )
addEventHandler ( "setTempToken", getRootElement(), setTempToken )