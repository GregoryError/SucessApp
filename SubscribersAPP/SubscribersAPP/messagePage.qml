import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: mainMsg
    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }


    Connections{
        target: myClient

        onStartReadMsgs: {

            msgModel.clear();
            inputLine.clear();

            for (var i = 0; i < myClient.msgMapSize(); ++i)
            {


                msgModel.append({"txt": myClient.giveMsgLine(myClient.giveMsgTime(i)),
                                    "time": myClient.convertTime(myClient.giveMsgTime(i))});
            }
            msgView.model = msgModel
            myClient.makeBusyOFF();
            msgView.positionViewAtEnd();
        }

    }



    Rectangle{
        id: backRect
        anchors.fill: parent
        color: "#e6f8ff"

        Image {
            id: backGroundTP
            source: "qrc:/trustedBack.png"
            width: backRect.width
            height: backRect.height
            opacity: 0.2
        }



        ListModel {
            id: msgModel
        }

        ListView{
            id: msgView
            anchors.top: backRect.top
            anchors.topMargin: 3
            anchors.bottomMargin: 3
            anchors.bottom: inputLine.top
            anchors.left: backRect.left
            anchors.right: backRect.right
            clip: true
            maximumFlickVelocity: 1000000
            spacing: 20
            delegate: msgDelegate





        }

        Component{
            id: msgDelegate


            Rectangle{
                id: msgUnit
                radius: 5
                color: content.text[0] === "Y"? "#f7f7f7" : "#93deff"
                opacity: 0.8
                height: content.paintedHeight + msgTime.height + 20
                width:  msgTime.paintedWidth > content.paintedWidth? msgTime.paintedWidth + 20 : content.paintedWidth + 20


                x: content.text[0] === "O"? 5 : mainMsg.width - (width + 5)


                Rectangle{
                    id: onlyTxtRect
                    anchors.left: msgUnit.left
                    anchors.right: msgUnit.right
                    anchors.top: msgUnit.top
                    anchors.bottom: msgUnit.bottom
                    anchors.topMargin: 4
                    anchors.rightMargin: 4
                    anchors.leftMargin: 4
                    anchors.bottomMargin: 30
                    color: "transparent"
                    // color: "red"

                    Text {
                        id: content
                        font.pointSize: 14
                        width: mainMsg.width - 100
                        wrapMode: Text.Wrap
                        anchors.margins: 8
                        //anchors.centerIn: msgUnit
                        color: "#323643"
                        text: txt
                    }


                }

                Text {
                    id: msgTime
                    //anchors.top: onlyTxtRect.bottom
                    anchors.topMargin: 7
                    anchors.right: msgUnit.right
                    anchors.rightMargin: 7
                    anchors.bottom: msgUnit.bottom
                    anchors.bottomMargin: 7
                    wrapMode: Text.Wrap
                    font.family: gotham_XNarrow.name;
                    font.pointSize: 16
                    fontSizeMode: Text.Fit
                    color: "#606470"
                    text: time

                }
            }
        }










        Rectangle{
            id: textBack
            anchors.bottom: inputLine.bottom
            width: mainMsg.width
            height: inputLine.height
            color: "#f7f7f7"

        }

        TextField{
            id: inputLine
            width: mainMsg.width - sendButt.width
            height: mainMsg.height * 0.1
            anchors.bottom: backRect.bottom
            anchors.left: backRect.left
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }
            color: "#323643"
            font.pointSize: 18
            font.family: gotham_XNarrow.name;
            placeholderText: "Сообщение... "
            maximumLength: 300
            wrapMode: Text.Wrap


            //  onTextChanged: {
            //      if (!sendButt.opacity > 0)
            //          arrowAnim.running = true
            //      if (!inputLine.text.length > 0)
            //          arrowDisAnim.running = true
            //  }


        }
        Button{
            id: sendButt
            enabled: false
            opacity: 0
            visible: false
            width: inputLine.height
            height: width
            anchors.bottom: backRect.bottom
            anchors.right: backRect.right
            background: Image {
                id: sendArrow
                anchors.centerIn: parent
                source: "qrc:/Menu/right-arrow-icon.png"
                width: sendButt.width * 0.8
                height: sendButt.height * 0.8
            }
            onPressed: {
                myClient.sendMsgs(inputLine.text);
                myClient.askForMsgs();
            }

            OpacityAnimator{
                id: arrowAnim
                running: inputLine.focus? true : false
                target: sendButt
                from: 0
                to: 1
                duration: 500
                onStarted: {
                    sendButt.visible = true
                }

                onStopped: {
                    sendButt.enabled = true
                }


            }

            OpacityAnimator{
                id: arrowDisAnim
                target: sendButt
                from: 1
                to: 0
                duration: 400
                running: inputLine.focus? false : true
                onStopped: {
                    sendButt.visible = false
                    sendButt.enabled = false
                }
            }
        }
    }
}













