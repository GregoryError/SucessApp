import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4



ApplicationWindow{
    id: mainwnd
    visible: true
  //  width: 540
  //  height: 960
    // width: 1080
    // height: 1920
     width: Screen.width
     height: Screen.height


    // color: "#f7f7f7"

    header: ToolBar {
        id: head
        //contentHeight: toolButton.implicitHeight

        contentHeight: infoRect.height





        Rectangle {
            id: startform
            opacity: 0
            //visible: true
            //visible: myClient.isAuth() ? false : true

            width: mainwnd.width
            height: mainwnd.height
            anchors.fill: parent



            OpacityAnimator {
                id: appearstartform
                target: startform;
                from: 0;
                to: 1;
                duration: 2000
                running: true
                easing.type: Easing.InOutExpo
            }

            OpacityAnimator {
                id: disappearStartForm
                target: startform;
                from: 1;
                to: 0;
                duration: 1700
                //running: false
                //running: (myClient.isAuth()) ? true : false
                easing.type: Easing.InOutExpo
            }


            Column {
                //anchors.centerIn: parent
                y: 100
                //anchors.topMargin: 50
                anchors.horizontalCenter: startform.horizontalCenter
                spacing: 14
                Column {
                    spacing: 4
                    TextField{
                        id: nameInput
                        maximumLength: 20
                        inputMethodHints: Qt.ImhPreferLowercase |
                                          Qt.ImhNoAutoUppercase |
                                          Qt.ImhNoPredictiveText


                        background: Rectangle {
                            opacity: 0
                            implicitWidth: flick.width / 2
                            implicitHeight: flick.height / 9
                        }
                        onAccepted: passwordInput.forceActiveFocus()
                        color: "steelblue"
                        font.pointSize: nameInput.width / 25
                        placeholderText: "Имя"
                        KeyNavigation.tab: passwordInput

                    }

                }

                Rectangle{
                    id: nameLine
                    height: 1
                    width: nameInput.width
                    anchors.top: nameInput.bottom
                    color: "#93deff"
                }


                Column {
                    spacing: 4
                    TextField {
                        id: passwordInput
                        maximumLength: 20
                        inputMethodHints: Qt.ImhPreferLowercase |
                                          Qt.ImhNoAutoUppercase |
                                          Qt.ImhNoPredictiveText

                        background: Rectangle {
                            opacity: 0
                            implicitWidth: flick.width / 2
                            implicitHeight: flick.height / 9
                        }
                        onAccepted: login()
                        color: "steelblue"
                        font.pointSize: passwordInput.width / 25
                        placeholderText: "Пароль"
                        echoMode: TextInput.PasswordEchoOnEdit
                        KeyNavigation.tab: loginButton
                    }
                }


                Rectangle{
                    id: passLine
                    height: 1
                    width: passwordInput.width
                    anchors.top: passwordInput.bottom
                    color: "#93deff"
                }







                Column {
                    spacing: 14
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        id: loginButton
                        color: "#51b6dd"
                        radius: 7
                        clip: true

                        implicitWidth: flick.width / 2
                        implicitHeight: flick.height / 9
                        Text{
                            anchors.centerIn: parent
                            color: "white"
                            font.pointSize: loginButton.width / 25
                            font.family: "Sawasdee"
                            text: "Войти";
                        }


                        Rectangle {
                            id: loginButtoncolorRect
                            height: 0
                            width: 0
                            color: "#c2ddff"

                            transform: Translate {
                                x: -loginButtoncolorRect.width / 2
                                y: -loginButtoncolorRect.height / 2
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {

                                Qt.inputMethod.hide();

                                loginButtoncolorRect.x = mouseX
                                loginButtoncolorRect.y = mouseY
                                loginButtoncircleAnimation.start()

                                myClient.setAuthData(nameInput.text, passwordInput.text);

                                bigbusy.running = true
                                firsttimer.running = true

                            }
                        }

                        PropertyAnimation {
                            id: loginButtoncircleAnimation
                            target: loginButtoncolorRect
                            properties: "width,height,radius"
                            from: 0
                            to: order.width*3
                            duration: 450

                            onStopped: {
                                loginButtoncolorRect.width = 0
                                loginButtoncolorRect.height = 0
                            }
                        }
                    }

                    Rectangle{
                        id: order
                        color: "#51b6dd"
                        radius: 7
                        clip: true

                        implicitWidth: flick.width / 2
                        implicitHeight: flick.height / 9

                        Text{

                            anchors.centerIn: parent
                            color: "white"
                            font.pointSize: order.width / 25
                            font.family: "Sawasdee"
                            text: "Оставить заявку";
                        }

                        Rectangle {
                            id: ordercolorRect
                            height: 0
                            width: 0
                            color: "#c2ddff"

                            transform: Translate {
                                x: -ordercolorRect.width / 2
                                y: -ordercolorRect.height / 2
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onPressed: {

                                Qt.inputMethod.hide();

                                ordercolorRect.x = mouseX
                                ordercolorRect.y = mouseY
                                circleAnimation.start()
                            }


                            onClicked:{
                                //circleAnimation.stop()
                                console.log("guest")
                            }

                        }
                    }



                    PropertyAnimation {
                        id: circleAnimation
                        target: ordercolorRect
                        properties: "width,height,radius"
                        from: 0
                        to: order.width*3
                        duration: 450

                        onStopped: {
                            ordercolorRect.width = 0
                            ordercolorRect.height = 0
                        }
                    }
                }
            }
        }





















































        Rectangle{
            id: flick
            width: mainwnd.width
            height: mainwnd.height
            anchors.fill: parent

            visible: false




            Rectangle{
                id: infoRect
                width: mainwnd.width
                height: mainwnd.height * 0.4 - 20
                anchors.top: mainwnd.top
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#323643"




                Image {
                    id: walletPic
                    scale: mainwnd.height / 1530
                    source: "qrc:/Wallet.png"
                    width: 70
                    height: 60
                    smooth: true
                    anchors.verticalCenter: billVal.verticalCenter
                    anchors.left:  billVal.right
                    anchors.margins: 40
                }

                //  Text {
                //      id: walletTxt
                //      anchors.topMargin: 8
                //      anchors.top: walletPic.bottom
                //      anchors.horizontalCenter: walletPic.horizontalCenter
                //      color: "#f7f7f7"
                //      font.family: "Segoe UI Light"
                //      font.pointSize: 10
                //      text: "Оплата<br>без комиссии"
                //
                //
                //  }
                //

                Text{
                    id: billVal
                    y: logoPic.y + logoPic.height + 5
                    anchors.topMargin: 8
                    // anchors.top: logoPic.bottom
                    anchors.horizontalCenter: infoRect.horizontalCenter
                    font.family: "Segoe UI Light"
                    font.pointSize: 40
                    color: "#f7f7f7"
                    //text: "550 ₽"
                    //text: myClient.showBill() + "₽"
                }


                Text{
                    id: bill
                    // y: billVal.y + billVal.height
                    anchors.top: billVal.bottom
                    anchors.topMargin: 8
                    anchors.horizontalCenter: infoRect.horizontalCenter
                    color: "#f7f7f7"
                    font.family: "Segoe UI Light"
                    font.pointSize: 10
                    text: "Баланс на сегодня"
                }


                Text{
                    id: planName
                    anchors.top: bill.bottom
                    anchors.topMargin: 8
                    anchors.horizontalCenter: infoRect.horizontalCenter
                    font.family: "Segoe UI Light"
                    font.pointSize: 20
                    color: "#f7f7f7"
                    //text: "Комплекс 550"
                    //text: myClient.showPlan()


                }


                Rectangle{
                    id: infoline
                    opacity: 0.7
                    width: parent.width - 70
                    height: 1
                    anchors.horizontalCenter: infoRect.horizontalCenter
                    anchors.top: planName.bottom
                    anchors.topMargin: 8
                    //y:  bill.y + bill.height + 3
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
                width: mainwnd.width / 4
                height: mainwnd.height / 21

                anchors.horizontalCenter: infoRect.horizontalCenter
                y: 20


            }




            Rectangle{
                id: bigMenu
                width: mainwnd.width - 30
                height: mainwnd.height - infoRect.height
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
                    samples: 30
                    radius: 12
                    color: "#606470"
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




            Drawer {
                id: drawer
                width: mainwnd.width * 0.7
                height: mainwnd.height
                dragMargin: (position == 0.0) ? 30 : mainwnd.width



                background: Rectangle{
                    id: drawerBack
                    anchors.fill: parent
                    color: "#586ac6"
                    gradient: Gradient {
                        GradientStop {
                            position: 0.00;
                            color: "#93deff";
                        }
                        GradientStop {
                            position: 0.95;
                            color: "#f7f7f7";
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




            Timer {
                id: firsttimer
                interval: 2000;

                //running: (myClient.isAuth()) ? true : false


                onTriggered:{

                    if(true/*myClient.isAuthRight()*/){           // Для теста

                        //  bigbusy.running = false
                        //
                        disappearStartForm.running = true
                        //
                        //
                        //  flick.opacity = 0
                        mainwnd.visible = true
                        //
                        //  flickappear.running = true
                        //
                        //

                        //billVal.text = myClient.showBill() + "₽"

                        // if(myClient.showState() === "off")
                        //     bigPaneltext.color = "#B84BFF"
                        // else bigPaneltext.color = "#f7f7f7"
                        //
                        // planName.text = myClient.showPlan()


                        //  lefttext.text = "Номер счета: <br>"
                        //          + myClient.showId()
                        //
                        //  righttext.text = "День платежа: <br>"
                        //          + myClient.showPay_day()
                        //

                        startform.visible = false
                        startform.enabled = false



                        //demoappear1.running = true


                    }else{
                        messageDialog.text = myClient.authResult();
                        bigbusy.running = false
                        messageDialog.visible = true;
                        flick.visible = false
                    }


                }
            }


        }

    }


}























































