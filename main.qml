import QtQuick 2.7
//import QtQuick.Controls 1.4
import QtQuick.Controls 2.2

import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1
import QtGraphicalEffects 1.0



ApplicationWindow{
    id: mainwnd
    visible: true
    // width: Screen.width
    // height: Screen.height

    width: Screen.width / 4
    height: Screen.height / 2 + 400



    Rectangle {
        id: startform
        opacity: 0
        //visible: true
        visible: myClient.isAuth() ? false : true

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
            running: (myClient.isAuth()) ? true : false
            easing.type: Easing.InOutExpo
        }


        Column {
            //anchors.centerIn: parent
            y: header.height + 50
            //anchors.topMargin: 50
            anchors.horizontalCenter: startform.horizontalCenter
            spacing: 16
            Column {
                spacing: 20
                TextField{
                    id: nameInput
                    maximumLength: 20
                    inputMethodHints: Qt.ImhPreferLowercase |
                                      Qt.ImhNoAutoUppercase |
                                      Qt.ImhNoPredictiveText

                    background: Rectangle {
                        radius: 7
                        implicitWidth: flick.width / 2
                        implicitHeight: flick.height / 9
                        border.color: "steelblue"
                        border.width: 3
                    }
                    onAccepted: passwordInput.forceActiveFocus()
                    color: "steelblue"
                    font.pointSize: nameInput.width / 25
                    placeholderText: "Имя"
                    KeyNavigation.tab: passwordInput

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
                        radius: 7
                        implicitWidth: flick.width / 2
                        implicitHeight: flick.height / 9
                        border.color: "steelblue"
                        border.width: 3
                    }
                    onAccepted: login()
                    color: "steelblue"
                    font.pointSize: passwordInput.width / 25
                    placeholderText: "Пароль"
                    echoMode: TextInput.PasswordEchoOnEdit
                    KeyNavigation.tab: loginButton
                }
            }
            Column {
                spacing: 20
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
                        color: "#1A6F90"

                        transform: Translate {
                            x: -loginButtoncolorRect.width / 2
                            y: -loginButtoncolorRect.height / 2
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {

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
                        color: "#1A6F90"

                        transform: Translate {
                            x: -ordercolorRect.width / 2
                            y: -ordercolorRect.height / 2
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {

                            ordercolorRect.x = mouseX
                            ordercolorRect.y = mouseY
                            circleAnimation.start()
                        }
                        //onReleased: circleAnimation.stop()
                        //onPositionChanged: circleAnimation.stop()

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


    MessageDialog {
        id: messageDialog
        title: "Вход невозможен"
        onAccepted: {
            // Qt.quit()
        }
        Component.onCompleted: visible = false

    }


    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


    Flickable{
        id: flick
        //visible: false
        opacity: 0
        visible: (myClient.isAuth()) ? true : false
        width:  mainwnd.width
        height: mainwnd.height - header.height
        //contentHeight: Screen.height * 5
        //quitbutton
        contentHeight: quitbutton.y + quitbutton.height + 300
        contentWidth: mainwnd.width
        anchors.top: header.bottom
        smooth: true
        boundsBehavior: Flickable.StopAtBounds
        interactive: true

        maximumFlickVelocity: 1000000


        OpacityAnimator {
            id: flickappear
            target: flick;
            from: 0;
            to: 1;
            duration: 700
            //running: false
            //running: (myClient.isAuth()) ? true : false

        }

        OpacityAnimator {
            id: flickdisappear
            target: flick;
            from: 1;
            to: 0;
            duration: 1700
            //running: false

        }

        Rectangle{
            anchors.fill: parent
            id: ground
            opacity: 0.4
            color: "#dedbf7"

        }

        Rectangle{
            anchors.fill: parent
            id: dark
            visible: false
            opacity: 0.8
            color: "#090806"
        } //"#f9a825"

        Rectangle{
            id: bigPanel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 50
            width: parent.width - 100
            height: mainwnd.height / 6 + 20
            radius: 9


            layer.enabled: true
            layer.effect: DropShadow {
                id: bigpanelshadow
                opacity: 0
                transparentBorder: true
                samples: 24
                //spread: 0.6
                radius: 20
                color: "#a09999"
            }




            Timer {
                id: firsttimer
                interval: 2000;

                running: (myClient.isAuth()) ? true : false


                onTriggered:{



                    if(myClient.isAuthRight()){

                        bigbusy.running = false

                        disappearStartForm.running = true


                        flick.opacity = 0
                        flick.visible = true

                        flickappear.running = true



                        bigPaneltext.text = myClient.showBill() + "₽"

                        if(myClient.showState() === "off")
                            bigPaneltext.color = "#B84BFF"
                        else bigPaneltext.color = "#4BD1FF"

                        plantext.text = "Тариф: <br>"
                                + myClient.showPlan()

                        lefttext.text = "Номер счета: <br>"
                                + myClient.showId()

                        righttext.text = "День платежа: <br>"
                                + myClient.showPay_day()


                        startform.visible = false

                        //demoappear1.running = true


                    }else{
                        messageDialog.text = myClient.authResult();
                        bigbusy.running = false
                        messageDialog.visible = true;
                        flick.visible = false
                    }


                }
            }


            Text{
                id: bigPaneltext1
                anchors.top: parent.top
                anchors.topMargin: 35
                anchors.left: parent.left
                anchors.leftMargin: 35
                color: "black"
                font.family: "Noto Sans CJK KR Thin"
                font.pointSize: 15
                text: "Баланс:"
            }


            Text{
                id: bigPaneltext
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 35
                //color: "#47d786"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 40
            }

        }


        Rectangle{
            id: halfwgt
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: bigPanel.bottom
            anchors.margins: 45
            width: bigPanel.width
            height: bigPanel.height / 2
            radius: 9

            Text{

                id: plantext
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 35
                color: "#000000"
                // text: "Тариф: <br>"
                // + myClient.showResult()
                //text: myClient.showResult()
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            layer.enabled: true
            layer.effect: DropShadow {
                id: halfshadow
                opacity: 0
                transparentBorder: true
                //horizontalOffset: 8
                //verticalOffset: 7
                samples: 20
                //spread: 0.6
                radius: 18
                color: "#a09999"

            }

        }



        Row{
            id: rowithcouple
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: halfwgt.bottom
            anchors.margins: 45
            spacing: 20

            Rectangle{
                id: left
                anchors.rightMargin: 7
                anchors.margins: 15
                width: bigPanel.width / 2 - 8
                height: bigPanel.height / 2
                radius: 9

                Text{
                    id: lefttext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    color: "#000000"
                    //text: "Номер счета: <br> 7753"
                    font.family: "Noto Sans CJK KR Thint"
                    font.pointSize: 15
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    id: leftshadow
                    opacity: 0
                    transparentBorder: true
                    horizontalOffset: -3
                    //verticalOffset: 7
                    samples: 16
                    //spread: 0.6
                    radius: 10
                    color: "#a09999"

                }


            }



            Rectangle{
                id: right

                anchors.rightMargin: 7
                anchors.margins: 15
                width: bigPanel.width / 2 - 8
                height: bigPanel.height / 2
                radius: 9

                Text{
                    id: righttext
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    color: "#000000"
                    //text: "Дата платежа: <br> 27.02.18"
                    font.family: "Noto Sans CJK KR Thint"
                    font.pointSize: 15
                }

                layer.enabled: true
                layer.effect: DropShadow {
                    visible: false
                    id: rightshadow
                    opacity: 0
                    transparentBorder: true
                    horizontalOffset: 3
                    //verticalOffset: 7
                    samples: 16
                    //spread: 0.6
                    radius: 10
                    color: "#a09999"


                }

            }

        }



        //=====================================================
        // Pointer
        //
        //          Rectangle{
        //              id: bigPanelDemo
        //              opacity: 0
        //              width: bigPanel.width / 2 + 50
        //              height: bigPanel.height / 2 + 50
        //              radius: 20
        //              anchors.horizontalCenter: bigPanel.horizontalCenter
        //              y: bigPanel.y + 120
        //              color: "#2155a8"
        //
        //              Rectangle{
        //                  width: bigPanelDemo.height / 3
        //                  height: bigPanelDemo.height / 3
        //                  color: "#2155a8"
        //                  anchors.verticalCenter: bigPanelDemo.top
        //                  x: bigPanelDemo.x - 300
        //
        //                  rotation: 45
        //
        //              }
        //              Text {
        //                  id: pointertxt
        //                  anchors.fill: parent
        //                  anchors.margins: 40
        //                  font.family: "Noto Sans CJK KR Thint"
        //                  font.pointSize: 20
        //                  color: "white"
        //                  text: "Здесь отображается<br>
        //                         состояние Вашего счета."
        //              }
        //
        //              OpacityAnimator {
        //                      id: demoappear1
        //                      target: bigPanelDemo
        //                      from: 0;
        //                      to: 1;
        //                      duration: 1700
        //                      running: true
        //                  }
        //
        //              OpacityAnimator {
        //                      id: demodisappear1
        //                      target: bigPanelDemo
        //                      from: 1;
        //                      to: 0;
        //                      duration: 1700
        //                      running: false
        //                  }
        //
        //
        //          }
        //
        //           onMovementStarted: demodisappear1.running = true
        //
        //=====================================================






        /////////////////////////////////////////////////////////////////////////////////////////  PAY_BUTTONS


        Text{
            id: namelbl
            anchors.top: rowithcouple.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.topMargin: 45
            color: "#555353"
            text: "Оплата"
            font.family: "Noto Sans CJK KR Thint"
            font.pointSize: 15
        }


        Timer {
            id: paytimer
            interval: 3000;

            running: false


            onTriggered:{

                payModel.clear()

                myClient.showPayments();
                // payflick.contentHeight = mainwnd.height * (myClient.payTableLenght() / 4);
                //console.log(myClient.payTableLenght())


                //payModel.count = myClient.payTableLenght()


                for(var i = 0; i < myClient.payTableLenght(); ++i)
                {

                    payModel.append({"date": myClient.givePayTime(i),
                                        "cash": myClient.givePayCash(i),
                                        "comment": myClient.givePayComm(i)})
                }

                bigbusy.running = false

            }
        }

        Rectangle{
            id: paylist
            anchors.top: namelbl.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            color: "white"
            clip: true

            Image {
                id: paylistIMG
                width: 70
                height: 70
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 70
                source: "qrc:/Menu/payhistory.png"
            }


            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "История платежей"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }


            Rectangle {
                id: paylistcolorRect
                height: 0
                width: 0
                color: "lightblue"

                transform: Translate {
                    x: -paylistcolorRect.width / 2
                    y: -paylistcolorRect.height / 2
                }
            }


            MouseArea {
                anchors.fill: parent

                onClicked: {

                    paylistcolorRect.x = mouseX
                    paylistcolorRect.y = mouseY
                    paylistcircleAnimation.start()

                    myClient.askForPayments()
                    paytimer.running = true
                    bigbusy.running = true
                    //if(!paypagetext.text.length > 0)
                    //    bigbusy.running = true
                }

            }

        }

        PropertyAnimation {
            id: paylistcircleAnimation
            target: paylistcolorRect
            properties: "width,height,radius"
            from: 0
            to: order.width*3
            duration: 300

            onStopped: {
                paylistcolorRect.width = 0
                paylistcolorRect.height = 0

                paymentspageanim.running = true
                paymentspage.focus = true
                paymentspage.visible = true
            }
        }



        Rectangle{
            id: paypoints
            anchors.horizontalCenter: parent.horizontalCenter
            y: paylist.y + paylist.height
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            color: "white"
            clip: true

            Image {
                id: paypointsIMG
                width: 70
                height: 70
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 70
                source: "qrc:/Menu/gps.png"
            }


            Text{
                id: paypoints_txt
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Ближайшие точки оплаты"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }


            Rectangle {
                id: paypointscolorRect
                height: 0
                width: 0
                color: "lightblue"

                transform: Translate {
                    x: -paypointscolorRect.width / 2
                    y: -paypointscolorRect.height / 2
                }
            }

            MouseArea {
                anchors.fill: parent

                onClicked:{

                    paypointscolorRect.x = mouseX
                    paypointscolorRect.y = mouseY
                    paypointscircleAnimation.start()

                    paypointspagetext.text = "<b>Ближайшие точки оплаты:</b><br><br>"
                            + BackEnd.showATM() +
                            "<br> <br> Для более точного определения <br>
                          местоположения, рекомендуется <br>
                          включить GPS модуль в настройках <br>
                          вашего устройства."
                    // bigbusy.running = false;
                }
            }
        }


        PropertyAnimation {
            id: paypointscircleAnimation
            target: paypointscolorRect
            properties: "width,height,radius"
            from: 0
            to: order.width*3
            duration: 300

            onStopped: {
                paypointscolorRect.width = 0
                paypointscolorRect.height = 0

                paypointspageanim.running = true
                paypointspage.focus = true
                paypointspage.visible = true


            }
        }



        Rectangle{
            id: trustedpay
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: paypoints.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2

            color: "white"
            clip: true

            Image {
                id: trustedpayIMG
                width: 70
                height: 70
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 70
                source: "qrc:/Menu/trusted.png"
            }

            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Обещанный платеж"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }

            Rectangle {
                id: trustedpaycolorRect
                height: 0
                width: 0
                color: "lightblue"

                transform: Translate {
                    x: -trustedpaycolorRect.width / 2
                    y: -trustedpaycolorRect.height / 2
                }
            }


            MouseArea {
                anchors.fill: parent

                onClicked: {

                    trustedpaycolorRect.x = mouseX
                    trustedpaycolorRect.y = mouseY
                    trustedpaycircleAnimation.start()

                    //trustedpage.visible = true
                    //BackEnd.trustedPay();
                }

            }

        }

        PropertyAnimation {
            id: trustedpaycircleAnimation
            target: trustedpaycolorRect
            properties: "width,height,radius"
            from: 0
            to: order.width*3
            duration: 300

            onStopped: {
                trustedpaycolorRect.width = 0
                trustedpaycolorRect.height = 0

                trustedpageanim.running = true
                trustedpage.focus = true
            }
        }


        /////////////////////////////////////////////////////////////// SERVICE_BUTTONS



        Text{
            id: namelbl_2
            anchors.top: trustedpay.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.topMargin: 45
            color: "#555353"
            text: "Сервис"
            font.family: "Noto Sans CJK KR Thint"
            font.pointSize: 15
        }

        Button{
            id: traffic
            anchors.top: namelbl_2.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"

                Image {
                    id: trafficIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/activity.png"
                }

            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Моя активность"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }

            onClicked: {


                BackEnd.payList();
            }

        }

        // next




        Button{
            id: closeback_access
            opacity: 0
            anchors.horizontalCenter: parent.horizontalCenter
            //y: traffic.y + traffic.height
            anchors.top: traffic.bottom
            visible: false
            width: parent.width
            height: bigPanel.height / 3

            background: Rectangle{
                anchors.fill: parent
                color: "#8bacc6"
                Text{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 220
                    color: "#fbf6f6"
                    text: "скрыть"
                    font.family: "Segoe UI"
                    font.pointSize: 12
                }
            }
            onClicked:{
                visible: false
                accessTextBlock.visible = false
                access_anim_up.running = true

                rowaccessswitcher.visible = false
                textblockbefore.visible = false
                accessswitcher.visible = false

            }



            OpacityAnimator {
                id: closebackAccessAppear
                target: closeback_access;
                from: 0;
                to: 1;
                duration: 1700
                //running: false
                running: (myClient.isAuth()) ? true : false
                easing.type: Easing.InOutExpo
            }



        }




        Button{
            id: access
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.top: traffic.bottom
            y: traffic.y + traffic.height
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: accessIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/access.png"
                }


            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Контроль доступа"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }


            onClicked: {

                //myClient.setAuthOn()

                accesspageanim.running = true
            }

        }




        Button{
            id: repair
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: access.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"




                Image {
                    id: repairIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/master.png"
                }



            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Вызов мастера"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }

            onClicked: {


            }

        }

        Button{
            id: plan
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: repair.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: planIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/changeplan.png"
                }



            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Заказ тарифа"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            onClicked: {

                BackEnd.trustedPay();
            }

        }

        ////////////////////////////////////// CONTACTS

        Text{
            id: namelbl_3
            anchors.top: plan.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.left: parent.left
            anchors.leftMargin: 220
            anchors.topMargin: 45
            color: "#555353"
            text: "Контакты"
            font.family: "Noto Sans CJK KR Thint"
            font.pointSize: 15
        }

        Button{
            id: callus
            anchors.top: namelbl_3.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: callusIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/call.png"
                }



            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Позвонить нам"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }

            onClicked: {
                BackEnd.callUs();
            }

        }
        Button{
            id: ourweb
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: callus.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: ourwebIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/oursite.png"
                }


            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Наш сайт"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }

            onClicked: {

                BackEnd.goUrl();
            }

        }
        Button{
            id: social
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: ourweb.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"



                Image {
                    id: socialIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/social.png"
                }


            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Соц. сети"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            onClicked: {

                BackEnd.social();
            }

        }

        Button{
            id: lightside
            visible: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: social.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"

                Image {
                    id: lightsideIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/skin.png"
                }


            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Вернуться к светлой стороне"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            onClicked: {
                ground.visible = true
                dark.visible = false
                darkside.visible = true
                lightside.visible = false
                namelbl.color = "#555353"
                namelbl_2.color = "#555353"
                namelbl_3.color = "#555353"
            }
        }
        Button{
            id: darkside
            visible: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: social.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: darksideIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/skin.png"
                }


            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Перейти на темную сторону"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            onClicked: {

                ground.visible = false
                dark.visible = true
                darkside.visible = false
                lightside.visible = true
                namelbl.color = "white"
                namelbl_2.color = "white"
                namelbl_3.color = "white"
            }

        }


        Button{
            id: quitbutton
            visible: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: darkside.bottom
            anchors.margins: 0
            width: parent.width
            height: bigPanel.height / 2
            background: Rectangle{
                anchors.fill: parent
                color: "white"


                Image {
                    id: quitbuttonIMG
                    width: 70
                    height: 70
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 70
                    source: "qrc:/Menu/quit.png"
                }



            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 220
                color: "#000000"
                text: "Выйти"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
            }
            onClicked: {

                startform.opacity = 0
                startform.visible = true
                appearstartform.running = true

                nameInput.clear()
                passwordInput.clear()

                flickdisappear.running = true
                flick.visible = false

                myClient.quitAndClear();

                // поднять Flickable при выходе



            }

        }

    }



    Rectangle{
        x: 0
        y: 0
        id: header
        visible: true
        // opacity: 0

        width: parent.width
        height: parent.parent.height / 7 - 10


        ColorAnimation on color{
            id: headeroncolor
            from: "white"
            to: "#4B94FF"
            duration: 3500
            //running: false
            running: true
            loops: 1
        }

        Image {
            id: logo
            source: "RotatingLogo.png"
            //scale: 0.2
            width: 260
            height: 90
            smooth: true
            anchors.verticalCenter: parent.verticalCenter


            SequentialAnimation{
                id: anim
                running: true
                NumberAnimation{
                    target: logo
                    from: mainwnd.width
                    to: 70
                    properties: "x"
                    easing.type: Easing.OutExpo
                    duration: 4000

                }

            }
        }

        layer.enabled: true
        layer.effect: DropShadow {
            id: headshadow
            transparentBorder: true
            //horizontalOffset: 8
            verticalOffset: 10
            samples: 30
            //spread: 0.6
            radius: 25

            color: "gray"

        }

    }


    Rectangle{
        id: paymentspage
        width: mainwnd.width
        height: mainwnd.height
        color: "white"
        x: mainwnd.width
        visible: false

        Keys.onPressed: {
            if(event.key === Qt.Key_Back)
            {
                event.accepted = true;

                if(paymentspage.x < mainwnd.width)
                {
                    paymentspageanim.running = false
                    paymentspageanimquit.running = true
                }
                else
                {
                    Qt.quit();
                }
            }
        }


        ListModel {
            id: payModel

            ListElement {
                date: ""
                cash: ""
                comment: ""
            }
        }


        Rectangle{
            id: payflick
            width: paymentspage.width
            height: mainwnd.height - paysheader.height
            Component{
                id: paydelegate
                Item {
                    width: payflick.width
                    height: payflick.height / 6
                    Row{
                        anchors.centerIn: parent
                        spacing: 3
                        Rectangle{
                            height: payflick.height / 6
                            width: payflickView.width * 0.3 -4;
                            color: (index % 2 == 0)? "#c4f0f9" : "#ebfbfb"
                            Text {
                                anchors.centerIn: parent;
                                id: dates
                                color: "steelblue"
                                font.pointSize: 12
                                text: date
                            }
                        }

                        Rectangle{
                            height: payflick.height / 6
                            width: payflickView.width * 0.2;
                            color: (index % 2 == 0)? "#c4f0f9" : "#ebfbfb"
                            Text {
                                anchors.centerIn: parent;
                                id: cashes
                                color: "steelblue"
                                font.pointSize: 12
                                text: cash
                            }
                        }

                        Rectangle{
                            height: payflick.height / 6
                            width: payflickView.width * 0.5 -4;
                            color: (index % 2 == 0)? "#c4f0f9" : "#ebfbfb"
                            Text {
                                anchors.centerIn: parent;
                                id: comments
                                color: "black"
                                font.pointSize: 7
                                text: comment
                            }
                        }
                    }
                }
            }
        }


        ListView{
            id: payflickView
            width: paymentspage.width
            height: mainwnd.height - paysheader.height
            anchors.top: paysheader.bottom
            anchors.horizontalCenter: mainwnd.horizontalCenter
            smooth: true
            focus: true
            maximumFlickVelocity: 1000000
            headerPositioning: ListView.OverlayHeader
            spacing: 3

            header: Rectangle{
                width: parent.width
                height: paysheader.height / 2
                z: 2

                Row{
                    anchors.centerIn: parent
                    spacing: 3
                    Rectangle{
                        border.color: "lightblue"
                        radius: 2
                        border.width: 1
                        height: paysheader.height / 2 -2
                        width: payflickView.width * 0.3 -4;
                        Text { anchors.centerIn: parent; font.pointSize: 16; color: "steelblue"; text: "Время: " }
                    }
                    Rectangle{
                        border.color: "lightblue"
                        radius: 2
                        border.width: 1
                        height: paysheader.height / 2 -2
                        width: payflickView.width * 0.2;
                        Text { anchors.centerIn: parent; font.pointSize: 16; color: "steelblue"; text: "Сумма: " }
                    }
                    Rectangle{
                        border.color: "lightblue"
                        radius: 2
                        border.width: 1
                        height: paysheader.height / 2 -2
                        width: payflickView.width * 0.5 -4;
                        Text { anchors.centerIn: parent; font.pointSize: 16; color: "steelblue"; text: "Комментарий: " }
                    }



                }
            }


            model: payModel
            delegate: paydelegate


        }



        //        }

        Rectangle{
            x: 0
            y: 0
            id: paysheader
            color: "#4B94FF"

            Button{
                id: backfrompays
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                //anchors.leftMargin: 25
                width: paysheader.height
                height: paysheader.height
                background: Rectangle{
                    anchors.fill: parent
                    //color: "#4B94FF"
                    opacity: 0
                }

                enabled: (paymentspage.x == 0)? true : false

                Image {
                    id: arrowpoints
                    source: "qrc:/arrow-left.png"
                    width: paysheader.height / 2 -10
                    height: paysheader.height / 2 -10
                    //anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.leftMargin: 25
                    anchors.centerIn: parent
                }

                onClicked: {
                    paymentspageanimquit.running = true

                }

            }

            width: parent.width
            height: parent.parent.height / 7 - 10

            layer.enabled: true
            layer.effect: DropShadow {
                id: paysheadershadow
                transparentBorder: true
                //horizontalOffset: 8
                verticalOffset: 10
                samples: 30
                //spread: 0.6
                radius: 25

                color: "gray"

            }

        }


        SequentialAnimation{
            id: paymentspageanim
            running: false
            NumberAnimation{
                target: paymentspage
                easing.amplitude: 0.5
                from: mainwnd.width
                to: 0
                properties: "x"
                easing.type: Easing.OutExpo
                duration: 1100
            }
            onStarted: paymentspage.visible = true
            onStopped: {
                // flick.visible = false
                // flick.enabled = false
            }

        }


        SequentialAnimation{
            id: paymentspageanimquit
            running: false
            NumberAnimation{
                target: paymentspage
                easing.amplitude: 0.5
                from: 0
                to: mainwnd.width
                properties: "x"
                easing.type: Easing.OutCirc
                duration: 500
            }
            onStarted: {
                flick.enabled = true
                flick.visible = true
            }
            onStopped: paymentspage.visible = false
        }

    }



    Rectangle{
        id: paypointspage
        width: mainwnd.width
        height: mainwnd.height
        color: "white"
        x: mainwnd.width * 2
        visible: false
        Keys.onPressed: {
            if(event.key === Qt.Key_Back)
            {
                event.accepted = true;

                if(paypointspage.x < mainwnd.width)
                {
                    paypointspageanim.running = false
                    paypointspageanimquit.running = true
                }
                else
                {
                    Qt.quit();
                }
            }
        }

        Rectangle{
            id: paypointsflick
            width:  paypointspage.width
            height: mainwnd.height - paysheader.height
            anchors.top: paypointsheader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            smooth: true

            Text {
                id: paypointspagetext
                color: "#194b77"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
                anchors.horizontalCenter: parent.horizontalCenter
                y: paypointsheader.y + 50


            }
        }

        Rectangle{
            x: 0
            y: 0
            id: paypointsheader
            color: "#4B94FF"

            Button{
                id: backfrompoints
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: paysheader.height
                height: paysheader.height
                background: Rectangle{
                    anchors.fill: parent
                    //color: "#4B94FF"
                    opacity: 0
                }

                enabled: (paypointspage.x == 0)? true : false

                Image {
                    id: arrow
                    source: "qrc:/arrow-left.png"
                    width: paysheader.height / 2 -10
                    height: paysheader.height / 2 -10
                    //anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.leftMargin: 25
                    anchors.centerIn: parent
                }

                onClicked: {
                    paypointspageanimquit.running = true
                }

            }

            width: parent.width
            height: parent.parent.height / 7 - 10

            layer.enabled: true
            layer.effect: DropShadow {
                id: paypointspageheadershadow
                transparentBorder: true
                //horizontalOffset: 8
                verticalOffset: 10
                samples: 30
                //spread: 0.6
                radius: 25

                color: "gray"

            }

        }


        SequentialAnimation{
            id: paypointspageanim
            running: false

            NumberAnimation{
                target: paypointspage
                easing.amplitude: 0.5
                from: mainwnd.width
                to: 0
                properties: "x"
                easing.type: Easing.OutExpo
                duration: 1100
            }
            onStarted: paypointspage.visible = true


            onStopped: {
                if(paypointspage.x == 0)
                {
                    flick.enabled = false
                    flick.visible = false
                }

            }


        }


        SequentialAnimation{
            id: paypointspageanimquit
            running: false
            NumberAnimation{
                target: paypointspage
                easing.amplitude: 0.5
                from: 0
                to: mainwnd.width
                properties: "x"
                easing.type: Easing.OutCirc
                duration: 500
            }
            onStarted: {
                flick.enabled = true
                flick.visible = true
            }
            onStopped: paypointspage.visible = false

        }

    }











    Rectangle{
        id: trustedpage
        width: mainwnd.width
        height: mainwnd.height
        color: "white"
        x: mainwnd.width * 2
        visible: false

        Keys.onPressed: {
            if(event.key === Qt.Key_Back)
            {
                event.accepted = true;


                if(trustedpage.x < mainwnd.width)
                {
                    trustedpageanim.running = false
                    trustedpageanimquit.running = true
                }
                else
                {
                    Qt.quit();
                }
            }
        }



        Flickable{
            id: trustedpageflick
            width:  trustedpage.width
            height: mainwnd.height - trustedpageheader.height
            //contentHeight: Screen.height * 2
            contentHeight: trustButton.y + trustButton.height + 200
            contentWidth: trustedpage.width
            anchors.top: trustedpageheader.bottom
            smooth: true
            boundsBehavior: Flickable.StopAtBounds
            interactive: true
            maximumFlickVelocity: 1000000


            Rectangle{
                id: rectworkspace
                //anchors.top: trustedpageflick.top
                width: mainwnd.width
                height: trustButton.y + trustButton.height + 200
                anchors.margins: 50

                anchors.fill: parent


                Text
                {
                    id: trustedpagetext
                    visible: true
                    color: "#194b77"
                    font.family: "Noto Sans CJK KR Thint"
                    font.pointSize: 13
                    anchors.horizontalCenter: rectworkspace.horizontalCenter
                    // anchors.fill: parent
                    anchors.topMargin: 50
                    // anchors.leftMargin: 70
                    // anchors.margins: 100
                    text: "- Обещанный платеж это бесплатная услуга.<br>
- Подключив обещанный платеж,<br>
вы обязуетесь внести плату за текущий месяц.<br><br>
<br>Условия использования Услуги:<br><br><br>
1. Услуга «Обещанный платеж» предоставляется<br>
Абонентам, у которых на начало нового расчетного<br>
периода не хватает денежных средств для списания<br>
платы за услуги связи.<br><br>

2. Услуга «Обещанный платёж» предоставляет<br>
временный доступ к услугам на срок до 3 суток.<br><br>

3. С момента подключения Услуги<br>
«Обещанный платеж», с Лицевого счета<br>
Абонента взимается абонентская плата<br>
в полном размере, согласно выбранному<br>
Абонентом тарифному плану.<br><br>

4. Если в течение пользования услугой<br>
«Обещанный платеж» Абонент не внесет<br>
на Лицевой счет денежные средства<br>
в размере не менее полной абонентской платы<br>
за Услуги за один расчетный период,<br>
предоставление Услуг Абоненту<br>
будет приостановлено.<br>
Для возобновления оказания Услуг<br>
Абоненту необходимо будет внести<br>
на Лицевой счет денежные средства<br>
в размере полной абонентской платы<br>
за Услуги за один расчетный период.<br><br>

5. Абонент не может воспользоваться услугой<br>
«Обещанный платеж» дважды в течение<br>
одного расчетного периода.<br><br>

6. Администрация оставляет за собой право<br>
отказать Абоненту в предоставлении<br>
Услуги «Обещанный платеж»."


                }

                CheckBox{
                    id: control
                    // width: 30
                    // height: 30
                    anchors.horizontalCenter: rectworkspace.horizontalCenter
                    anchors.top: trustedpagetext.bottom
                    anchors.topMargin: 50
                    text: " Условия принимаю"

                    indicator: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 100
                        x: control.leftPadding
                        y: parent.height / 2 - height / 2
                        radius: 3
                        border.color: control.down ? "#9c27b0" : "#1565c0"

                        Rectangle {
                            width: 70
                            height: 70
                            anchors.centerIn: parent
                            x: 6
                            y: 6
                            radius: 2
                            color: control.down ? "#9c27b0" : "#1565c0"
                            visible: control.checked
                        }
                    }

                    contentItem: Text {
                        text: control.text
                        font: control.font
                        opacity: enabled ? 1.0 : 0.3
                        color: control.down ? "#9c27b0" : "#1565c0"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        leftPadding: control.indicator.width + control.spacing
                    }


                }
                Button{
                    id: trustButton
                    enabled: control.checked ? true : false
                    opacity: 0
                    anchors.horizontalCenter: rectworkspace.horizontalCenter
                    anchors.top: control.bottom
                    anchors.topMargin: 50
                    width: rectworkspace.width / 2
                    height: rectworkspace.width / 4
                    background: Rectangle{
                        id: trustButtonStyle
                        anchors.fill: parent
                        color: "steelblue"
                        radius: 9

                    }
                    Text {
                        id: trButtTxt
                        anchors.centerIn: parent
                        font.family: "Noto Sans CJK KR Thint"
                        font.pointSize: 20
                        color: "white"
                        text: "Подключить"
                    }


                    onClicked: {
                        myClient.askForTrustedPay();
                    }

                    OpacityAnimator {
                        id: trustButtonappear
                        target: trustButton;
                        from: 0;
                        to: 1;
                        duration: 1000
                        running: control.checked ? true : false
                        easing.type: Easing.InOutExpo
                    }


                    OpacityAnimator {
                        id: trustButtondisappear
                        target: trustButton;
                        from: 1;
                        to: 0;
                        duration: 1000
                        running: control.checked ? false : true
                        easing.type: Easing.InOutExpo
                    }


                }

            }
        }

        Rectangle{
            x: 0
            y: 0
            id: trustedpageheader
            color: "#4B94FF"

            Button{
                id: backfromtrusted
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                //anchors.leftMargin: 25
                width: trustedpageheader.height
                height: trustedpageheader.height
                background: Rectangle{
                    anchors.fill: parent
                    //color: "#4B94FF"
                    opacity: 0
                }

                enabled: (trustedpage.x == 0)? true : false

                Image {
                    id: trustarrow
                    source: "qrc:/arrow-left.png"
                    width: trustedpageheader.height / 2 -10
                    height: trustedpageheader.height / 2 -10
                    //anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.leftMargin: 25
                    anchors.centerIn: parent
                }

                onClicked: {
                    trustedpageanimquit.running = true
                }

            }

            width: parent.width
            height: parent.parent.height / 7 - 10

            layer.enabled: true
            layer.effect: DropShadow {
                id: trustedpageshadow
                transparentBorder: true
                //horizontalOffset: 8
                verticalOffset: 10
                samples: 30
                //spread: 0.6
                radius: 25
                color: "gray"

            }

        }


        SequentialAnimation{
            id: trustedpageanim
            running: false
            NumberAnimation{
                target: trustedpage
                easing.amplitude: 0.5
                from: mainwnd.width
                to: 0
                properties: "x"
                easing.type: Easing.OutExpo
                duration: 1100
            }
            onStarted: trustedpage.visible = true
            onStopped: {
                flick.visible = false
                flick.enabled = false
            }

        }


        SequentialAnimation{
            id: trustedpageanimquit
            running: false
            NumberAnimation{
                target: trustedpage
                easing.amplitude: 0.5
                from: 0
                to: mainwnd.width
                properties: "x"
                easing.type: Easing.OutCirc
                duration: 500
            }
            onStarted: {
                flick.enabled = true
                flick.visible = true
            }
            onStopped: trustedpage.visible = false

        }

    }









    Rectangle{
        id: accesspage
        width: mainwnd.width
        height: mainwnd.height
        color: "white"
        x: mainwnd.width * 2
        visible: false
        Keys.onPressed: {
            if(event.key === Qt.Key_Back)
            {
                event.accepted = true;

                if(accesspage.x < mainwnd.width)
                {
                    accesspageageanim.running = false
                    accesspageageanimquit.running = true
                }
                else
                {
                    Qt.quit();
                }
            }
        }

        Rectangle{
            id: accesspageflick
            width:  accesspage.width
            height: mainwnd.height - accesspageheader.height
            anchors.top: accesspageheader.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            smooth: true


            Text{
                id: textblockbefore
                anchors.top: accesspageheader.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                //anchors.left: parent.left
                //anchors.leftMargin: 220
                y: accesspageheader.y + 50
                color: "#194b77"
                text: "<b>Контроль доступа:</b><br>"
                font.family: "Segoe UI"
                font.pointSize: 15
            }


            Row{
                id: rowaccessswitcher
                visible: true
                anchors.top: textblockbefore.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 45
                spacing: 12

                Text{
                    font.family: "Segoe UI"
                    font.pointSize: 15
                    text:("Выкл  ")
                    anchors.verticalCenter: parent.verticalCenter
                }
                Switch {
                    id: accessswitcher


                    SwitchStyle {
                        groove: Rectangle {
                            implicitWidth: 150
                            implicitHeight: 20
                            radius: 2
                            border.color: accessswitcher.activeFocus ? "darkblue" : "gray"
                            border.width: 3
                        }
                    }

                    indicator: Rectangle {
                        implicitWidth: 150
                        implicitHeight: 70
                        //  x: accessswitcher.width - width - accessswitcher.rightPadding
                        //  y: accessswitcher.height / 2 - height / 2
                        radius: 10
                        color: accessswitcher.checked ? "steelblue" : "transparent"
                        border.color: accessswitcher.checked ? "steelblue" : "#cccccc"

                        Rectangle {
                            x: accessswitcher.checked ? parent.width - width : 0
                            width: 70
                            height: 70
                            radius: 10
                            //color: accessswitcher.down ? "#cccccc" : "#ffffff"
                            //border.color: accessswitcher.checked ? (accessswitcher.down ? "#17a81a" : "#21be2b") : "#999999"
                        }
                    }

                    onClicked:{

                        if(accessswitcher.position === 1.0)
                            myClient.setAuthNo();
                        if(accessswitcher.position === 0.0)
                            myClient.setAuthOn();
                    }

                }

                Text{
                    font.family: "Segoe UI"
                    font.pointSize: 15
                    text:("Вкл")
                    anchors.verticalCenter: parent.verticalCenter
                }



            }


            Text {
                id: accesspagetext
                color: "#194b77"
                font.family: "Noto Sans CJK KR Thint"
                font.pointSize: 15
                anchors.topMargin: 45
                anchors.top: rowaccessswitcher.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                y: accesspageheader.y + 50
                text: "<br> Включение и выключение доступа.<br>
                                         Обратите внимание: Данная опция<br>
                                         предоставляется для удобства, <br>
                                         как дополнительная бесплатная услуга,<br>
                                         и не влияет на размер ежемесячной <br>
                                         абонентской платы."

            }



        }

        Rectangle{
            x: 0
            y: 0
            id: accesspageheader
            color: "#4B94FF"

            width: parent.width
            height: parent.parent.height / 7 - 10

            Button{
                id: backfromaccesspage
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                width: accesspageheader.height
                height: accesspageheader.height
                background: Rectangle{
                    anchors.fill: parent
                    //color: "#4B94FF"
                    opacity: 0
                }

                enabled: (accesspage.x === 0)? true : false

                Image {
                    id: arrowaccesspage
                    source: "qrc:/arrow-left.png"
                    width: accesspageheader.height / 2 -10
                    height: accesspageheader.height / 2 -10
                    //anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.leftMargin: 25
                    anchors.centerIn: parent
                }

                onClicked: {
                    accesspageanimquit.running = true
                }

            }



            layer.enabled: true
            layer.effect: DropShadow {
                id: accesspageheadershadow
                transparentBorder: true
                verticalOffset: 10
                samples: 30
                radius: 25
                color: "gray"
            }

        }


        SequentialAnimation{
            id: accesspageanim
            running: false

            NumberAnimation{
                target: accesspage
                easing.amplitude: 0.5
                from: mainwnd.width
                to: 0
                properties: "x"
                easing.type: Easing.OutExpo
                duration: 1100
            }
            onStarted: accesspage.visible = true


            onStopped: {

                    flick.enabled = false
                    flick.visible = false

            }


        }


        SequentialAnimation{
            id: accesspageanimquit
            running: false
            NumberAnimation{
                target: accesspage
                easing.amplitude: 0.5
                from: 0
                to: mainwnd.width
                properties: "x"
                easing.type: Easing.OutCirc
                duration: 500
            }
            onStarted: {
                flick.enabled = true
                flick.visible = true
            }
            onStopped: accesspage.visible = false

        }

    }








































    BusyIndicator {
        id: bigbusy
        opacity: 0
        running: (myClient.isAuth()) ? true : false
        //running:
        width: parent.width / 3
        height: parent.width / 3
        anchors.centerIn: parent


        OpacityAnimator {
            id: bigbusyappear
            target: bigbusy;
            from: 0;
            to: 1;
            duration: 1300
            running: true
            easing.type: Easing.InOutExpo
        }


        contentItem: Item {
            id: item
            // x: parent.width / 2 - 32
            // y: parent.height / 2 - 32
            //anchors.fill: parent
            //width: 64
            //height: 64
            opacity: bigbusy.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 1700
                }
            }

            RotationAnimator {
                target: item
                running: bigbusy.visible && bigbusy.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 1100
            }

            Repeater {
                id: repeater
                model: 6

                Rectangle {
                    x: item.width / 2 - width / 11
                    y: item.height / 2 - height / 11
                    implicitWidth: 70
                    implicitHeight: 70
                    radius: 50
                    color: "#4B94FF"
                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.5 + 5
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: 5
                            origin.y: 5
                        }
                    ]
                }
            }

        }

    }

}






























































