import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Tab {
    title: i18n.tr("Green Line")

    page: Page {
        id: greenLinePage
        visible: true

        // Always begin by loading the selected stop.
        Component.onCompleted: {
            activityIndicator.running = true
            queryStopTimesWorker.sendMessage({'stop': greenLineModel.get(stopSelector.selectedIndex).name})
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
                    messageTitle.color = "#006600";
                else
                    messageTitle.color = "red";

                messageContentLabel.text = String(getArray(messageObject.reply)[6])

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
                model: greenLineModel

                delegate: OptionSelectorDelegate {
                    text: name
                    subText: description
                    icon: image
                }

                onSelectedIndexChanged: {
                    activityIndicator.running = true
                    queryStopTimesWorker.sendMessage({'stop': greenLineModel.get(stopSelector.selectedIndex).name})
                }
            }

            ListModel {
                id: greenLineModel
                ListElement { name: "St. Stephen's Green"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Harcourt"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Charlemont"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Ranelagh"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Beechwood"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Cowper"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Milltown"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Windy Arbour"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Dundrum"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Balally"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Kilmacud"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Stillorgan"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Sandyford"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Central Park"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Glencairn"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "The Gallops"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Leopardstown Valley"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Ballyogan Wood"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Carrickmines"; description: ""; image: "../img/parking_and_bicycle.png" }
                ListElement { name: "Laughanstown"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Cherrywood"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Brides Glen"; description: ""; image: "../img/blank.png" }
            }

            UbuntuShape {
                id: messageTitle
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "green"

                anchors {
                    top: stopSelector.bottom
                    topMargin: units.gu(2)
                }

                Label {
                    text: "<b>Message</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: messageContent
                width: parent.width
                height: units.gu(3)
                color: "white"

                anchors {
                    top: messageTitle.bottom
                }

                Label {
                    id: messageContentLabel
                    width: parent.width - 12
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    onTextChanged: messageContent.height = messageContentLabel.height + 6

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
                    top: messageContent.bottom
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
        }
    }
}
