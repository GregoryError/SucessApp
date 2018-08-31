import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: mainMsg
    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }
    Component.onCompleted: myClient.makeBusyOFF();

    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#f7f7f7"
        Flickable{
            id: msgFlickField
            anchors.top: backRect.top
            anchors.bottom: inputLine.top
            anchors.left: backRect.left
            anchors.right: backRect.right
            contentHeight: 2000
            clip: true

            Rectangle{
                id: msgBody
                radius: 4
                width: backRect.width - 50
                height: 250
                color: "white"
                anchors.leftMargin: 5
                Text {
                    id: msgTxt
                    width: parent.width
                    height: parent.height
                    //anchors.centerIn: parent
                    anchors.margins: 5
                    font.family: gotham_XNarrow.name;
                    color: "#606470"
                    minimumPointSize: 8
                    font.pointSize: 15
                    fontSizeMode: Text.Fit
                    text: "В оригинальной версии биографии Бэтмен — <br>
тайное альтер-эго миллиардера Брю́са Уэ́йна, успешного<br>
промышленника, филантропа и любимца женщин.<br>
В детстве, став свидетелем убийства своих родителей,<br>
Брюс поклялся посвятить свою жизнь <br>
искоренению преступности и борьбе за справедливость."
                }

            }

        }
        TextField{
            id: inputLine
            width: mainMsg.width
            height: mainMsg.height * 0.1
            anchors.bottom: backRect.bottom
            background: Rectangle{
                anchors.fill: parent
                opacity: 0.2
                color: "#93deff"
            }
            color: "#606470"
            font.pointSize: (inputLine.width  * 0.1) / 2
            font.family: gotham_XNarrow.name;
            placeholderText: "Сообщение"
        }

    }
}
