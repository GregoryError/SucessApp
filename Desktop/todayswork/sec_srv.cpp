#include "sec_srv.h"

sec_srv::sec_srv(quint16 nPort, QObject* parent) : QObject(parent), NextBlockSize(0)
{
    srv = new QTcpServer(this);
    if (!srv->listen(QHostAddress::Any, nPort))
    {
        qDebug() << "Server error. Unable start the server:\n"
                    + srv->errorString();
        srv->close();
        return;
    }
   connect(srv, SIGNAL(newConnection()),
           this, SLOT(slotNewConnection()));

}

void sec_srv::slotNewConnection()
{
    QTcpSocket* pSocket = srv->nextPendingConnection();

    connect(pSocket, SIGNAL(disconnected()),
            pSocket, SLOT(deleteLater()));
    connect(pSocket, SIGNAL(readyRead()),
            this, SLOT(slotReadClient()));
    //sendToClient(pSocket, "Response: connected!");
}

void sec_srv::slotReadClient()
{
    QTcpSocket* pSocket = dynamic_cast<QTcpSocket*>(sender());
    //qDebug() << pSocket->readAll();
    std::cout << pSocket->readAll().toStdString();
    std::cout.flush();
    sendToClient(pSocket, "Message recived!");
}


void sec_srv::sendToClient(QTcpSocket* ptrSocket, const QString& str)
{
    QByteArray arrBlock;
    QDataStream out(&arrBlock,
                    QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_5_9);
    out << quint16(0) << str;
    out.device()->seek(0);
    out << quint16(arrBlock.size() - sizeof(quint16));
    ptrSocket->write(arrBlock);
}


sec_srv::~sec_srv()
{
   // delete srv;
}


















