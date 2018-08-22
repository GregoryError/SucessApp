import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1



Item {
   // anchors.fill: parent
    id: mainwnd

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }






    Connections{
        target: myClient
        onStartReadInfo: {
            billVal.text = myClient.showBill() + "₽"
            planName.text = myClient.showPlan()
            countTxt.text = "Ваш номер счета: " + myClient.showId()
            dateTxt.text = "Ваш день платежа: " + myClient.showPay_day()
            //bigbusy.running = false


        }
    }


    Item{
        id: infoRect
        width: mainwnd.width
        height: mainwnd.height * 0.3
        anchors.top: mainwnd.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        //color: "#323643"
        z: 3
        // visible: false

        Image {
            id: walletPic
            scale: mainwnd.height / 1530
            width: 70
            height: 60
            source: "qrc:/Wallet.png"
            smooth: true
            anchors.verticalCenter: billVal.verticalCenter
            anchors.right: billVal.left
            anchors.margins: 40
        }

        Text{
            id: billVal
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: infoRect.top
            anchors.topMargin: -15                      /////// controversal <<<<<<<<<<<<<<<<<<<<
            font.family: gotham_XNarrow.name;
            font.pointSize: 50
            color: "#f7f7f7"
            //text: "550 ₽"
            text: myClient.showBill() + "₽"
            //wrapMode: Text.WordWrap

        }

        Text{
            id: bill
            // y: billVal.y + billVal.height
            anchors.top: billVal.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: infoRect.horizontalCenter
            color: "#f7f7f7"
            font.family: gotham_XNarrow.name;
            font.pointSize: 15
            text: "Баланс на сегодня"
        }

        Text{
            id: planName
            anchors.top: bill.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: infoRect.horizontalCenter
            font.family: gotham_XNarrow.name;
            font.pointSize: 24
            color: "#f7f7f7"
            //text: "Комплекс 550"

        }

        Rectangle{
            id: infoline
            opacity: 0.7
            width: bigMenu.width
            height: 1
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: planName.bottom
            anchors.topMargin: 4
            //y:  bill.y + bill.height + 3
            color: "white"
        }

        Image {
            id: infoPic
            y: countTxt.y + 4
            anchors.horizontalCenter: walletPic.horizontalCenter
            width: (walletPic.width - 10) * 0.5
            height: walletPic.height * 0.5
            source: "qrc:/infoPic.png"
            smooth: true

        }

        Text {
            id: countTxt
            anchors.top: infoline.bottom
            anchors.topMargin: 8
            anchors.horizontalCenter: infoRect.horizontalCenter
            font.family: gotham_XNarrow.name;
            font.pointSize: 15
            color: "#f7f7f7"

        }

        Text{
            id: dateTxt
            anchors.top: countTxt.bottom
            anchors.topMargin: 8
            anchors.horizontalCenter: infoRect.horizontalCenter
            font.family: gotham_XNarrow.name;
            font.pointSize: 15
            color: "#f7f7f7"


        }



    }

    /////////////////////////////////// BUTTONS /////////////////////////////////////////////////////




    ListModel {
        id: myModel

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/payhistory.png"
            active: true
            mtext: "Платежи"
        }
        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/gps.png"
            active: true
            mtext: "Точки оплаты"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/trusted.png"
            active: true
            mtext: "Обещанный платеж"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/msg.png"
            active: true
            mtext: "Сообщения"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/call.png"
            active: true
            mtext: "Позвонить нам"
        }

        ListElement {
            mycolor: "#2cbaf1"
            backdata: "qrc:/Menu/oursite.png"
            active: true
            mtext: "Наш сайт"
        }

    }


    Rectangle{
        id: bigMenu
        width: infoRect.width - 30
        height: mainwnd.height - infoRect.height
        anchors.horizontalCenter: infoRect.horizontalCenter
        radius: 2
        anchors.top: infoRect.bottom
        anchors.topMargin: -15         // WTF
        smooth: true

        layer.enabled: true
        layer.effect: DropShadow {
            id: bigMenushadow
            transparentBorder: true
            samples: 30
            radius: 12
            color: "#606470"

        }

        GridView{
            id: cells
            interactive: false
            //visible: false
            anchors.centerIn: parent
            smooth: true

            width: cellWidth * 2
            height: cellHeight * 3

            cellHeight: bigMenu.height / 3
            cellWidth: bigMenu.width / 2

            model: myModel

            delegate: Component{
                id: cellDelegat
                Item {
                    id: oneCell
                    width: cells.cellWidth
                    height: cells.cellHeight
                    smooth: true

                    MouseArea{
                        id: buttons
                        enabled: active
                        width: oneCell.width
                        height: oneCell.height
                        clip: true
                        anchors.fill: parent

                        Rectangle{
                            id: backOfCell
                            color: "#f7f7f7"
                            smooth: true
                            anchors.fill: parent
                            radius: 3
                            anchors.margins: 1

                            Rectangle {
                                id: bigMenucolorRect
                                height: 0
                                width: 0
                                visible: false
                                color: "#93deff"
                                opacity: 0.6

                                transform: Translate {
                                    x: -bigMenucolorRect.width / 2
                                    y: -bigMenucolorRect.height  / 2
                                }
                            }



                            Image {
                                id: buttImg
                                smooth: true
                                //anchors.fill: parent
                                anchors.centerIn: parent
                                width: 30
                                height: 30
                                source: backdata
                                //scale: 0.3

                            }

                            Text {
                                id: cellButtonTxt
                                anchors.top: buttImg.bottom
                                anchors.topMargin: 10
                                anchors.horizontalCenter: buttImg.horizontalCenter
                                color: "#606470"
                                font.family: gotham_XNarrow.name;
                                font.pointSize: 16
                                text: mtext
                                smooth: true
                            }


                        }

                        onPressed: {
                            //backOfCell.color = "#C4EDFF"    // color: "#f7f7f7"
                            onPressedAnim.running = true
                            backOfCell.opacity = 0.7
                        }

                        onReleased: {
                            //game_engine.soundTap()


                            bigMenucolorRect.x = mouseX
                            bigMenucolorRect.y = mouseY

                            if(cellButtoncircleAnimation.running)
                                cellButtoncircleAnimation.stop()

                            cellButtoncircleAnimation.start()



                            //if (index === 0)
                            //    stackView.push("payments.qml")


                           // console.log(index)


                        }





                        ColorAnimation {
                            id: onPressedAnim
                            running: false
                            target: backOfCell
                            property: "color"
                            duration: 200
                            from: "#f7f7f7"
                            to: "#C4EDFF"
                            //easing.type: Easing.InExpo;
                        }


                        Timer{
                            id: operationTimer
                            running: false
                            interval: 250
                            onTriggered: {
                                switch (index) {
                                case 0: myClient.askForPayments(); /*myClient.fillPaysPage();*/ stackView.push("payments.qml"); break;
                                case 1: stackView.push("payPoints.qml"); break;
                                case 2: console.log(stackView.currentItem); break; //myClient.startPushTrusted(); break;
                                case 3: //myClient.startPushMsg(); break;
                                case 4: BackEnd.callUs(); break;
                                case 5: BackEnd.goUrl(); break;
                                }

                            }
                        }


                        ParallelAnimation {
                            id: cellButtoncircleAnimation

                            NumberAnimation {
                                //id: cellButtoncircleAnimation
                                target: bigMenucolorRect;
                                properties: "width,height,radius";
                                from: bigMenucolorRect.width;
                                to: buttons.width;
                                duration: 1100;
                                easing.type: Easing.OutExpo

                            }


                            NumberAnimation {
                                id: cellButtonOpacityAnimation
                                target: bigMenucolorRect;
                                //easing.type: Easing.InExpo;
                                properties: "opacity";
                                from: 0.6;
                                to: 0;
                                duration: 800;


                            }


                            ColorAnimation {
                                target: backOfCell
                                property: "color"
                                duration: 1100
                                from: "#C4EDFF"
                                to: "#f7f7f7"
                                easing.type: Easing.InExpo;


                            }


                            onStarted: {
                                bigMenucolorRect.visible = true
                                operationTimer.running = true

                            }

                            onStopped: {
                                backOfCell.color = "#f7f7f7"    // color: "#f7f7f7"
                                backOfCell.opacity = 1

                                bigMenucolorRect.width = 0
                                bigMenucolorRect.height = 0
                                bigMenucolorRect.visible = false



                            }


                        }


                    }

                }






            }





            // OpacityAnimator{
            //     id: cellAppear
            //     target: cells
            //     running: cells.visible
            //     from: 0
            //     to: 1
            //     duration: 200
            //
            //     easing.type: Easing.InCirc
            //     onStopped: {
            //         // some soundeffects
            //         // game_engine.soundBegin()
            //         //backgroundAppear.start()
            //     }
            // }



            // SequentialAnimation{
            //     id: cellsExit
            //     running: false
            //
            //
            //     ParallelAnimation{
            //
            //         NumberAnimation{
            //             target: cells
            //             properties: "scale"
            //             from: 1
            //             to: 150
            //             duration: 700
            //             easing.type: Easing.InExpo
            //
            //
            //         }
            //         NumberAnimation{
            //             target: cells
            //             properties: "opacity"
            //             from: 1
            //             to: 0
            //             duration: 800
            //             easing.type: Easing.InExpo
            //
            //         }
            //
            //     }
            //
            //     onStopped: {
            //
            //
            //     }
            //
            // }

        }

    }


    // BusyIndicator {
    //     id: bigbusy
    //     opacity: 0
    //     //running: (myClient.isAuth()) ? true : false
    //     running: true
    //     width: parent.width / 4 + 10
    //     height: parent.width / 4 + 10
    //     anchors.centerIn: parent
    //
    //     OpacityAnimator {
    //         id: bigbusyappear
    //         target: bigbusy;
    //         from: 0;
    //         to: 1;
    //         duration: 600
    //         running: true
    //         easing.type: Easing.InOutExpo
    //     }
    //
    //     contentItem: Item {
    //         id: item
    //         opacity: bigbusy.running ? 1 : 0
    //
    //         Behavior on opacity {
    //             OpacityAnimator {
    //                 duration: 600
    //             }
    //         }
    //
    //         RotationAnimator {
    //             target: item
    //             running: bigbusy.visible && bigbusy.running
    //             from: 0
    //             to: 360
    //             loops: Animation.Infinite
    //             duration: 2500
    //         }
    //
    //         Repeater {
    //             id: repeater
    //             model: 6
    //             Rectangle{
    //                 id: itemRec
    //                 x: item.width / 2 - width / 2
    //                 y: item.height / 2 - width / 2
    //                 implicitWidth: mainwnd.width / 20
    //                 implicitHeight: mainwnd.width / 20
    //                 //radius: 50
    //                 radius: 10
    //                 color: "#2284e0"
    //                 transform: [
    //                     Translate {
    //                         y: -Math.min(item.width, item.height) * 0.3
    //                     },
    //                     Rotation {
    //                         angle: index / repeater.count * 360
    //                         origin.x: width / 2
    //                         origin.y: height / 2
    //                     }
    //                 ]
    //             }
    //         }
    //
    //     }
    //
    // }


}


