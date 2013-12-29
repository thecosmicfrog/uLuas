
WorkerScript.onMessage = function(message) {
    var stopName = message.stop;
    var xmlHttp = new XMLHttpRequest();
    var msg;
    var parsedMsg;
    var stopTimes = [];

    // Create two dimensional array. The first dimension will be the stop name. The second will be the stop time.
    for (var i = 0; i < stopTimes.length; i++) {
        stopTimes[i] = [];
    }

    // Query a hosted Luas API script. Returns JSON object of times for the given stop.
    // API can be found here: https://github.com/ncremins/luas-api
    // Note: Currently using v1 of the this API. Will be updated to use v2 in a future release.
    xmlHttp.open("GET", "http://ks3290596.kimsufi.com/luas-api.php?action=gettimes&station=" + stopName, true);
    xmlHttp.send(null);

    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            msg = xmlHttp.responseText;
        }

        parsedMsg = eval("(" + msg + ")");

        if (typeof parsedMsg != "undefined") {
            // First, ensure both inbound and outbound arrays are of length 3.
            while (parsedMsg.inbound.length < 3) {
                parsedMsg.inbound.push("");
            }

            while (parsedMsg.outbound.length < 3) {
                parsedMsg.outbound.push("");
            }

            // Then, append "min" or "mins" to time.
            for (var i = 0; i < parsedMsg.inbound.length; i++) {
                if (parsedMsg.inbound[i].time !== "DUE") {
                    if (parsedMsg.inbound[i].time !== "1")
                        parsedMsg.inbound[i].time += " mins";
                    else
                        parsedMsg.inbound[i].time += " min";
                }
            }

            for (var i = 0; i < parsedMsg.outbound.length; i++) {
                if (parsedMsg.outbound[i].time !== "DUE") {
                    if (parsedMsg.outbound[i].time !== "1")
                        parsedMsg.outbound[i].time += " mins";
                    else
                        parsedMsg.outbound[i].time += " min";
                }
            }

            // Finally, compile an array of stop times, replacing undefined times with empty strings.
            // Note: As stopTimes is always defined with length 6, outbound times are offset by 3.
            for (var i = 0; i < 3; i++) {
                stopTimes[i] = [parsedMsg.inbound[i].dest, parsedMsg.inbound[i].time];

                if (typeof stopTimes[i][0] == "undefined")
                    stopTimes[i][0] = "";
                if (typeof stopTimes[i][1] == "undefined")
                    stopTimes[i][1] = "";

                stopTimes[i+3] = [parsedMsg.outbound[i].dest, parsedMsg.outbound[i].time];

                if (typeof stopTimes[i+3][0] == "undefined")
                    stopTimes[i+3][0] = "";
                if (typeof stopTimes[i+3][1] == "undefined")
                    stopTimes[i+3][1] = "";
            }

            WorkerScript.sendMessage({'reply': stopTimes});
        }
    }
}
