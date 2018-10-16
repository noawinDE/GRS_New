local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
local player_screen = x * y
local screen = (1920 * 1080) -- deine auflösung
local screen = screen/100 --dreisatz = 1%
local player_screen = player_screen/screen -- die Prozentzahl vom Spieler Bildschirm im Vergleich mit der größten Auflösung
local size = 1*sx
hud = "on"
cityabk = {
["San Fierro"] = ", SF",
["Los Santos"] = ", LS",
["Las Venturas"] = ", LV"
}
local dxfont0_segoeui = dxCreateFont(":reallife_server/fonts/segoeui.ttf", 13)
local dxfont1_segoeui = dxCreateFont(":reallife_server/fonts/segoeui.ttf", 14)

function getXPForNextLevel(client)
    local xp = tonumber(getElementData(client,"MainXP"))
    local level =  tonumber(getElementData(client,"MainLevel"))
    if level < (maxlevel) then
        nxp = levelSys[level]
        lvlDatas = nxp/xp
        lvlDatas = 100/lvlDatas
    end
	
end
addEvent ( "getXPForNextLevel", true )
addEventHandler ( "getXPForNextLevel", getRootElement(), getXPForNextLevel )


function showLevel()
    getXPForNextLevel(getLocalPlayer())
    setTimer ( function()
            if lvlDatas >= 100 then
                triggerServerEvent ( "checkPlayerLevelUP", lp,lp)
            end
    end, 7000, 1 )
end
addEvent ( "showLevel", true )
addEventHandler ( "showLevel", getRootElement(), showLevel )


function drawMainHUD ()
	
		local level = getElementData(getLocalPlayer(),"MainLevel")
		local xp = getElementData(getLocalPlayer(),"MainXP")
		if level < (maxlevel+1) then
			nxp = levelSys[level+1]
			nxpShow = levelSys[level+1] - xp
			lvlData = xp*100/nxp
		end
		local datum, time = timestampOpticalZeitDatum ()
		local weaponslot = getPedWeaponSlot(localPlayer)
		local pHunger = getElementHunger ( )	
		local pHealth = getElementHealth ( localPlayer )
		local pArmor = getPedArmor ( localPlayer )
		local pMoney = convertNumber(mymoney)
		local failOxy = 7.51484375
		local pOxy =  (math.floor((getPedOxygenLevel(getLocalPlayer()) - failOxy)/10))-6
		local x, y, z = getElementPosition(lp) or 0, 0, 0
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		-- Oberer Teil Outline
		dxDrawLine(1596*sx, 5*sy, 1596*sx, 151*sy, tocolor(255, 254, 254, 254), 1, false)
        dxDrawLine(1910*sx, 5*sy, 1596*sx, 5*sy, tocolor(255, 254, 254, 254), 1, false)
        dxDrawLine(1596*sx, 151*sy, 1910*sx, 151*sy, tocolor(255, 254, 254, 254), 1, false)
        dxDrawLine(1910*sx, 151*sy, 1910*sx, 5*sy, tocolor(255, 254, 254, 254), 1, false)
		-- Oberer Teil
        dxDrawRectangle(1597*sx, 6*sy, 313*sx, 145*sy, tocolor(23, 0, 0, 121), false)
		dxDrawLine(1729*sx, 10*sy, 1729*sx, 152*sy, tocolor(254, 254, 254, 252), 1, false)
		-- Waffen
		local weaponID = getPedWeapon (localPlayer)
        dxDrawImage(1604*sx, 14*sy, 110*sx, 116*sy, ":reallife_server/images/hud/"..weaponID..".png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if weaponslot >= 2 and weaponslot <= 9 then
			local clip = getPedAmmoInClip (localPlayer, weaponslot )
			local clip1 = getPedTotalAmmo (localPlayer, weaponslot )
			dxDrawText(clip.." | "..clip1, 1632*sx, 126*sy, 1691*sx, 141*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
		end
		-- Ober Teil | HUD Elemente
        dxDrawImage(1732*sx, 11*sy, 26*sx, 25*sy, ":reallife_server/images/hud/time.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(time.." Uhr ,"..datum, 1770*sx, 12*sy, 1906*sx, 37*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_segoeui, "left", "top", false, false, false, false, false)
        dxDrawImage(1734*sx, 51*sy, 26*sx, 25*sy, ":reallife_server/images/hud/gps1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(zone..(cityabk[city] or ""), 1769*sx, 51*sy, 1905*sx, 76*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_segoeui, "left", "top", false, false, false, false, false)
        dxDrawImage(1734*sx, 97*sy, 27*sx, 23*sy, ":reallife_server/images/hud/money.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(pMoney.." $", 1770*sx, 95*sy, 1906*sx, 120*sy, tocolor(255, 255, 255, 255), 1.00, dxfont1_segoeui, "left", "top", false, false, false, false, false)
		
		-- Unterer Teil Outline
        dxDrawLine(1598*sx, 161*sy, 1598*sx, 279*sy, tocolor(255, 255, 255, 254), 1, false)
        dxDrawLine(1910*sx, 161*sy, 1598*sx, 161*sy, tocolor(255, 255, 255, 254), 1, false)
        dxDrawLine(1598*sx, 279*sy, 1910*sx, 279*sy, tocolor(255, 255, 255, 254), 1, false)
        dxDrawLine(1910*sx, 279*sy, 1910*sx, 161*sy, tocolor(255, 255, 255, 254), 1, false)
		-- Unterer Teil
        dxDrawRectangle(1599, 162, 311, 117, tocolor(3, 0, 0, 142), false)
		-- Hintergründe vom Unterem Teil
		dxDrawImage(1630*sx, 168*sy, 271*sx, 17*sy, ":reallife_server/images/hud/healthBG.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		
		dxDrawImage(1630*sx, 197*sy, 270*sx, 17*sy, ":reallife_server/images/hud/armourBG.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawImage(1628*sx, 253*sy, 271*sx, 17*sy, ":reallife_server/images/hud/xpBG.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		-- Unterer Teil | HUD elemente
        dxDrawImage(1604*sx, 168*sy, 18*sx, 18*sy, ":reallife_server/images/hud/health.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1630*sx, 168*sy, 271*sx/100*pHealth, 17*sy, ":reallife_server/images/hud/healthbar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1604*sx, 196*sy, 18*sx, 18*sy, ":reallife_server/images/hud/armour.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		if isElementInWater(getLocalPlayer()) then
			dxDrawImage(1604*sx, 224*sy, 18*sx, 18*sy, ":reallife_server/images/hud/air.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1629*sx, 223*sy, 271*sx/100*pOxy, 17*sy, ":reallife_server/images/hud/lungenbar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1629*sx, 223*sy, 271*sx, 17*sy, ":reallife_server/images/hud/lungenBG.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		else
			dxDrawImage(1604*sx, 224*sy, 18*sx, 18*sy, ":reallife_server/images/hud/hunger.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1629*sx, 223*sy, 271*sx, 17*sy, ":reallife_server/images/hud/hungerBG.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			dxDrawImage(1629*sx, 223*sy, 271*sx/100*pHunger, 17*sy, ":reallife_server/images/hud/hungerbar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		end
        dxDrawImage(1604*sx, 252*sy, 18*sx, 18*sy, ":reallife_server/images/hud/xp.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1630*sx, 197*sy, 270*sx/100*pArmor, 17*sy, ":reallife_server/images/hud/armourbar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	--	local totalData = 271/100*lvlDatas
		dxDrawImage(1628*sx, 253*sy, (lvlData*2.71)*sx, 17*sy, ":reallife_server/images/hud/xpbar.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
       
        dxDrawText(pHealth.."%", 1739*sx, 168*sy, 1773*sx, 183*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawText(pArmor.."%", 1739*sx, 198*sy, 1773*sx, 213*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
		if isElementInWater(getLocalPlayer()) then
			dxDrawText( pOxy.."%", 1739*sx, 224*sy, 1773*sx, 239*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
		else
			dxDrawText(pHunger.."%", 1739*sx, 224*sy, 1773*sx, 239*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
		end
        dxDrawText(nxpShow.." XP zu Level "..level+1, 1695*sx, 253*sy, 1817*sx, 269*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        end

		
		
function drawWantedHUD ()
	local playerWanted = getElementData ( localPlayer, "wanteds" )
	if playerWanted >= 1 then
		 dxDrawImage(1549*sx, 6*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		 dxDrawImage(1549*sx, 6*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 2 then
		 dxDrawImage(1549*sx, 50*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		 dxDrawImage(1549*sx, 50*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 3 then
		dxDrawImage(1549*sx, 93*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1549*sx, 93*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 4 then
		dxDrawImage(1549*sx, 137*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1549*sx, 137*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 5 then
		dxDrawImage(1549*sx, 178*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1549*sx, 178*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 6 then
		dxDrawImage(1549*sx, 222*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1549*sx, 222*sy, 38*sx, 38*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
end

function renderHUD ()
addEventHandler ( "onClientRender", root, drawMainHUD )
addEventHandler ( "onClientRender", root, drawWantedHUD )
end
addEvent ( "renderHUD", true )
addEventHandler ( "renderHUD", getRootElement(), renderHUD )

function unRenderHUD ()
removeEventHandler ( "onClientRender", root, drawMainHUD )
removeEventHandler ( "onClientRender", root, drawWantedHUD )
end
addEvent ( "unRenderHUD", true )
addEventHandler ( "unRenderHUD", getRootElement(), unRenderHUD )

function loginHUD ()
	renderHUD ()
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
	setPlayerHudComponentVisible("radar", true)
	hud = "on"
	end
addEvent ( "loginHUD", true )
addEventHandler ( "loginHUD", getRootElement(), loginHUD )

function timestampOpticalDatum ()
	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month+1
	local day = regtime.monthday
	return tostring(day.."."..month.."."..year)
end

function timestampOpticalZeit ()
	local regtime = getRealTime()
	local hour = regtime.hour
	local minute = regtime.minute
	if hour < 10 then
		hour = "0"..hour
	end
	if minute < 10 then
		minute = "0"..minute
	end
	return tostring(hour..":"..minute)
end


function timestampOpticalZeitDatum ()
	local regtime = getRealTime()
	local year = regtime.year + 1900
	local month = regtime.month+1
	local day = regtime.monthday
	local hour = regtime.hour
	local minute = regtime.minute
	if hour < 10 then
		hour = "0"..hour
	end
	if minute < 10 then
		minute = "0"..minute
	end
	return tostring(day.."."..month.."."..year), tostring(hour..":"..minute)
end

function switchHUD ()
if hud == "off" then
	renderHUD ()
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
	setPlayerHudComponentVisible("radar", true)
	hud = "on"
elseif hud == "on" then
	unRenderHUD ()
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
	setPlayerHudComponentVisible("radar", true)
	hud = "invi"
elseif hud == "invi" then
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", true)
	hud = "off"
	end
end
bindKey ( "b", "down", switchHUD )

function convertNumber ( number )  
    local formatted = number  
    while true do      
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
        if ( k==0 ) then      
            break  
        end  
    end  
    return formatted
end
