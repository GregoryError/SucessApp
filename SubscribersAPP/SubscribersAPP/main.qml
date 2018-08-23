import QtQuick 2.9
import QtQuick.Controls 2.2
//import QtQuick 2.11

import QtGraphicalEffects 1.0
import QtQuick.Window 2.3

import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1


ApplicationWindow {
    id: window

    visible: true
    // width: 540
    // height: 960
    width: 430
    height: 850
    // width: 1080
    // height: 1920
    //width: Screen.width
    //height: Screen.height



    Rectangle{
        id: startHead
        visible: myClient.isAuth() ? false : true
        width: window.width
        height: 66
        x: 0
        y: 0
        color: "#93deff"


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
        visible: myClient.isAuth() ? false : true
        width: window.width * 0.6
        height: window.height * 0.5
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
            duration: 1500
            running: true
            easing.type: Easing.InOutExpo
        }

        OpacityAnimator {
            id: disappearStartForm
            target: startform;
            from: 1;
            to: 0;
            duration: 1000
            running: false
            easing.type: Easing.InOutExpo

            onStopped: {
                startform.visible = false
                startform.enabled = false
            }
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

                            bigbusy.running = true

                            loginButtoncolorRect.x = mouseX
                            loginButtoncolorRect.y = mouseY
                            loginButtoncircleAnimation.start()
                            loginButtonOpacityAnimation.start()

                            myClient.setAuthData(nameInput.text, passwordInput.text);

                            console.log(nameInput.text, passwordInput.text)


                            //firsttimer.running = true

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




    Connections{
        target: myClient
        onSwitchToHomePage: {
            if(myClient.isAuthRight()){

                bigbusy.running = false
                disappearStartForm.running = true
            }else{
                messageDialog.text = myClient.authResult();
                bigbusy.running = false
                messageDialog.visible = true;
            }

        }

        onBusyON:{
            bigbusy.running = true;
        }

        onBusyOFF:{
            bigbusy.running = false;
        }
    }


    //  Timer {
    //      id: firsttimer
    //      interval: 2000;
    //
    //      running: (myClient.isAuth()) ? true : false
    //
    //
    //      onTriggered:{
    //
    //          if(myClient.isAuthRight()){
    //
    //              bigbusy.running = false
    //
    //              disappearStartForm.running = true
    //
    //              myClient.fillHomePage()    // this emit signal to QML to update info
    //
    //          }else{
    //              messageDialog.text = myClient.authResult();
    //              bigbusy.running = false
    //              messageDialog.visible = true;
    //              infoRect.visible = false
    //          }
    //
    //
    //      }
    //  }
    //
    //


    //////////////////////////////////////////// END OF START-FORM ///////////////////////////////////////////////




    Item {
        id: workItem
        anchors.fill: parent
        visible: startform.visible? false : true
        enabled: startform.visible? false : true




        Rectangle{                        // Временный фон на период разработки
            id: tempRect
            width: window.width
            height: window.height * 0.3 + 50
            x: 0
            y: 0
            color: "steelblue"
            layer.enabled: true
            layer.effect: DropShadow {
                id: backhadow
                transparentBorder: true
                samples: 30
                radius: 12
                color: "#606470"

            }

        }



        //
        // LinearGradient {
        //     width: window.width
        //     height: window.height * 0.3 + 50
        //     x: 0
        //     y: 0
        //     //visible: false
        //     start: Qt.point(0, 0)
        //     end: Qt.point(window.width, window.width)
        //     gradient: Gradient {
        //         GradientStop { position: 0.0; color: "#93deff" }
        //         GradientStop { position: 0.2; color: "#638AA1" }
        //         GradientStop { position: 0.4; color: "#4B6072" }
        //         GradientStop { position: 0.7; color: "#323643" }
        //         GradientStop { position: 1.0; color: "#323643" }
        //     }
        // }

        FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }

        //   header:

        //     Item{
        //         x: 0
        //         y: 0
        //         id: bar
        //         width: window.width
        //         height: 50
        //         ToolBar {
        //             contentHeight: toolButton.implicitHeight
        //             anchors.fill: parent
        //
        //
        //             background: Rectangle {
        //                 //color: "transparent"
        //                  color: "green"
        //             }
        //
        //
        //             ToolButton {
        //                 id: toolButton
        //                 ////text: stackView.depth > 1 ? "\u25C0" : "\u2630"
        //                 ////font.pixelSize: Qt.application.font.pixelSize * 1.6
        //                 anchors.verticalCenter: bar.verticalCenter
        //                 background: Rectangle {
        //                     anchors.fill: parent
        //                     //color: "transparent"
        //                     color: "red"
        //                    // Image {
        //                    //     id: toolImg
        //                    //     width: 20
        //                    //     height: 15
        //                    //     source: stackView.depth > 1 ? "qrc:/arrow_left.png" : "qrc:/toolPic.png"
        //                    //     anchors.centerIn: parent
        //                    // }
        //                 }
        //
        //                 onClicked: {
        //                     if (stackView.depth > 1) {
        //                         stackView.pop()
        //                     } else {
        //                         drawer.open()
        //                     }
        //                 }
        //             }
        //
        //             Label {
        //                 text: stackView.currentItem.title
        //                 anchors.centerIn: parent
        //             }
        //         }
        //
        //     }





        Item{
            id: bar
            x: 0
            y: 0
            width: window.width
            height: 66
            //color: "#323643"
            //opacity: 0
            z: 3
            clip: true


            Image {
                id: logoPic
                source: "qrc:/RotatingLogo.png"
                smooth: true
                scale: 0.3
                anchors.horizontalCenter: bar.horizontalCenter
                anchors.verticalCenter: bar.verticalCenter

            }


            Rectangle{                     // add background if use "Toolbutton"
                id: toolRect
                anchors.verticalCenter: logoPic.verticalCenter
                color: "transparent"
                radius: 25
                width: toolPic.width * 3.5
                height: toolPic.height * 3.5
                x: 15
                // y: 15
                clip: true
                smooth: true



                Image {
                    id: toolPic
                    //source: "qrc:/toolPic.png"
                    source: stackView.depth > 1 ? "qrc:/arrow_left.png" : "qrc:/toolPic.png"
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
                duration: 300

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
                duration: 300

            }


        }



        Drawer {
            id: drawer
            width: window.width * 0.66
            height: window.height
            dragMargin: 40

            enter:Transition {
                NumberAnimation { property: "position"; easing.type: Easing.OutSine /*from: 0.0; to:1; duration: 70 */}
            }


            Column {
                anchors.fill: parent

                ItemDelegate {
                    text: qsTr("Выход")
                    width: parent.width
                    onClicked: {

                        myClient.quitAndClear()
                        stackView.push("Page1Form.ui.qml")
                        drawer.close()
                    }
                }
                ItemDelegate {
                    text: qsTr("Платежи")
                    width: parent.width
                    onClicked: {
                        myClient.askForPayments();
                        stackView.push("payments.qml");
                        bigbusy.running = true;
                        drawer.close()
                    }
                }
            }
        }


        Item {
            id: mainField
            anchors.top: bar.bottom
            width: window.width
            height: window.height - bar.height


            StackView {
                id: stackView
                //antialiasing: true

                focus: true
                Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                                     stackView.pop();
                                     event.accepted = true;
                                 }

                initialItem: "homePage.qml"
                anchors.fill: parent

                pushEnter: Transition {
                    PropertyAnimation {
                        property: "opacity"
                        from: 0
                        to:1
                        duration: 130
                    }
                }


                popEnter: Transition {
                    XAnimator {
                        from: (stackView.mirrored ? -1 : 1) * -stackView.width
                        to: 0
                        duration: 650
                        easing.type: Easing.OutCubic
                    }
                }



                popExit: Transition {
                    XAnimator {
                        from: 0
                        to: (stackView.mirrored ? -1 : 1) * stackView.width
                        duration: 80
                        easing.type: Easing.OutCubic
                    }
                }


                // popExit: Transition {
                //         PropertyAnimation {
                //             property: "opacity"
                //             from: 1
                //             to:0
                //             duration: 150
                //         }
                //     }
                //

            }
        }

    }




    BusyIndicator {
        id: bigbusy
        opacity: 0
        running: false
        width: parent.width / 3
        height: parent.width / 3


        anchors.centerIn: parent
        z: 3

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
                duration: 2000
            }

            Repeater {
                id: repeater
                model: 6
                Rectangle{
                    id: itemRec
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - width / 2
                    implicitWidth: window.width / 22
                    implicitHeight: window.width / 22
                    //radius: 50
                    radius: 10
                    color: "#2284e0"
                    transform: [
                        Translate {
                            id: trans
                            y: -Math.min(item.width, item.height) * 0.3

                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: width / 2
                            origin.y: height / 2
                        }




                    ]

                    SequentialAnimation{
                        running: bigbusy.running == true ? true : false
                        loops:  Animation.Infinite

                        NumberAnimation {
                            running: true
                            target: trans
                            property: "y";
                            easing.type: Easing.OutQuart
                            from: 1
                            to: -Math.min(item.width, item.height) * 0.8
                            duration: 1000

                        }

                        NumberAnimation {
                            running: true
                            target: trans
                            property: "y";
                            easing.type: Easing.InQuart
                            to: 1
                            from: -Math.min(item.width, item.height) * 0.8
                            duration: 1000

                        }

                    }
                }
            }

        }

    }

}
























































