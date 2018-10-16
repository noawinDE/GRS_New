local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
local player_screen = x * y
local screen = (1920 * 1080) 
local screen = screen/100 
local player_screen = player_screen/screen 
local size = 1.0*sy
pl = {}
local factionCounter = {}
factionCounter[0] = 0
factionCounter[1] = 0
factionCounter[2] = 0
factionCounter[3] = 0
factionCounter[4] = 0
factionCounter[5] = 0
factionCounter[6] = 0
factionCounter[7] = 0
factionCounter[8] = 0
factionCounter[9] = 0
factionCounter[10] = 0
factionCounter[11] = 0
factionCounter[12] = 0
factionCounter[13] = 0
local scroll = 0
local updateTimer 
local player = getLocalPlayer()
local alpha = 0
-- Script by Mezzo ( Max Foidl )
local dxfont0_BEBAS = dxCreateFont(":reallife_server/fonts/BEBAS.ttf", 16)
local dxfont1_BEBAS = dxCreateFont(":reallife_server/fonts/BEBAS.ttf", 14)

bindKey("tab","down",function()
		getPlayersScoreboard ()
		addEventHandler("onClientRender", root, drawScoreboard)
		refreshScoreboard()
		if isTimer(updateTimer) then killTimer(updateTimer) end
		updateTimer = setTimer(refreshScoreboard,500,0)
		bindKey("mouse_wheel_down","down",scrollDown)
		bindKey("mouse_wheel_up","down",scrollUp)
		toggleControl("next_weapon",false)
		toggleControl("previous_weapon",false)
		toggleControl("fire",false)
		alpha = 0
	
end)

bindKey("tab","up",function()
	unbindKey("mouse_wheel_down","down",scrollDown)
	unbindKey("mouse_wheel_up","down",scrollUp)
	removeEventHandler("onClientRender", root, drawScoreboard)
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	toggleControl("fire",true)
	di = 0
	i = 0
	alpha = 0
	factionCounter[0] = 0
	factionCounter[1] = 0
	factionCounter[2] = 0
	factionCounter[3] = 0
	factionCounter[4] = 0
	factionCounter[5] = 0
	factionCounter[6] = 0
	factionCounter[7] = 0
	factionCounter[8] = 0
	factionCounter[9] = 0
	factionCounter[10] = 0
	factionCounter[11] = 0
	factionCounter[12] = 0
	factionCounter[13] = 0
end)

function getPlayersScoreboard ()
	iPlayers = #getElementsByType("player")
end

function scrollDown ()
	if #getElementsByType("player") - scroll <= 2 then
		scroll = #getElementsByType("player")
	else
		scroll = scroll + 2
	end
end

function scrollUp ()
	if scroll <= 2 then
		scroll = 0
	else
		scroll = scroll - 2
	end
end

function formString (text)
	if string.len(text) == 1 then
		text = "0"..text
	end
	return text
end


function refreshScoreboard ()
	factionCounter[0] = 0
	factionCounter[1] = 0
	factionCounter[2] = 0
	factionCounter[3] = 0
	factionCounter[4] = 0
	factionCounter[5] = 0
	factionCounter[6] = 0
	factionCounter[7] = 0
	factionCounter[8] = 0
	factionCounter[9] = 0
	factionCounter[10] = 0
	factionCounter[11] = 0
	factionCounter[12] = 0
	factionCounter[13] = 0
	pl = {}
	local i = 0
	for id, p in ipairs(getElementsByType("player")) do
	
		local ping = getPlayerPing(p)
		local pname = getPlayerName(p)
		local pname = string.gsub(pname,"#%x%x%x%x%x%x","")
		local color = {255,255,255} 
		
		if getElementData  ( p, "loggedin" ) == 1 then
			
			if getElementData (p, "isafk") == false then
				playingtime = tonumber(getElementData ( p, "playingtime" ))
				spielzeit = math.floor ( playingtime / 60 )..":"..( playingtime - math.floor ( playingtime / 60 ) * 60 )
			else
				spielzeit = "afk"
			end
			faction = getElementData(p,"fraktion")
			status = getElementData(p,"socialState")
			number = getElementData(p, "telenr")
			job = jobNames [ getElementData ( p, "job" ) ]
			fname = fraktionsNamen[faction]
			prison =  getElementData(p,"prison")
			level = getElementData(p,"MainLevel")
			premium = getElementData(p,"premium")
		else
			spielzeit = "N.a"
			faction = 0
			fname = " - Keine -"
			status = "N.a"
			number = "N.a"
			job = "N.a"
			premium = "N.a"
			level = "N.a"
		end
		
		pl[i] = {} 
		pl[i].job = job
		pl[i].faction = faction
		pl[i].fname = fname
		pl[i].number = number
		pl[i].state = status
		pl[i].name = pname
		pl[i].spielzeit = spielzeit
		pl[i].ping = ping
		pl[i].color = color
		pl[i].level = level
		pl[i].prem = premium
		pl[i].prison = prison
		factionCounter[faction] = factionCounter[faction] + 1
		i = i + 1
	end
	table.sort(pl,function(a,b)
		return a.faction < b.faction
	end)
	
end

function getPingColor ( ping )

	if ping <= 50 then
		return 0, 200, 0
	elseif ping <= 150 then
		return 200, 200, 0
	else
		return 200, 0, 0
	end
end

function drawScoreboard()
		di = 0
        dxDrawImage(742*sx, 429*sy, 437*sx, 108*sy, ":reallife_server/images/header.jpg", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(389*sx, 255*sy, 1141*sx, 528*sy, tocolor(3, 0, 0, 224), false)
        dxDrawLine(429*sx, 295*sy, 1492*sx, 295*sy, tocolor(22, 190, 188, 224), 3, false)
        dxDrawText("VIP", 429*sx, 267*sy, 466*sx, 292*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Name", 483*sx, 267*sy, 520*sx, 292*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("sozialer Status", 658*sx, 267*sy, 695*sx, 292*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Spielzeit", 879*sx, 267*sy, 916*sx, 292*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Telefonnummer", 999*sx, 267*sy, 1036*sx, 292*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Fraktion", 1169*sx, 267*sy, 1206*sx, 293*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Level", 1295*sx, 267*sy, 1315*sx, 294*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
        dxDrawText("Ping", 1360*sx, 267*sy, 1400*sx, 294*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)

		for i = 0+scroll, 12+scroll do
			if pl[i] then
				
				r,g,b = getPingColor(pl[i].ping)
				frak = tonumber(pl[i].faction)
				fr,fg,fb =  factionColors[frak][1], factionColors[frak][2], factionColors[frak][3]
				
				dxDrawText(pl[i].name, 483*sx, 305*sy+(di*25), 631*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				dxDrawText(pl[i].state, 658*sx, 305*sy+(di*25), 806*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				if pl[i].prison > 0 then
					dxDrawText("Prison-"..pl[i].prison.." min.", 879*sx, 305*sy+(di*25), 967*sx, 330*sy, tocolor(102, 5, 5, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				elseif pl[i].spielzeit == "afk" then
					dxDrawText("[AFK]", 879*sx, 305*sy+(di*25), 967*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				else
					dxDrawText(pl[i].spielzeit, 879*sx, 305*sy+(di*25), 967*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				end
				if frak == 9 then
					pl[i].fname = "AoD"
				end
				dxDrawText(pl[i].number, 999*sx, 305*sy+(di*25), 1087*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				dxDrawText(pl[i].fname, 1169*sx, 305*sy+(di*25), 1257*sx, 330*sy, tocolor(fr, fg, fb, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				dxDrawText(pl[i].level, 1295*sx, 305*sy+(di*25), 1366*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)   
				dxDrawText(pl[i].ping, 1360*sx, 305*sy+(di*25), 1399*sx, 330*sy, tocolor(r, g, b , 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
				if pl[i].prem == true then
					dxDrawImage(429*sx, 304*sy+(di*25), 28*sx, 25*sy, ":reallife_server/images/vip.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
				end
				di = di + 1
			end 
		end
		--[[
		dxDrawText("EasyCascades12", 483*sx, 305*sy+(i*14), 631*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("EasyCascades12 suckt", 658*sx, 305*sy, 806*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("1111:1111", 879*sx, 305*sy, 967*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("9010808", 999*sx, 305*sy, 1087*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("- Keine -", 1169*sx, 305*sy, 1257*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("30", 1278*sx, 305*sy, 1366*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)   
		dxDrawText("1000", 1362*sx, 305*sy, 1399*sx, 330*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		--]]
        dxDrawLine(389*sx, 652*sy, 1530*sx, 652*sy, tocolor(22, 190, 188, 224), 30, false)
        dxDrawText("Es sind "..iPlayers.." Spieler online", 481*sx, 641*sy, 742*sx, 662*sy, tocolor(0, 3, 3, 254), 1.00, dxfont1_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[1]..": "..factionCounter[1], 481*sx, 682*sy, 742*sx, 703*sy, tocolor(factionColors[1][1], factionColors[1][2], factionColors[1][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[2]..": "..factionCounter[2], 481*sx, 713*sy, 742*sx, 734*sy, tocolor(factionColors[2][1], factionColors[2][2], factionColors[2][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[3]..": "..factionCounter[3], 481*sx, 744*sy, 742*sx, 765*sy, tocolor(factionColors[3][1], factionColors[3][2], factionColors[3][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[4]..": "..factionCounter[4], 654*sx, 744*sy, 915*sx, 765*sy, tocolor(factionColors[4][1], factionColors[4][2], factionColors[4][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[5].." "..factionCounter[5], 654*sx, 713*sy, 915*sx, 734*sy, tocolor(factionColors[5][1], factionColors[5][2], factionColors[5][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[6]..": "..factionCounter[6], 654*sx, 682*sy, 915*sx, 703*sy, tocolor(factionColors[6][1], factionColors[6][2], factionColors[6][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[7]..": "..factionCounter[7], 824*sx, 744*sy, 1085*sx, 765*sy, tocolor(factionColors[7][1], factionColors[7][2], factionColors[7][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[8]..": "..factionCounter[8], 824*sx, 713*sy, 1085*sx, 734*sy, tocolor(factionColors[8][1], factionColors[8][2], factionColors[8][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText("AoD: "..factionCounter[9], 824*sx, 682*sy, 1085*sx, 703*sy, tocolor(factionColors[9][1], factionColors[9][2], factionColors[9][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[10]..": "..factionCounter[10], 983*sx, 682*sy, 1244*sx, 703*sy, tocolor(factionColors[10][1], factionColors[10][2], factionColors[10][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[11]..": "..factionCounter[11], 983*sx, 713*sy, 1244*sx, 734*sy, tocolor(factionColors[11][1], factionColors[11][2], factionColors[11][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[12]..": "..factionCounter[12], 983*sx, 744*sy, 1244*sx, 765*sy, tocolor(factionColors[12][1], factionColors[12][2], factionColors[12][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
		dxDrawText(fraktionsNamen[13]..": "..factionCounter[13], 1151*sx, 682*sy, 1412*sx, 703*sy, tocolor(factionColors[13][1], factionColors[13][2], factionColors[13][3], 254), 1.00, dxfont0_BEBAS, "left", "top", false, false, false, false, false)
   end
   

   fileDelete(":reallife_server/client/playerlist_client.lua")