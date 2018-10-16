local settingsPath = ":vio_stored_files"
settings = {}
settingsSave = {}
settings[1] = {name = "latuna", status = 1, value = 1333.66, }
settings[2] = {name = "fisch", status = "false", value = 1333.66, }
settings[3] = {name = "dena", status	= 1, value = "false", }




function createSettings ()
    local settingsTree =  xmlLoadFile ( settingsPath.."/userSettings.xml" )
    if settingsTree then
        outputConsole("Einstellungen gefunden. Werden nun geladen...")
        for i, setting in ipairs(settings) do
            local xml =  xmlFindChild ( settingsTree, setting.name, 0 )
			if xml then
				local xmlStatus = xmlNodeGetValue ( xmlFindChild ( xml, "status", 0 ) )
				local xmlValue = xmlNodeGetValue (  xmlFindChild ( xml, "value", 0 ) )
				print("Status: "..xmlStatus..", Value "..xmlValue)
				settingsSave[i] = {name = setting.name,status	= xmlStatus, value = xmlValue, }
			else
				outputChatBox("Fehler beim laden deiner Einstellungen! ("..setting.name..")")
			end
        end
		
    else
        local settingsTree = xmlCreateFile ( settingsPath.."/userSettings.xml", "userSettings" )
		outputChatBox("Einstellungs Datei wird erstellt.")
        for i, setting in ipairs(settings) do
            local xml = xmlCreateChild ( settingsTree, setting.name )
            xmlNodeSetValue (xmlCreateChild ( xml, "status"), setting.status )
            xmlNodeSetValue (xmlCreateChild ( xml, "value"), setting.value )
        end
    end
end
addCommandHandler("css",createSettings)

createSettings ()

function changeSetting (state, var)
	if settingsTree then
			if state then
				settingsSave[1].status = state
			end
			if var then
				settingsSave[1].value = var
			end
	else
		print("Einstellungen konnten nicht geladen werden.")
	end
end
--addCommandHandler("cs",changeSetting, false)

--[[
function ClientResourceStop ()
	for i, setting in ipairs(settings) do
		local xml = xmlFindChild ( settingsTree, setting.name, 0 )
		local xmlStatus = xmlNodeGetValue ( xmlFindChild ( xml, "status", 0 ) )
		local xmlValue = xmlNodeGetValue (  xmlFindChild ( xml, "value", 0 ) )
		if xmlStatus ~= settingsSave[i].status then 
			outputConsole ( "Status von "..settingsSave[i].name.." von "..xmlStatus.." zu "..settingsSave[i].status.." geändert."  )
            xmlNodeSetValue (xmlFindChild ( xml, "status", 0 ), settingsSave[i].status )
		end
		if xmlValue ~= settingsSave[i].value then
			outputConsole ( "Wert von "..settingsSave[i].name.." von "..xmlValue.." zu "..settingsSave[i].value.." geändert."  )
			xmlNodeSetValue (xmlFindChild ( xml, "value", 0 ), settingsSave[i].value )
		end
		xmlSaveFile ( settingsTree ) 
		xmlUnloadFile ( settingsTree ) 
		outputConsole ( "Einstellungen gespeichert." )
	end
end
addEventHandler ( "onClientResourceStop", resourceRoot, ClientResourceStop )
--]]


