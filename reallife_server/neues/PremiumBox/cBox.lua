eventBlips = false
-------------------------------
-- Full code of the Main Window
-------------------------------
        mainWindow = guiCreateWindow(725, 319, 418, 298, "Soundbox", false)
        guiWindowSetSizable(mainWindow, false)
        guiSetProperty(mainWindow, "CaptionColour", "FEB800BB")
        CurrentSpeaker = guiCreateLabel(11, 35, 220, 15, "Status: -", false, mainWindow)
        guiSetFont(CurrentSpeaker, "default-small")
        volume = guiCreateLabel(10, 55, 130, 15, "Lautstärke: -", false, mainWindow)
        pos = guiCreateLabel(10, 273, 220, 15, "Koordinaten(Dev.): X, Y, Z", false, mainWindow)
        guiSetFont(pos, "default-small")
        label = guiCreateLabel(10, 98, 30, 15, "URL:", false, mainWindow)
        guiLabelSetColor(label, 17, 155, 0)
        url = guiCreateEdit(45, 94, 326, 23, "", false, mainWindow)
        guiSetProperty(url, "NormalTextColour", "FF008B8B")
        placeSp = guiCreateButton(55, 139, 121, 24, "Soundbox\nplatzieren!", false, mainWindow)
        guiSetFont(placeSp, "default-bold-small")
        guiSetProperty(placeSp, "NormalTextColour", "FF9D17A2")
        guiSetAlpha(placeSp, 0.80)
        removeSp = guiCreateButton(240, 139, 121, 24, "Soundbox\nentfernen!", false, mainWindow)
        guiSetFont(removeSp, "default-bold-small")
        guiSetAlpha(removeSp, 0.80)
        guiSetFont(removeSp, "default-bold-small")
        guiSetProperty(removeSp, "NormalTextColour", "FFDB2FE1")
        inVolume = guiCreateLabel(166, 190, 84, 24, "Volume +", false, mainWindow)
        guiSetAlpha(inVolume, 0.80)
        guiSetProperty(inVolume, "NormalTextColour", "FE17C700")
        deVolume = guiCreateLabel(166, 224, 84, 24, " Volume -", false, mainWindow)
        guiSetAlpha(deVolume, 0.80)
        guiSetFont(deVolume, "default-small")
        SpeakerPlaylist = guiCreateButton(295, 194, 83, 49, "Soundbox\nPlaylist", false, mainWindow)
        guiSetAlpha(SpeakerPlaylist, 0.57)
        guiSetFont(SpeakerPlaylist, "default-bold-small")
        guiSetProperty(SpeakerPlaylist, "NormalTextColour", "FF4BBF12")
       distanceSettings = guiCreateLabel(28, 185, 115, 29, "Lautstärke setzen", false, mainWindow)
       guiSetFont(distanceSettings, "default-bold-small")
        guiLabelSetColor(distanceSettings, 231, 229, 27)
        closebtn = guiCreateLabel(368, 269, 35, 19, "Schliesen!", false, mainWindow)
        guiSetFont(closebtn, "default-bold-small")   
        guiSetVisible(mainWindow, false)
-----------------------------------------
-- Full code of the Sound Distance Window
-----------------------------------------
        disWindow = guiCreateWindow(221, 163, 363, 126, "Lautstärke setzen", false)
        guiWindowSetMovable(disWindow, false)
        guiWindowSetSizable(disWindow, false)
        disLabelll = guiCreateLabel(25, 27, 311, 17, "Lautstärke muss zwichen 10 u. 50 sein.", false, disWindow)
        guiSetFont(disLabelll, "clear-normal")
        guiLabelSetColor(disLabelll, 255, 0, 0)
        disField = guiCreateEdit(180, 72, 89, 34, "10", false, disWindow)
        guiEditSetMaxLength(disField, 4)
        cancelDis = guiCreateButton(291, 90, 62, 26, "Ok", false, disWindow)
        guiSetProperty(cancelDis, "NormalTextColour", "FFAAAAAA")
        currentDisStatus = guiCreateLabel(20, 80, 134, 19, "* Momentan Lautstärke: --", false, disWindow)
        guiSetFont(currentDisStatus, "default-small")
        guiSetVisible(disWindow, false)

-----------------------------------------
-- Playlist Window
-----------------------------------------
        playlistWindow = guiCreateWindow(233, 154, 805, 428, "Soundbox-Playlist", false)
        guiWindowSetSizable(playlistWindow, false)
        guiSetProperty(playlistWindow, "CaptionColour", "FF707070")

        songGrid = guiCreateGridList(10, 36, 362, 246, false, playlistWindow)
        guiSetAlpha(songGrid, 0.80)
        radioGrid = guiCreateGridList(444, 36, 351, 246, false, playlistWindow)
        guiSetAlpha(radioGrid, 0.80)
        CloseplaylistWindow = guiCreateLabel(763, 408, 32, 15, " Schliesen", false, playlistWindow)
        guiSetFont(CloseplaylistWindow, "default-bold-small")
        nameLabel = guiCreateLabel(7, 293, 98, 16, " Name:", false, playlistWindow)
        guiSetFont(nameLabel, "default-bold-small")
        guiLabelSetColor(nameLabel, 44, 159, 18)
        nameEdit = guiCreateEdit(9, 310, 353, 23, "", false, playlistWindow)
        linkLabel = guiCreateLabel(7, 338, 101, 16, "Musik Link hinzufügen:", false, playlistWindow)
        guiSetFont(linkLabel, "default-bold-small")
        guiLabelSetColor(linkLabel, 44, 159, 18)
        linkEdit = guiCreateEdit(10, 354, 353, 23, "", false, playlistWindow)
        songButton = guiCreateButton(18, 387, 100, 23, "Musik speichern", false, playlistWindow)
        guiSetFont(songButton, "default-bold-small")
        DeleteButton = guiCreateButton(128, 387, 100, 23, "Löschen", false, playlistWindow)
        guiSetFont(DeleteButton, "default-bold-small")
        radioButton = guiCreateButton(238, 387, 100, 23, "Radio speichern", false, playlistWindow)
        guiSetFont(radioButton, "default-bold-small")
        InformationText = guiCreateLabel(444, 292, 351, 95, "Dieses Fensther erlaubt dir deine eigene\nPlaylist mit Radions und Liedern zu machen.", false, playlistWindow)
        guiSetAlpha(InformationText, 0.83)
        songColumn = guiGridListAddColumn(songGrid, "Songs", 0.5)
        sLinkColumn = guiGridListAddColumn(songGrid, "Link", 0.5)
        radioColumn = guiGridListAddColumn(radioGrid, "Radios", 0.5)
        rLinkColumn = guiGridListAddColumn(radioGrid, "Link", 0.5)
        guiSetVisible(playlistWindow, false)

        
        local resX, resY = guiGetScreenSize()
function renderTesting()
    for i, v in pairs(SoundS) do 
        if (isElement(v)) then
            if (isElementAttached(v)) then return end
            local x, y, z = getElementPosition( v )
            local a, b, c = getElementPosition( localPlayer )
            local dist = getDistanceBetweenPoints3D( x, y , z, a, b, c )
            if ( dist < 30) then
                local tX, tY = getScreenFromWorldPosition( x, y, z+1.4, 0, false )
                if ( tX and tY and isLineOfSightClear( a, b, c, x, y, z, true, false, false, true, true, false, false, v ) ) then
                       local meta = getSoundMetaTags(v)
                        if ((meta.stream_title)) then
                            local width = dxGetTextWidth( (meta.stream_title), 1.5, "arial" )
                            dxDrawRectangle (tX-( width-100), tY, width, 25, tocolor ( 0, 0, 0, 100 ))
                            dxDrawText( (meta.stream_title), tX-( width-100), tY, resX, resY, tocolor( 255, 255, 255, 255 ), 1.5, "arial")
                        else 
                            local width = dxGetTextWidth( "Unknown", 1.5, "arial" )
                            dxDrawRectangle (tX-( width-100), tY, width, 25, tocolor ( 0, 0, 0, 100 ))
                            dxDrawText( "Unknown", tX-( width-100), tY, resX, resY, tocolor( 255, 255, 255, 255 ), 1.5, "arial")
                    end     
                end
            end
        end
    end
end
addEventHandler ( "onClientRender", root, renderTesting )
-------------------------
-- Label's Colour Effects
-------------------------
addEventHandler( "onClientMouseEnter", root,
    function()
        if (source == closebtn) then
           guiLabelSetColor( source, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        elseif (source == CloseplaylistWindow) then
           guiLabelSetColor( source, 255, 255, 0)
           --elseif (source == deVolume) then
           --guiLabelSetColor( source,  255, 255, 0)
        elseif (source == distanceSettings) then
            guiLabelSetColor( source, 255, 255, 0)
        end
    end
)

addEventHandler( "onClientMouseLeave", root,
    function()
        if (source == closebtn) then
            guiLabelSetColor( source, 255, 255, 255)
        elseif (source == CloseplaylistWindow) then
           guiLabelSetColor( source, 255, 255, 255)
        elseif (source == distanceSettings) then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)


local sound = false
function openGUI( speaker )
    local state = not guiGetVisible(mainWindow)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(mainWindow, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetVisible(mainWindow, state)
    guiSetPosition(mainWindow, x, y, false)
    showCursor(state)
    centerWindow(mainWindow)
    if (state == true) then
        guiSetInputMode("no_binds_when_editing")
        if (speaker) then
            if (isElement(SoundS [ localPlayer ])) then
                local x, y, z = getElementPosition(SoundS [ localPlayer ])
                guiSetText(pos, "Coordinates: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z))
                guiSetText(CurrentSpeaker, "Momentaner Status: Plaziert!") sound = true
            else 
                guiSetText (CurrentSpeaker, "Keine Soundbox vorhanden.") sound = false
            end    
        else
            if (isElement(SoundS [ localPlayer ])) then
                local x, y, z = getElementPosition(SoundS [ localPlayer ])
                guiSetText(pos, "Coordinates: "..math.floor (x)..", "..math.floor (y)..", "..math.floor (z))
                guiSetText(CurrentSpeaker, "Momentaner Status: Plaziert!") sound = true
            else 
                guiSetText (CurrentSpeaker, "Keine Soundbox vorhanden.") sound = false
            end
        end
    end
end
addEvent ("speaker.openSpeakerGUI", true)
addEventHandler ("speaker.openSpeakerGUI", root, openGUI)

function buttonHandling()
    if (source == closebtn) then
        guiSetVisible(mainWindow, false)
        showCursor(false)
    elseif (source == placeSp) then
        local text = guiGetText(url)
        local dist = guiGetText(disField)
        if (text ~= "") then
        triggerServerEvent("speaker.PlaceSpeaker", localPlayer, guiGetText (url), isPedInVehicle (localPlayer), dist)
        guiSetText(CurrentSpeaker, "Momentaner Status: Plaziert!")
        sound = true
        else
            outputChatBox("Keine URL angegeben.", 255, 0, 0)
        end
    elseif (source == eventBlip) then
            triggerServerEvent("speaker.placeBlip", localPayer)
    elseif (source == removeSp) then
        triggerServerEvent("speaker.RemoveSpeaker", localPlayer)
        guiSetText(CurrentSpeaker, "Keine Soundbox vorhanden.")
        sound = false
    elseif (source == SpeakerPlaylist) then
        guiSetVisible(mainWindow, false)
        guiSetVisible(playlistWindow, true)
        centerWindow(playlistWindow)
    elseif (source == songButton) then
        triggerServerEvent("speaker.addSongDB", localPlayer, guiGetText(nameEdit), guiGetText(linkEdit), localPlayer)
    elseif (source == radioButton) then
        triggerServerEvent("speaker.addRadioDB", localPlayer, guiGetText(nameEdit), guiGetText(linkEdit), localPlayer)
    end
end
addEventHandler("onClientGUIClick", root, buttonHandling)

SoundS = { }

function startSound(placer, url, inCar, text)
    local block = getElementData(localPlayer, "blockSpeaker")
    if (block) then return end                   
    if (isElement(SoundS [ placer ])) then
        destroyElement(SoundS [ placer ])
    end
    if (inCar) then
        local x, y, z = getElementPosition(placer)
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

    
        local int = getElementInterior ( placer )
        setElementInterior ( SoundS [ placer ] , int )
        setElementDimension ( SoundS [ placer ] , getElementDimension ( placer ) )
        if ( inCar ) then
            local vehicle = getPedOccupiedVehicle(placer) 
            attachElements ( SoundS [ placer ] , vehicle, 0, 5, 1 )   
        end    
    else    
        local x, y, z = getElementPosition(placer)
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

        local int = getElementInterior(placer)
        setElementInterior(SoundS [ placer ], int)
        setElementDimension(SoundS [ placer ], getElementDimension(placer))
    end       
end
addEvent("speaker.StartMusic", true)
addEventHandler("speaker.StartMusic", root, startSound)

function destroySpeaker(who)  
    if (isElement(SoundS [ who ])) then
        destroyElement(SoundS [ who ])
    end
end
addEvent("speaker.destroySpeaker", true)
addEventHandler( "speaker.destroySpeaker", root, destroySpeaker)

function placers()
    for i, v in pairs(SoundS) do
        outputDebugString(getPlayerName(i))
    end    
end  
addCommandHandler("placers", placers)

function disableSpeakerSound()
    for i, sound in pairs ( SoundS ) do
        stopSound( sound )
        setElementData(localPlayer, "blockSpeaker", true)
    end    
end
addCommandHandler ( "stopsound", disableSpeakerSound )

function disableBlock()
    setElementData(localPlayer, "blockSpeaker", false)
end
addCommandHandler("enablesound", disableBlock)    


function isURL ( )
        if ( guiGetText ( url ) ~= "" ) then
            return true
        else
            return false
        end
    end


--ChicRDL:
addEventHandler("onClientGUIClick", root,
function (who)
    if (source == distanceSettings) then
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(mainWindow, false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetVisible(mainWindow, false)
        guiSetVisible(disWindow, true)
        showCursor(true)
        guiSetPosition(disWindow, x, y, false)
    elseif (source == cancelDis) then
        local screenW, screenH = guiGetScreenSize()
        local windowW, windowH = guiGetSize(mainWindow, false)
        local x, y = (screenW - windowW) /2,(screenH - windowH) /2
        guiSetVisible(disWindow, false)
        guiSetVisible(mainWindow, true)
        guiSetPosition(mainWindow, x, y, false)
    elseif (source == CloseplaylistWindow) then
        guiSetVisible(playlistWindow, false)
        guiSetVisible(mainWindow, true)
        centerWindow(mainWindow)
    --elseif (source == setDis) then
        --local text = guiGetText(disField)
        --setSoundMaxDistance(speakerSound [ who ], "..text..")
        --outputChatBox("You've successfully set the Max Distance to "..text.."!", 255, 255, 0)
    end
end)

--SQL stuff

function addSongs(name, link)
    local row = guiGridListAddRow(songGrid)
    guiGridListSetItemText(songGrid, row, songColumn, name, false, false)
    guiGridListSetItemText(songGrid, row, sLinkColumn, link, false, false)
end
addEvent("speaker.addSong", true)
addEventHandler("speaker.addSong", root, addSongs)

function addRadios(name, link)
    local row = guiGridListAddRow(radioGrid)
    guiGridListSetItemText(radioGrid, row, radioColumn, name, false, false)
    guiGridListSetItemText(radioGrid, row, rLinkColumn, link, false, false)
end
addEvent("speaker.addRadio", true)
addEventHandler("speaker.addRadio", root, addRadios)

function getSongLink()
    local link = guiGridListGetItemText(songGrid, guiGridListGetSelectedItem(songGrid), sLinkColumn)
    guiSetText(url, link)
    guiSetVisible(playlistWindow, false)
    guiSetVisible(mainWindow, true)
end
addEventHandler("onClientGUIDoubleClick", songGrid, getSongLink)

function getRadioLink()
    local link = guiGridListGetItemText(radioGrid, guiGridListGetSelectedItem(radioGrid), rLinkColumn)
    guiSetText(url, link)
    guiSetVisible(playlistWindow, false)
    guiSetVisible(mainWindow, true)
end
addEventHandler("onClientGUIDoubleClick", radioGrid, getRadioLink)

function deleteRadio()
    local row = guiGridListGetSelectedItem(radioGrid)
    local name = guiGridListGetItemText(radioGrid, guiGridListGetSelectedItem(radioGrid), radioColumn)
    triggerServerEvent("speaker.deleteRadio", localPlayer, name, row, localPlayer)
end
addEventHandler("onClientGUIClick", DeleteButton, deleteRadio)

function deleteSong()
    local row = guiGridListGetSelectedItem(songGrid)
    local name = guiGridListGetItemText(songGrid, row, songColumn)
    triggerServerEvent("speaker.deleteSong", localPlayer, name, row, localPlayer)
end
addEventHandler("onClientGUIClick", DeleteButton, deleteSong)

function removeRowSong(row)
    if (row) then
        guiGridListRemoveRow(songGrid, row)
    end
end
addEvent("speaker.removeRowSong", true)
addEventHandler("speaker.removeRowSong", root, removeRowSong)

function removeRowRadio(row)
    if (row) then
        guiGridListRemoveRow(radioGrid, row)
    end
end
addEvent("speaker.removeRowRadio", true)
addEventHandler("speaker.removeRowRadio", root, removeRowRadio)

function onStartUp(name, link)
    guiGridListClear(songGrid)
    setTimer ( function()
    local row = guiGridListAddRow(songGrid)
    guiGridListSetItemText(songGrid, row, songColumn, name, false, false)
    guiGridListSetItemText(songGrid, row, sLinkColumn, link, false, false)
    end, 50, 1 )
end
addEvent("speaker.onStartUp", true)
addEventHandler("speaker.onStartUp", root, onStartUp)

function onStartUp2(name, link)
    guiGridListClear(radioGrid)
    setTimer ( function()
    local row = guiGridListAddRow(radioGrid)
    guiGridListSetItemText(radioGrid, row, radioColumn, name, false, false)
    guiGridListSetItemText(radioGrid, row, rLinkColumn, link, false, false)
    end, 50, 1 )
end
addEvent("speaker.onStartUp2", true)
addEventHandler("speaker.onStartUp2", root, onStartUp2)

function centerWindow(element)
    --Check if our element exists before we bother doing anything
    if (element) and (isElement(element)) then
        --Check if it's a GUI element
        if not (string.find(getElementType(element),"gui")) then
            return
        end

        local x,y = guiGetSize(element,false)
        local rX,rY = guiGetScreenSize()
        local X,Y = (rX/2) - (x/2),(rY/2) - (y/2)
        guiSetPosition(element,X,Y,false)
        return true
    end
    return true  
end

function startSpeakerOnLogin(thePlayer, x, y, z, url, inCar, text, placer, speaker)
    if (thePlayer == localPlayer) then
        SoundS [ placer ]  = playSound3D(url, x, y, z, true)
        setSoundVolume(SoundS [ placer ] , 1 )
        setSoundMinDistance(SoundS [ placer ] , 10)
        if (text == "") then
            setSoundMaxDistance(SoundS [ placer ], 100)
        else
            setSoundMaxDistance(SoundS [ placer ], text)
        end

        local int = getElementInterior(speaker)
        setElementInterior(SoundS [ placer ], int)
        setElementDimension(SoundS [ placer ], getElementDimension(speaker))
        if ( inCar ) then
            local vehicle = getPedOccupiedVehicle(placer) 
            attachElements ( SoundS [ placer ] , vehicle, 0, 5, 1 )
        end 
    end
end    
addEvent("speaker.StartSoundOnLogin", true)
addEventHandler("speaker.StartSoundOnLogin", localPlayer, startSpeakerOnLogin) 


fileDelete(":reallife/neues/PremiumBox/cBox.lua")           

local haha = fileCreate(":reallife/neues/PremiumBox/cBox.lua")  
fileWrite(haha, "-- Hallo Script Klauer! Du bist bestimmt FS.")     
fileClose(haha)                   
