
local screenW, screenH = guiGetScreenSize()
loadTime = 0.25*50*1000
screenX,screenY = guiGetScreenSize()
local front = dxCreateFont(":reallife_server/fonts/font2.ttf", 24)

swtGUI = {
    button = {},
    window = {},
    edit = {},
    label = {}
}	
function showSWTGUI ()
    swtGUI.window[1] = guiCreateWindow(0.44, 0.42, 0.12, 0.14, "Staatswaffentruck", true)

    swtGUI.label[1] = guiCreateLabel(0.05, 0.18, 0.33, 0.13, "SWAT Sets:", true, swtGUI.window[1])
    swtGUI.edit[1] = guiCreateEdit(0.41, 0.19, 0.55, 0.12, "", true, swtGUI.window[1])
    swtGUI.label[2] = guiCreateLabel(0.05, 0.37, 0.33, 0.13, "Waffen Sets:", true, swtGUI.window[1])
    swtGUI.edit[2] = guiCreateEdit(0.41, 0.38, 0.55, 0.12, "", true, swtGUI.window[1])
    swtGUI.label[3] = guiCreateLabel(0.05, 0.56, 0.57, 0.31, "Ladezeit pro Set: 0.25 Sekunden\nSWAT Set: 100$\nWeapon Set: 50$", true, swtGUI.window[1])
    swtGUI.button[1] = guiCreateButton(0.69, 0.56, 0.27, 0.15, "Beladen", true, swtGUI.window[1])
    swtGUI.button[2] = guiCreateButton(0.68, 0.78, 0.27, 0.15, "X", true, swtGUI.window[1])
    setElementClicked ( true )
    showCursor(true)
    addEventHandler("onClientGUIClick", swtGUI.button[1], function()
        if tonumber(guiGetText(swtGUI.edit[1])) >= 100 and tonumber(guiGetText(swtGUI.edit[2])) >= 100 then
            if tonumber(guiGetText(swtGUI.edit[1])) <= 1000 and tonumber(guiGetText(swtGUI.edit[2])) <= 1000 then
				loadTime = 0.05*(guiGetText(swtGUI.edit[1])+guiGetText(swtGUI.edit[2]))*1000
                triggerServerEvent("loadSWT", getRootElement(),getLocalPlayer(), guiGetText(swtGUI.edit[1]), guiGetText(swtGUI.edit[2]), loadTime)
                guiSetVisible(swtGUI.window[1], false)
                showCursor(false)
                setElementClicked ( false )
            else
                infobox_start ("Maximal 1000 Sets.\nwerden benötigt.", 5000, 125, 0, 0 )
            end
        else
			infobox_start ("Mindestens 100 Sets.\nwerden benötigt.", 5000, 125, 0, 0 )  
        end
    end, false)


    addEventHandler("onClientGUIClick", swtGUI.button[2], function()
        guiSetVisible(swtGUI.window[1], false)
        showCursor(false)
        setElementClicked ( false )
    end, false)

end
addEvent( "showSWTGUI", true )
addEventHandler( "showSWTGUI", getRootElement(), showSWTGUI )


function renterSWTText ()

	addEventHandler ( "onClientRender", root, drawSWTText )
end
addEvent( "renterSWTText", true )
addEventHandler( "renterSWTText", getRootElement(), renterSWTText )

function drawSWTText ()
	if not systemUpTime then
       systemUpTime = getTickCount () 
	end
	maxLoadTime = getTickCount()
	if  (maxLoadTime-systemUpTime) <= loadTime then
		dxDrawText((math.floor((loadTime-(maxLoadTime-systemUpTime))/ 1000)).." Sekunden\nbis der SWT beladen ist.", screenW * 0.3964, screenH * 0.2083, screenW * 0.6036, screenH * 0.2806, tocolor(255, 255, 255, 255), 1.00, front, "left", "top", false, false, false, false, false)
	else
		removeEventHandler ( "onClientRender", root, drawSWTText )
	end
end

--[[-------------------------------------------------
Notes:

> This code is using a custom font. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move custom fonts into your local resource and reference them there.
--]]-------------------------------------------------



