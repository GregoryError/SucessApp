import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    id: mainwnd

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }


    Flickable {
        id: sbFlick
        anchors.fill: parent
        clip: true
        contentHeight: sb_IMG.height
        contentWidth: sb_IMG.width
        Image {
            id: sb_IMG
            source: "qrc:/PaySystems/materials/sb_instruction.png"
            width: mainwnd.width
            fillMode: Image.PreserveAspectFit
            //height: backRect.height
            //opacity: 0.6
            //z: 1
        }
        Text {
            id: ls
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: sb_IMG.bottom
            anchors.bottomMargin: 240
            font.pointSize: 35
            text: myClient.showId()
            color: "#112d4e"
        }
        Button {
            id: copyButt
            anchors.left: ls.right
            anchors.verticalCenter: ls.verticalCenter
            anchors.leftMargin: 5
            width: ls.width / 2
            height: width
            text: "копия"
            background: Rectangle{
                id: buttBack
                anchors.fill: parent
                color: "#eff0f4"
                radius: 3
            }
            onClicked: myClient.copyToBuf();

            onPressed: buttBack.color = "#0074e4"

            onReleased: buttBack.color = "#eff0f4"
        }


    }

}
