import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Tab {
    title: i18n.tr("Red Line")

    page: Page {
        id: redLinePage
        visible: true

        // Always begin by loading the selected stop.
        Component.onCompleted: {
            activityIndicator.running = true
            stopSelector.selectedIndex = getLastStopIndex(redLineLastStop.contents.stopName, redLineModel)
            queryStopTimesWorker.sendMessage({'stop': redLineModel.get(stopSelector.selectedIndex).name})
        }

        WorkerScript {
            id: queryStopTimesWorker
            source: "../js/gettimes.js"

            onMessage: {
                inboundStop1Name.text = String(getArray(messageObject.reply)[0][0])
                inboundStop1Time.text = String(getArray(messageObject.reply)[0][1])
                inboundStop2Name.text = String(getArray(messageObject.reply)[1][0])
                inboundStop2Time.text = String(getArray(messageObject.reply)[1][1])
                inboundStop3Name.text = String(getArray(messageObject.reply)[2][0])
                inboundStop3Time.text = String(getArray(messageObject.reply)[2][1])

                outboundStop1Name.text = String(getArray(messageObject.reply)[3][0])
                outboundStop1Time.text = String(getArray(messageObject.reply)[3][1])
                outboundStop2Name.text = String(getArray(messageObject.reply)[4][0])
                outboundStop2Time.text = String(getArray(messageObject.reply)[4][1])
                outboundStop3Name.text = String(getArray(messageObject.reply)[5][0])
                outboundStop3Time.text = String(getArray(messageObject.reply)[5][1])

                if (String(getArray(messageObject.reply)[6]) === "All services operating normally")
                    statusTitle.color = "#006600";
                else
                    statusTitle.color = "red";

                statusContentLabel.text = String(getArray(messageObject.reply)[6])

                activityIndicator.running = false
            }
        }

        Item {
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            ActivityIndicator {
                id: activityIndicator

                // Align activity indicator to the right.
                anchors.left: parent.left
                LayoutMirroring.enabled: true
            }

            OptionSelector {
                id: stopSelector
                text: "<h2>Select Stop:</h2>"
                containerHeight: units.gu(21.5)
                expanded: false
                model: redLineModel

                delegate: OptionSelectorDelegate {
                    text: name
                    subText: description
                    icon: image
                }

                onSelectedIndexChanged: {
                    activityIndicator.running = true
                    queryStopTimesWorker.sendMessage({'stop': redLineModel.get(stopSelector.selectedIndex).name})

                    // Save stop to U1DB backend for faster access on next app start.
                    redLineLastStop.contents = {stopName: redLineModel.get(stopSelector.selectedIndex).name}
                }
            }

            ListModel {
                id: redLineModel
                ListElement { name: "The Point"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Spencer Dock"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Mayor Square - NCI"; description: ""; image: "../img/blank.png" }
                ListElement { name: "George's Dock"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Connolly"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Busáras"; description: "Alight for Connolly"; image: "../img/blank.png" }
                ListElement { name: "Abbey Street"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Jervis"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Four Courts"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Smithfield"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Museum"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Heuston"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "James's"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Fatima"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Rialto"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Suir Road"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Goldenbridge"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Drimnagh"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Blackhorse"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Bluebell"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Kylemore"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Red Cow"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Kingswood"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Belgard"; description: "Tallaght/Saggart interchange"; image: "../img/bicycle.png" }
                ListElement { name: "Cookstown"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Hospital"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Tallaght"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Fettercairn"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Cheeverstown"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Citywest Campus"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Fortunestown"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Saggart"; description: ""; image: "../img/bicycle.png" }
            }

            UbuntuShape {
                id: statusTitle
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "green"

                anchors {
                    top: stopSelector.bottom
                    topMargin: units.gu(2)
                }

                Label {
                    text: "<b>Status</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: statusContent
                width: parent.width
                height: units.gu(3)
                color: "white"

                anchors {
                    top: statusTitle.bottom
                }

                Label {
                    id: statusContentLabel
                    width: parent.width - 12
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    onTextChanged: statusContent.height = statusContentLabel.height + 6

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: inbound
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "#100054"

                anchors {
                    top: statusContent.bottom
                    topMargin: units.gu(2)
                }

                Label {
                    text: "<b>Inbound</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: inboundStop1
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inbound.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundStop1Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop1Time

                    anchors.left: inboundStop1Name.right
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: inboundStop2
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inboundStop1.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundStop2Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop2Time

                    anchors.left: inboundStop2Name.right
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: inboundStop3
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inboundStop2.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundStop3Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop3Time

                    anchors.left: inboundStop3Name.right
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: outbound
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "#100054"

                anchors {
                    top: inboundStop3.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    text: "<b>Outbound</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: outboundStop1
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outbound.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundStop1Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop1Time

                    anchors.left: outboundStop1Name.right
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: outboundStop2
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outboundStop1.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundStop2Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop2Time

                    anchors.left: outboundStop2Name.right
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: outboundStop3
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outboundStop2.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundStop3Name
                    width: parent.width / 2

                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop3Time

                    anchors.left: outboundStop3Name.right
                    y: parent.x + 5
                }
            }
        }

        tools: GlobalTools {
            ToolbarButton {
                id: reloadButton

                text: "Reload"
                iconSource: "../img/reload.png"
                onTriggered: {
                    activityIndicator.running = true
                    queryStopTimesWorker.sendMessage({'stop': redLineModel.get(stopSelector.selectedIndex).name})
                }
            }
        }
    }
}
