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

        Text {
            id: payTxt
            anchors.top: parent.top
            anchors.topMargin: 40
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: gotham_XNarrow.name;
            font.pointSize: 40
            color: "#f7f7f7"
            text: "Оплата"
        }









        ListModel {
            id: payWayModel
            ListElement {
                date: "Как оплатить?"
                cash: ""
                comment: "Узнайте способы оплаты услуг"
            }

            ListElement {

                date: "Точки оплаты"
                cash: ""
                comment: "Найдите терминал поблизости"
            }

            ListElement {

                date: "Временный платеж"
                cash: ""
                comment: "Воспользуйтесь, если не успеваете оплатить услуги."
            }

        }

        ListView{
            id: payWayListView
            visible: true
            interactive: false
            smooth: true
            width: mainwnd.width
            height: mainwnd.height// - payTxt.height
            anchors.top: payTxt.bottom
            anchors.topMargin: 40
            anchors.bottom: parent.bottom

            spacing: 20

            delegate: payWaydelegate
            model: payWayModel

        }


        Component{
            id: payWaydelegate
            Item {

                MouseArea{
                    anchors.fill: parent

                    onClicked: console.log("IT WORKS");
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
                        font.pointSize: 22
                        color: "#0074e4"
                        anchors.horizontalCenter: payUnit.horizontalCenter
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }

                    Text {
                        id: payCash
                        text: cash
                        font.family: gotham_XNarrow.name;
                        font.pointSize: 20
                        color: "gray"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 40
                        anchors.verticalCenter: kindOfPay.verticalCenter
                    }


                    Rectangle{
                        id: commentItem
                        anchors.horizontalCenter: payUnit.horizontalCenter
                        anchors.top: payUnitLine.bottom
                        anchors.topMargin: 6
                        anchors.bottomMargin: 6
                        width: payUnit.width - 45
                        height: (payUnit.height - payUnit.height / 3) - 20
                        color: "transparent"
                        //color: "gray"

                        Text {
                            id: payComment
                            text: comment
                            font.family: gotham_XNarrow.name;
                            //font.pointSize: 8
                            minimumPointSize: 7
                            font.pointSize: 15
                            fontSizeMode: Text.Fit
                            width: parent.width
                            height: parent.height
                            color: "black"
                            anchors.topMargin: 5
                            anchors.horizontalCenter: commentItem.horizontalCenter
                        }

                    }



                    border.color: "#E3EAEA"
                    border.width: 0.5



                }
            }
        }


    }

}
