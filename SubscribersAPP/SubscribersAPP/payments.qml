import QtQuick 2.9
import QtQuick.Controls 2.2







Item {
    //anchors.fill: parent
    id: mainwnd
    objectName: "payments"

    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }



    Connections{
        target: myClient
        onStartReadPays: {
            paytimer.running = true
        }
    }



    Timer {
        id: paytimer
        interval: 3000;

        running: false

        onTriggered:{

            payModel.clear()

            myClient.showPayments();
            console.log(myClient.payTableLenght())


            payModel.append({"date": "test"});





            for(var i = 0; i < myClient.payTableLenght(); ++i)
            {

                payModel.append({"date": myClient.givePayTime(i),
                                    "cash": myClient.givePayCash(i),
                                    "comment": myClient.givePayComm(i)})


            }


            payListView.model = payModel
            payListView.delegate = paydelegate

        }
    }








    ListView{
        id: payListView
        anchors.fill: parent
        width: mainwnd.width
        height: mainwnd.height
        smooth: true
        focus: true
        maximumFlickVelocity: 1000000
        headerPositioning: ListView.OverlayHeader
        spacing: 3
       // delegate: paydelegate
       // model: payModel

    }





    ListModel {
        id: payModel


         ListElement {
        //     date: ""
        //     cash: ""
        //     comment: ""
         }
    }
    Component{
        id: paydelegate
        Item {
            width: 400
            height: 200
            Row{
                anchors.centerIn: parent
                spacing: 3
                Rectangle{
                    height: 90
                    width: 150
                    color: "lightgreen"
                    Text {
                        anchors.centerIn: parent;
                        id: dates
                        color: "steelblue"
                        font.pointSize: 12
                        text: date
                    }
                }

                Rectangle{
                    height: 90
                    width: 150
                    color: "lightgreen"
                    Text {
                        anchors.centerIn: parent;
                        id: cashes
                        color: "steelblue"
                        font.pointSize: 12
                        text: cash
                    }
                }

                Rectangle{
                    height: 90
                    width: 150
                    color: "lightgreen"
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




















