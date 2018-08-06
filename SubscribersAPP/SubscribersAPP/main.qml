import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3



import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4



ApplicationWindow {
    id: window
    visible: true
    //width: 540
    //height: 960
    width: 1080
    height: 1920
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
            height: window.height * 0.3
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

                y: logoPic.y + logoPic.height + 5

                anchors.top: logoPic.bottom
               // anchors.right: billRow.right
                anchors.horizontalCenter: infoRect.horizontalCenter
                font.family: "Segoe UI Light"
                font.pointSize: 45
                color: "#f7f7f7"
                text: "550 ₽"
            }



            Text{
                id: bill
                //anchors.top: billVal.bottom
                y: billVal.y + billVal.height
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
                width: parent.width - 70
                height: 1
                anchors.horizontalCenter: infoRect.horizontalCenter
                y:  bill.y + bill.height + 3
                color: "white"
            }


        }



            Rectangle{                     // add background if use "Toolbutton"
                id: toolRect
                color: infoRect.color
                // opacity: 0.4
                radius: 25
                width: toolPic.width * 2.2
                height: toolPic.height * 2.2
                 x: 20
                 y: 20
                clip: true


                Image {
                    id: toolPic
                    source: "qrc:/toolPic.png"
                    width: 20
                    height: 15
                    smooth: true
                    anchors.centerIn: parent
                }


                Rectangle {
                    id: toolButtoncolorRect
                    height: 0
                    width: 0
                    color: "#f7f7f7"

                    transform: Translate {
                        x: -toolButtoncolorRect.width / 2
                        y: -toolButtoncolorRect.height / 2
                    }
                }



                MouseArea{
                    id: toolButton
                    anchors.fill: parent

                    onClicked: {

                        toolButtoncolorRect.x = mouseX
                        toolButtoncolorRect.y = mouseY
                        toolButtoncircleAnimation.start()


                        if (stackView.depth > 1) {
                            stackView.pop()
                        } else {
                            drawer.open()
                        }
                    }
                }
            }



            Image {
                id: logoPic
                source: "qrc:/RotatingLogo.png"
                smooth: true
                width: window.width / 4
                height: window.height / 21

                anchors.horizontalCenter: infoRect.horizontalCenter
                y: 20


           }




            Rectangle{
                id: bigMenu
                width: window.width - 30
                height: window.height - infoRect.height
                anchors.horizontalCenter: infoRect.horizontalCenter
                radius: 2
                anchors.top: infoRect.bottom
                anchors.topMargin: -15
                z: 3
                color: "white"






                layer.enabled: true
                layer.effect: DropShadow {
                    id: bigMenushadow
                    transparentBorder: true
                    //horizontalOffset: 8
                    verticalOffset: 10
                    samples: 30
                    //spread: 0.6
                    radius: 10

                    color: "gray"

                }

            }



        PropertyAnimation {
            id: toolButtoncircleAnimation
            target: toolButtoncolorRect
            properties: "width,height,radius"
            from: 0
            to: toolRect.width*3
            duration: 450

            onStopped: {
                toolButtoncolorRect.width = 0
                toolButtoncolorRect.height = 0



            }
        }



        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }



//    Rectangle{
//        id: bigMenu
//        width: window.width - 40
//        height: window.height - infoRect.height + 40
//        anchors.horizontalCenter: head.horizontalCenter
//        radius: 2
//        //anchors.top: infoRect.bottom
//        anchors.margins: 200
//        z: 3
//        color: "white"
//
//
//
//
//
//
//        layer.enabled: true
//        layer.effect: DropShadow {
//            id: bigMenushadow
//            transparentBorder: true
//            //horizontalOffset: 8
//            verticalOffset: 10
//            samples: 30
//            //spread: 0.6
//            radius: 10
//
//            color: "gray"
//
//        }
//
//    }
//
//

    Drawer {
        id: drawer
        width: window.width * 0.7
        height: window.height
        dragMargin: (position == 0.0) ? 30 : window.width



        background: Rectangle{
            id: drawerBack
            anchors.fill: parent
            color: "#586ac6"
            gradient: Gradient {
                GradientStop {
                    position: 0.00;
                    color: "#5886c6";
                }
                GradientStop {
                    position: 0.67;
                    color: "#ffffff";
                }
                GradientStop {
                    position: 0.95;
                    color: "#beeef5";
                }
            }




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


    }




    StackView {
        id: stackView
        // initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }
}
