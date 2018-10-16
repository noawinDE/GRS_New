



function SubmitRegisterBtn(button)
	
	if button == "left" then
		local pname = getPlayerName ( lp )
		local passwort = DGS:dgsDxGUIGetText( pw )
		local pwlaenge = #passwort
		local email = DGS:dgsDxGUIGetText( email )
		local bonuscode =  DGS:dgsDxGUIGetText( bonus )
		local werbender = DGS:dgsDxGUIGetText( werber )
					
					
		
		if  DGS:dgsDxGUIGetText( pwAgain ) ~= passwort then
			outputChatBox ( "Die beiden Passwoerter stimmen nicht ueberein!", 125, 0, 0 )
		elseif pwlaenge < 6 or passwort == "******" or passwort == pname or passwort == "123456" then
			outputChatBox ("Fehler: Ungueltiges Passwort", 255, 0 ,0 )
		else
			local birth_correct = 0
			bday = tonumber( DGS:dgsDxGUIGetText( registerDay ))
			bmon = tonumber( DGS:dgsDxGUIGetText( registerMonth ))
			byear = tonumber( DGS:dgsDxGUIGetText( registerYear ))
			if math.floor(bday) == bday and math.floor(bmon) == bmon and byear == math.floor (byear) then
				if bday < 32 and  bday > 0 and byear < 2009 and byear > 1900 and bmon < 13 and bmon > 0 then
					if bday < 29 then
						birth_correct = 1
					elseif (bday == 29 or bday == 30) and bmon ~= 2 then
						birth_correct = 1
					elseif bday == 31 and ( bmon == 1 or bmon == 3 or bmon == 5 or bmon == 7 or bmon == 8 or bmon == 10 or bmon == 12 ) then
						birth_correct = 1
					elseif bday == 29 and bmony == 2 and math.floor((byear/4)) == byear/4 then
						birth_correct = 1
					end
				else
					birth_correct = 0
				end
			else
				birth_correct = 0
			end
			if birth_correct == 1 then
				if DGS:dgsDxRadioButtonGetSelected(weib) == true then
					geschlecht = 0
				elseif DGS:dgsDxRadioButtonGetSelected(oberbanga) == true then
					geschlecht = 1
				end
				player = lp
				stopSound (joinmusik)
				triggerServerEvent ( "register", lp, player, hash ( "sha512", passwort ), bday, bmon, byear, geschlecht,bonuscode,email,werbender)
				DGS:dgsDxGUICloseWindow(register)
				findSettings ()
				killTimer(pwTimer)
				showChat(false)
			else
				outputChatBox ("Fehler: Ungueltiges Geburtsdatum!", 255, 0 , 0 )
			end
		end
	end
end
 





 
function showRegisterGui_func ()
		showCursor(true)
		register = DGS:dgsDxCreateWindow(0.35, 0.37, 0.27, 0.25,"Registrieren",true, nil,nil,nil,nil,nil,nil,nil, true)
		DGS:dgsDxWindowSetSizable(register,false)
		DGS:dgsDxWindowSetMovable(register,false)
		tabmenu = DGS:dgsDxCreateTabPanel(0.02, 0.09, 0.96, 0.88,true, register)
		acc = DGS:dgsDxCreateTab("Account erstellen",tabmenu)
		opt = DGS:dgsDxCreateTab("Optionales",tabmenu)
		reg = DGS:dgsDxCreateTab("Registrieren",tabmenu)
		DGS:dgsDxCreateLabel(0.03, 0.02, 0.12, 0.13, "Name",true,acc)
		DGS:dgsDxCreateLabel(0.03, 0.17, 0.29, 0.13, getPlayerName(getLocalPlayer()),true,acc)
		DGS:dgsDxCreateLabel(0.03, 0.35, 0.15, 0.13, "Passwort",true,acc)
		pw = DGS:dgsDxCreateEdit( 0.03, 0.53, 0.29, 0.13, "", true, acc )
		DGS:dgsDxGUISetProperty(pw,"masked",true) 
		DGS:dgsDxCreateLabel(0.38, 0.02, 0.37, 0.13, "Geburtstag (tt/mm/jjjj)",true,acc)
		registerDay = DGS:dgsDxCreateEdit( 0.38, 0.17, 0.09, 0.13, "", true, acc )
		registerMonth = DGS:dgsDxCreateEdit( 0.51, 0.17, 0.09, 0.13, "", true, acc )
		registerYear = DGS:dgsDxCreateEdit( 0.65, 0.17, 0.11, 0.13, "", true, acc )
		DGS:dgsDxCreateLabel(0.38, 0.35, 0.37, 0.13, "Geschlecht",true,acc)
		weib = DGS:dgsDxCreateRadioButton(0.38, 0.52, 0.23, 0.14, "Weiblich",true, acc)
		oberbanga  = DGS:dgsDxCreateRadioButton(0.65, 0.52, 0.23, 0.14, "Männlich",true, acc)
		DGS:dgsDxRadioButtonSetSelected(weib, true)
		DGS:dgsDxEditSetMaxLength(registerDay,2)
		DGS:dgsDxEditSetMaxLength(registerMonth,2)
		DGS:dgsDxEditSetMaxLength(registerYear,4)
		pwSafety = DGS:dgsDxCreateProgressBar(0.03, 0.77, 0.29, 0.18, true, acc)
		-- Optionales
		DGS:dgsDxCreateLabel(0.02, 0.05, 0.17, 0.13, "Bonuscode",true,opt)
		DGS:dgsDxCreateLabel(0.02, 0.33, 0.50, 0.52, "Ein Bonuscode kannst du im Forum\nfinden oder von anderen Usern\nerhalten. Ein Bonuscode gibt\ndir beim erstellen deines Accounts \nextra Geld.",true,opt)
		bonus = DGS:dgsDxCreateEdit(0.02, 0.18, 0.28, 0.13, "", true, opt )
		
		DGS:dgsDxCreateLabel(0.62, 0.05, 0.17, 0.13, "E-Mail", true,opt)
		email = DGS:dgsDxCreateEdit( 0.62, 0.18, 0.28, 0.13, "", true, opt )
		
		DGS:dgsDxCreateLabel(0.62, 0.33, 0.17, 0.13, "Werber",true,opt)
		werber = DGS:dgsDxCreateEdit(0.62, 0.49, 0.28, 0.13, "", true, opt )
		
		DGS:dgsDxCreateLabel(0.02, 0.05, 0.65, 0.34, "Überprüfe deine Daten und gebe dein Passwort\nnochmal ein.",true,reg)
		DGS:dgsDxCreateLabel(0.02, 0.43, 0.35, 0.14, "Passwort Wiederholung",true,reg)
		pwAgain = DGS:dgsDxCreateEdit(0.02, 0.62, 0.35, 0.13, "", true, reg )
		regButton = DGS:dgsDxCreateButton(0.07, 0.79, 0.5, 0.17, "Registrierung abschließen", true, reg, nil, nil, nil, nil, nil, nil, tocolor(1,223,1), tocolor(4,170,4), tocolor(4,170,4) )
		setTimer(checkPWSafety,250,1 )
		DGS:dgsDxGUISetProperty(pwAgain,"masked",true) 
		addEventHandler ( "onClientDgsDxMouseClick", regButton, SubmitRegisterBtn, true )
		





end
addEvent ( "ShowRegisterGui", true)
addEventHandler ( "ShowRegisterGui", getRootElement(), showRegisterGui_func )



	
function checkPWSafety ()

--	if guiGetVisible ( GUIEditor.window[1] ) then
		local pw = tostring ( DGS:dgsDxGUIGetText( pw ) )
		safety = # pw
		if safety >= 10 then
			safety = 50
		elseif safety >= 7 then
			safety = 30
		else
			safety = 10
		end
		if tonumber ( pw ) then	
			safety = safety
		else
			safety = safety + 25
		end
		if pw ~= "123456" then
			safety = safety + 25
		end
		if # pw < 6 then
			safety = 0
		end
		DGS:dgsDxProgressBarSetProgress(pwSafety, safety)
		
		pwTimer = setTimer ( checkPWSafety, 250, 1 )
--	end
end

function GUI_DisableRegisterGui()

-- 	cancelCameraIntro ()
	destroyElement ( GUIEditor.window[1] )
	showCursor ( false )
	
end
addEvent ( "DisableRegisterGui", true )
addEventHandler ( "DisableRegisterGui", getRootElement(), GUI_DisableRegisterGui)

function showBeginGui_func ()

	gWindow["welcomeInfo"] = guiCreateWindow(507,285,445,266,"Fast geschafft!",false)
	guiSetAlpha(gWindow["welcomeInfo"],1)
	gLabel["anfangsText"] = guiCreateLabel(0.0225,0.0789,0.9303,0.3083,"Das Tutorial ist nun beendet!\nNun waere es angebracht, sich im Hilfemenue ( Kurztaste: F1 ) erst einmal\nueber die Serverregeln und anfaenglichen Schritte zu informieren.\n\nViel Spass auf "..servername.."!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsText"],1)
	guiLabelSetColor(gLabel["anfangsText"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsText"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsText"],"left",false)
	guiSetFont(gLabel["anfangsText"],"default-bold-small")
	gButton["HelmenueOpen"] = guiCreateButton(0.0225,0.406,0.2292,0.1466,"Hilfemenue aufrufen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["HelmenueOpen"],1)
	gButton["closeAnfangsWindow"] = guiCreateButton(0.2674,0.406,0.2292,0.1466,"Fenster\nschliessen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["closeAnfangsWindow"],1)
	gLabel["anfangsPS"] = guiCreateLabel(0.0225,0.609,0.9618,0.1391,"P.S.: Vergiss nicht, auch in unserem Forum vorbei zu schauen - dort erwarten\ndich zahlreiche Events und Informationen!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsPS"],1)
	guiLabelSetColor(gLabel["anfangsPS"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsPS"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsPS"],"left",false)
	guiSetFont(gLabel["anfangsPS"],"default-bold-small")
	gLabel["anfangsAdresse"] = guiCreateLabel(0.1011,0.7707,1,0.1729,forumURL,true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsAdresse"],1)
	guiLabelSetColor(gLabel["anfangsAdresse"],200,200,000)
	guiLabelSetVerticalAlign(gLabel["anfangsAdresse"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsAdresse"],"left",false)
	guiSetFont(gLabel["anfangsAdresse"],"sa-header")
	addEventHandler("onClientGUIClick", gButton["HelmenueOpen"], SubmitOpenHelpMenueBtn, false)
	addEventHandler("onClientGUIClick", gButton["closeAnfangsWindow"], SubmitCloseThisWindowBtn, false)
end
addEvent ( "showBeginGui", true )
addEventHandler ( "showBeginGui", getRootElement(), showBeginGui_func )

function SubmitCloseThisWindowBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", lp )
end
function SubmitOpenHelpMenueBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	_CreateHelpmenueGui()
end