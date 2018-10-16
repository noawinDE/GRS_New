
	
function showForumRegister ()
	 if getSetting (11, 1) == 1 then 
		forumReg = DGS:dgsDxCreateWindow(0.43, -0.02, 0.14, 0.18, "Forum",true, nil,nil,nil,nil,nil,nil,nil, true)
		DGS:dgsMoveTo(forumReg,0.43, 0.41,true,false,"OutQuad",2000)
		DGS:dgsDxWindowSetSizable(forumReg,false)
		DGS:dgsDxWindowSetMovable(forumReg,false)
		DGS:dgsDxCreateLabel(.06, 0.14, 0.91, 0.23, "Du hast momentan kein Foren Account. \nGebe deine E-Mail ein, um einen zu erstellen.",true,forumReg)
		createAccount = DGS:dgsDxCreateButton(0.06, 0.70, 0.35, 0.20, "Account\nerstellen", true, forumReg, nil, nil, nil, nil, nil, nil, tocolor(11, 76, 11), tocolor(11, 76, 11), tocolor(11, 76, 11) )
		cancelCreation = DGS:dgsDxCreateButton(0.58, 0.70, 0.35, 0.20, "Später\nerstellen", true, forumReg, nil, nil, nil, nil, nil, nil, tocolor(188, 37, 11), tocolor(188, 37, 11), tocolor(188, 37, 11) )
		email = DGS:dgsDxCreateEdit( 0.19, 0.43, 0.69, 0.21, "", true, forumReg )
		addEventHandler ( "onClientDgsDxMouseClick", cancelCreation, cancelAcc, true )
		addEventHandler ( "onClientDgsDxMouseClick", createAccount, createAcc, true )
		setElementClicked ( true )
		showCursor(true)
	else
		outputChatBox("Foren Register wird nicht mehr angezeigt.")
	end
end
addEvent ( "showForumRegister", true)
addEventHandler ( "showForumRegister", getRootElement(), showForumRegister)
addCommandHandler("forum", showForumRegister)

function cancelAcc ()
	 DGS:dgsDxGUICloseWindow(forumReg)
	 showCursor(false)
	 setElementClicked ( false )
	 outputChatBox ( "Die Nachricht wird beim nächsen mal nicht erneut erscheinen. ", 0,139,0 )
	 changeSetting (11, 0, 1)
end

function createAcc ()
	local email = DGS:dgsDxGUIGetText( email )
	if string.len(email) > 0 then
        if allowedEmailEnding[string.cut(email,"@")] and string.find(email,"@") then
			if triggerServerEvent ( "registerUserInForum", getLocalPlayer(), getLocalPlayer(), email  ) then
				 DGS:dgsDxGUICloseWindow(forumReg)
				 showCursor(false)
				 setElementClicked ( false )
			end
		else
			infobox_start_func("Deine E-Mail ist ungültig.", 7500 )	
		end
	end
end