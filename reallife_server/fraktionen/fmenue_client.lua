

fMenue_Window = {}
fMenue_TabPanel = {}
fMenue_Tab = {}
fMenue_Button = {}
fMenue_Label = {}
fMenue_Edit = {}
fMenue_Grid = {}

factionNamesx = {}
factionNamesx[0] = "Zivilist"
factionNamesx[1]="SFPD"
factionNamesx[2]="Mafia"
factionNamesx[3]="Triaden"
factionNamesx[4]="Terroristen"
factionNamesx[5]="Reporter"
factionNamesx[6]="FBI"
factionNamesx[7]="Aztecas"
factionNamesx[8]="Army"
factionNamesx[9]="Biker"
factionNamesx[10]="Neon"
factionNamesx[11]="Medic"
factionNamesx[12]="Grove"
factionNamesx[13]="Ballas"
factionNamesx[14]="Hitman"
factionNamesx[15]="Schurken-Liga"
factionNamesx[16]="Delta Force"


-- Refresh Func.
function refreshmember ()
    guiGridListClear (fMenue_Grid[1])
    triggerServerEvent("getDataForFmenue", getLocalPlayer())
end

function refresfcars ()
    guiGridListClear (carlist)
    triggerServerEvent("getDataForCMenue", getLocalPlayer())
end

function refresfbuyablecars ()
    guiGridListClear (carbuylist)
    triggerServerEvent("getDataForCarbuymenue", getLocalPlayer())
end

-- Events

addEvent("refreshmember",true)
addEventHandler("refreshmember",getRootElement(),refreshmember )
addEvent("refresfcars",true)
addEventHandler("refresfcars",getRootElement(),refresfcars )
addEvent("refresfbuyablecars",true)
addEventHandler("refresfbuyablecars",getRootElement(),refresfbuyablecars )
-- Ende

function fMenue(kasse,drogen,mats,rearms,swatsets,level,levelm,maxvehs, momvehs)
    showCursor(true)

    local rang = tonumber(vioGetElementData(getLocalPlayer(), "rang"))
    local faction = tonumber(vioGetElementData(getLocalPlayer(), "fraktion"))

    if rang == 4 then
        rang = "Co-Leader (4)"
    end
    if rang == 5 then
        rang = "Leader (5)"
    end


    fMenue_Window[1] = guiCreateWindow(0.19, 0.12, 0.58, 0.71,"Fraktionsmenue - Fraktion: "..factionNamesx[faction].."  Rang: "..rang.."",true)
    fMenue_TabPanel[1] = guiCreateTabPanel(0.01, 0.09, 0.97, 0.87, true,fMenue_Window[1])
    fMenue_Tab[1] = guiCreateTab("Übersicht", fMenue_TabPanel[1])
    buyAbleLevel = level+1
    buylevel = guiCreateButton(0.62, 0.20, 0.24, 0.13, "Frakions Level "..buyAbleLevel.." kaufen. \nPreis: "..levelm.."$", true, fMenue_Tab[1])
    guiSetFont(buylevel, "default-bold-small")
    levelinfo = guiCreateLabel(0.01, 0.90, 0.25, 0.08, "*=Vom Level abhängig.\nJedes Level stellt 10 Neue Fahrzeuge\nzur verfügung.", true, fMenue_Tab[1])
    guiSetFont(levelinfo, "default-small")
    fMenue_Label[1] = guiCreateLabel(0.01, 0.02, 0.53, 0.74, "Fraktion: "..factionNamesx[faction].."\n\nRang: "..rang.."\n\nFraktions-Warns: "..vioGetElementData(getLocalPlayer(),"fwarns").." \n\nFraktions-Kasse: "..kasse.."$\n\nDepot-Drogen: "..drogen.."gr.\n\nDepot-Mats: "..mats.."Stk.\n\nRearms:  "..rearms.."\n\nSWAT Sets:  "..swatsets.."\n\nFrakions Level: "..level.."\n\nMaximale Fahrzeuge*: "..momvehs.."/"..maxvehs.." ", true,fMenue_Tab[1])
    guiSetFont(fMenue_Label[1],"default-bold-small")
    fMenue_Button[1] = guiCreateButton(0.62, 0.05, 0.24, 0.13, "Fahrezeuge Respawnen", true,fMenue_Tab[1])
    -- GUIEditor.button[2] = guiCreateButton(0.62, 0.20, 0.24, 0.13, "button2", true, GUIEditor.tab[1])
    -- GUIEditor.button[3] = guiCreateButton(0.62, 0.36, 0.24, 0.13, "button3", true, GUIEditor.tab[1])
    --  GUIEditor.button[4] = guiCreateButton(0.62, 0.51, 0.24, 0.13, "button4", true, GUIEditor.tab[1])
    guiSetFont(fMenue_Button[1],"default-bold-small")
    fMenue_Tab[2] = guiCreateTab("Mitglieder",fMenue_TabPanel[1])
    fMenue_Grid[1] = guiCreateGridList(0.01, 0.03, 0.70, 0.93, true, fMenue_Tab[2])
    guiGridListSetSelectionMode(fMenue_Grid[1],2)
    --Spielzeit
    cname = guiGridListAddColumn(fMenue_Grid[1],"Name",0.2)

    crang = guiGridListAddColumn(fMenue_Grid[1],"Rang",0.2)

    cwarns = guiGridListAddColumn(fMenue_Grid[1],"Frak-Warns",0.2)

    clast= guiGridListAddColumn(fMenue_Grid[1],"Letzter Login",0.2)

    ctime= guiGridListAddColumn(fMenue_Grid[1],"Spielzeit",0.1)

    fMenue_Button[2] =  guiCreateButton(0.72, 0.03, 0.25, 0.10, "Rank Up", true, fMenue_Tab[2])
    guiSetFont(fMenue_Button[2],"default-bold-small")

    fMenue_Button[3] = guiCreateButton(0.72, 0.15, 0.25, 0.10, "Rank Down", true,fMenue_Tab[2])
    guiSetFont(fMenue_Button[3],"default-bold-small")

    fMenue_Button[4] = guiCreateButton(0.72, 0.27, 0.25, 0.10, "Uninviten", true, fMenue_Tab[2])
    guiSetFont(fMenue_Button[4],"default-bold-small")

    fMenue_Label[2] = guiCreateLabel(0.73, 0.65, 0.24, 0.06, "Spieler in die Fraktion inviten", true,fMenue_Tab[2])
    guiSetFont(fMenue_Label[2],"default-bold-small")

    fMenue_Edit[1] =  guiCreateEdit(0.80, 0.71, 0.17, 0.07, "", true,fMenue_Tab[2])

    fMenue_Label[3] = guiCreateLabel(0.73, 0.72, 0.09, 0.04, "Name:", true,fMenue_Tab[2])
    guiSetFont(fMenue_Label[3],"default-bold-small")

    fMenue_Button[5] = guiCreateButton(0.72, 0.80, 0.25, 0.10, "Inviten", true,fMenue_Tab[2])
    guiSetFont(fMenue_Button[5],"default-bold-small")

    fMenue_Label[4] = guiCreateLabel(0.73, 0.38, 0.24, 0.04, "Spieler verwarnen", true,fMenue_Tab[2])
    guiSetFont(fMenue_Label[4],"default-bold-small")

    fMenue_Edit[2] = guiCreateEdit(0.81, 0.44, 0.17, 0.07, "", true,fMenue_Tab[2])

    fMenue_Button[6] = guiCreateButton(0.72, 0.53, 0.25, 0.10, "Verwarnen", true,fMenue_Tab[2])
    guiSetFont(fMenue_Button[6],"default-bold-small")

    fMenue_Label[5] = guiCreateLabel(0.73, 0.44, 0.09, 0.04, "Grund:", true,fMenue_Tab[2])
    guiSetFont(fMenue_Label[5],"default-bold-small")

    --fMenue_Label[6] = guiCreateLabel(12,25,180,16,"Fraktion: "..factionNamesx[faction].."  Rang: "..rang.."",false,fMenue_Window[1])
    --guiSetFont(fMenue_Label[6],"default-bold-small")

    fMenue_Button[7] = guiCreateButton(0.90, 0.06, 0.04, 0.04, "X", true,fMenue_Window[1])
    -- Ausgewähltes Fahrzeug\nverkaufen (75% des Geldes in die F-Kasse)
    -- Ausgewähltes Fahrzeug orten
    -- Fahrzeuge kaufen

    fMenue_Button[8] = guiCreateButton(0.72, 0.92, 0.25, 0.06, "Member-Liste \naktualisieren", true, fMenue_Tab[2])
    triggerServerEvent("getDataForFmenue", getLocalPlayer())
    triggerServerEvent("getDataForCMenue", getLocalPlayer())

    logst = guiCreateTab("Fraktion-Logs", fMenue_TabPanel[1])

    logs = guiCreateMemo(0.01, 0.02, 0.98, 0.96, "", true, logst)
    guiMemoSetReadOnly(logs, true)

    noticet = guiCreateTab("Fraktion-Notizen", fMenue_TabPanel[1])

    notice = guiCreateMemo(0.01, 0.02, 0.97, 0.85, "", true, noticet)
    guiMemoSetReadOnly(notice, true)

    --notice1 = guiCreateButton(0.01, 0.89, 0.19, 0.09,"Schliessen",true,noticet)
    notice2 = guiCreateButton(0.41, 0.89, 0.19, 0.09,"Speichern",true,noticet)
    notice3  = guiCreateButton(0.80, 0.89, 0.19, 0.09,"Bearbeiten",true,noticet)
    guiSetEnabled(notice2,false)


    carbuy = guiCreateTab("Fraktion-Fahrzeuge", fMenue_TabPanel[1])
    carlist = guiCreateGridList(0.02, 0.03, 0.71, 0.95, true, carbuy)
    ccars = guiGridListAddColumn(carlist, "Fahrzeug", 0.2)
    ccrang = guiGridListAddColumn(carlist, "Rang", 0.2)
    cloc = guiGridListAddColumn(carlist, "Ort", 0.3)
    cid = guiGridListAddColumn(carlist, "ID", 0.2)

    admintab = guiCreateTab("Administrativ", fMenue_TabPanel[1])

    arespawn = guiCreateButton(0.01, 0.01, 0.17, 0.09, "Fahrzeuge Respawnen", true,admintab)
    --  acardelete = guiCreateButton(0.01, 0.12, 0.17, 0.09, "Alle Fahrzeuge löschen", true,admintab)
    --     afreset = guiCreateButton(0.01, 0.22, 0.17, 0.09, "Fraktion zurücksetzen\n(Level,Mitglieder,Rang der Fahrzeuge)", true,admintab)
    --   afrangreset = guiCreateButton(0.01, 0.32, 0.17, 0.09, "Jedes Mitglied Rang 0\nsetzen", true,admintab)
    --   anoleader = guiCreateButton(0.01, 0.42, 0.17, 0.09, "Leader entfernen", true,admintab)
    --    anomoney= guiCreateButton(0.01, 0.53, 0.17, 0.09, "Kasse zurücksetzen", true,admintab)



    local rRank = vioGetElementData(getLocalPlayer(), "rang")
    if (rRank == 4) or (rRank == 5) then
        guiSetEnabled(notice2,true)
    else
        guiSetEnabled(notice2,false)
    end
    setElementData(getLocalPlayer(), "ElementClicked", true)
    vkfcar = guiCreateButton(0.74, 0.04, 0.25, 0.12, "Ausgewähltes Fahrzeug\nverkaufen (75% des Geldes in die F-Kasse)", true, carbuy)
    findfcar = guiCreateButton(0.74, 0.18, 0.25, 0.12, "Ausgewähltes Fahrzeug\norten", true, carbuy)
    buyfcar = guiCreateButton(0.74, 0.32, 0.25, 0.12, "Fahrzeuge kaufen", true, carbuy)
    setfcarrang = guiCreateButton(0.74, 0.47, 0.25, 0.12, "Fahrzeug Rang setzen", true, carbuy)
    infolab = guiCreateLabel(0.74, 0.60, 0.05, 0.06, "Rang:", true, carbuy)
    guiSetFont(infolab, "default-bold-small")
    fcarrang = guiCreateEdit(0.80, 0.60, 0.17, 0.06, "", true, carbuy)
    fcarsreload = guiCreateButton(0.74, 0.90, 0.25, 0.08, "Vehicle-Liste \naktualisieren", true, carbuy)

    addEventHandler("onClientGUIClick",   arespawn, function()

            triggerServerEvent("afPanelRespawn", getRootElement(), getLocalPlayer())

    end, false)




    addEventHandler("onClientGUIClick", vkfcar, function()
        local id = guiGridListGetItemText(carlist, guiGridListGetSelectedItem(carlist), 4)

        triggerServerEvent("fPanelSellCar", getLocalPlayer(),getLocalPlayer(),"cmd", id)

    end, false)

    addEventHandler("onClientGUIClick", fcarsreload, function()

            refresfcars ()
    end, false)

    addEventHandler("onClientGUIClick", findfcar, function()
        local id = guiGridListGetItemText(carlist, guiGridListGetSelectedItem(carlist), 4)

        triggerServerEvent("fPanelFindCar", getLocalPlayer(),getLocalPlayer(),"cmd", id)

    end, false)

    addEventHandler("onClientGUIClick", buylevel, function()

            local faction = tonumber(vioGetElementData(getLocalPlayer(), "fraktion"))
            triggerServerEvent("fPanelBuyLevel", getLocalPlayer(),getLocalPlayer(),"cmd",levelm, faction )
            guiSetVisible(fMenue_Window[1], false)
            showCursor(false)
            setElementData(getLocalPlayer(), "ElementClicked", false)
    end, false)



    addEventHandler("onClientGUIClick", setfcarrang, function()
        local id = guiGridListGetItemText(carlist, guiGridListGetSelectedItem(carlist), 4)

        triggerServerEvent("fPanelSetCarRang", getLocalPlayer(),getLocalPlayer(),"cmd", id,guiGetText(fcarrang))
        refresfcars ()
    end, false)

    addEventHandler("onClientGUIClick", buyfcar, function()

            guiSetVisible(fMenue_Window[1], false)
            carbuypanel ()

    end, false)

    addEventHandler("onClientGUIClick", fMenue_Button[7], function()
        showCursor(false)
        setElementData(getLocalPlayer(), "ElementClicked", false)
        guiSetVisible(fMenue_Window[1], false)
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[8], function()
        refreshmember ()
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[1], function()
        triggerServerEvent("fPanelRespawn", getRootElement(), getLocalPlayer())
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[2], function()
        local name = guiGridListGetItemText(fMenue_Grid[1], guiGridListGetSelectedItem(fMenue_Grid[1]), 1)
        triggerServerEvent("fPanelRankUP", getLocalPlayer(), name)
        --	refreshmember ()
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[3], function()
        local name = guiGridListGetItemText(fMenue_Grid[1], guiGridListGetSelectedItem(fMenue_Grid[1]), 1)
        triggerServerEvent("fPanelRankDown", getLocalPlayer(), name)
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[4], function()
        local name = guiGridListGetItemText(fMenue_Grid[1], guiGridListGetSelectedItem(fMenue_Grid[1]), 1)
        triggerServerEvent("fPanelUninvite", getLocalPlayer(), name)
        --	refreshmember ()
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[5], function()
        local name = guiGetText(fMenue_Edit[1])
        triggerServerEvent("fPanelInvite", getLocalPlayer(), name)
        --refreshmember ()
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[6], function()
        local name = guiGridListGetItemText(fMenue_Grid[1], guiGridListGetSelectedItem(fMenue_Grid[1]), 1)
        local grund = guiGetText(fMenue_Edit[2])
        triggerServerEvent("fPanelWarn", getLocalPlayer(), name, grund)
        --refreshmember ()
    end, false)
    addEventHandler("onClientGUIClick", fMenue_Button[7], function()
        showCursor(false)
        setElementData(getLocalPlayer(), "ElementClicked", false)
        guiSetVisible(fMenue_Window[1], false)
    end, false)

    addEventHandler("onClientGUIClick", notice2, function()
        if (source == notice2) then
            local playername = guiGetText(notice)
            triggerServerEvent("NoticeEdit",getRootElement(),getLocalPlayer(), "cmd",playername, guiGetText(notice))
            guiSetAlpha(notice, 1)
            guiMemoSetReadOnly(notice,true)
            guiSetEnabled(notice2,false)
        end

    end, false)

    addEventHandler("onClientGUIClick", notice3, function()
        local rRank = vioGetElementData(getLocalPlayer(), "rang")
        if (rRank == 4) or (rRank == 5) then
            guiSetAlpha(notice, 0.7)
            guiMemoSetReadOnly(notice,false)
            guiSetEnabled(notice2,true)
        end
    end, false)

    setGuiPermsM()

end
addEvent( "fraktionsMenue", true )
addEventHandler( "fraktionsMenue", getRootElement(), fMenue )

-- Setzt die Button etc. Perms.
function setGuiPermsM()
    local rRank = vioGetElementData(getLocalPlayer(), "rang")
    if (rRank == 4) or (rRank == 5) then
        guiSetEnabled(vkfcar,true)
    else
        guiSetEnabled(vkfcar,false)
    end
    if (rRank >= 1) then
        guiSetEnabled(findfcar,true)
    else
        guiSetEnabled(findfcar,false)
    end
    if (rRank >= 3) then
        guiSetEnabled(buyfcar,true)
    else
        guiSetEnabled(buyfcar,false)
    end

    if (rRank >= 4) then
        guiSetEnabled(setfcarrang,true)
    else
        guiSetEnabled(setfcarrang,false)
    end
    if (rRank == 5) then
        guiSetEnabled(buylevel,true)
    else
        guiSetEnabled(buylevel,false)
    end
end


function  carbuypanel ()
    local faction = tonumber(vioGetElementData(getLocalPlayer(), "fraktion"))
    fcarbuymenue = guiCreateWindow(0.17, 0.20, 0.60, 0.60, "Fraktionsmenue - Fahrzeugkauf - Fraktion: "..factionNamesx[faction], true)
    guiWindowSetSizable(fcarbuymenue, false)
    carbuylist = guiCreateGridList(0.01, 0.06, 0.80, 0.91, true, fcarbuymenue)
    buycar = guiCreateButton(0.82, 0.06, 0.17, 0.09, "Fraktions Fahrzeug\nkaufen", true, fcarbuymenue)
    createcar = guiCreateButton(0.82, 0.17, 0.17, 0.13, "Neues Fahrzeug erstellen\nAdmin only", true, fcarbuymenue)
    guiSetFont(createcar, "default-bold-small")
    label1 = guiCreateLabel(0.82, 0.32, 0.04, 0.04, "Preis:", true, fcarbuymenue)
    guiSetFont(label1, "default-bold-small")
    carpreis = guiCreateEdit(0.87, 0.32, 0.10, 0.04, "", true, fcarbuymenue)
    label2 = guiCreateLabel(0.82, 0.38, 0.04, 0.04, "V-ID:", true, fcarbuymenue)
    guiSetFont(label2, "default-bold-small")
    carid = guiCreateEdit(0.87, 0.38, 0.10, 0.04, "", true, fcarbuymenue)
    rgblabel = guiCreateLabel(0.82, 0.43, 0.15, 0.04, "----------RGB-------------------------", true, fcarbuymenue)
    guiSetFont(rgblabel, "default-bold-small")
    redit = guiCreateEdit(0.82, 0.49, 0.07, 0.05, "R", true, fcarbuymenue)
    gedit = guiCreateEdit(0.92, 0.49, 0.07, 0.05, "G", true, fcarbuymenue)
    bedit = guiCreateEdit(0.82, 0.56, 0.07, 0.05, "B", true, fcarbuymenue)
    rgb2edit = guiCreateEdit(0.92, 0.56, 0.07, 0.05, "RGB2", true, fcarbuymenue)
    back = guiCreateButton(0.84, 0.90, 0.13, 0.07, "Zurück", true, fcarbuymenue)
    refresgcarbuylistb = guiCreateButton(0.83, 0.81, 0.16, 0.07, "Aktualisieren", true, fcarbuymenue)
    guiSetFont(refresgcarbuylistb, "default-bold-small")
    setGuiPermsC()
    -- Fügt die Collums hinzu
    vehicle_cbuy = guiGridListAddColumn(carbuylist, "Fahrzeug", 0.3)
    price_cbuy   = guiGridListAddColumn(carbuylist, "Preis($)", 0.3)
    id_cbuy 	= guiGridListAddColumn(carbuylist, "ID", 0.3)
    -- Rows

    addEventHandler("onClientGUIClick", buycar, function()
        local car = guiGridListGetItemText(carbuylist, guiGridListGetSelectedItem(carbuylist), 3)
        triggerServerEvent("fPanelBuyCar", getLocalPlayer(), getLocalPlayer(), "cmd", car)
        --	refreshmember ()
    end, false)


    triggerServerEvent("getDataForCarbuymenue", getLocalPlayer())


    addEventHandler("onClientGUIClick", refresgcarbuylistb, function()



            refresfbuyablecars ()
    end, false)
    addEventHandler("onClientGUIClick", createcar, function()



            triggerServerEvent("addCarBuyMenueBuyAbleCars", getLocalPlayer(), getLocalPlayer(),"cmd",guiGetText(carid),guiGetText(carpreis),guiGetText(redit),guiGetText(gedit),guiGetText(bedit),guiGetText(rgb2edit))
    end, false)

    addEventHandler("onClientGUIClick",back, function()
        guiSetVisible(fcarbuymenue, false)
        guiSetVisible(fMenue_Window[1], true)


    end, false)
end


function setGuiPermsC()
    local rRank = vioGetElementData(getLocalPlayer(), "rang")
    -- Basis
    guiEditSetMaxLength(redit,3)
    guiEditSetMaxLength(gedit,3)
    guiEditSetMaxLength(bedit,3)
    guiEditSetMaxLength(rgb2edit,3)
    guiEditSetMaxLength(carpreis,7)
    guiEditSetMaxLength(carid,3)

    if (rRank == 4) or (rRank == 5) then
        guiSetEnabled(buycar,true)
    else
        guiSetEnabled(buycar,false)
    end
    if (vioGetElementData(getLocalPlayer(), "adminlvl") >= 4) then
        guiSetEnabled(createcar,true)
        guiEditSetReadOnly(redit,false)
        guiEditSetReadOnly(gedit,false)
        guiEditSetReadOnly(bedit,false)
        guiEditSetReadOnly(rgb2edit,false)
        guiEditSetReadOnly(carid,false)
        guiEditSetReadOnly(carpreis,false)
    else
        guiSetEnabled(createcar,false)
        guiEditSetReadOnly(redit,true)
        guiEditSetReadOnly(gedit,true)
        guiEditSetReadOnly(bedit,true)
        guiEditSetReadOnly(rgb2edit,true)
        guiEditSetReadOnly(carid,true)
        guiEditSetReadOnly(carpreis,true)
    end

end

-- CarBuy
function fMenue_addBuyAbleVehs(count, dataString,online)

    for i = 1, count do
        dataStringPartxx = gettok ( dataString, i, string.byte ( '~' ) )

        local carname = gettok ( dataStringPartxx, 1, string.byte ( '|' ) )
        local price = gettok ( dataStringPartxx, 2, string.byte ( '|' ) )
        local id = gettok ( dataStringPartxx, 3, string.byte ( '|' ) )


        local row_gui = guiGridListAddRow(carbuylist)
        guiGridListSetItemText(carbuylist, row_gui, vehicle_cbuy, carname, false, true)
        guiGridListSetItemText(carbuylist, row_gui, price_cbuy, price, false, false)
        guiGridListSetItemText(carbuylist, row_gui, id_cbuy, id, false, false)


    end
end
addEvent("fMenue_addBuyAbleVehs", true)
addEventHandler("fMenue_addBuyAbleVehs", getRootElement(), fMenue_addBuyAbleVehs)

-- ende
function setregeltext(text)
    guiSetText(notice,text)
    guiSetFont (notice, "default-bold-small" )
end
addEvent("setRuleText",true)
addEventHandler("setRuleText",getRootElement(),setregeltext)

function setlogstext(text)
    guiSetText(logs,text)
end
addEvent("setlogstext",true)
addEventHandler("setlogstext",getRootElement(),setlogstext)



function fMenue_addCars(count, dataString,online)
    --outputChatBox("es geht lol")
    for i = 1, count do
        dataStringPartx = gettok ( dataString, i, string.byte ( '~' ) )

        local carname = gettok ( dataStringPartx, 1, string.byte ( '|' ) )
        local rang = gettok ( dataStringPartx, 2, string.byte ( '|' ) )
        local location = gettok ( dataStringPartx, 3, string.byte ( '|' ) )
        local id = gettok ( dataStringPartx, 4, string.byte ( '|' ) )

        local row_gui = guiGridListAddRow(carlist)
        guiGridListSetItemText(carlist, row_gui, ccars, carname, false, true)
        guiGridListSetItemText(carlist, row_gui, ccrang, rang, false, false)
        guiGridListSetItemText(carlist, row_gui, cloc, location, false, false)
        guiGridListSetItemText(carlist, row_gui, cid, id, false, false)

    end
end
addEvent("fMenue_addCars", true)
addEventHandler("fMenue_addCars", getRootElement(), fMenue_addCars)



function fMenue_addMembers(count, dataString,online)

    for i = 1, count do
        dataStringPart = gettok ( dataString, i, string.byte ( '~' ) )

        local name = gettok ( dataStringPart, 1, string.byte ( '|' ) )
        local rang = gettok ( dataStringPart, 2, string.byte ( '|' ) )
        local warns = gettok ( dataStringPart, 3, string.byte ( '|' ) )
        local lastlogin = gettok ( dataStringPart, 4, string.byte ( '|' ) )
        local time = gettok ( dataStringPart, 5, string.byte ( '|' ) )
        local login = gettok ( dataStringPart, 6, string.byte ( '|' ) )
        local row_gui = guiGridListAddRow(fMenue_Grid[1])
        guiGridListSetItemText(fMenue_Grid[1], row_gui, cname, name, false, true)
        guiGridListSetItemText(fMenue_Grid[1], row_gui, crang, rang, false, false)
        guiGridListSetItemText(fMenue_Grid[1], row_gui, cwarns, warns, false, false)
        if tonumber(login) == 0	 then
            guiGridListSetItemText(fMenue_Grid[1], row_gui, clast, lastlogin, false, false)
            guiGridListSetItemColor ( fMenue_Grid[1], row_gui, clast, 250,19,19 )
        else
            guiGridListSetItemText(fMenue_Grid[1], row_gui, clast, "Online", false, false)
            guiGridListSetItemColor ( fMenue_Grid[1], row_gui, clast, 75,242,24 )
        end
        local playtime = time
        local playtimehours = math.floor(playtime/60)
        local playtimeminutes = playtime-playtimehours*60
        local playtime = playtimehours..":"..playtimeminutes
        guiGridListSetItemText(fMenue_Grid[1], row_gui, ctime, playtime, false, false)
    end
end
addEvent("fMenue_addMembers", true)
addEventHandler("fMenue_addMembers", getRootElement(), fMenue_addMembers)



