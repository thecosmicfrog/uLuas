import QtQuick 2.0
import Ubuntu.Components 1.2

Page {
    id: settingsPage

    title: i18n.tr("Settings")

    // Default to Red Line on initial startup.
    property string defaultLineSelection: "Red Line"

    Column {
        id: settingsColumn

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right

            topMargin: units.gu(4)
            margins: units.gu(2)
        }

        Label {
            id: selectStopLabel

            text: "<b>Default Line:</b>"
        }

        OptionSelector {
            id: defaultLineSelector

            anchors {
                topMargin: units.gu(1)
            }

            containerHeight: units.gu(21.5)
            expanded: true
            model: ["Red Line", "Green Line"]

            onSelectedIndexChanged: {
                if (selectedIndex === 1)
                    defaultLineSelection = "Green Line"
                else
                    defaultLineSelection = "Red Line"

                // Save stop to U1DB backend for persistence.
                defaultLine.contents = {lineName: defaultLineSelection}
            }
        }
    }
}
