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

    FontLoader { id: firaSansCondensed_Light; source: "/fonts/firaSansCondensed_Light.ttf" }


    Connections{
        target: myClient
        onStartReadInfo: {
            billVal.text = myClient.showBill();
            planName.text = myClient.showPlan();
            countTxt.text = "Лицевой счет: " + myClient.showId();
            dateTxt.text = "Расчетный день: " + myClient.showPay_day() + "  (" + myClient.nextPayDay() + ")";
            bill.text = "Баланс на сегодня " + myClient.serverTime();

            //console.log(myClient.nextPayDay() + " - NEXT DATE FOR PAY");

            myClient.switchToMe();
        }
    }


    Item{
        id: infoRect
        width: mainwnd.width
        height: (mainwnd.height * 0.3) + 10
        anchors.top: mainwnd.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 0
        //z: 3
        // visible: false
        //clip: true

        Component.onCompleted: focus = true

        Image {
            id: walletPic
            z: 4
            scale: mainwnd.height / 1530
            width: 75
            height: 65
            source: "qrc:/Wallet.png"
            // smooth: true
            anchors.verticalCenter: billVal.verticalCenter
            anchors.horizontalCenter: infoPic.horizontalCenter
            //anchors.right: billVal.left
            //anchors.margins: 40
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    myClient.makeBusyON(); stackView.push("qrc:/payDescribe.qml");

                }
            }

        }

        Text{
            id: billVal
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: infoRect.top
            anchors.topMargin: -15           /////// controversal <<<<<<<<<<<<<<<<<<<<
            font.family: firaSansCondensed_Light.name;
            font.pointSize: 55
            color: "#f7f7f7"
            //color: "#9ab5d5"
            //text: "550 ₽"
            text: myClient.showBill()
            //wrapMode: Text.WordWrap

        }

        Image {
            id: rubPic
            width: billVal.height * 0.6
            height: billVal.height * 0.6
            source: "qrc:/Menu/rub.png"
            anchors.verticalCenter: billVal.verticalCenter
            anchors.left: billVal.right
            anchors.margins: 5
        }

        Text{
            id: bill
            // y: billVal.y + billVal.height
            anchors.top: billVal.bottom
            //anchors.topMargin:
            anchors.horizontalCenter: infoRect.horizontalCenter
            color: "#f7f7f7"
            //color: "#9ab5d5"
            font.family: firaSansCondensed_Light.name;
            font.pointSize: 14
            // text: "Баланс на сегодня " + myClient.serverTime();
        }

        Text{
            id: planName
            anchors.top: bill.bottom
            anchors.topMargin: 2
            anchors.horizontalCenter: infoline.horizontalCenter
            font.family: firaSansCondensed_Light.name;
            font.pointSize: 24
            color: "#f7f7f7"
            width: infoline.width
            horizontalAlignment: Text.AlignHCenter
            minimumPointSize: 8
            fontSizeMode: Text.Fit
            //text: "Комплекс 550"

        }

        Rectangle{
            id: infoline
            opacity: 0.6
            width: bigMenu.width
            height: 1
            anchors.horizontalCenter: infoRect.horizontalCenter
            anchors.top: planName.bottom
            anchors.topMargin: 2
            //y:  bill.y + bill.height + 3
            color: "white"
        }

        Image {
            id: infoPic
            //y: countTxt.y + 4
            anchors.verticalCenter: countItem.bottom

            anchors.right: countItem.left
            anchors.rightMargin: 12



            width: 30
            height: 30
            source: "qrc:/infoPic.png"
            //smooth: true

        }






        Item {
            id: countItem
           // anchors.horizontalCenter: infoline.horizontalCenter
            x: dateTxt.x
            anchors.top: infoline.bottom
            anchors.topMargin: 5
            height: countTxt.height
            width: infoline.width
            z: 4


            MouseArea{
                id: bufArea
                z: 4
                anchors.fill: parent
                onPressed: {
                    console.log("copyed");
                    countBack.color = "#95c9e8"
                    countBack.opacity = 1
                    copyTxt.visible = true
                    myClient.copyToBuf();
                }
                onReleased: {
                    countBackDiss.running = true
                }


                OpacityAnimator{
                    id: countBackDiss
                    target: countBack
                    from: 1
                    to: 0
                    duration: 2500
                    running: false
                    onStopped: {
                        countBack.color = "transparent"
                        copyTxt.visible = false
                    }

                }
            }



            Text {
                id: countTxt
                anchors.top: countItem.top
               // anchors.top: infoline.bottom
               // anchors.topMargin: 10
               // anchors.horizontalCenter: countItem.horizontalCenter
                anchors.left: countItem.left
                font.family: firaSansCondensed_Light.name;
                font.pointSize: 15
                color: "#f7f7f7"
               // color: "#70859e"

                Rectangle{
                    id: countBack
                    anchors.fill: parent
                    radius: 4
                    color: "transparent"
                    Text {
                        id: copyTxt
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.family: firaSansCondensed_Light.name;
                        font.pointSize: 15
                        text: "скопированно"
                        visible: false
                        color: "white"

                    }
                }

            }

            Image {
                id: copyImg
                source: "qrc:/Menu/copyimg.png"
                anchors.left: countTxt.right
                anchors.leftMargin: 8
                width: 16
                height: 16
                anchors.verticalCenter: countTxt.verticalCenter
            }

            Text {
                id: copyComment
                anchors.left: copyImg.right
                anchors.verticalCenter: copyImg.verticalCenter
                anchors.leftMargin: 4
                font.family: firaSansCondensed_Light.name;
                font.pointSize: 10
                color: "#f7f7f7"
               // color: "#70859e"
                text: "копировать"
            }


        }










        Text{
            id: dateTxt
            anchors.top: countItem.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: infoRect.horizontalCenter
            font.family: firaSansCondensed_Light.name;
            font.pointSize: 15
            color: "#f7f7f7"


        }


        Rectangle {
            id: infoRectcolorRect
            height: 0
            width: 0

            color: "#95c9e8"

            transform: Translate {
                x: -infoRectcolorRect.width / 2
                y: -infoRectcolorRect.height / 2
            }
        }
        MouseArea{
            id: infoArea
            z: 2
            anchors.fill: infoRect
            // enabled: false
            onPressed: {

                infoRectcolorRectcleAnimation.stop();
                infoRectcolorRectOpacityAnimation.stop();

                infoRectcolorRect.x = mouseX
                infoRectcolorRect.y = mouseY
                infoRectcolorRectcleAnimation.start()
                infoRectcolorRectOpacityAnimation.start()

            }
        }

        PropertyAnimation {
            id: infoRectcolorRectcleAnimation
            target: infoRectcolorRect
            properties: "width,height,radius"
            from: 0
            to: infoRect.width
            duration: 600

            onStopped: {
                infoRectcolorRect.width = 0
                infoRectcolorRect.height = 0
            }
        }


        PropertyAnimation {
            id: infoRectcolorRectOpacityAnimation
            target: infoRectcolorRect
            properties: "opacity"
            from: 1
            to: 0
            duration: 350

        }


    }

    /////////////////////////////////// BUTTONS ////////////////////////////////////////////


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
            mtext: "Оплата"
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
        anchors.topMargin: -20         // WTF
        // smooth: true



        DropShadow {
            id: bigMenuShadow
            anchors.fill: bigMenu
            cached: true
            //horizontalOffset: 3
            verticalOffset: 2
            radius: 3.0
            samples: 6
            color: "#80000000"
            smooth: true
            source: bigMenu
            opacity: 0.3
        }

        GridView{
            id: cells
            interactive: false
            opacity: 0
            //visible: false
            anchors.centerIn: parent
            // smooth: true

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
                    // smooth: true

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
                            // smooth: true
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
                                //  smooth: true
                                //anchors.fill: parent
                                anchors.centerIn: parent
                                width: 26
                                height: 25

                                //sourceSize.height: 32
                                //sourceSize.width: 32

                                source: backdata
                                //scale: 0.3

                            }

                            Text {
                                id: cellButtonTxt
                                anchors.top: buttImg.bottom
                                anchors.topMargin: 10
                                anchors.horizontalCenter: buttImg.horizontalCenter
                                color: "#606470"
                                font.family: firaSansCondensed_Light.name;
                                font.pointSize: 16
                                text: mtext
                                // smooth: true
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
                                case 0: myClient.askForPayments(); myClient.makeBusyON();
                                    stackView.push("payments.qml"); break;
                                case 1: myClient.makeBusyON(); stackView.push("qrc:/payDescribe.qml"); break;
                                case 2: stackView.push("trustedPayPage.qml"); break;
                                case 3: myClient.makeBusyON();
                                    myClient.askForMsgs();
                                    stackView.push("messagePage.qml"); break;
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

                                // if (index === 1) { stackView.push("payPoints.qml"); }



                            }


                        }


                    }

                }

            }


            OpacityAnimator{
                id: cellAppear
                target: cells
                running: cells.visible
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.InCirc
                onStopped: {
                    // some soundeffects
                    // game_engine.soundBegin()
                    //backgroundAppear.start()
                }
            }



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

}


