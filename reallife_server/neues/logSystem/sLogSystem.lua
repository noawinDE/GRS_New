rootElement = getRootElement()

addCommandHandler("logs",
function (thePlayer)
local accountname = getAccountName(getPlayerAccount(thePlayer))
if vioGetElementData(thePlayer,"adminlvl") >= 2 then triggerClientEvent(thePlayer,"show_editor",thePlayer)
else outputChatBox("Du bist nicht Befugt.",thePlayer,255,0,0)
  end
end)

function getScriptEnd(file)
  local tmp, endPos = fileGetPos(file)
  while not fileIsEOF(file) do    
  fileRead(file, 500)                      
  end
  endPos = fileGetPos(file)
  fileSetPos(file, tmp)
  return endPos
end

function getResNameFromPath(path)
  if (type(path) ~= "string") then return "" end
  local sep1, sep = path:find("\\") or 0
  local sep2 = path:find("/") or 0
  if (sep1 > sep2) then sep = sep1 else sep = sep2 end
  if (sep == 0) then return path end
  return path:sub(1, sep-1), path:sub(sep+1, path:len())
end

function reload_script(client, path)
    triggerClientEvent(client, "return_message", client, "Logs aktualisiert", 255, 140, 0)
    local file = fileOpen(":stored_files/logs/"..path..".log", true)
	if (file) then
	local text = fileRead(file, getScriptEnd(file))
	triggerClientEvent(client, "return_script_open", client, text)
    fileClose(file)
	end
end
addEvent("reload_script", true)
addEventHandler("reload_script", rootElement, reload_script)
 
function save_script(client, path, text)
  local resName = getResNameFromPath(path)
  local file = fileCreate(":"..path, resName)
  if (file) then
    fileWrite(file, text)
	fileClose(file)
    triggerClientEvent(client, "return_message", client, "Information: Script Saved!", 0, 255, 0)  	
  if (resName) and get("restart_resource") == "true" then restartResource(getResourceFromName(resName)) end
  else
    triggerClientEvent(client, "return_message", client, "Error: Couldn't save the script!", 255, 0, 0)
  end
end
addEvent("save_script", true)
addEventHandler("save_script", rootElement, save_script)
 
function open_script(client, path)
  triggerClientEvent(client, "return_message", client, "Information: Logs  wird geladen...", 0, 255, 0)
  local file = fileOpen(":stored_files/logs/"..path..".log", true)
  if (file) then
    local text = fileRead(file, getScriptEnd(file))
    triggerClientEvent(client, "return_message", client, "Information: Logs geladen!", 0, 255, 0)
	triggerClientEvent(client, "return_script_open", client, text)
    fileClose(file)
  else
    triggerClientEvent(client, "return_message", client, "Error: Logs exestiert nicht.", 255, 0, 0)
  end    
end
addEvent("open_script", true) 
addEventHandler("open_script", rootElement, open_script)

function getAllResources(client)
	local resources = getResources()
	for i,v in ipairs(resources) do
		local name = getResourceName(v)
		triggerClientEvent(client,"return_resources",client,name)
	end
end
addEvent("get_resources", true) 
addEventHandler("get_resources", rootElement, getAllResources)

function getResourceContent(client,resName)
	if getResourceFromName(resName) then
		local file = xmlLoadFile(":"..resName.."/meta.xml")
		local child = xmlNodeGetChildren(file)
		for i,v in ipairs(child) do
			if xmlNodeGetName(v) == "script" then
			local src = xmlNodeGetAttribute(v,"src")
			triggerClientEvent(client,"return_content",client,src)
			end
		end
		xmlUnloadFile(file)
	end
end
addEvent("get_content", true) 
addEventHandler("get_content", rootElement, getResourceContent)

function open_script_browser(client, resName, scriptName)
  triggerClientEvent(client, "return_message", client, "Information: Script is loading...", 0, 255, 0)
  local file = fileOpen(":"..resName.."/"..scriptName,true)
  if (file) then
    local text = fileRead(file, getScriptEnd(file))
    triggerClientEvent(client, "return_message", client, "Information: Script loaded!", 0, 255, 0)
	triggerClientEvent(client, "return_script_open", client, text)
    fileClose(file)
	outputDebugString(getPlayerName(client) .." opened resource ".. resName .." and script ".. scriptName .."!")
  else
    triggerClientEvent(client, "return_message", client, "Error: Script couldn't be loaded!", 255, 0, 0)
  end    
end
addEvent("open_script_browser", true) 
addEventHandler("open_script_browser", rootElement, open_script_browser)

function create_resource(client,resourceName,name,author,description,version,type,clientSide,serverSide)
if not getResourceFromName(tostring(resourceName)) then
local resource = createResource ( tostring(resourceName) )
if ( resource ) then
outputChatBox("Resource ".. tostring(resourceName) .." created!",client,0,255,0)
setResourceInfo ( resource, "name", tostring(name) )
setResourceInfo ( resource, "author", tostring(author) )
setResourceInfo ( resource, "description", tostring(description) )
setResourceInfo ( resource, "version", tostring(version) )
setResourceInfo ( resource, "type", tostring(type) )
if clientSide == "" then
clientSide = "client"
end
if serverSide == "" then
serverSide = "server"
end
local meta = xmlLoadFile( ":"..getResourceName(resource).."/meta.xml" )
if meta then
local client_root = xmlCreateChild (meta,"script")
local server_root = xmlCreateChild (meta,"script")
xmlNodeSetAttribute(client_root, "src", tostring(clientSide) .. ".lua")
xmlNodeSetAttribute(client_root, "type", "client")
xmlNodeSetAttribute(server_root, "src", tostring(serverSide) .. ".lua")
xmlNodeSetAttribute(server_root, "type", "server")
xmlSaveFile(meta)
xmlUnloadFile(meta)
file_client = fileCreate(":".. getResourceName(resource) .."/"..tostring(clientSide)..".lua", resName)
file_server = fileCreate(":".. getResourceName(resource) .."/"..tostring(serverSide)..".lua", resName)
fileClose(file_client)
fileClose(file_server)
end
end
end
end
addEvent("create_resource", true) 
addEventHandler("create_resource", rootElement, create_resource)