
WorkerScript.onMessage = function(message) {
    var stopName = message.stop;
    var xmlHttp = new XMLHttpRequest();
    var msg;
    var parsedMsg;
    var formattedMsg = "";

    xmlHttp.open("GET", "http://localhost/ap.php?action=gettimes&station=" + stopName, true);
    xmlHttp.send(null);

    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            msg = xmlHttp.responseText;
        }

        parsedMsg = eval("(" + msg + ")");

        if (typeof parsedMsg != "undefined") {
            formattedMsg += "<b><u>Inbound</u></b><br>";

            for (var i = 0; i < parsedMsg.inbound.length; i++) {
                formattedMsg += parsedMsg.inbound[i].dest;
                formattedMsg += ": ";
                formattedMsg += parsedMsg.inbound[i].time;
                formattedMsg += "<br>";
            }

            formattedMsg += "<br><b><u>Outbound</u></b><br>";

            for (var i = 0; i < parsedMsg.outbound.length; i++) {
                formattedMsg += parsedMsg.outbound[i].dest;
                formattedMsg += ": ";
                formattedMsg += parsedMsg.outbound[i].time;
                formattedMsg += "<br>";
            }

            WorkerScript.sendMessage({'reply': formattedMsg});
        }
    }
}
