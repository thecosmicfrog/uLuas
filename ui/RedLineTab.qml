import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 0.1

Tab {
    title: i18n.tr("Red Line")

    page: Page {
        id: redLinePage
        visible: true

        // Always begin by loading the selected stop.
        Component.onCompleted: {
            activityIndicator.running = true
            queryStopTimesWorker.sendMessage({'stop': slugify(redLineModel.get(stopSelector.selectedIndex).name)})
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

            ListItem.ItemSelector {
                id: stopSelector
                text: "<h2>Select Stop:</h2>"
                containerHeight: units.gu(25)
                expanded: true
                model: redLineModel
                delegate: OptionSelectorDelegate { text: name; subText: description; icon: image }

                onSelectedIndexChanged: {
                    activityIndicator.running = true
                    queryStopTimesWorker.sendMessage({'stop': slugify(redLineModel.get(stopSelector.selectedIndex).name)})
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop1Time
                    text: ""
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop2Time
                    text: ""
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop3Time
                    text: ""
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop1Time
                    text: ""
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop2Time
                    text: ""
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
                    text: ""
                    width: parent.width / 2
                    anchors.leftMargin: 6
                    x: parent.x + 6
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop3Time
                    text: ""
                    anchors.left: outboundStop3Name.right
                    y: parent.x + 5
                }
            }
        }

        tools: ToolbarItems {
            ToolbarButton {
                id: aboutButton

                action: Action {
                    text: "About"
                    iconSource: "../img/about_icon.svg"
                    onTriggered: PopupUtils.open(aboutComponent, aboutButton)
                }
            }

            Component {
                id: aboutComponent

                Popover {
                    id: aboutPopover

                    Label {
                        text: "<p>Real-time tram stop information for Dublin's Luas light rail service.</p><br>
                               <p><a href=\"https://www.github.com/thecosmicfrog/uluas\">
                               https://www.github.com/thecosmicfrog/uluas</a></p>"
                        wrapMode: Text.WordWrap

                        onLinkActivated: {
                            Qt.openUrlExternally(link)
                        }

                        anchors {
                            left: parent.left
                            right: parent.right
                            margins: units.gu(1)
                        }
                    }
                }
            }
        }
    }
}
