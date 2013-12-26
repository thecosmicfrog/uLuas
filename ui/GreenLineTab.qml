import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Tab {
    title: i18n.tr("Green Line")

    page: Page {
        WorkerScript {
            id: myWorker
            source: "../gettimes.js"

            onMessage: {
                inboundTime1Label.text = String(getArray(messageObject.reply)[0])
                inboundTime2Label.text = String(getArray(messageObject.reply)[1])
                inboundTime3Label.text = String(getArray(messageObject.reply)[2])

                outboundTime1Label.text = String(getArray(messageObject.reply)[3])
                outboundTime2Label.text = String(getArray(messageObject.reply)[4])
                outboundTime3Label.text = String(getArray(messageObject.reply)[5])

                activityIndicator.running = false
            }
        }

        Column {
            spacing: units.gu(1)

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

            ListItem.ItemSelector {
                id: stopSelector
                text: "<h2>Select Stop:</h2>"
                containerHeight: units.gu(25)
                expanded: true
                model: greenLineModel
                delegate: OptionSelectorDelegate { text: name; subText: description; icon: image }

                onSelectedIndexChanged: {
                    activityIndicator.running = true
                    myWorker.sendMessage({'stop': slugify(greenLineModel.get(stopSelector.selectedIndex).name)})
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
                id: inbound
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "#100054"

                anchors {
                    top: stopSelector.bottom
                    topMargin: units.gu(2)
                }

                Label {
                    text: "<b>Inbound</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: inboundTime1
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inbound.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundTime1Label
                    text: ""
                    x: parent.x + 6
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: inboundTime2
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inboundTime1.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundTime2Label
                    text: ""
                    x: parent.x + 6
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: inboundTime3
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: inboundTime2.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: inboundTime3Label
                    text: ""
                    x: parent.x + 6
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
                    top: inboundTime3.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    text: "<b>Outbound</b>"
                    color: "white"

                    anchors.centerIn: parent
                }
            }

            UbuntuShape {
                id: outboundTime1
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outbound.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundTime1Label
                    text: ""
                    x: parent.x + 6
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: outboundTime2
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outboundTime1.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundTime2Label
                    text: ""
                    x: parent.x + 6
                    y: parent.x + 5
                }
            }

            UbuntuShape {
                id: outboundTime3
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "white"

                anchors {
                    top: outboundTime2.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    id: outboundTime3Label
                    text: ""
                    x: parent.x + 6
                    y: parent.x + 5
                }
            }
        }
    }
}
