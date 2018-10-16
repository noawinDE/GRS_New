function news1 ()
    for id, playeritem in ipairs(getElementsByType("player")) do
        if vioGetElementData ( playeritem, "loggedin" ) == 1 then
            outputChatBox ( "---Info---", playeritem, 200, 200, 0 )
            outputChatBox ( "Der Chat ist nur in der unmittelbaren Umgebung lesbar!", playeritem, 200, 200, 0 )
            outputChatBox ( "Bei Fragen und Problemen benutzt /support, und /admins um zu sehen, wer online ist!", playeritem, 200, 200, 0 )
            outputChatBox ( "Unser Tipp: Flugjob, Truckerjob oder der Farmerjob ist gut fuer den Anfang!", playeritem, 200, 200, 0 )
            outputChatBox ( "Forum: "..forumURL..", Weiteres: F1 - Hilfemenue, F11 - Karte, Polizei-NR: 911", playeritem, 200, 200, 0 )

        end
    end
    setTimer ( news2, 300000, 1 )

end
function news2 ()
    for id, playeritem in ipairs(getElementsByType("player")) do
        if vioGetElementData ( playeritem, "loggedin" ) == 1 then

            outputChatBox ( "---Info---", playeritem, 200, 200, 0 )
            outputChatBox ( "Du brauchst einen Status? Gebe /buystatus [Status] ein!", playeritem, 200, 200, 0 )
            outputChatBox ( "Bei Fragen und Problemen benutzt /report, und /admins um zu sehen, wer online ist!", playeritem, 200, 200, 0 )
            if tonumber(vioGetElementData ( playeritem, "fraktion" )) > 0 then
                outputChatBox ( "Benutze /fraktioncommands um die Befehle deiner Fraktion zu sehen!", playeritem, 200, 200, 0 )
            else
                outputChatBox ( "Benutze /commands um alle Befehle einzusehen!", playeritem, 200, 200, 0 )
            end

        end
    end
    setTimer ( news3, 300000, 1 )
end
function news3 ()
    for id, playeritem in ipairs(getElementsByType("player")) do
        if vioGetElementData ( playeritem, "loggedin" ) == 1 then
            outputChatBox ( "---Info---", playeritem, 200, 200, 0 )
            outputChatBox ( "Du willst in eine Fraktion? /fc [NAME]!", playeritem, 200, 200, 0 )
            outputChatBox ( "Bei Fragen und Problemen benutzt /support, und /admins um zu sehen, wer online ist!", playeritem, 200, 200, 0 )
            outputChatBox ( "Nutze /save, um deine Position und deine Waffen zu sichern!", playeritem, 200, 200, 0 )

        end
    end
    setTimer ( news1, 300000, 1 )
end
setTimer ( news1, 300000, 1 )

function infobox ( player, text, time, r, g, b )

    if isElement ( player ) then
        triggerClientEvent ( player, "infobox_start", getRootElement(), text, time, r, g, b )
    end
end
