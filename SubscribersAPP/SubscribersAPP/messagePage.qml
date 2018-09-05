import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: mainMsg
    FontLoader { id: gotham_XNarrow; source: "/fonts/Gotham_XNarrow.ttf" }


    Connections{
        target: myClient

        onStartReadMsgs: {

            msgModel.clear();

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
            opacity: 0.1
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
                color: "#f7f7f7"
                opacity: 0.9
                height: content.paintedHeight + msgTime.paintedHeight + 50
                width:  msgTime.paintedWidth > content.paintedWidth? msgTime.paintedWidth + 50 : content.paintedWidth + 50


                x: content.text[0] === "Y"? 5 : 25


                Rectangle{
                    id: onlyTxtRect
                    anchors.left: msgUnit.left
                    anchors.right: msgUnit.right
                    anchors.top: msgUnit.top
                    anchors.bottom: msgUnit.border
                    anchors.margins: {
                        left: 7
                        right: 7
                        top: 7
                        bottom: 20
                    }

                    color: "red"

                    Text {
                        id: content
                        font.pointSize: 10
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
                    anchors.topMargin: 7
                    anchors.right: msgUnit.right
                    anchors.rightMargin: 7
                    anchors.bottom: msgUnit.bottom
                    anchors.bottomMargin: 7
                    wrapMode: Text.Wrap
                    font.family: gotham_XNarrow.name;
                    font.pointSize: 12
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
            font.pointSize: 12
            font.family: gotham_XNarrow.name;
            placeholderText: "Сообщение... "
            maximumLength: 300
        }
        Button{
            id: sendButt
            width: inputLine.height
            height: width
            anchors.bottom: backRect.bottom
            anchors.right: backRect.right
            background: Image {
                id: sendArrow
                opacity: 0;
                source: "qrc:/Menu/right-arrow-icon.png"
                width: sendButt.width
                height: sendButt.height
            }

            OpacityAnimator{
                id: arrowAnim
                target: sendArrow
                from: 0
                to: 1
                duration: 400
                running: inputLine.focus === true? true : false
            }
        }
    }
}













