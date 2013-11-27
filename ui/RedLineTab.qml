import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Pickers 0.1

Tab {
    title: i18n.tr("Red Line")

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
                    "The Point",
                    "Spencer Dock",
                    "Mayor Square NCI",
                    "George's Dock",
                    "Connolly",
                    "Busaras",
                    "Abbey Street",
                    "Jervis",
                    "The Four Courts",
                    "Smithfield",
                    "Museum",
                    "Heuston",
                    "James's",
                    "Fatima",
                    "Rialto",
                    "Suir Road",
                    "Goldenbridge",
                    "Drimnagh",
                    "Blackhorse",
                    "Bluebell",
                    "Kylemore",
                    "Red Cow",
                    "Kingswood",
                    "Belgard",
                    "Cookstown",
                    "Hospital",
                    "Tallaght",
                    "Fettercairn",
                    "Cheeverstown",
                    "Citywest Campus",
                    "Fortunestown",
                    "Saggart"
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
