import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 1.0 as ListItem
import Ubuntu.Components.Popups 1.0

Page {
    id: linePage

    property var lineModel: ""
    property var lastStop: ""

    Component.onCompleted: {
        // For each tab, load the appropriate model and U1DB database.
        if (parent.objectName === "redLineTab") {
            lineModel = redLineModel
            lastStop = redLineLastStop
        }
        else if (parent.objectName === "greenLineTab") {
            lineModel = greenLineModel
            lastStop = greenLineLastStop
        }

        // Start by loading the tab based on the user's selected default line.
        if (defaultLine.contents.lineName === "Green Line")
            tabs.selectedTabIndex = 1
        else
            tabs.selectedTabIndex = 0

        // Always begin by loading the selected stop.
        activityIndicator.running = true
        stopSelector.selectedIndex = getLastStopIndex(lastStop.contents.stopName, lineModel)
        queryStopTimesWorker.sendMessage({'stop': lineModel.get(stopSelector.selectedIndex).name})
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

            if (String(getArray(messageObject.reply)[6]).indexOf("operating normally") > -1)
                statusTitle.color = "#006600";
            else
                statusTitle.color = "red";

            statusContentLabel.text = String(getArray(messageObject.reply)[6])

            activityIndicator.running = false
        }
    }

    head.actions: [
        Action {
            id: reloadAction

            iconName: "reload"
            text: "Reload"

            onTriggered: {
                activityIndicator.running = true
                queryStopTimesWorker.sendMessage({'stop': lineModel.get(stopSelector.selectedIndex).name})
            }
        },
        Action {
            id: settingsAction

            iconName: "settings"
            text: "Settings"

            onTriggered: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
        },
        Action {
            id: aboutAction

            iconName: "info"
            text: "About"

            onTriggered: PopupUtils.open(aboutPopover)
        }
    ]

    AboutPopover {
        id: aboutPopover
    }

    Item {
        id: selectStopRow

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right

            topMargin: units.gu(2)
            margins: units.gu(2)
        }

        Label {
            id: selectStopLabel

            text: "<b>Select Stop:</b>"
        }

        ActivityIndicator {
            id: activityIndicator

            anchors.right: parent.right

            y: selectStopLabel.y - 6
        }
    }

    Row {
        id: stopRow

        spacing: -20

        anchors {
            top: selectStopRow.bottom
            left: parent.left
            right: parent.right

            topMargin: units.gu(4)
            margins: units.gu(2)
        }

        OptionSelector {
            id: stopSelector
            containerHeight: units.gu(21.5)
            expanded: false
            model: lineModel

            delegate: OptionSelectorDelegate {
                text: name
                subText: description
                iconSource: image
            }

            onSelectedIndexChanged: {
                activityIndicator.running = true
                queryStopTimesWorker.sendMessage({'stop': lineModel.get(stopSelector.selectedIndex).name})

                // Save stop to U1DB backend for faster access on next app start.
                lastStop.contents = {stopName: lineModel.get(stopSelector.selectedIndex).name}
            }
        }
    }

    Column {
        id: statusColumn

        anchors {
            top: stopRow.bottom
            left: parent.left
            right: parent.right

            topMargin: units.gu(4)
            margins: units.gu(2)
        }

        UbuntuShape {
            id: statusTitle
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "green"

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

            Label {
                id: statusContentLabel
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                onTextChanged: statusContent.height = statusContentLabel.height + 6

                anchors.centerIn: parent
            }
        }
    }

    Column {
        id: stopInformationColumn

        anchors {
            top: statusColumn.bottom
            left: parent.left
            right: parent.right

            margins: units.gu(2)
            topMargin: units.gu(2)
        }

        UbuntuShape {
            id: inbound
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "#100054"

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

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: inboundStop1Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop1Time
                    width: parent.width / 2

                    anchors.left: inboundStop1Name.right
                    y: parent.x + 5
                }
            }
        }

        UbuntuShape {
            id: inboundStop2
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "white"

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: inboundStop2Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop2Time
                    width: parent.width / 2

                    anchors.left: inboundStop2Name.right
                    y: parent.x + 5
                }
            }
        }

        UbuntuShape {
            id: inboundStop3
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "white"

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: inboundStop3Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: inboundStop3Time
                    width: parent.width / 2

                    anchors.left: inboundStop3Name.right
                    y: parent.x + 5
                }
            }
        }

        UbuntuShape {
            id: outbound
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "#100054"

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

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: outboundStop1Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop1Time
                    width: parent.width / 2

                    anchors.left: outboundStop1Name.right
                    y: parent.x + 5
                }
            }
        }

        UbuntuShape {
            id: outboundStop2
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "white"

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: outboundStop2Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop2Time
                    width: parent.width / 2

                    anchors.left: outboundStop2Name.right
                    y: parent.x + 5
                }
            }
        }

        UbuntuShape {
            id: outboundStop3
            width: parent.width
            height: units.gu(3)
            radius: "medium"
            color: "white"

            Row {
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }

                Label {
                    id: outboundStop3Name
                    width: parent.width / 2

                    x: parent.width / 8
                    y: parent.x + 5
                }

                Label {
                    id: outboundStop3Time
                    width: parent.width / 2

                    anchors.left: outboundStop3Name.right
                    y: parent.x + 5
                }
            }
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
}
