import QtQuick 2.0



import QtLocation 5.6
import QtPositioning 5.6

Item {
    anchors.fill: parent
    Plugin {
           id: mapPlugin
           name: "osm" // "mapboxgl", "esri", ...
           // specify plugin parameters if necessary
           // PluginParameter {
           //     name:
           //     value:
           // }
       }

       Map {
           anchors.fill: parent
           plugin: mapPlugin
           center: QtPositioning.coordinate(60.7069, 28.7690) // Oslo


           zoomLevel: 14
       }

}
