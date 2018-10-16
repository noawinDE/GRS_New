infobh = createPickup ( -1983.134765625, 127.943359375, 27.6875, 3, 1239, 50, 0 )




function infob ( player )

    infobox ( player, "Tippe /tutorial um\ndas Tutorial zu starten.\nDies dauert bis zu 3 Minuten ! ", 5000, 200, 200, 0 )
end
addEventHandler ( "onPickupHit", infobh , infob )




function starttut (player)
    local x, y, z = getElementPosition ( player )
    if getDistanceBetweenPoints3D ( x, y, z,  -1983.134765625, 127.943359375, 27.6875 ) <= 5 then
        triggerClientEvent ( player, "playtutsound", player )
        outputChatBox("", player, 30,242,235)
        outputChatBox("» #1E4CF2Willkommen #1EF2EB« ", player, 30,242,235, true)
        outputChatBox("Herzlich willkommen auf "..sk.." Reallife.", player, 0, 125, 0)
        outputChatBox("In diesem Tutorial werden dir einige Sachen über den Server erklärt!", player, 0, 125, 0)
        setElementFrozen(player,true)
        local pname = getPlayerName(player)


        triggerClientEvent ( player, "smoothMoveCam", player, -2013.1728515625, 209.36329650879, 53.990200042725, -2012.8369140625, 208.50341796875, 53.605823516846,  -1997.0504150391, 131.03489685059, 35.915500640869, -1996.2158203125, 130.947265625, 35.37166595459, 15*1000  )
        setTimer ( function()
            triggerClientEvent ( player, "smoothMoveCam", player, -1997.0504150391, 131.03489685059, 35.915500640869, -1996.2158203125, 130.947265625, 35.37166595459,  -2055.4951171875, 192.03410339355, 57.024398803711, -2054.7919921875, 191.45709228516, 56.608741760254, 10000  )
            outputChatBox("", player, 30,242,235)
            outputChatBox("» #1E4CF2Der Bahnhof #1EF2EB« ", player, 30,242,235, true)
            outputChatBox("Dies ist der San Fierro Haupt-Bahnhof, dieser ist der Treffpunkt für Events oder einfach zum Ausruhen.", player, 0, 125, 0)
            outputChatBox("Hier findet man auch Fahrzeuge für Anfänger, einen Sprunk Automaten mit leckerer Sprunk Limo und einen ATM!", player, 0, 125, 0)
            outputChatBox("Dieser Ort steht gleichzeitig unter NO DM Schutz, hier ist töten und das abschiessen anderer Personen untersagt!", player, 255, 0, 0)
        end, 17*1000, 1 )
        setTimer ( function()
            triggerClientEvent ( player, "smoothMoveCam", player,  -2055.4951171875, 192.03410339355, 57.024398803711, -2054.7919921875, 191.45709228516, 56.608741760254,   -2030.7189941406, 269.78009033203, 65.925903320313, -2029.8389892578, 270.03509521484, 65.52522277832, 10000  )
            outputChatBox("", player, 30,242,235)
            outputChatBox("» #1E4CF2Autohäuser #1EF2EB« ", player, 30,242,235, true)
            outputChatBox("In Las Venturas (Oben Rechts) und in San Fierro (dein momentaner Standort) befinden sich mehrere", player, 0, 125, 0)
            outputChatBox("Autohäuser, bei dennen man sich verschiedene Fahrzeuge, von Auto bis zum Flugzeug, kaufen kann.", player, 0, 125, 0)
            outputChatBox("Alle Auto-/Fahrzeughäuser sind mit einem Flugzeug oder einem Auto markiert, in Las Venturas befindet sich aber noch ein Premium Auto Shop!", player, 0, 125, 0)
            --outputChatBox("Diese Zone steht gleichzeitig unter NO DM Schutz, hier ist töten und das abschiessen anderer Personen untersagt!", player, 255, 0, 0)
        end, 34*1000, 1 )
        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player,  -2030.7189941406, 269.78009033203, 65.925903320313, -2029.8389892578, 270.03509521484, 65.52522277832,   -1710.6325683594, 299.75289916992, 63.371101379395, -1709.7080078125, 299.94625854492, 63.042922973633, 10000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2Fraktion #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Auf unseren Server gibt es Gute, Böse und Neutrale Fraktionen, jede von ihnen hat ihre Besonderheiten.", player, 0, 125, 0)
                outputChatBox("Man kann fast jeden Fraktion via /fc beitreten.", player, 0, 125, 0,true)
                outputChatBox("Wir, das "..sk.." Team, weisen darauf hin, dass die Serverregeln trotz allen zu befolgen sind!", player, 255, 0, 0)
                outputChatBox("Diese Zone steht gleichzeitig unter NO DM Schutz, hier ist töten und das abschiessen anderer Personen untersagt!", player, 255, 0, 0)
        end, 48*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player,  -1710.6325683594, 299.75289916992, 63.371101379395, -1709.7080078125, 299.94625854492, 63.042922973633,   -1508.4158935547, 891.77886962891, 91.17259979248, -1509.365234375, 892, 90.949493408203, 5000  )

        end, 63*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -1508.4158935547, 891.77886962891, 91.17259979248, -1509.365234375, 892, 90.949493408203,  -1709.7998046875, 936.47100830078, 35.953201293945, -1710.7006835938, 936.86090087891, 35.762195587158, 5000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2Rathhaus #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Um bestimmte Lizensen zu bekommen oder Jobs zu finden, gibt es das Rathhaus.", player, 0, 125, 0)
                outputChatBox("Dort kann man Lizensen erwerben und sich in der Job Börse umschauen", player, 0, 125, 0,true)
                outputChatBox("Tipp: Der Job #B31919'Farmer' #007D00ist sehr beliebt!", player,0, 125, 0,true)
        end, 70*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -1709.7998046875, 936.47100830078, 35.953201293945, -1710.7006835938, 936.86090087891, 35.762195587158,   -1757.8304443359, 912.93188476563, 26.596300125122, -1757.8485107422, 911.93481445313, 26.670692443848, 10000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2Häuser #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Auf unserem Server kann man fast in jeder Stadt Häuser oder  Geschäfte erwerben.", player, 0, 125, 0)
                outputChatBox("Dort kann man seine Fahrzeuge parken und/oder eine Party feiern!", player, 0, 125, 0)

        end, 79*1000, 1 )
        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -1757.8304443359, 912.93188476563, 26.596300125122, -1757.8485107422, 911.93481445313, 26.670692443848,   -1773.7486572266, 947.36267089844, 37.208099365234, -1774.6962890625, 947.35308837891, 36.889019012451, 10000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2Hunger #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Um nicht zu verhungern, muss man regelmäßig etwas essen." ,player, 0, 125, 0)
                outputChatBox("Man kann an Sprunk Automaten oder bei FastFood Ketten etwas essen/drinken. ", player, 0, 125, 0)

        end, 92*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player,  -1773.7486572266, 947.36267089844, 37.208099365234, -1774.6962890625, 947.35308837891, 36.889019012451,    -1906.6021728516, 855.10906982422, 46.293701171875, -1905.7247314453, 855.43145751953, 45.938583374023, 10000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2Kleidung #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Du kannst deine Kleidung bzw. deinen Skin jederzeit im Skin Shop ändern.", player, 0, 125, 0)
                outputChatBox("Jeder Shop ist mit einem T-Shirt gekennzeichnet.", player, 0, 125, 0)

        end, 105*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player,  -1906.6021728516, 855.10906982422, 46.293701171875, -1905.7247314453, 855.43145751953, 45.938583374023,    -2152.5263671875, 794.54809570313, 108.99269866943, -2153.4272460938, 794.11602783203, 108.95364379883, 5000  )

        end, 118*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -2152.5263671875, 794.54809570313, 108.99269866943, -2153.4272460938, 794.11602783203, 108.95364379883,    -2440.7038574219, 730.49127197266, 43.773498535156, -2440.7529296875, 731.38592529297, 43.329410552979, 5000  )
                outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF224/#FF30307 #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Im 24/7 Shop (Rotes S) kann man Lose kaufen und andere Lebenswichtige", player, 0, 125, 0)
                outputChatBox("Produkte wie Zigaretten.", player, 0, 125, 0)
        end, 125*1000, 1 )

        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -2440.7038574219, 730.49127197266, 43.773498535156, -2440.7529296875, 731.38592529297, 43.329410552979,     -2400.3918457031, 463.89370727539, 112.06590270996, -2399.6540527344, 463.28549194336, 111.77285003662, 5000  )
                -- outputChatBox("", player, 30,242,235)
                --outputChatBox("» #1E4CF224/#FF30307 #1EF2EB« ", player, 30,242,235, true)
                --outputChatBox("Im 24/7 Shop (Rotes S) kann man Lose kaufen und andere Lebenswichtige", player, 0, 125, 0)
                --outputChatBox("Produkte wie Zigaretten.", player, 0, 125, 0)
        end, 133*1000, 1 )


        setTimer ( function()

                triggerClientEvent ( player, "smoothMoveCam", player, -2400.3918457031, 463.89370727539, 112.06590270996, -2399.6540527344, 463.28549194336, 111.77285003662,    -2055.4951171875, 192.03410339355, 57.024398803711, -2054.7919921875, 191.45709228516, 56.608741760254, 5000  )
                -- outputChatBox("", player, 30,242,235)
                outputChatBox("» #1E4CF2 Das Ende #1EF2EB« ", player, 30,242,235, true)
                outputChatBox("Dies war das Ende des Tutorials.", player, 0, 125, 0)
                outputChatBox("Falls deine Fragen #FF3030nicht#007D00 beantwortet wurden tippe #1EF2EB/report#007D00 in den Chat!", player, 0, 125, 0,true)
                outputChatBox("#007D00Forum: #1EF2EB"..forumURL.."#007D00, TS³: #1EF2EB "..tsip.." ", player, 0, 125, 0,true)
                --outputChatBox("Produkte wie Zigaretten.", player, 0, 125, 0)
        end, 139*1000, 1 )

        setTimer ( function()
            fadeCamera ( player, true )
            setCameraTarget( player, player )
            triggerClientEvent ( player, "stoptutm", player )
            setElementFrozen(player,false)
            outputChatBox("Du kannst das Tutorial jederzeit wiederholen!", player, 255,165,79)
        end, 147*1000, 1 )



        -- -1508.4158935547, 891.77886962891, 91.17259979248, -1509.365234375, 892, 90.949493408203
    end
end
addCommandHandler ( "tutorial", starttut )
