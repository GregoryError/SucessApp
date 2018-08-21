import QtQuick 2.9
//import QtQuick.Controls 2.2



Item {
    //anchors.fill: parent
    id: mainwnd

    Rectangle{
        anchors.fill: parent
        color: "#f7f7f7"


        FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }


        Connections{
            target: myClient
            onStartReadPays: {
                paytimer.start()
            }
        }

        Timer {
            id: paytimer
            interval: 3000;  ////////////////////////////////////////////////

            running: true

            onTriggered:{

                payModel.clear()

                myClient.showPayments();

                for(var i = 0; i < myClient.payTableLength(); ++i)
                {
                    payModel.append({"date": myClient.givePayTime(i),
                                        "cash": myClient.givePayCash(i),
                                        "comment": myClient.givePayComm(i)})
                }

                console.log("Timer event!")   // <- is working

            }
        }

        ListView{
            id: payListView
            visible: true
            anchors.fill: parent
            width: mainwnd.width
            height: mainwnd.height
            smooth: true
            focus: true
            maximumFlickVelocity: 1000000
            //headerPositioning: ListView.PullBackHeader
            clip: true
            spacing: 20
            anchors.topMargin: 20
            delegate: paydelegate
            model:   ListModel {
                id: payModel
            }



        }


        Component{
            id: paydelegate
            Item {
                width: mainwnd.width - 20
                height: mainwnd.height / 5
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: payUnit
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: mainwnd.width - 20
                    height: mainwnd.height / 5
                    radius: 8
                    //color: "steelblue"
                    color: "white"
                    Rectangle{
                        id: payUnitLine
                        anchors.top: payUnit.top
                        anchors.topMargin: payUnit.height / 3
                        height: 3
                        width: payUnit.width - 20
                        color: "#f7f7f7"
                    }

                    Rectangle{
                        id: kindOfPay
                        width: 10
                        height: 10
                        radius: 30
                        color: cash[0] === '-'? "red" : "lightgreen"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 15
                        anchors.verticalCenter: payCash.verticalCenter
                    }

                    Text {
                        id: payDate
                        text: date
                        font.family: gotham_XNarrow.name;
                        font.pointSize: 24
                        color: "#0074e4"
                        anchors.right: payUnit.right
                        anchors.rightMargin: 20
                        anchors.top: payUnit.top
                        anchors.topMargin: 20
                    }

                    Text {
                        id: payCash
                        text: cash
                        font.family: gotham_XNarrow.name;
                        font.pointSize: 20
                        color: "gray"
                        anchors.left: payUnit.left
                        anchors.leftMargin: 40
                        anchors.top: payUnit.top
                        anchors.topMargin: 20
                    }
                    Text {
                        id: payComment
                        text: comment
                        font.family: gotham_XNarrow.name;
                        font.pointSize: 8
                        color: "black"
                        anchors.top: payUnitLine.bottom
                        anchors.topMargin: 5
                        anchors.horizontalCenter: payUnitLine.horizontalCenter
                    }


                }
            }
        }

    }

}




















