import QtQuick 2.0

import QtLocation 5.6
import QtPositioning 5.6



Item {
    //anchors.fill: parent



    Plugin {
           id: mapPlugin
           name: "osm"

       }

       Map {
           anchors.fill: parent
           plugin: mapPlugin
           center: QtPositioning.coordinate(60.706, 28.769) // Oslo

           zoomLevel: 17
       }

}
