local x, y = guiGetScreenSize()
local sx, sy = x/1920, y/1080
local player_screen = x * y
local screen = (1920 * 1080) -- deine auflösung
local screen = screen/100 --dreisatz = 1%
local player_screen = player_screen/screen -- die Prozentzahl vom Spieler Bildschirm im Vergleich mit der größten Auflösung
local size = 1*sx
local font = dxCreateFont(":reallife_server/fonts/DSDIGI.ttf", 10)
local achievment = {}
achievmentSound = false

function showAchievment (id, name, desc, xp, money, pic, socialName)

    achievment[#achievment+1] = { name, desc, xp, money, pic, getTickCount(), id, socialName }




end
addEvent ( "showAchievment", true )
addEventHandler ( "showAchievment", getRootElement(), showAchievment )

function drawAchievment ()
    if achievment[1] then
        for i=1, 1, -1 do
            if getTickCount() - achievment[i][6] < 10000 then
                dxDrawImage(827*sx, 217*sy, 258*sx, 152*sy, ":reallife_server/neues/achievementSystem/achievmentPictures/archBox.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawImage(837*sx, 240*sy, 64*sx, 64*sy, ":reallife_server/neues/achievementSystem/achievmentPictures/"..achievment[i][5], 0, 0, 0, tocolor(255, 255, 255, 255), false)
                dxDrawText(achievment[i][1], 909*sx, 238*sy, 1075*sx, 269*sy, tocolor(255, 255, 255, 255), 1.00, font, "left", "top", false, false, false, false, false)
                dxDrawText("+ "..achievment[i][4].."$", 944*sx, 273*sy, 1110*sx, 304*sy, tocolor(255, 255, 255, 255), 1.40, font, "left", "top", false, false, false, false, false)
                dxDrawText("+ "..achievment[i][3], 878*sx, 314*sy, 1044*sx, 345*sy, tocolor(255, 255, 255, 255), 1.50, font, "left", "top", false, false, false, false, false)
                dxDrawText(achievment[i][8], 950*sx, 340*sy, 1116*sx, 371*sy, tocolor(255, 255, 255, 255), 1.20, font, "left", "top", false, false, false, false, false)
				if achievmentSound == false then
					if tonumber(achievment[i][7]) == 13 then
						playSound("neues/achievementSystem/weed.mp3")
					else
						playSound("neues/achievementSystem/achievment.mp3")
					end
					createTrayNotification( "Erolg: "..achievment[i][1], "info" )
					achievmentSound = true
				end
            else
                table.remove ( achievment, i )
				
				if achievment[1] then
					achievment[1][6] = getTickCount()
					achievmentSound = false
				end
            end
        end
    end
end
addEventHandler ( "onClientRender", root, drawAchievment )
