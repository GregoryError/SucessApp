//import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Controls 2.2


Item {
    id: mainTP

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }





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
                font.pointSize: 13
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
                font.pointSize: 13
                text: " Условия принимаю"

                indicator: Rectangle {
                    implicitWidth: 80
                    implicitHeight: 80
                    x: control.leftPadding
                    y: parent.height / 2 - height / 2
                    radius: 3
                    border.color: "#0074e4"
                    //color: "#0074e4"

                    Rectangle {
                        width: 70
                        height: 70
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
            Button{
                id: trustButton
                enabled: control.checked ? true : false
                opacity: 0
                anchors.horizontalCenter: trustedTXT.horizontalCenter
                anchors.top: control.bottom
                anchors.topMargin: 50
                width: backRect.width / 2
                height: backRect.width / 4
                background: Rectangle{
                    id: trustButtonStyle
                    anchors.fill: parent
                    color: "#93deff"
                    radius: 9

                }
                Text {
                    id: trButtTxt
                    anchors.centerIn: parent
                    font.family: gotham_XNarrow.name;
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





}
