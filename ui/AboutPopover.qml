import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import Ubuntu.Components.Popups 1.0

Component {
    id: popoverComponent

    Popover {
        id: aboutPopover

        Column {
            id: aboutColumn

            anchors {
                left: parent.left
                right: parent.right
            }

            ListItem.Header {
                text: "uLuas\tv" + version
            }

            ListItem.Standard {
                text: "Written by Aaron Hastings (thecosmicfrog)"

                onClicked: Qt.openUrlExternally("https://github.com/thecosmicfrog")
            }

            ListItem.Standard {
                text: "License: GNU GPLv3"
            }

            ListItem.Standard {
                text: "Source code, bugs and feature requests:<br>
                       <a href=\"https://github.com/thecosmicfrog/uLuas\">github.com/thecosmicfrog/uLuas</a>"

                onClicked: Qt.openUrlExternally("https://github.com/thecosmicfrog/uLuas")
            }

            ListItem.Standard {
                Item {
                    anchors.fill: parent

                    Image {
                        id: aboutLogo

                        anchors {
                            left: parent.left
                            leftMargin: units.gu(2)
                        }

                        source: "../uluas_logo.png"
                        width: parent.width / 6.8
                        height: parent.width / 6.8
                    }

                    Label {
                        anchors {
                            left: aboutLogo.right
                            leftMargin: units.gu(2)
                            verticalCenter: aboutLogo.verticalCenter
                        }

                        text: "uLuas logo by Sam Hewitt (<a href=\"http://snwh.org\">snwh</a>)"
                        color: "#000000"

                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                }
            }

            ListItem.SingleControl {
                highlightWhenPressed: false

                control: Button {
                    text: "Close"
                    onClicked: PopupUtils.close(aboutPopover)
                }
            }
        }
    }
}
