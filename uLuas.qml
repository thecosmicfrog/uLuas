import QtQuick 2.0
import Ubuntu.Components 1.1
import U1db 1.0 as U1db
import "ui"

MainView {
    id: mainView

    applicationName: "org.thecosmicfrog.uluas"
    property string version: "0.22"

    useDeprecatedToolbar: false

    //automaticOrientation: true

    width: units.gu(45)
    height: units.gu(68)

    function getArray(obj) {
        var arr = [];

        for (var i = 0; i < obj.length; i++) {
            arr.push(obj[i]);
        }

        return arr;
    }

    function getLastStopIndex(lastStop, lineModel) {
        for (var i = 0; i < lineModel.count; i++) {
            if (lastStop === lineModel.get(i).name)
                return i;
        }

        return 0;
    }

    // U1DB backend to record the last-picked stop. Makes it faster for users to get information for their usual stop.
    U1db.Database {
        id: db;
        path: "uluas.u1db"
    }

    U1db.Document {
        id: defaultLine
        database: db
        docId: "defaultLine"
        create: true
        defaults: {
            lineName: "Red Line"
        }
    }

    U1db.Document {
       id: redLineLastStop
       database: db
       docId: "redLineLastStop"
       create: true
       defaults: {
           stopName: ""
       }
    }

    U1db.Document {
       id: greenLineLastStop
       database: db
       docId: "greenLineLastStop"
       create: true
       defaults: {
           stopName: ""
       }
    }

    PageStack {
        id: pageStack

        anchors.fill: parent

        Component.onCompleted: push(tabs)

        Tabs {
            id: tabs

            RedLineTab {
                objectName: "redLineTab"
            }

            GreenLineTab {
                objectName: "greenLineTab"
            }
        }
    }
}
