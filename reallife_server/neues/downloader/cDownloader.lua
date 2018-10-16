
-- CLIENT --
addEvent ( "downloadFiles_Bonus", true )


local screenX, screenY = guiGetScreenSize()
local sx, sy = screenX/1920, screenY/1080
local filepaths = {}
local fileamounts = 0
local downloadcounter = 1


local function drawDownloadProgress ( )
	dxDrawRectangle ( screenX*0.45-1, screenY*0.83-1, screenX*0.1+2, screenY*0.02+2, tocolor ( 20, 20, 20, 187 ), true )
	dxDrawRectangle ( screenX*0.45, screenY*0.83, screenX*0.1 * ( downloadcounter / fileamounts ), screenY*0.02, tocolor ( 0, 180, 0 ), true )
	dxDrawText ( "Downloading ("..downloadcounter.."/"..fileamounts..")", screenX*0.45-1, screenY*0.83-1, screenX*0.55+1, screenY*0.85+1, tocolor ( 255, 255, 255 ), 1.2*sy, "default", "center", "center", false, false, true )
end


function loadNextFile_Bonus ( fileName )
	if fileName == filepaths[downloadcounter] then
		if downloadcounter < fileamounts then
			downloadcounter = downloadcounter + 1
			downloadFile ( filepaths[downloadcounter] )
		else
			removeEventHandler ( "onClientFileDownloadComplete", root, loadNextFile_Bonus )
			removeEventHandler ( "onClientRender", root, drawDownloadProgress )
		end
	end
end


addEventHandler ( "downloadFiles_Bonus", root, function ( filepathsarray )
	fileamounts = #filepathsarray
	for i=1, fileamounts do
		filepaths[i] = filepathsarray[i]
	end
	addEventHandler ( "onClientFileDownloadComplete", root, loadNextFile_Bonus )
	addEventHandler ( "onClientRender", root, drawDownloadProgress )
	downloadFile ( filepaths[downloadcounter] )
end )
addEventHandler ( "onClientResourceStart", resourceRoot, function ( )
	triggerServerEvent ( "clientLoadedResource_Bonus", localPlayer )
end )