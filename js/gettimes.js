
WorkerScript.onMessage = function(sentMessage) {
    var stopName = sentMessage.stop;
    var xmlHttp = new XMLHttpRequest();
    var msg;
    var parsedMsg;
    var inboundTrams = [];
    var outboundTrams = [];
    var serviceMessage;
    var stopInfo = [];

    var stopCodes = {
        // Red Line
        "The Point": "TPT",
        "Spencer Dock": "SDK",
        "Mayor Square - NCI": "MYS",
        "George's Dock": "GDK",
        "Connolly": "CON",
        "Busáras": "BUS",
        "Abbey Street": "ABB",
        "Jervis": "JER",
        "Four Courts": "FOU",
        "Smithfield": "SMI",
        "Museum": "MUS",
        "Heuston": "HEU",
        "James's": "JAM",
        "Fatima": "FAT",
        "Rialto": "RIA",
        "Suir Road": "SUI",
        "Goldenbridge": "GOL",
        "Drimnagh": "DRI",
        "Blackhorse": "BLA",
        "Bluebell": "BLU",
        "Kylemore": "KYL",
        "Red Cow": "RED",
        "Kingswood": "KIN",
        "Belgard": "BEL",
        "Cookstown": "COO",
        "Hospital": "HOS",
        "Tallaght": "TAL",
        "Fettercairn": "FET",
        "Cheeverstown": "CVN",
        "Citywest Campus": "CIT",
        "Fortunestown": "FOR",
        "Saggart": "SAG",

        // Green Line
        "St. Stephen's Green": "STS",
        "Harcourt": "HAR",
        "Charlemont": "CHA",
        "Ranelagh": "RAN",
        "Beechwood": "BEE",
        "Cowper": "COW",
        "Milltown": "MIL",
        "Windy Arbour": "WIN",
        "Dundrum": "DUN",
        "Balally": "BAL",
        "Kilmacud": "KIL",
        "Stillorgan": "STI",
        "Sandyford": "SAN",
        "Central Park": "CPK",
        "Glencairn": "GLE",
        "The Gallops": "GAL",
        "Leopardstown Valley": "LEO",
        "Ballyogan Wood": "BAW",
        "Carrickmines": "CCK",
        "Laughanstown": "LAU",
        "Cherrywood": "CHE",
        "Brides Glen": "BRI"
    };

    // Query a hosted Luas API script. Returns JSON object with service message and times for the given stop.
    // API can be found here: https://github.com/ncremins/luas-api
    xmlHttp.open("GET", "http://uluas-times.thecosmicfrog.org/luas-api-v2/luas-api.php?action=times&station=BLA/luas-api-v2/luas-api.php?action=times&station=" + stopCodes[stopName], true);
    xmlHttp.send(null);

    xmlHttp.onreadystatechange = function() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            msg = xmlHttp.responseText;
        }

        // Parse response text to usable object.
        parsedMsg = eval("(" + msg + ")");

        if (typeof parsedMsg != "undefined") {
            // Ensure that service message is available.
            if (parsedMsg.hasOwnProperty("message"))
                serviceMessage = parsedMsg.message;
            else
                serviceMessage = "";

            // Ensure that tram times are available.
            if (parsedMsg.hasOwnProperty("trams")) {
                for (var i = 0; i < parsedMsg.trams.length; i++) {
                    if (parsedMsg.trams[i].direction === "Inbound")
                        inboundTrams.push(parsedMsg.trams[i]);

                    if (parsedMsg.trams[i].direction === "Outbound")
                        outboundTrams.push(parsedMsg.trams[i]);
                }

                // Ensure that both inbound and outbound arrays are of length 3.
                while (inboundTrams.length < 3) {
                    inboundTrams.push("");
                }

                while (outboundTrams.length < 3) {
                    outboundTrams.push("");
                }

                // Append "min" or "mins" to time.
                for (var i = 0; i < inboundTrams.length; i++) {
                    if (inboundTrams[i].dueMinutes !== "DUE") {
                        if (parseInt(inboundTrams[i].dueMinutes) > 1)
                            inboundTrams[i].dueMinutes += " mins";
                        else if (parseInt(inboundTrams[i].dueMinutes) === 1)
                            inboundTrams[i].dueMinutes += " min";
                    }
                }

                for (var i = 0; i < outboundTrams.length; i++) {
                    if (outboundTrams[i].dueMinutes !== "DUE") {
                        if (parseInt(outboundTrams[i].dueMinutes) > 1)
                            outboundTrams[i].dueMinutes += " mins";
                        else if (parseInt(outboundTrams[i].dueMinutes) === 1)
                            outboundTrams[i].dueMinutes += " min";
                    }
                }

                // Compile all stop times and add to stop info array, replacing undefined times with empty strings.
                // Note: As there will always be 6 stop times, outbound times are offset by 3.
                for (var i = 0; i < 3; i++) {
                    stopInfo[i] = [inboundTrams[i].destination, inboundTrams[i].dueMinutes];

                    if (typeof stopInfo[i][0] == "undefined")
                        stopInfo[i][0] = "";
                    if (typeof stopInfo[i][1] == "undefined")
                        stopInfo[i][1] = "";

                    stopInfo[i+3] = [outboundTrams[i].destination, outboundTrams[i].dueMinutes];

                    if (typeof stopInfo[i+3][0] == "undefined")
                        stopInfo[i+3][0] = "";
                    if (typeof stopInfo[i+3][1] == "undefined")
                        stopInfo[i+3][1] = "";
                }
            }
            // If tram times are not present in returned API message, the RTPI system may be down.
            // We assume that a lack of times coupled with a non-standard service message represents a system outage.
            // Otherwise, the tram service has probably stopped running for the day.
            else {
                if (serviceMessage === "All services operating normally") {
                    stopInfo[0] = ["<b>No trams forecast</b>", ""];
                    stopInfo[1] = ["", ""];
                }
                else {
                    stopInfo[0] = ["Error retrieving times from Luas RTPI system.", ""];
                    stopInfo[1] = ["See <b>Message</b> box above for more information.", ""];
                }

                // Populate array with empty strings.
                for (var i = 2; i < 6; i++) {
                    stopInfo[i] = ["", ""];
                }
            }

            stopInfo[6] = serviceMessage;

            WorkerScript.sendMessage({'reply': stopInfo});
        }
    }
}
