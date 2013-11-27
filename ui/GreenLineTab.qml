import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Pickers 0.1

Tab {
    title: i18n.tr("Green Line")

    page: Page {
        WorkerScript {
            id: myWorker
            source: "../gettimes.js"

            onMessage: stopTimes.text = String(messageObject.reply)
        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Image {
                source: "../img/uluas_logo.png"
                width: parent.width
                fillMode: Image.PreserveAspectFit
                smooth: true
            }

            Picker {
                id: stopPicker
                width: parent.width
                circular: false
                model: [
                    "St. Stephen's Green",
                    "Harcourt",
                    "Charlemont",
                    "Ranelagh",
                    "Beechwood",
                    "Cowper",
                    "Milltown",
                    "Windy Arbour",
                    "Dundrum",
                    "Balally",
                    "Kilmacud",
                    "Stillorgan",
                    "Sandyford",
                    "Central Park",
                    "Glencairn",
                    "The Gallops",
                    "Leopardstown Valley",
                    "Ballyogan Wood",
                    "Carrickmines",
                    "Laughanstown",
                    "Cherrywood",
                    "Brides Glen"
                ]
                delegate: PickerDelegate {
                    Label {
                        text: modelData
                    }
                }
                selectedIndex: 0
                onSelectedIndexChanged: myWorker.sendMessage({'stop': slugify(stopPicker.model[stopPicker.selectedIndex])})
            }

            TextArea {
                id: stopTimes
                width: parent.width
                height: 300
                textFormat: TextEdit.RichText
            }
        }
    }
}
