local settingsFileName = getPlayerName( getLocalPlayer() ).."_client.xml"
local settingsFilePath = ":vio_stored_files"
local settingsFile =  settingsFilePath.."/"..settingsFileName
local warningInFile = true
settings = {}
settings.save	= {}
settings.save.binds	= {}
settings.save.game	= {}
settings.game	= {}
settings.binds	= {}




-- // Name = Name der Einstellung, value = Standard Wert
settings.game[1] = {name = "joinmessage", value = "0" }
settings.game[2] = {name = "hud", value = "0" }
settings.game[3] = {name = "betamapstream", value = "0" }
settings.game[4] = {name = "fogdistance", value = getFogDistance() }
settings.game[5] = {name = "clouds", value = "1" }
settings.game[6] = {name = "renderdistance", value = getFarClipDistance() }

settings.binds[1] = {name = "helpmenu", key = "f1" }
settings.binds[2] = {name = "list", key = "f2" }
--print(settings.game[1].name)

local version = (tonumber(#settings.binds) + tonumber(#settings.game))
function findSettings ()
	settingsTree = xmlLoadFile ( settingsFile )
	if settingsTree then
        loadSettings ()
	else
		createSettings ()
	end
end

function createSettings ()
	settingsTree = xmlCreateFile ( settingsFile, "GRS_Einstellungen" )
	if settingsTree then
		outputChatBox("Einstellungs Datei wird erstellt.")
	else
		outputChatBox("Einstellungs Datei konnte nicht hergestellt werden.")
	end
	xmlNodeSetValue (xmlCreateChild ( settingsTree, "settingVersion"), version )
	if warningInFile == true then
		xmlNodeSetValue (xmlCreateChild ( settingsTree, "HINWEIS"), "Ohne Wissen nicht bearbeiten!" )
	end
	-- // Erstellt die Game Settings
	settingsGameBranch = xmlCreateChild ( settingsTree, "GameSettings" )
	for i, setting in ipairs(settings.game) do
		
        local xml = xmlCreateChild ( settingsGameBranch, setting.name )
		xmlNodeSetValue (xml, setting.value )
		settings.save.game[tonumber(i)] = {name = setting.name, value = setting.value }
	end
	
	-- // Erstellt die Bind Liste
	
	settingsBindsBranch = xmlCreateChild ( settingsTree, "GameBinds" )
	for i, setting in ipairs(settings.binds) do
        local xml = xmlCreateChild ( settingsBindsBranch,  setting.name )
		xmlNodeSetValue (xml, setting.key )
		settings.save.binds[tonumber(i)] = {name = setting.name, key = setting.key }
	end
	
	xmlSaveFile(settingsTree)
end

function loadSettings ()
	outputConsole("Einstellungen gefunden. Werden nun geladen...")
	local settingVersion = xmlNodeGetValue ( xmlFindChild ( settingsTree, "settingVersion", 0 ) )
	if tonumber(settingVersion) ~= tonumber(version) then
		outputChatBox("Deine Einstellungen sind Veraltet. Deine: "..settingVersion..", die optimale: "..version)
		outputChatBox("Gehe in die Einstellungen und gehe auf `Einstellungen resetten`")
	end
	
	
	-- // Läd Einstellungen
	for i, setting in ipairs(settings.game) do
        local xml =  xmlFindChild (  xmlFindChild ( settingsTree, "GameSettings", 0 ), setting.name, 0 )
		if xml then
			local xmlValue = xmlNodeGetValue ( xml )
			settings.save.game[tonumber(i)] = {name = setting.name, value = xmlValue }
		else
			outputChatBox("Fehler beim laden deiner Einstellungen! ("..setting.name..")")
		end
    end
	
	-- // Läd Binds
	for i, setting in ipairs(settings.binds) do
        local xml =  xmlFindChild (  xmlFindChild ( settingsTree, "GameBinds", 0 ), setting.name, 0 )
		if xml then
			local xmlValue = xmlNodeGetValue (  xml )
			settings.save.binds[tonumber(i)] = {name = setting.name, key = xmlValue }
		else
			outputChatBox("Fehler beim laden deiner Binds! ("..setting.name..")")
		end
    end
end
--[[
function changeSetting (id, state, var)
	local id = tonumber(id)
	if settingsTree then
			if state then
				settingsSave[id].status = state
			end
			if var then
				settingsSave[id].value = var
			end
		--	print("Daten geändert. "..settingsSave[id].value.." und "..settingsSave[id].status)
	else
		outputConsole("Einstellungen konnten nicht geladen werden.")
	end
end
--]]
function getSetting (id, typ)
	settingsTree = xmlLoadFile ( settingsFile )
	local id = tonumber(id)
	if settingsTree then
		if typ == 1 or typ == "game" then
			local var = settings.save.game[id].value
			return var
		else
			local key = settings.save.binds[id].key
			return key
		end
	end
end
findSettings ()

