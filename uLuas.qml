import QtQuick 2.0
import Ubuntu.Components 0.1
import "ui"

MainView {
    applicationName: "org.thecosmicfrog.uluas"

    //automaticOrientation: true

    width: units.gu(65)
    height: units.gu(100)

    function getArray(obj) {
        var arr = [];

        for (var i = 0; i < obj.length; i++) {
            arr.push(obj[i]);
        }

        return arr;
    }

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
