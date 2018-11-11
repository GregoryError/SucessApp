import QtQuick 2.0

Item {
    id: mainwnd

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }

    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#e6f8ff"

        Component.onCompleted:
        {
            myClient.makeBusyOFF();
            focus = true;
        }



        Image {
            id: backGroundTP
            source: "qrc:/trustedBack.png"
            width: backRect.width
            height: backRect.height
            opacity: 0.3
        }



        Flickable{
            id: payListFlick
            anchors.top: backRect.top
            anchors.topMargin: 15
            anchors.horizontalCenter: backRect.horizontalCenter
            clip: true
            width: backRect.width
            height: backRect.height
            contentHeight: payWayListView.height * 1.2
            contentWidth: backRect.width


            Text {
                id: payTxt
                // anchors.top: parent.top
                anchors.top: payListFlick.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter
                font.family: gotham_XNarrow.name;
                font.pointSize: 30
                color: "#f7f7f7"
                text: "Способы оплаты:"
            }



            ListModel {
                id: payWayModel
                ListElement {
                    date: "Через Сбербанк-онлайн"
                    cash: ""
                    comment: ""
                    commentImg: "qrc:/PaySystems/logo-sberbank-online.png"
                }

                ListElement {

                    date: "Через терминал"
                    cash: ""
                    comment: ""
                    commentImg:"qrc:/PaySystems/SbTerminal.png"
                }

                ListElement {

                    date: "Через Яндекс-деньги"
                    cash: ""
                    comment: ""
                    commentImg: "qrc:/PaySystems/yandex.dengi_horizontal_rgb-01.png"
                }

                ListElement {

                    date: "Платежная система QIWI"
                    cash: ""
                    comment: ""
                    commentImg: "qrc:/PaySystems/qiwi_logo_rgb.png"
                }

                ListElement {

                    date: "Через Тинькофф"
                    cash: ""
                    comment: ""
                    commentImg: "qrc:/PaySystems/tinkoff-bank-general-logo-2.png"
                }

                ListElement {

                    date: ""
                    cash: "Найти точку оплаты"
                    comment: ""
                    commentImg: "qrc:/PaySystems/PayPoints.png"
                }

                ListElement {

                    date: ""
                    cash: "Подключить доверительный платеж"
                    comment: ""
                    commentImg: "qrc:/Menu/trusted.png"
                }



            }

            ListView{
                id: payWayListView
                visible: true
                interactive: false
                //clip: true
                // smooth: true
                width: mainwnd.width
                height: payWayModel.count * (mainwnd.height / 5) //mainwnd.height * 5// - payTxt.heigh
                anchors.top: payTxt.bottom
                anchors.topMargin: 15
                anchors.horizontalCenter: payListFlick.horizontalCenter
                //anchors.bottom: parent.bottom

                spacing: 10

                delegate: payWaydelegate
                model: payWayModel

            }


        }




        Component{
            id: payWaydelegate
            Item {

                MouseArea{
                    anchors.fill: parent

                    onClicked: console.log("IT WORKS" + index);
                }



                width: mainwnd.width
                height: mainwnd.height / 5
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: payUnit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: mainwnd.width - 30
                    height: parent.height - 4
                    radius: 8
                    Rectangle{
                        id: payUnitLine
                        anchors.top: payUnit.top
                        anchors.topMargin: payUnit.height / 3
                        height: 3
                        width: payUnit.width - 20
                        color: backRect.color
                        border.width: 1
                        border.color: "#E3EAEA"
                    }

                    Rectangle{
                        id: kindOfPay
                        width: 12
                        height: 12
                        radius: 30
                        color: "#93deff"  //cash[0] === '-'? "#93deff" : "lightgreen"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 15
                        y: payUnit.y + (payUnit.height / 3) * 0.4
                    }

                    Text {
                        id: payDate
                        text: date
                        font.family: gotham_XNarrow.name;
                        minimumPointSize: 7
                        font.pointSize: 16
                        fontSizeMode: Text.Fit
                        width: payUnit.width - 15
                        color: "#0074e4"
                        anchors.left: kindOfPay.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }

                    Text {
                        id: payCash
                        text: cash
                        font.family: gotham_XNarrow.name;
                        minimumPointSize: 7
                        font.pointSize: 16
                        fontSizeMode: Text.Fit
                        width: payUnit.width - 15
                        color: "#264e86"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }


                    Rectangle{
                        id: commentItem
                        anchors.horizontalCenter: payUnit.horizontalCenter
                        anchors.top: payUnitLine.bottom
                        anchors.topMargin: 4
                        anchors.bottomMargin: 4
                        width: payUnit.width - 30
                        height: (payUnit.height - payUnit.height / 3) - 20
                        color: "transparent"
                        //color: "gray"

                        Image {
                            id: commentImage
                            source: commentImg
                            anchors.centerIn: parent
                            width: commentItem.width * 0.8
                            height: commentItem.height  * 0.8
                            fillMode: Image.PreserveAspectFit
                            //height: width

                        }


                    }



                    border.color: "#E3EAEA"
                    border.width: 0.5



                }
            }
        }


    }

}
