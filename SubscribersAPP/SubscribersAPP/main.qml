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
    // width: Screen.width
    // height: Screen.height



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
                        height: 10
                        width: 10
                        visible: false
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
                            loginButtonOpacityAnimation.start()

                            myClient.setAuthData(nameInput.text, passwordInput.text);

                            console.log(nameInput.text, passwordInput.text)

                            bigbusy.running = true
                            firsttimer.running = true

                        }
                    }

                    PropertyAnimation {
                        id: loginButtoncircleAnimation
                        target: loginButtoncolorRect
                        properties: "width,height,radius"
                        from: loginButtoncolorRect.width
                        to: order.width * 2
                        duration: 250

                        onStarted: {
                            loginButtoncolorRect.visible = true
                        }

                        onStopped: {
                            loginButtoncolorRect.width = 10
                            loginButtoncolorRect.height = 10
                            loginButtoncolorRect.visible = false
                        }
                    }


                    PropertyAnimation {
                        id: loginButtonOpacityAnimation
                        target: loginButtoncolorRect
                        properties: "opacity"
                        from: 1
                        to: 0
                        duration: 300

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
                        height: 10
                        width: 10
                        visible: false
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
                            orderButtonCircleAnimation.start()
                        }


                        onClicked:{
                            //circleAnimation.stop()
                            console.log("guest")
                        }

                    }
                }

                PropertyAnimation {
                    id: orderButtonCircleAnimation
                    target: ordercolorRect
                    properties: "width,height,radius"
                    from: ordercolorRect.width
                    to: order.width * 2
                    duration: 250
                    easing.type: Easing.OutExpo

                    onStarted: {
                        ordercolorRect.visible = true
                        orderButtonOpacityAnimation.start()
                    }

                    onStopped: {
                        ordercolorRect.width = 10
                        ordercolorRect.height = 10
                        ordercolorRect.visible = false
                    }
                }
                PropertyAnimation {
                    id: orderButtonOpacityAnimation
                    target: ordercolorRect
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 300

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


    Item {
        id: mainItem
        width: mainwnd.width
        height: mainwnd.height - head.height
        anchors.top: head.bottom








        Rectangle{
            id: flick
            width: mainwnd.width
            height: head.height + infoRect.height
            //anchors.fill: parent
            // color: "steelblue"
            x: 0
            y: 0
            z: 0

            // visible: (myClient.isAuth()) ? true : false
            opacity: 0
            visible: false  // (myClient.isAuth()) ? true : false




            OpacityAnimator {
                id: flickappear
                target: flick;
                from: 0;
                to: 1;
                duration: 600
                running: false
                //running: (myClient.isAuth()) ? true : false
                onStopped: {
                    cells.visible = true
                }


            }


            color: "steelblue"


            //   LinearGradient {
            //      anchors.fill: parent
            //      //visible: false
            //      start: Qt.point(0, 0)
            //      end: Qt.point(mainwnd.width, mainwnd.width)
            //      gradient: Gradient {
            //          GradientStop { position: 0.0; color: "#93deff" }
            //          GradientStop { position: 0.2; color: "#638AA1" }
            //          GradientStop { position: 0.4; color: "#4B6072" }
            //          GradientStop { position: 0.7; color: "#323643" }
            //          GradientStop { position: 1.0; color: "#323643" }
            //      }
            //  }


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
                        anchors.centerIn: toolRect
                    }

                    Rectangle {
                        id: toolButtoncolorRect
                        height: 0
                        width: 0
                        anchors.centerIn: toolRect
                        color: "#93deff"

                        transform: Translate {
                            // x: -toolButtoncolorRect.width / 2
                            // y: -toolButtoncolorRect.height / 2
                        }
                    }

                    MouseArea{
                        id: toolButton
                        anchors.fill: parent
                        onPressed: {

                            //toolButtoncolorRect.x = mouseX
                            //toolButtoncolorRect.y = mouseY
                            toolButtoncircleAnimation.start()
                            toolButtonOpacityAnimation.start()

                        }
                    }
                }

                PropertyAnimation {
                    id: toolButtoncircleAnimation
                    target: toolButtoncolorRect
                    properties: "width,height,radius"
                    from: 0
                    to: toolRect.width * 0.8
                    duration: 170

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


                PropertyAnimation {
                    id: toolButtonOpacityAnimation
                    target: toolButtoncolorRect
                    properties: "opacity"
                    from: 1
                    to: 0
                    duration: 250

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
                    font.pointSize: 24
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
                    backdata: "qrc:/Menu/activity.png"
                    active: true
                    mtext: "Моя активность"
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
                width: mainwnd.width - 30
                height: mainwnd.height - flick.height
                anchors.horizontalCenter: infoRect.horizontalCenter
                radius: 2
                anchors.top: infoRect.bottom
                anchors.topMargin: -15
                // color: "transparent"

                // clip: true
                smooth: true

                layer.enabled: true
                layer.effect: DropShadow {
                    id: bigMenushadow
                    transparentBorder: true
                    samples: 30
                    radius: 12
                    color: "#606470"

                }






                //
                // LinearGradient {
                //     anchors.fill: parent
                //     source: bigMenu
                //     start: Qt.point(0, 0)
                //     end: Qt.point(cells.width, cells.width)
                //     gradient: Gradient {
                //         GradientStop { position: 0.2; color: "#f7f7f7" }
                //         GradientStop { position: 0.5; color: "#93deff" }
                //         GradientStop { position: 0.8; color: "#f7f7f7" }
                //     }
                // }



                GridView{
                    id: cells
                    interactive: false
                    visible: false
                    anchors.centerIn: parent
                    smooth: true

                    width: cellWidth * 2
                    height: cellHeight * 3

                    cellHeight: bigMenu.height / 3
                    cellWidth: bigMenu.width / 2


                    model: myModel


                    //   Rectangle{
                    //       id: cellBack
                    //       anchors.fill: parent
                    //       color: "#f7f7f7"
                    //       width: cells.width
                    //       height: cells.height
                    //       z: 0
                    //   }



                    //clip: true
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


                                    console.log(index)


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



                                ParallelAnimation {
                                    id: cellButtoncircleAnimation

                                    NumberAnimation {
                                        //id: cellButtoncircleAnimation
                                        target: bigMenucolorRect;
                                        properties: "width,height,radius";
                                        from: bigMenucolorRect.width;
                                        to: buttons.width * 1.8;
                                        duration: 1400;
                                        easing.type: Easing.OutExpo

                                    }


                                    NumberAnimation {
                                        id: cellButtonOpacityAnimation
                                        target: bigMenucolorRect;
                                        easing.type: Easing.InExpo;
                                        properties: "opacity";
                                        from: 0.6;
                                        to: 0;
                                        duration: 450;

                                    }


                                    ColorAnimation {
                                       target: backOfCell
                                       property: "color"
                                       duration: 1500
                                       from: "#C4EDFF"
                                       to: "#f7f7f7"
                                       easing.type: Easing.InExpo;
                                       }


                                    onStarted: {
                                        bigMenucolorRect.visible = true
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


                    ScaleAnimator{
                        id: cellAppear
                        target: cells
                        running: cells.visible
                        from: 0.7
                        to: 1
                        duration: 200

                        easing.type: Easing.InCirc
                        onStopped: {
                            // some soundeffects
                            // game_engine.soundBegin()
                            //backgroundAppear.start()
                        }
                    }



                    SequentialAnimation{
                        id: cellsExit
                        running: false


                        ParallelAnimation{

                            NumberAnimation{
                                target: cells
                                properties: "scale"
                                from: 1
                                to: 150
                                duration: 700
                                easing.type: Easing.InExpo


                            }
                            NumberAnimation{
                                target: cells
                                properties: "opacity"
                                from: 1
                                to: 0
                                duration: 800
                                easing.type: Easing.InExpo

                            }

                        }

                        onStopped: {


                        }

                    }

                }

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
        initialItem: "flick"
        anchors.fill: parent
    }



    Timer {
        id: firsttimer
        interval: 2000;

        running: (myClient.isAuth()) ? true : false


        onTriggered:{

            if(myClient.isAuthRight()){           // Для теста

                bigbusy.running = false
                //
                disappearStartForm.running = true
                //
                //
                flick.opacity = 0
                mainwnd.visible = true
                toolRect.visible = true
                flick.visible = true
                //
                flickappear.running = true
                //
                //

                billVal.text = myClient.showBill() + "₽"

                // if(myClient.showState() === "off")     // This feature allowed to change balance
                //     bigPaneltext.color = "#B84BFF"     // color, depend of access status.
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
                bigbusy.running = false
                messageDialog.visible = true;
                flick.visible = false
            }


        }
    }





    BusyIndicator {
        id: bigbusy
        opacity: 0
        running: (myClient.isAuth()) ? true : false
        //running:
        width: parent.width / 4 + 10
        height: parent.width / 4 + 10
        anchors.centerIn: parent

        OpacityAnimator {
            id: bigbusyappear
            target: bigbusy;
            from: 0;
            to: 1;
            duration: 600
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
                    duration: 600
                }
            }

            RotationAnimator {
                target: item
                running: bigbusy.visible && bigbusy.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 1200
            }

            Repeater {
                id: repeater
                model: 6
                Rectangle{
                    id: itemRec
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - width / 2
                    implicitWidth: mainwnd.width / 20
                    implicitHeight: mainwnd.width / 20
                    //radius: 50
                    radius: 2
                    color: "#606470"
                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.3
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: width / 2
                            origin.y: height / 2
                        }
                    ]
                }
            }

        }

    }


}























































