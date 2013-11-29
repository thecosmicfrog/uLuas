import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Pickers 0.1
import "ui"

MainView {
    applicationName: "org.thecosmicfrog.uluas"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(65)
    height: units.gu(100)

    function getArray(obj) {
        var arr = [];

        for (var i = 0; i < obj.length; i++) {
            if (obj[i] === "undefined: undefined")
                obj[i] = "";
            arr.push(obj[i]);
        }

        return arr;
    }

    function slugify(str) {
        str = str.replace(/[^a-zA-Z0-9\s]/g,"");
        str = str.toLowerCase();
        str = str.replace(/\s/g,'-');

        return str;
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
