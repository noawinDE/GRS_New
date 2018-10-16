-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

gLabels = { }
noInfobox = false
function infobox ( text, tts, r, g, b )

	infobox_start_func ( text, tts, r, g, b )
end

--[[function showInfoText_func ()
	
	if not gLabels["InfoTextForum"] then
		gLabels["InfoTextForumShadow"] = guiCreateLabel(10, screenheight-20+1, screenwidth+1, screenheight,"Forum: "..forumURL..", Hilfemenue: F1, Karte: F11",false)
		gLabels["InfoTextForum"] = guiCreateLabel(10, screenheight-20, screenwidth, screenheight,"Forum: "..forumURL..", Hilfemenue: F1, Karte: F11",false)
		guiLabelSetColor(gLabels["InfoTextForum"],125,20,20)
		guiLabelSetColor(gLabels["InfoTextForumShadow"],0,0,0)
		guiSetFont(gLabels["InfoTextForum"],"default-bold-small")
		guiSetFont(gLabels["InfoTextForumShadow"],"default-bold-small")
	end
end
addEvent ( "showInfoText", true )
addEventHandler ( "showInfoText", getRootElement(), showInfoText_func )]]

function infobox_start_func ( text, timetoshow, r, g, b )
if noInfobox == false then
	infoboxText = text
	-- DEV --
	while string.sub ( infoboxText, 1, 2 ) == "\n" do
		infoboxText = string.sub ( infoboxText, 3, #infoboxText )
	end
	while string.sub ( infoboxText, #infoboxText-1, #infoboxText ) == "\n" do
		infoboxText = string.sub ( infoboxText, 1, #infoboxText-2 )
	end
	-- DEV --
	if r == nil then
		r = 200
	end
	if g == nil then
		g = 200
	end
	if b == nil then
		b = 200
	end
	infoboxR = r
	infoboxG = g
	infoboxB = b
	
	if isTimer ( ChatBoxTimer1 ) then
		killTimer ( ChatBoxTimer1 )
		killTimer ( ChatBoxTimer2 )
	else
		local x, y = guiGetScreenSize()
		addEventHandler ( "onClientRender", getRootElement(), infoboxRender )
		infoboxIMG = guiCreateStaticImage(x/2-140,5,280,160,"images/black.png",false)
		guiSetAlpha(infoboxIMG, 0.95)
	end
	
	playSoundFrontEnd ( 42 )
	ChatBoxTimer1 = setTimer ( removeInfoboxDraw, timetoshow, 1 )
	ChatBoxTimer2 = setTimer ( destroyElement, timetoshow, 1, infoboxIMG )
	end
end
addEvent ( "infobox_start", true )
addEventHandler ( "infobox_start", getRootElement(), infobox_start_func )

function removeInfoboxDraw ()

	removeEventHandler ( "onClientRender", getRootElement(), infoboxRender )
end

function _CreateInfobox ()
if noInfobox == false then
	local x, y = guiGetScreenSize()
	--infoboxText = guiCreateTabPanel ( 4, 4, 135, 90, false )
	infoboxText = guiCreateStaticImage ( x/2-150, 5, 280, 160, "images/black.png", false )
	infoboxTextLabel = guiCreateLabel ( 10,10,122,78,"", false )
	guiLabelSetColor ( infoboxTextLabel, 255, 255, 125 )
	guiSetAlpha ( infoboxText, 1 )
	guiSetAlpha ( infoboxTextLabel, 1 )
	guiSetVisible(infoboxText, false)
	guiSetVisible(infoboxTextLabel, false)
	guiSetFont ( infoboxTextLabel, "default-bold-small" )
	end
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		_CreateInfobox()
	end
)

function showDrawnText_func ( text, timeToShow, r, g, b )

	curDrawedText = text
	curDrawedTextR = tonumber ( r )
	curDrawedTextG = tonumber ( g )
	curDrawedTextB = tonumber ( b )
	addEventHandler ( "onClientRender", getRootElement(), showDrawnText_render )
	setTimer ( function () removeEventHandler ( "onClientRender", getRootElement(), showDrawnText_render ) end, timeToShow, 1 )
end
addEvent ( "showDrawnText", true )
addEventHandler ( "showDrawnText", getRootElement(), showDrawnText_func )

function showDrawnText_render ()
if noInfobox == false then
	dxDrawText ( curDrawedText, screenwidth/2-3-200, screenheight/2-3, screenwidth, screenheight, tocolor ( 0, 0, 0, 255 ), 2.5, "pricedown" )
	dxDrawText ( curDrawedText, screenwidth/2-200, screenheight/2, screenwidth, screenheight, tocolor ( curDrawedTextR, curDrawedTextG, curDrawedTextB, 255 ), 2.5, "pricedown" )
	end
end

function infoboxRender ()
if noInfobox == false then
	local x, y = guiGetScreenSize()
	dxDrawText(infoboxText,0,5,x,160,tocolor(infoboxR,infoboxG,infoboxB,255),1.4,"default-bold","center","center",false,false,true)
	else
	destroyElement(infoboxIMG)
	end
end

local screenX, screenY = guiGetScreenSize()
local sx, sy = screenX/1920, screenY/1080
local showing = false
local modus = ""
local rectangles = {}
local texts = {}
local buttons = {}
local lines = {}
local edits = {}
local checkboxes = {}
local functions = {}
local chosenedit = 0


local function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end


local function draw ( )
	if rectangles[1] then
		for i=1, #rectangles do
			dxDrawRectangle ( unpack ( rectangles[i] ) )
		end
	end
	if edits[1] then
		guiSetInputMode ( "no_binds" )
		for i=1, #edits do
			dxDrawRectangle ( edits[i][2], edits[i][3], edits[i][4], edits[i][5], edits[i][6], edits[i][14] )
			dxDrawText ( edits[i][1], edits[i][2]+2*sx, edits[i][3]+1*sy, edits[i][2]+edits[i][4]-4*sx, edits[i][3]+edits[i][5]-4*sy, edits[i][7], edits[i][8], edits[i][9], edits[i][10], edits[i][11], edits[i][12], edits[i][13], edits[i][14] )
			if chosenedit == i then
				local x = dxGetTextWidth ( edits[i][1], edits[i][8], edits[i][9] )
				local length = dxGetFontHeight ( edits[i][8], edits[i][9] )
				local alpha = 255
				local tick = getTickCount()
				if tick - edits[i][16] >= 2000 then
					alpha = 0
					if tick - edits[i][16] >= 2500 then
						edits[i][16] = tick
					end
				end
				dxDrawRectangle ( edits[i][2]+2*sx + x + 1*sx, edits[i][3]+2*sy, 2*sx, length*sy, tocolor ( 0, 0, 0, alpha ), edits[i][14] )
			end
		end
	else
		guiSetInputMode ( "allow_binds" )
	end
	if texts[1] then
		for i=1, #texts do
			dxDrawText ( unpack ( texts[i] ) )
		end
	end
	if checkboxes[1] then
		for i=1, #checkboxes do
			for j=1, #checkboxes[i][1] do

				--[[1 { { unpack ( choices ) }, 
				2 x, 
				3 y, 
				4 width or 10*sx, 
				5 length or 10*sx, 
				6 color or tocolor ( 255, 255, 255 ), 
				7 gap or 2*sy, 
				8 textColor or tocolor ( 255, 255, 255 ), 
				9 textSize or 1*sy, 
				10 textFont or "default",
				11 postGUI or true, 
				12 gapToText or 2*sx, 
				13 onlyone or true, 
				14 lineSize or 2*sx, 
				15 lineColor or tocolor ( 0, 0, 0 ), 
				16 {} } ]]

				dxDrawText ( checkboxes[i][1][j], checkboxes[i][2]-checkboxes[i][12], checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1), checkboxes[i][2]-checkboxes[i][12], checkboxes[i][3] + checkboxes[i][5] + (checkboxes[i][5]+checkboxes[i][7])*(j-1), checkboxes[i][8], checkboxes[i][9], checkboxes[i][10], "right", "center", false, false, checkboxes[i][11] )
				dxDrawRectangle ( checkboxes[i][2], checkboxes[i][3]+ (checkboxes[i][5]+checkboxes[i][7])*(j-1), checkboxes[i][4], checkboxes[i][5], checkboxes[i][6], checkboxes[i][11] )
				if checkboxes[i][13] and checkboxes[i][16][1] == j or not checkboxes[i][13] and checkboxes[i][16][j] then
					dxDrawLine ( checkboxes[i][2], checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1), checkboxes[i][2]+checkboxes[i][4], checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1) + checkboxes[i][5], checkboxes[i][15], checkboxes[i][14], checkboxes[i][11] )
					dxDrawLine ( checkboxes[i][2], checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1) + checkboxes[i][5], checkboxes[i][2]+checkboxes[i][4], checkboxes[i][3]+ (checkboxes[i][5]+checkboxes[i][7])*(j-1), checkboxes[i][15], checkboxes[i][14], checkboxes[i][11] )
				end
			end
		end
	end
end



local function write ( button )
	if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive() then 
		return
	end
	if chosenedit > 0 and edits[chosenedit] then
		if #edits[chosenedit][1] <= edits[chosenedit][15] then
			edits[chosenedit][1] = edits[chosenedit][1] .. button
		end
	end
end


local function delete ( button, press )
	if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive() then 
		return
	end
	if press and button == 'backspace' then
		if chosenedit > 0 and edits[chosenedit] then
			if edits[chosenedit][1] ~= "" then
				edits[chosenedit][1] = string.sub ( edits[chosenedit][1], 1, -2 )
			end
		end
	end
end


local function click ( button, state, x, y )
	if button == "left" and state == "down" then
		if buttons[1] then
			for i=1, #buttons do
				if x >= buttons[i][1] and x <= buttons[i][3] and y >= buttons[i][2] and y <= buttons[i][4] then
					functions[buttons[i][5]]()
					return
				end
			end
		end
		if edits[1] then
			for i=1, #edits do
				if x >= edits[i][2] and x <= edits[i][2]+edits[i][4] and y >= edits[i][3] and y <= edits[i][3]+edits[i][5] then
					chosenedit = i
					return
				end
			end
		end
		if checkboxes[1] then
			for i=1, #checkboxes do
				if x >= checkboxes[i][2] and x <= checkboxes[i][2]+checkboxes[i][4] and y >= checkboxes[i][3] and y <= checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(#checkboxes[i][1]-1) + checkboxes[i][5] then
					for j=1, #checkboxes[i][1] do
						if y >= checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1) and y <= checkboxes[i][3] + (checkboxes[i][5]+checkboxes[i][7])*(j-1) + checkboxes[i][5] then
							if checkboxes[i][13] then
								checkboxes[i][16][1] = j
							else
								checkboxes[i][16][j] = not checkboxes[i][16][j]
							end 
							return
						end
					end
				end
			end
		end
		chosenedit = 0
	end
end
 

local function createRectangle ( x, y, width, length, color, postGUI )
	rectangles[#rectangles+1] = { x, y, width, length, color or tocolor ( 255, 255, 255 ), postGUI or false }
end


local function createButton ( func, text, x, y, width, length, colorRectangle, colorText, textSize, textFont, postGUI )
	rectangles[#rectangles+1] = { x, y, width, length, colorRectangle or tocolor ( 255, 255, 255 ), postGUI or false }
	texts[#texts+1] = { text, x, y, x+width, y+length, colorText or tocolor ( 255, 255, 255 ), textSize or 1*sy, textFont or "default", "center", "center", false, false, postGUI or false }
	buttons[#buttons+1] = { x, y, x+width, y+length, func }
end


local function createText ( text, x, y, right, bottom, color, size, font, alignX, alignY, clip, wordBreak, postGUI )
	texts[#texts+1] = { text, x, y, right or x, bottom or y, color or tocolor ( 255, 255, 255 ), size or 1*sy, font or "default", alignX or "left", alignY or "top", clip or false, wordBreak or false, postGUI or false }
end


local function createEdit ( x, y, width, length, color, postGUI, text, textColor, textSize, textFont, clip, wordBreak, limit )
	edits[#edits+1] = { text or "", x, y, width, length, color or tocolor ( 255, 255, 255 ), textColor or tocolor ( 0, 0, 0 ), textSize or 1*sy, textFont or "default", "left", wordBreak and "top" or "center", clip or false, wordBreak or false, postGUI or false, limit or 9999, getTickCount() }
end


local function createCheckBox ( choices, x, y, width, length, color, gap, textColor, textSize, textFont, postGUI, gapToText, onlyone, lineSize, lineColor )
	checkboxes[#checkboxes+1] = { { unpack ( choices ) }, x, y, width or 15*sx, length or 15*sx, color or tocolor ( 255, 255, 255 ), gap or 5*sy, textColor or tocolor ( 255, 255, 255 ), textSize or 1*sy, textFont or "default", postGUI or true, gapToText or 5*sx, onlyone or true, lineSize or 2*sx, lineColor or tocolor ( 0, 0, 0 ), {} } 
end


functions.closeGangCreation = function( )
	removeEventHandler ( "onClientRender", root, draw )
	removeEventHandler ( "onClientCharacter", root, write )
	removeEventHandler ( "onClientKey", root, delete )
	removeEventHandler ( "onClientClick", root, click )
	showCursor ( false )
	showing = false
	guiSetInputMode ( "allow_binds" )
end


functions.createGang = function ( )
	--outputDebugString ( "create" )
end


--addEventHandler ( "openFirmaCreation", root, function ( )
addCommandHandler ( "testmatze", function ( )
	if not showing then
		showCursor ( true )
		modus = ""
		rectangles = {}
		texts = {}
		buttons = {}
		lines = {}
		edits = {}	
		checkboxes = {}
		chosenedit = 0
		showing = true
		createRectangle ( screenX*0.4, screenY*0.35, screenX*0.2, screenY*0.3, tocolor ( 20, 20, 20, 187 ), true )
		createText ( "Willkommen bei der Unternehmens-Erstellen!\nHier kannst du eine Firma oder eine Gang erstellen.\nDer Preis beträgt $1!", screenX*0.41, screenY*0.36, screenX*0.59, screenY*0.36, tocolor ( 255, 255, 255 ), 1.2*sy, "default", "left", "top", false, true, true )
		
		createText ( "Name:", screenX*0.44, screenY*0.45, screenX*0.44, screenY*0.47, tocolor ( 255, 255, 255 ), 1.2*sy, "default", "left", "center", false, true, true )
		createEdit ( screenX*0.5, screenY*0.45, screenX*0.09, screenY*0.02, tocolor ( 255, 255, 255 ), true, "", tocolor ( 0, 0, 0 ), 1*sy, "default", false, false, 25 )
		createText ( "Typ:", screenX*0.44, screenY*0.49, screenX*0.44, screenY*0.51, tocolor ( 255, 255, 255 ), 1.2*sy, "default", "left", "center", false, true, true )
		createCheckBox ( { "Firma", "Gang" }, screenX*0.59-15*sy, screenY*0.5-7.5*sy, 15*sy, 15*sy, tocolor ( 255, 255, 255, 187 ), 5*sy, tocolor ( 255, 255, 255 ), 1.2*sy, "default", true, 20*sx, true, 2*sx, tocolor ( 0, 0, 0 ) )
		--createText ( "Branche:", screenX*0.44, screenY*0.53, screenX*0.44, screenY*0.55, tocolor ( 255, 255, 255 ), 1.2*sy, "default", "left", "center", false, true, true )
		--createCheckBox ( { "Firma", "Gang" }, screenX*0.59-15*sy, screenY*0.5-7.5*sy, 15*sy, 15*sy, tocolor ( 255, 255, 255, 187 ), 5*sy, tocolor ( 255, 255, 255 ), 1.2*sy, "default", true, 20*sx, true, 2*sx, tocolor ( 0, 0, 0 ) )
		
		createButton ( "closeGangCreation", "Schließen", screenX*0.55, screenY*0.62, screenX*0.04, screenY*0.02, tocolor ( 200, 0, 0, 187 ), tocolor ( 255, 255, 255 ), 1.2*sy, "default", true )
		createButton ( "createGang", "Erstellen", screenX*0.5, screenY*0.62, screenX*0.04, screenY*0.02, tocolor ( 0, 200, 0, 187 ), tocolor ( 255, 255, 255 ), 1.2*sy, "default", true )
		addEventHandler ( "onClientRender", root, draw )
		addEventHandler ( "onClientCharacter", root, write )
		addEventHandler ( "onClientKey", root, delete )
		addEventHandler ( "onClientClick", root, click )
	end
end )