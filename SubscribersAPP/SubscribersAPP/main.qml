import QtQuick 2.9
import QtQuick.Controls 2.2

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1







ApplicationWindow{
    id: mainwnd
    visible: true
    // width: 540
    // height: 960
    width: 430
    height: 850
    // width: 1080
    // height: 1920
    //  width: Screen.width
    //  height: Screen.height


    // color: "#f7f7f7"


    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }



    Rectangle{
        id: startHead
        width: mainwnd.width
        height: 66
        x: 0
        y: 0
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(mainwnd.width, mainwnd.width)
            gradient: Gradient {
                GradientStop { position: 0.1; color: "#93deff" }
                GradientStop { position: 0.2; color: "#638AA1" }
                GradientStop { position: 1.0; color: "#323643" }
            }
        }



        Image {
            id: startlogo
            source: "qrc:/RotatingLogo.png"
            smooth: true
            scale: 0.3
            anchors.horizontalCenter: startHead.horizontalCenter
            anchors.verticalCenter: startHead.verticalCenter

        }
    }


    Rectangle {
        id: startform
        opacity: 0
        //visible: true
        visible: myClient.isAuth() ? false : true

        width: mainwnd.width * 0.6
        height: mainwnd.height * 0.5
        anchors.top: startHead.bottom
        anchors.horizontalCenter: startHead.horizontalCenter
        //anchors.topMargin: 15
        //y:

        // color: "orange"


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
            running: (myClient.isAuth()) ? true : false
            easing.type: Easing.InOutExpo
        }


        Column {
            //anchors.centerIn: parent

            //anchors.topMargin: 50
            anchors.horizontalCenter: startform.horizontalCenter
            spacing: 10
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
                        implicitWidth: startform.width - 20
                        implicitHeight: startform.height / 5

                    }
                    onAccepted: passwordInput.forceActiveFocus()
                    color: "#606470"
                    font.pointSize: nameInput.width  * 0.1
                    font.family: gotham_XNarrow.name;
                    placeholderText: "Имя"
                    KeyNavigation.tab: passwordInput

                    Rectangle{
                        id: nameLine
                        height: 1
                        width: nameInput.width
                        anchors.top: nameInput.bottom
                        color: "#606470"
                    }

                }

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
                        implicitWidth: startform.width - 20
                        implicitHeight: startform.height / 5
                    }
                    onAccepted: login()
                    color: "#606470"
                    font.pointSize: passwordInput.width * 0.1
                    font.family: gotham_XNarrow.name;
                    placeholderText: "Пароль"
                    echoMode: TextInput.PasswordEchoOnEdit
                    KeyNavigation.tab: loginButton

                    Rectangle{
                        id: passLine
                        height: 1
                        width: passwordInput.width
                        anchors.top: passwordInput.bottom
                        color: "#606470"
                    }

                }
            }


            Column {
                spacing: 14
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: loginButton
                    color: "#93deff"
                    radius: 5

                    clip: true

                    implicitWidth: startform.width - 20
                    implicitHeight: startform.height / 5
                    Text{
                        anchors.centerIn: parent
                        color: "white"
                        font.pointSize: loginButton.width  * 0.1
                        font.family: gotham_XNarrow.name;
                        text: "Войти";
                    }


                    Rectangle {
                        id: loginButtoncolorRect
                        height: 0
                        width: 0
                        color: "#f7f7f7"

                        transform: Translate {
                            x: -loginButtoncolorRect.width / 2
                            y: -loginButtoncolorRect.height  / 2
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

                            console.log(nameInput.text, passwordInput.text)

                            //  bigbusy.running = true
                            firsttimer.running = true

                        }
                    }

                    PropertyAnimation {
                        id: loginButtoncircleAnimation
                        target: loginButtoncolorRect
                        properties: "width,height,radius"
                        from: 0
                        to: order.width * 2
                        duration: 130

                        onStopped: {
                            loginButtoncolorRect.width = 0
                            loginButtoncolorRect.height = 0
                        }
                    }
                }

                Rectangle{
                    id: order
                    radius: 5
                    clip: true
                    color: "#93deff"


                    implicitWidth: startform.width - 20
                    implicitHeight: startform.height / 5

                    Text{

                        anchors.centerIn: parent
                        color: "white"
                        font.pointSize: order.width  * 0.1
                        font.family: gotham_XNarrow.name;
                        text: "Подключиться";
                    }

                    Rectangle {
                        id: ordercolorRect
                        height: 0
                        width: 0
                        color: "#f7f7f7"

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
                    to: order.width * 2
                    duration: 130

                    onStopped: {
                        ordercolorRect.width = 0
                        ordercolorRect.height = 0
                    }
                }
            }
        }
    }



    MessageDialog {
        id: messageDialog
        title: "Вход невозможен"
        onAccepted: {
            // Qt.quit()
        }
        Component.onCompleted: visible = false

    }


    //////////////////////////////////////////// END OF START-FORM ////////////////////////////////////////////////


    //var space = 3;             // space between buttons


    Rectangle{
        id: flick
        width: mainwnd.width
        height: head.height + infoRect.height
        //anchors.fill: parent
        // color: "steelblue"
        x: 0
        y: 0
        z: 0

        visible: (myClient.isAuth()) ? true : false

        //visible: false  // (myClient.isAuth()) ? true : false


        LinearGradient {
            anchors.fill: parent
            //visible: false
            start: Qt.point(0, 0)
            end: Qt.point(mainwnd.width, mainwnd.width)
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#93deff" }
                GradientStop { position: 0.2; color: "#638AA1" }
                GradientStop { position: 0.4; color: "#4B6072" }
                GradientStop { position: 0.7; color: "#323643" }
                GradientStop { position: 1.0; color: "#323643" }
            }
        }


        //   }




        Item{
            id: head
            x: 0
            y: 0
            width: mainwnd.width
            height: 66
            //color: "#323643"
            //opacity: 0
            z: 3




            Image {
                id: logoPic
                source: "qrc:/RotatingLogo.png"
                smooth: true
                scale: 0.3
                anchors.horizontalCenter: head.horizontalCenter
                anchors.verticalCenter: toolRect.verticalCenter

            }


            Rectangle{                     // add background if use "Toolbutton"
                id: toolRect
                color: "transparent"
                radius: 25
                width: toolPic.width * 3.5
                height: toolPic.height * 3.5
                x: 15
                y: 15
                clip: true
                smooth: true


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
                    color: "#93deff"

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

                    }
                }
            }

            PropertyAnimation {
                id: toolButtoncircleAnimation
                target: toolButtoncolorRect
                properties: "width,height,radius"
                from: 0
                to: toolRect.width * 0.6
                duration: 80

                onStopped: {
                    toolButtoncolorRect.width = 0
                    toolButtoncolorRect.height = 0


                    if (stackView.depth > 1) {
                        stackView.pop()
                    } else {
                        drawer.open()
                    }

                }
            }
        }




        Item{
            id: infoRect
            width: mainwnd.width
            height: mainwnd.height * 0.3
            anchors.top: head.bottom
            anchors.horizontalCenter: flick.horizontalCenter
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
                font.family: gotham_XNarrow.name;
                font.pointSize: 50
                color: "#f7f7f7"
                //text: "550 ₽"
                //text: myClient.showBill() + "₽"

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
                font.pointSize: 14
                text: "Баланс на сегодня"
            }


            Text{
                id: planName
                anchors.top: bill.bottom
                anchors.topMargin: 4
                anchors.horizontalCenter: infoRect.horizontalCenter
                font.family: gotham_XNarrow.name;
                font.pointSize: 25
                color: "#f7f7f7"
                //text: "Комплекс 550"
                //text: myClient.showPlan()


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
                font.pointSize: 14
                //text:
                color: "#f7f7f7"

            }



            Text{
                id: dateTxt
                anchors.top: countTxt.bottom
                anchors.topMargin: 8
                anchors.horizontalCenter: infoRect.horizontalCenter
                font.family: gotham_XNarrow.name;
                font.pointSize: 14
               // text: "Ваш день платежа: 17"
                color: "#f7f7f7"

            }


        }

        /////////////////////////////////// BUTTONS /////////////////////////////////////////////////////

        Rectangle{
            id: bigMenu
            width: mainwnd.width - 30
            height: mainwnd.height - flick.height
            anchors.horizontalCenter: infoRect.horizontalCenter
            radius: 2
            anchors.top: infoRect.bottom
            anchors.topMargin: -15
            z: 3
            // color: "transparent"



            layer.enabled: true
            layer.effect: DropShadow {
                id: bigMenushadow
                transparentBorder: true
                samples: 30
                radius: 12
                color: "#606470"
            }




            Rectangle{
                id: paysList
                height: bigMenu.height / 3 - 3
                width: bigMenu.width / 2 - 3


                anchors.horizontalCenter: bigMenu.horizontalCenter - bigMenu.width / 4
                anchors.verticalCenter: bigMenu.verticalCenter - bigMenu.height / 5
                radius: 5

            }


            Rectangle{
                id: cashPoints
                height: paysList.height
                width: paysList.width



                anchors.horizontalCenter: bigMenu.horizontalCenter - bigMenu.width / 4
                anchors.top: paysList.bottom
                anchors.topMargin: 3
                radius: 5

            }


            Rectangle{
                id: trustedPay
                height: paysList.height
                width: paysList.width



                anchors.horizontalCenter: bigMenu.horizontalCenter - bigMenu.width / 4
                anchors.top: cashPoints.bottom
                anchors.topMargin: 3
                radius: 5

            }

            //////////

            Rectangle{
                id: messages
                height: paysList.height
                width: paysList.width


                anchors.verticalCenter: paysList.verticalCenter
                anchors.left: paysList.right
                anchors.leftMargin: 3
                radius: 5

            }


            Rectangle{
                id: callUs
                height: paysList.height
                width: paysList.width


                anchors.verticalCenter: cashPoints.verticalCenter
                anchors.left: cashPoints.right
                anchors.leftMargin: 3
                radius: 5

            }


            Rectangle{
                id: webSite
                height: paysList.height
                width: paysList.width



                anchors.verticalCenter: trustedPay.verticalCenter
                anchors.left: trustedPay.right
                anchors.leftMargin: 3
                radius: 5

            }


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
        dragMargin: (position == 0.0) ? flick.visible == true ? 40 : 0 : mainwnd.width





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
                        myClient.quitAndClear()
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

        running: (myClient.isAuth()) ? true : false


        onTriggered:{

            if(myClient.isAuthRight()){           // Для теста

                //  bigbusy.running = false
                //
                disappearStartForm.running = true
                //
                //
                //flick.opacity = 0
                mainwnd.visible = true
                toolRect.visible = true
                flick.visible = true
                //
                //  flickappear.running = true
                //
                //

                billVal.text = myClient.showBill() + "₽"

                // if(myClient.showState() === "off")
                //     bigPaneltext.color = "#B84BFF"
                // else bigPaneltext.color = "#f7f7f7"
                //


                planName.text = myClient.showPlan();

                countTxt.text = "Ваш номер счета: " + myClient.showId();

                dateTxt.text = "Ваш день платежа: " + myClient.showPay_day();


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
                //bigbusy.running = false
                messageDialog.visible = true;
                flick.visible = false
            }


        }
    }

}























































