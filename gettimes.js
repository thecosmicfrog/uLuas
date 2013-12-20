
WorkerScript.onMessage = function(message) {
    var stopName = message.stop;
    var xmlHttp = new XMLHttpRequest();
    var msg;
    var parsedMsg;
    var stopTimes = new Array;

    // Query a hosted Luas API script. Returns JSON object of times for the given stop.
    xmlHttp.open("GET", "http://ks3290596.kimsufi.com/luas-api.php?action=gettimes&station=" + stopName, true);
    xmlHttp.send(null);

    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            msg = xmlHttp.responseText;
        }

        parsedMsg = eval("(" + msg + ")");

        if (typeof parsedMsg != "undefined") {
            while (parsedMsg.inbound.length < 3) {
                parsedMsg.inbound.push("");
            }

            for (var i = 0; i < parsedMsg.inbound.length; i++) {
                stopTimes.push(parsedMsg.inbound[i].dest + ": " + parsedMsg.inbound[i].time);
            }

            while (parsedMsg.outbound.length < 3) {
                parsedMsg.outbound.push("");
            }

            for (var i = 0; i < parsedMsg.outbound.length; i++) {
                stopTimes.push(parsedMsg.outbound[i].dest + ": " + parsedMsg.outbound[i].time);
            }

            WorkerScript.sendMessage({'reply': stopTimes});
        }
    }
}
