import QtQuick 2.9
import QtGraphicalEffects 1.0

Item {
    //anchors.fill: parent
    id: mainwnd

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }


    Rectangle{
        anchors.fill: parent
        id: backRect
        color: "#f8f8ff"
        //color: "#606470"


        Connections{
            target: myClient
            onStartReadPays: {
                //paytimer.start()




                payModel.clear()

                //myClient.showPayments();

                for(var i = 0; i < myClient.payTableLength(); ++i)
                {
                    if (myClient.givePayCash(i)[0] !== '0')
                        payModel.append({"date": myClient.givePayTime(i),
                                            "cash": myClient.givePayCash(i),
                                            "comment": myClient.givePayComm(i)})
                }

                console.log("Timer event!")   // <- is working







            }
        }

        // Timer {
        //     id: paytimer
        //     interval: 3000;  ////////////////////////////////////////////////
        //
        //     running: true
        //
        //     onTriggered:{
        //
        //         payModel.clear()
        //
        //         myClient.showPayments();
        //
        //         for(var i = 0; i < myClient.payTableLength(); ++i)
        //         {
        //             if (myClient.givePayCash(i)[0] !== '0')
        //                 payModel.append({"date": myClient.givePayTime(i),
        //                                     "cash": myClient.givePayCash(i),
        //                                     "comment": myClient.givePayComm(i)})
        //         }
        //
        //         console.log("Timer event!")   // <- is working
        //
        //     }
        // }

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
            anchors.topMargin: 25
            delegate: paydelegate
            model:   ListModel {
                id: payModel
            }



        }


        Component{
            id: paydelegate
            Item {
                width: mainwnd.width
                height: mainwnd.height / 5
                anchors.horizontalCenter: parent.horizontalCenter
                Rectangle{
                    id: payUnit
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    width: mainwnd.width - 20
                    height: parent.height - 4
                    radius: 8
                    Rectangle{
                        id: payUnitLine
                        anchors.top: payUnit.top
                        anchors.topMargin: payUnit.height / 3
                        height: 3
                        width: payUnit.width - 20
                        color: backRect.color
                    }

                    Rectangle{
                        id: kindOfPay
                        width: 12
                        height: 12
                        radius: 30
                        color: cash[0] === '-'? "#ff5c5c" : "lightgreen"
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
                        anchors.right: payUnit.right
                        anchors.rightMargin: 20
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

                    // layer.enabled: true
                    // layer.effect: DropShadow {
                    //     id: payDelegatShadow
                    //     opacity: 0
                    //     transparentBorder: true
                    //     samples: 30
                    //     radius: 10
                    //     color: "lightgray"
                    //
                    // }

                    border.color: "#E3EAEA"
                    border.width: 0.5



                }
            }
        }

    }

}




















