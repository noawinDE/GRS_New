local dxfont0_DSDIGI = dxCreateFont(":reallife_server/fonts/DSDIGI.ttf", 10)
local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
LevelUPSound = false

function drawLevelUP ()
	local level = getElementData ( getLocalPlayer(), "MainLevel")
    dxDrawImage(827*sx, 217*sy, 256*sx, 152*sy, ":reallife_server/neues/levelsystem/levelup.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    dxDrawText("Du bist nun Level  "..level, 910*sx, 261*sy, 1056*sx, 294*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_DSDIGI, "left", "top", false, false, true, false, false)
    dxDrawText("Nächstes Level bei:\n\n"..levelSys[level].." XP", 834*sx, 312*sy, 1073*sx, 359*sy, tocolor(255, 255, 255, 255), 1.00, dxfont0_DSDIGI, "left", "top", false, false, false, false, false)
	if LevelUPSound == false then
		playSound("neues/achievementSystem/achievment.mp3")
	end
	LevelUPSound = true
end


function drawLevelUP_func ()

	addEventHandler ( "onClientRender", root, drawLevelUP )
	setTimer ( function()
		removeEventHandler ( "onClientRender", root, drawLevelUP )
		LevelUPSound = false
	end, 10000, 1 )
end
addEvent("drawLevelUP", true)
addEventHandler("drawLevelUP", getRootElement(), drawLevelUP_func)

