#ifndef SEC_SRV_H
#define SEC_SRV_H

#include <QtNetwork>
#include <QTcpServer>
#include <QTcpSocket>
#include <QString>
#include <QDataStream>
#include <QByteArray>
#include <QTime>

#include <QDebug>
#include <iostream>

#include <QSqlDatabase>
#include <QSql>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlQueryModel>
#include <QSqlError>


//   \033[0;32m    - start write in GREEN color
//   \033[0m       - return default attrebutes

class sec_srv : public QObject
{
    Q_OBJECT
private:
    QTcpServer* srv;
    quint16 NextBlockSize;
    void sendToClient(QTcpSocket* ptrSocket, const QString& str);
public:
    sec_srv(quint16 nPort, QObject* parent = nullptr);
    virtual ~sec_srv();
public slots:
    virtual void slotNewConnection();
    void slotReadClient();
};

#endif // SEC_SRV_H
