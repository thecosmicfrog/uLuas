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
            }
        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Image {
                id: logo
                source: "../img/uluas_logo.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            ListItem.ItemSelector {
                id: stopSelector
                text: "<h2>Select Stop</h2>"
                containerHeight: units.gu(28)
                expanded: true
                onSelectedIndexChanged: myWorker.sendMessage({'stop': slugify(greenLineModel.get(stopSelector.selectedIndex).name)})
                model: greenLineModel
                delegate: OptionSelectorDelegate { text: name; subText: description; icon: image }

                anchors {
                    top: logo.bottom
                }
            }

            ListModel {
                id: greenLineModel
                ListElement { name: "St. Stephen's Green"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Harcourt"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Charlemont"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Ranelagh"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Beechwood"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Cowper"; description: "Alight for Connolly"; image: "../img/bicycle.png" }
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
                color: "darkblue"

                anchors {
                    top: stopSelector.bottom
                    topMargin: units.gu(2)
                }

                Label {
                    text: "<b>Inbound</b>"
                    color: "white"
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
                }
            }

            UbuntuShape {
                id: outbound
                width: parent.width
                height: units.gu(3)
                radius: "medium"
                color: "darkblue"

                anchors {
                    top: inboundTime3.bottom
                    topMargin: units.gu(0)
                }

                Label {
                    text: "<b>Outbound</b>"
                    color: "white"
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
                }
            }
        }
    }
}
