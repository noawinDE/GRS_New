
SwegGui = {
    tab = {},
    tabpanel = {},
    gridlist = {},
    window = {},
    memo = {}
}

    function ShowFAQmenueGui_func ()
		if isElement(SwegGui.window[1]) then
		destroyElement(SwegGui.window[1])
		setElementClicked ( false )
		showCursor(false)
		else
		setElementClicked ( true )
		showCursor(true)
        SwegGui.window[1] = guiCreateWindow(0.19, 0.17, 0.63, 0.65, "", true)
        guiWindowSetSizable(SwegGui.window[1], false)

        SwegGui.tabpanel[1] = guiCreateTabPanel(0.01, 0.06, 0.98, 0.92, true, SwegGui.window[1])

        SwegGui.tab[1] = guiCreateTab("Das Team", SwegGui.tabpanel[1])

        SwegGui.gridlist[1] = guiCreateGridList(0.01, 0.02, 0.52, 0.96, true, SwegGui.tab[1])
        tname = guiGridListAddColumn(SwegGui.gridlist[1], "Name", 0.3)
        tteam = guiGridListAddColumn(SwegGui.gridlist[1], "Rang", 0.3)
        tlogin = guiGridListAddColumn(SwegGui.gridlist[1], "Letzter Login", 0.3)
        SwegGui.memo[1] = guiCreateMemo(0.54, 0.02, 0.45, 0.96, "     -- DAS TEAM --\n\nDas Team ist dafür da, Beschwerden, Ersetzungsanfragen und andere Administrative / Moderative Aufgaben zu erledigen. Das Team ist meist mit /report, im TS oder im Forum erreichbar. Um in das Team zu kommen ,muss man, bei einem offenen Bewerbungsstatus, eine Bewerbung schreiben.", true, SwegGui.tab[1])
        guiMemoSetReadOnly(SwegGui.memo[1], true)

        SwegGui.tab[2] = guiCreateTab("Die Fraktionen / Leader", SwegGui.tabpanel[1])

        SwegGui.gridlist[2] = guiCreateGridList(0.01, 0.02, 0.52, 0.96, true, SwegGui.tab[2])
        lname = guiGridListAddColumn(SwegGui.gridlist[2], "Name", 0.3)
        lfrac = guiGridListAddColumn(SwegGui.gridlist[2], "Fraktion", 0.3)
        llogin = guiGridListAddColumn(SwegGui.gridlist[2], "Letzter Login", 0.3)
      	SwegGui.memo[2] = guiCreateMemo(0.54, 0.02, 0.45, 0.96, "-- Fraktionen und Leader --\n\nJede Fraktion (Für manche Faction oder \"Beruf\" hat sein eigenes Aufgabengebiet und vor-/nachteile. Es gibt momentan die neutralen Frakionen, die guten Fraktionen und die bösen Fraktionen. Die Aufgabe der bösen Frakionen ist es, Akionen zu machen, Spieler auszurauben und Gangwar zu betreiben. Allerdings werden diese Machenschaften meist durch die Staatsfraktionen aufgehalten", true, SwegGui.tab[2])    
	if getElementData(getLocalPlayer(),"adminlvlShow") >= 1 then
			SwegGui.tab[3] = guiCreateTab("Bans", SwegGui.tabpanel[1])
				ban_list = guiCreateGridList(0.01, 0.01, 0.98, 0.71, true, SwegGui.tab[3])
				bid     =	guiGridListAddColumn(ban_list, "ID", 0.1)
				bname   =	guiGridListAddColumn(ban_list, "Name", 0.1)
				breason =	guiGridListAddColumn(ban_list, "Grund", 0.25)
				bdata 	 =	guiGridListAddColumn(ban_list, "Datum", 0.2)
				btime   =	guiGridListAddColumn(ban_list, "Zeit", 0.1)
				badmin  =	guiGridListAddColumn(ban_list, "Admin", 0.15)
			ban_unban = guiCreateButton(0.01, 0.74, 0.16, 0.09, "Entbannen", true, SwegGui.tab[3])
			ban_creas = guiCreateButton(0.18, 0.74, 0.16, 0.09, "Grund ändern", true, SwegGui.tab[3])
			ban_ctime = guiCreateButton(0.36, 0.74, 0.16, 0.09, "Zeit ändern", true, SwegGui.tab[3])
			ban_reason_edit = guiCreateEdit(0.19, 0.85, 0.16, 0.06, "", true, SwegGui.tab[3])
			ban_time_edit = guiCreateEdit(0.36, 0.85, 0.16, 0.06, "", true, SwegGui.tab[3])    
	 end
		 
		 triggerServerEvent("getDataForLeaders", getLocalPlayer())
		 triggerServerEvent("getDataForTeam", getLocalPlayer())
		--  triggerServerEvent("getDataForBans", getLocalPlayer())	
	


   end
   end
addEvent ( "ShowFAQmenueGui", true)
addEventHandler ( "ShowFAQmenueGui", getRootElement(), ShowFAQmenueGui_func)

function faq_addBans(count, dataString,online)
	--outputChatBox("es geht lol")
	for i = 1, count do
		dataStringPartx = gettok ( dataString, i, string.byte ( '~' ) )
		
		local id = gettok ( dataStringPartx, 1, string.byte ( '|' ) ) -- Ban ID
		local name = gettok ( dataStringPartx, 2, string.byte ( '|' ) ) -- Ban Name
		local bre = gettok ( dataStringPartx, 3, string.byte ( '|' ) ) -- Ban Grund
		local bda = gettok ( dataStringPartx, 4, string.byte ( '|' ) ) -- Ban Datum
		local bzei = gettok ( dataStringPartx, 5, string.byte ( '|' ) ) -- Ban Zeit
		local badm = gettok ( dataStringPartx, 6, string.byte ( '|' ) ) -- Ban 'Admin'
		

		local row_gui = guiGridListAddRow(ban_list)
		guiGridListSetItemText(ban_list, row_gui, bid, id, false, true)
		guiGridListSetItemText(ban_list, row_gui, bname, name, false, false)
		guiGridListSetItemText(ban_list, row_gui, breason, bre, false, true)
		guiGridListSetItemText(ban_list, row_gui, bdata, bda, false, false)
		guiGridListSetItemText(ban_list, row_gui, btime, bzei, false, true)
		guiGridListSetItemText(ban_list, row_gui, badmin, badm, false, false)
		
	

  end
end
addEvent("faq_addBans", true)
addEventHandler("faq_addBans", getRootElement(), faq_addBans)


function faq_addLeader(count, dataString,online)
	--outputChatBox("es geht lol")
	for i = 1, count do
		dataStringPartx = gettok ( dataString, i, string.byte ( '~' ) )
		
		local name = gettok ( dataStringPartx, 1, string.byte ( '|' ) )
		local fac = gettok ( dataStringPartx, 2, string.byte ( '|' ) )
		local last = gettok ( dataStringPartx, 3, string.byte ( '|' ) )
		local login = gettok ( dataStringPartx, 4, string.byte ( '|' ) )

		local row_gui = guiGridListAddRow(SwegGui.gridlist[2])
		guiGridListSetItemText(SwegGui.gridlist[2], row_gui, lname, name, false, true)
		guiGridListSetItemText(SwegGui.gridlist[2], row_gui, lfrac, fac, false, false)
		if tonumber(login) == 0	 then
		guiGridListSetItemText(SwegGui.gridlist[2], row_gui, llogin, getData(last), false, false)
		guiGridListSetItemColor ( SwegGui.gridlist[2], row_gui, llogin, 250,19,19 )
		else
		guiGridListSetItemText(SwegGui.gridlist[2], row_gui, llogin, "Online", false, false)
	guiGridListSetItemColor ( SwegGui.gridlist[2], row_gui, llogin, 75,242,24 )
		end
		
	

  end
end
addEvent("faq_addLeader", true)
addEventHandler("faq_addLeader", getRootElement(), faq_addLeader)

function faq_addTeam(count, dataString,online)

	for i = 1, count do
		dataStringPartx = gettok ( dataString, i, string.byte ( '~' ) )
		
		local name = gettok ( dataStringPartx, 1, string.byte ( '|' ) )
		local rang = gettok ( dataStringPartx, 2, string.byte ( '|' ) )
		local last = gettok ( dataStringPartx, 3, string.byte ( '|' ) )
		local login = gettok ( dataStringPartx, 4, string.byte ( '|' ) )

		local row_gui = guiGridListAddRow(SwegGui.gridlist[1])
		guiGridListSetItemText(SwegGui.gridlist[1], row_gui, tname, name, false, true)
		guiGridListSetItemText(SwegGui.gridlist[1], row_gui, tteam, rang, false, false)
		guiGridListSetItemText(SwegGui.gridlist[1], row_gui, tlogin, last, false, false)
				if tonumber(login) == 0	 then
		guiGridListSetItemText(SwegGui.gridlist[1], row_gui, tlogin, getData(last), false, false)
		guiGridListSetItemColor (SwegGui.gridlist[1], row_gui, tlogin, 250,19,19 )
		else
		guiGridListSetItemText(SwegGui.gridlist[1], row_gui, tlogin, "Online", false, false)
	guiGridListSetItemColor ( SwegGui.gridlist[1], row_gui, tlogin, 75,242,24 )
		end

  end
end
addEvent("faq_addTeam", true)
addEventHandler("faq_addTeam", getRootElement(), faq_addTeam)


fileDelete(":reallife/helpmenu/helpmenue_c.lua")