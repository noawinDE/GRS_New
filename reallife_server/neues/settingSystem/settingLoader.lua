local sRes = getResourceFromName("reallife_server")

function loadClientSettings ()
	experimanetelLoading()
	local var = getSetting (5, 1)
	if var == 1 then
		setCloudsEnabled(true)
	else
		setCloudsEnabled(false)
	end
	local var = getSetting (4, 1)
	setFogDistance(var)
	local var = getSetting (6, 1)
	setFarClipDistance(var)
	
	local var = getSetting (12, 1)
	if not tonumber(var) then
		outputChatBox ( "FPS-Einstellung Fehlerhaft! FPS maximum auf 45 gesetzt!", 224, 13, 13 )
		setFPSLimit(45)
	elseif tonumber(var) <= 30 then
		outputChatBox ( "FPS-Cap. ist 30 oder nierdriger! Dies kann zu einem schlechten Spielerlebnis führen.",  224, 13, 13 )
		setFPSLimit(var)
	else
		setFPSLimit(var)
	end
end
addCommandHandler("reloadSettings",loadClientSettings)

function experimanetelLoading ()
	local var = getSetting (3, 1)
	if var == 1 then
		addEventHandler("onClientResourceStart", sRes, function()
			for i,v in pairs(getResourceDynamicElementRoot(sRes), "object") do 
				setElementStreamable(v, false)
			end
		end)
		outputChatBox("Experimentel Map-Streaming ist aktiviert. Dies kann zu lade & Performance Problemen führen!")
	end
end

