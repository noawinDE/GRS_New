fraktionRearms = {}


function loadRearmSystem ()
    local result = dbQuery ( handler, "SELECT * FROM fraktionen WHERE ??=?", "ID", 1 )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local rearms = rows.rearms
				local swatsets = rows.swatsets
				if not rearms then
					setTimer ( outputDebugString, 5000, 1, "[Set-System] Waffen Sets wurden nicht geladen." )
				end
				if not swatsets then
					setTimer ( outputDebugString, 5000, 1, "[Set-System] SWAT Sets wurden nicht geladen." )
				end
				fraktionRearms["SWATSets"] = swatsets
				fraktionRearms["WeaponSets"] = rearms
				setTimer ( outputDebugString, 5000, 1, "[Set-System] Es wurden "..fraktionRearms["SWATSets"].." SWAT Sets und "..fraktionRearms["WeaponSets"].." Waffen Sets geladen." )
				
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, loadRearmSystem )

function saveRearmInDB ()
	
		dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ?? = ?", "fraktionen", "rearms", fraktionRearms["WeaponSets"], "swatsets", fraktionRearms["SWATSets"], "ID", 1 )
		outputDebugString(fraktionRearms["WeaponSets"].." Waffen Sets und "..fraktionRearms["SWATSets"].." SWAT Sets wurde gespeichert.") 
end
setTimer ( saveRearmInDB, 25*60*1000, 0 )