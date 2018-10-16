
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

local function removeCamHandler()
    if(sm.moov == 1)then
        sm.moov = 0
    end
end

local function camRender()
    if (sm.moov == 1) then
        local x1,y1,z1 = getElementPosition(sm.object1)
        local x2,y2,z2 = getElementPosition(sm.object2)
        setCameraMatrix(x1,y1,z1,x2,y2,z2)
    end
end
addEventHandler("onClientPreRender",root,camRender)
addEventHandler ( "onClientRender", root, camRender )

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
    if(sm.moov == 1)then return false end
    sm.object1 = createObject(1337,x1,y1,z1)
    sm.object2 = createObject(1337,x1t,y1t,z1t)
    setElementAlpha(sm.object1,0)
    setElementAlpha(sm.object2,0)
    setObjectScale(sm.object1,0.01)
    setObjectScale(sm.object2,0.01)
    moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
    moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
    sm.moov = 1
    setTimer(removeCamHandler,time,1)
    setTimer(destroyElement,time,1,sm.object1)
    setTimer(destroyElement,time,1,sm.object2)
    return true
end
addEvent ( "smoothMoveCam", true )
addEventHandler ( "smoothMoveCam", getRootElement(), smoothMoveCamera )


function playtutsound (player)
	unRenderHUD ()
	unbindKey ( "b", "down", switchHUD )
	setPlayerHudComponentVisible("all", false)
	setPlayerHudComponentVisible("crosshair", false)
    tutsound =  playSound("http://grs-rl.de/grsInhalt/tutorial.mp3", false)
    setSoundVolume(tutsound, 1.0)
    setTimer ( function()
		   setSoundVolume(tutsound, 0)
			stopSound (tutsound)
			setPlayerHudComponentVisible("radar", true)
			setPlayerHudComponentVisible("crosshair", true)
			bindKey ( "b", "down", switchHUD )
    end, 147*1000, 1 )
end
addEvent ( "playtutsound", true )
addEventHandler ( "playtutsound", getRootElement(), playtutsound )

function stoptutsound (player)
    stopSound (tutsound)
    setSoundVolume(tutsound, 0)
end
addEventHandler ( "stoptutm", getRootElement(), stoptutsound )
addEvent ( "stoptutm", true )

