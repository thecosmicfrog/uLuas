import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Tab {
    title: i18n.tr("Red Line")

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
                onSelectedIndexChanged: myWorker.sendMessage({'stop': slugify(redLineModel.get(stopSelector.selectedIndex).name)})
                model: redLineModel
                delegate: OptionSelectorDelegate { text: name; subText: description; icon: image }

                anchors {
                    top: logo.bottom
                }
            }

            ListModel {
                id: redLineModel
                ListElement { name: "The Point"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Spencer Dock"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Mayor Square NCI"; description: ""; image: "../img/blank.png" }
                ListElement { name: "George's Dock"; description: ""; image: "../img/blank.png" }
                ListElement { name: "Connolly"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Busaras"; description: "Alight for Connolly"; image: "../img/blank.png" }
                ListElement { name: "Abbey Street"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "Jervis"; description: ""; image: "../img/bicycle.png" }
                ListElement { name: "The Four Courts"; description: ""; image: "../img/blank.png" }
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
