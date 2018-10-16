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

function getXPForNextLevel(player)
    local xp = tonumber(getElementData(player,"MainXP"))
    local level =  tonumber(getElementData(player,"MainLevel"))
    if level < (maxlevel+1) then
        nxp = levelSys[level]
        lvlDatas =nxp/xp
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
		 local xp = tonumber(getElementData(player,"MainXP"))
		local level =  tonumber(getElementData(player,"MainLevel"))
		if level < (maxlevel+1) then
			nxp = levelSys[level]
			lvlDatas =nxp/xp
			lvlDatas = 100/lvlDatas
		end
		local datum, time = timestampOpticalZeitDatum ()
		local weaponslot = getPedWeaponSlot(localPlayer)
		local playerHunger = getElementHunger ( )	
		local playerHealth = getElementHealth ( localPlayer )
		local playerArmor = getPedArmor ( localPlayer )
		local playerMoney = convertNumber(mymoney)
		
		local x, y, z = getElementPosition(lp) or 0, 0, 0
		local zone = getZoneName ( x, y, z )
		local city = getZoneName ( x, y, z, true )
		dxDrawRectangle(1888*sx, 20*sy, 0*sx, 36*sy, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(1655*sx, 20*sy, 243*sx, 106*sy, tocolor(9, 0, 0, 130), false)
        dxDrawImage(1665*sx, 62*sy, 22*sx, 22*sy, ":reallife_server/images/hud/gps1.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1665*sx, 94*sy, 22*sx, 22*sy, ":reallife_server/images/hud/money.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawImage(1665*sx, 30*sy, 22*sx, 22*sy, ":reallife_server/images/hud/time.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(time.." Uhr ,"..datum, 1704*sx, 30*sy, 1846*sx, 62*sy, tocolor(255, 255, 255, 255), 1.40, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText(zone..(cityabk[city] or ""), 1704*sx, 65*sy, 1846*sx, 97, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText(playerMoney.." $", 1704*sx, 95*sy, 1846*sx, 127*sy, tocolor(255, 255, 255, 255), 1.30, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawRectangle(1535*sx, 21*sy, 110*sx, 105*sy, tocolor(9, 0, 0, 127), false)
		local weaponID = getPedWeapon (localPlayer)
        dxDrawImage(1549*sx, 20*sy, 86*sx, 84*sy, ":reallife_server/images/hud/"..weaponID..".png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
		if weaponslot >= 2 and weaponslot <= 9 then
			local clip = getPedAmmoInClip (localPlayer, weaponslot )
			local clip1 = getPedTotalAmmo (localPlayer, weaponslot )
				dxDrawText(clip.." | "..clip1, 1553*sx, 104*sy, 1629*sx, 121*sy, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
		end 
        dxDrawRectangle(1535*sx, 131*sy, 254*sx, 24*sy, tocolor(35, 57, 255, 92), false)
        dxDrawRectangle(1799*sx, 131*sy, 99*sx, 80*sy, tocolor(11, 0, 0, 125), false)
        dxDrawImage(1811*sx, 136*sy, 77*sx, 56*sy, ":reallife_server/images/hud/coins.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(tonumber(getElementData(getLocalPlayer(),"coins")).." Coins", 1815*sx, 192*sy, 1869*sx, 204*sy, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
        dxDrawRectangle(1535*sx, 131*sy, 254*sx/100*playerArmor, 24*sy, tocolor(3, 25, 242, 152), true)
        dxDrawImage(1543*sx, 136*sy, 16*sx, 16, ":reallife_server/images/hud/armour.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(1535*sx, 158*sy, 254*sx/100*playerHealth, 24*sy, tocolor(248, 0, 0, 111), false)
        dxDrawRectangle(1535*sx, 158*sy, 254*sx, 24*sy, tocolor(246, 0, 0, 152), true)
        dxDrawImage(1543*sx, 162*sy, 16*sx, 16*sy, ":reallife_server/images/hud/health.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawText(math.floor(tonumber(playerHealth)).."%", 1650*sx, 163*sy, 1680*sx, 177*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawText(math.floor(tonumber(playerArmor)).."%", 1649*sx, 136*sy, 1679*sx, 150*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawRectangle(1535*sx, 187*sy, 254*sx, 24*sy, tocolor(20, 227, 45, 189), true)
        dxDrawRectangle(1535*sx, 187*sy, 254*sx/100*playerHunger, 24*sy, tocolor(20, 227, 45, 222), true)
        dxDrawText(math.floor(tonumber(playerHunger)).."%", 1650*sx, 191*sy, 1680*sx, 205*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
        dxDrawImage(1543*sx, 192*sy, 16*sx, 16*sy, ":reallife_server/images/hud/hunger.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(1535*sx, 215*sy, 254*sx, 19*sy, tocolor(28, 209, 216, 149), false)
		local totalData = 254*sx/100*lvlDatas
		if totalData >= 254 then
			dxDrawRectangle(1535*sx, 215*sy, 254*sx, 19*sy, tocolor(21, 222, 211, 244), true)
		else
			 dxDrawRectangle(1535*sx, 215*sy, totalData, 19*sy, tocolor(21, 222, 211, 244), true)
		end
        dxDrawImage(1543*sx, 216*sy, 16*sx, 16*sy, ":reallife_server/images/hud/xp.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
        dxDrawRectangle(1799*sx, 215*sy, 99*sx, 19*sy, tocolor(11, 0, 0, 125), false)
        dxDrawText("Level "..tonumber(getElementData(getLocalPlayer(),"MainLevel")).." zu "..tonumber(getElementData(getLocalPlayer(),"MainLevel"))+1, 1815*sx, 215*sy, 1869*sx, 227*sy, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "top", false, false, false, false, false)
        dxDrawText(tonumber(getElementData(getLocalPlayer(),"MainXP")).."/"..nxp, 1630*sx, 217*sy, 1660*sx, 231*sy, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, true, false, false)
end

function drawWantedHUD ()
	local playerWanted = getElementData ( localPlayer, "wanteds" )
	if playerWanted >= 1 then
		dxDrawImage(1538*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1538*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 2 then
		dxDrawImage(1596*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1596*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 3 then
		dxDrawImage(1654*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1654*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 4 then
		dxDrawImage(1712*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1712*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 5 then
		dxDrawImage(1770*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1770*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	end
	if playerWanted >= 6 then
		dxDrawImage(1828*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_activ.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
	else
		dxDrawImage(1828*sx, 238*sy, 48*sx, 48*sy, ":reallife_server/images/hud/wanted_deactiv.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
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
	addEventHandler ( "onClientRender", root, drawMainHUD )
	showPlayerHudComponent("all", false)
	showPlayerHudComponent("crosshair", true)
	showPlayerHudComponent("radar", true)
	hud = "on"
elseif hud == "on" then
	removeEventHandler ( "onClientRender", root, drawMainHUD )
	showPlayerHudComponent("all", false)
	showPlayerHudComponent("crosshair", true)
	showPlayerHudComponent("radar", true)
	hud = "invi"
elseif hud == "invi" then
	showPlayerHudComponent("all", false)
	showPlayerHudComponent("crosshair", true)
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
