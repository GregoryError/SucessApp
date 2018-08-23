//import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Controls 2.2


Item {
    id: mainTP

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }

    Connections{
        target: myClient
        onTrustedPayDenied:{

        }

        onTrustedPayOk:{

        }
    }





    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#f7f7f7"

        Flickable{
            id: trustedFlick
            width: backRect.width
            height: backRect.height
            anchors.horizontalCenter: backRect.horizontalCenter
            contentHeight: trustButton.y + trustButton.height + 200
            contentWidth: parent.width
            smooth: true
            boundsBehavior: Flickable.StopAtBounds
            interactive: true
            maximumFlickVelocity: 1000000
            clip: true


            Image {
                id: backGroundTP
                source: "qrc:/trustedBack.png"
                width: mainTP.width
                height: trustedFlick.contentHeight
                opacity: 0.1
            }

            Text {
                id: trustedTXT
                anchors.top: parent.top
                anchors.topMargin: 50
                anchors.leftMargin: 50

                anchors.horizontalCenter: parent.horizontalCenter
                font.family: gotham_XNarrow.name;
                font.pointSize: 15
                color: "#0074e4"
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
                anchors.horizontalCenter: trustedTXT.horizontalCenter
                anchors.top: trustedTXT.bottom
                anchors.topMargin: 50
                font.family: gotham_XNarrow.name;
                font.pointSize: 17
                text: " Условия принимаю"

                indicator: Rectangle {
                    implicitWidth: 60
                    implicitHeight: 60
                    x: control.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 3
                    border.color: "#0074e4"
                    //color: "#0074e4"

                    Rectangle {
                        width: 50
                        height: 50
                        anchors.centerIn: parent
                        x: 6
                        y: 6
                        radius: 2
                        color: "#93deff"
                        visible: control.checked
                    }
                }

                contentItem: Text {
                    text: control.text
                    font: control.font
                    opacity: enabled ? 1.0 : 0.3
                    color: "#0074e4"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: control.indicator.width + control.spacing
                }

            }
            MouseArea{
                id: trustButton
                clip: true
                enabled: control.checked ? true : false
                anchors.horizontalCenter: trustedTXT.horizontalCenter
                anchors.top: control.bottom
                anchors.topMargin: 50
                width: backRect.width / 2
                height: backRect.width / 4

                Rectangle{
                    id: backOfButton
                    color: "#93deff" //  93deff  //50a5f5
                    smooth: true
                    anchors.fill: parent
                    radius: 6
                    anchors.margins: 1


                    Rectangle {
                        id: backOfButtoncolorRect
                        height: 0
                        width: 0
                        visible: false
                        color: "#50a5f5"
                        opacity: 0

                        transform: Translate {
                            x: -backOfButtoncolorRect.width / 2
                            y: -backOfButtoncolorRect.height  / 2
                        }
                    }


                    Text {
                        id: trButtTxt
                        anchors.centerIn: parent
                        font.family: gotham_XNarrow.name;
                        font.pointSize: 25
                        color: "white"
                        text: "Подключить"
                    }


                }

                onPressed: {
                    onPressedAnim.running = true
                    //backOfButton.opacity = 0.7
                }

                onReleased: {

                    backOfButtoncolorRect.x = mouseX
                    backOfButtoncolorRect.y = mouseY

                    if(cellButtoncircleAnimation.running)
                        cellButtoncircleAnimation.stop()

                    cellButtoncircleAnimation.start()


                }

                ColorAnimation {
                    id: onPressedAnim
                    running: false
                    target: backOfButton
                    property: "color"
                    duration: 200
                    from: "#93deff"
                    to: "#75bbfb"
                    //easing.type: Easing.InExpo;
                }

                ParallelAnimation {
                    id: cellButtoncircleAnimation

                    NumberAnimation {
                        target: backOfButtoncolorRect;
                        properties: "width,height,radius";
                        from: backOfButtoncolorRect.width;
                        to: trustButton.width;
                        duration: 1100;
                        easing.type: Easing.OutExpo
                    }

                    NumberAnimation {
                        target: backOfButtoncolorRect;
                        //easing.type: Easing.InExpo;
                        properties: "opacity";
                        from: 1;
                        to: 0;
                        duration: 800;
                    }

                    ColorAnimation {
                        target: backOfButton
                        property: "color"
                        duration: 1100
                        from: backOfButton.color
                        to: "#93deff"
                        easing.type: Easing.InExpo;
                    }

                    onStarted: {
                        backOfButtoncolorRect.visible = true

                    }

                    onStopped: {
                        backOfButtoncolorRect.width = 0
                        backOfButtoncolorRect.height = 0
                        backOfButtoncolorRect.visible = false

                    }

                }

            }

        }

    }

}


























