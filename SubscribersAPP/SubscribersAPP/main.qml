import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

ApplicationWindow {
    id: window
    visible: true
    width: 540
    height: 960
    //width: Screen.width
    //height: Screen.height

    color: "#f7f7f7"

    header: ToolBar {
        id: head
        //contentHeight: toolButton.implicitHeight

        contentHeight: infoRect.height


        Rectangle{
            id: infoRect
            width: window.width
            height: window.height * 0.4
            anchors.top: window.top
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#323643"



            Image {
                id: logo
                scale: window.height / 1530
                source: "qrc:/vallet.png"
                width: 90
                height: 90
                smooth: true
                anchors.verticalCenter: billVal.verticalCenter
                anchors.left: infoRect.left
                anchors.margins: 20
            }


            Text{
                id: billVal
                y: infoRect.y + (infoRect.height / 2 - 100) / 2
                anchors.right: billRow.right
                anchors.horizontalCenter: infoRect.horizontalCenter
                font.family: "Segoe UI Light"
                font.pointSize: 60
                color: "#f7f7f7"
                text: "550"
            }



            Text{
                id: bill
                anchors.top: billVal.bottom
                //anchors.margins: 30
                anchors.horizontalCenter: infoRect.horizontalCenter
                color: "#f7f7f7"
                font.family: "Noto Sans CJK KR Thin"
                font.pointSize: 10
                text: "Баланс на сегодня"
            }


            Rectangle{
                id: infoline
                opacity: 0.7
                width: parent.width - 30
                height: 1
                anchors.horizontalCenter: infoRect.horizontalCenter
                y:  infoRect.y + (infoRect.height / 2 + 30)
                color: "white"
            }




        }


        ToolButton {
            id: toolButton
            width: 30
            height: 30
            x: 30
            y: 20

            // opacity: 0.4
            //text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            //font.pixelSize: Qt.application.font.pixelSize * 4


            Image {
                id: toolPic
                source: "qrc:/toolPic.png"
                width: 30
                height: 30
                smooth: true
                anchors.fill: parent
            }






            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }


    Rectangle{
        id: bigMenu
        width: window.width - 70
        height: window.height * 0.6
        anchors.horizontalCenter: head.horizontalCenter
        y: head.y + head.height - (window.height / 100) * 3
        radius: 4
        z: 2
        color: "white"



        layer.enabled: true
        layer.effect: DropShadow {
            id: bigMenushadow
            transparentBorder: true
            //horizontalOffset: 8
            verticalOffset: 10
            samples: 30
            //spread: 0.6
            radius: 20

            color: "gray"

        }

    }



    Drawer {
        id: drawer
        width: window.width * 0.6
        height: window.height
        dragMargin: 30

        z: 0


        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    //stackView.push("Page1Form.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    // stackView.push("Page2Form.ui.qml")
                    drawer.close()
                }
            }
        }


    }








    StackView {
        id: stackView
        // initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }
}
