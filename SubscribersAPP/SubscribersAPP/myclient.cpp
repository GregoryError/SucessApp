#include <QtNetwork>
#include <QtGui>
#include "myclient.h"

// ----------------------------------------------------------------------
// (len1-29c#h7rJ2Pn4)getAllData!
// (len1-29c#h7rJ2Pn4)showPlan:59
// (len1-29c#h7rJ2Pn4)setNextPaket:7






sslClient::sslClient(QString& answer, QObject* prnt)
    : QObject(prnt), sslNextBlock(0)
{
    pSslSocket = new QTcpSocket(this);
    //pSslSocket->connectToHost(strHost, nsPort); // ??
    connect(pSslSocket, SIGNAL(connected()), SLOT(slotConnectedToServ()));
    connect(pSslSocket, SIGNAL(readyRead()), SLOT(slotReadyToRead()));
    connect(pSslSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(slotErrorSsl(QAbstractSocket::SocketError)));



}

void sslClient::connectionToSrv(const QString& strHost, quint16 nsPort)
{
    pSslSocket->connectToHost(strHost, nsPort);
}

void sslClient::slotReadyToRead()
{
    QDataStream in(pSslSocket);

    in.setVersion(QDataStream::Qt_5_9);

    for(;;)
    {
        if (!sslNextBlock)
        {
            if (pSslSocket->bytesAvailable() < sizeof(quint16))
            {
                break;
            }
            in >> sslNextBlock;
        }
        if (pSslSocket->bytesAvailable() < sslNextBlock)
        {
            break;
        }
        in >> sslContent;
        sslNextBlock = 0;
    }

    if (sslContent != "denied")
    {

       // out << sslContent;
       // qDebug() << "Reading SSL done!" << sslContent;

    }

    sslContent.clear();
}

void sslClient::slotErrorSsl(QAbstractSocket::SocketError err)
{
    QString strError=
            "Error: " + (err == QAbstractSocket::HostNotFoundError ?
                             "The host was not faund." :
                             err == QAbstractSocket::RemoteHostClosedError ?
                                 "The remote host is closed." :
                                 err == QAbstractSocket::ConnectionRefusedError ?
                                     "The connection was refused." :
                                     QString(pSslSocket->errorString()));
    qDebug() << strError;
    sslContent = strError;
}



void sslClient::slotSender(const QString& msg)
{
    pSslSocket->write(msg.toUtf8());
}



void sslClient::slotConnectedToServ()
{
    qDebug() << "Connected for getting the cert!";
}




////////////////////////////////////// Secure connection:





MyClient::MyClient(QWidget* pwgt) : QObject(pwgt) /*QWidget(pwgt)*/, m_nNextBlockSize(0)
{

    //dataSet.setValue("isEntered", false);



    m_pTcpSocket = new QSslSocket(this);


    const QString rootCAPath(":/new/prefix1/rootCA.pem");
    auto rootCACert = QSslCertificate::fromPath(rootCAPath);

    //Q_ASSERT(!rootCACert.isEmpty());

    if (rootCACert.isEmpty())
        qDebug() << "rootCACert is empty!";


    if (!rootCACert.isEmpty())
        m_pTcpSocket->setCaCertificates(rootCACert);   //  was changed with two next lines, coz of named as depricated

    //QSslConfiguration config = m_pTcpSocket->sslConfiguration();
    //config.setCaCertificates(rootCACert);





    QList<QSslError> errorsToIgnore;
    const QString serverCertPath(":/new/prefix1/client1.pem");
    auto serverCert = QSslCertificate::fromPath(serverCertPath);

    //Q_ASSERT(!serverCert.isEmpty());
    if (serverCert.isEmpty())
    {
        noCert = true;
        qDebug() << "serverCert is empty!";
    }


    if (!serverCert.isEmpty())
        errorsToIgnore << QSslError(QSslError::HostNameMismatch, serverCert.at(0));
    m_pTcpSocket->ignoreSslErrors(errorsToIgnore);

    connect(m_pTcpSocket, SIGNAL(readyRead()), SLOT(slotReadyRead()));
    connect(m_pTcpSocket, SIGNAL(connected()), SLOT(slotConnected()));



    connect(m_pTcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this,         SLOT(slotError(QAbstractSocket::SocketError))
            );



    if(dataSet.value("isEntered").toBool()){
        Sender("(" + dataSet.value("name").toString()
               + "#" + dataSet.value("pass").toString()
               + ")getAllData!");
    }

    //if(!dataSet.value("isEntered").toBool())
    //    demo = true;
    //
    // if(!m_pTcpSocket->waitForEncrypted())
    //{}
    //    // m_ptxtInfo->setText(m_pTcpSocket->errorString());
    //     connectToHost();
    //


}

// ----------------------------------------------------------------------
void MyClient::slotReadyRead()
{

    //m_pTcpSocket->waitForReadyRead();


    QDataStream in(m_pTcpSocket);

    in.setVersion(QDataStream::Qt_5_9);

    for(;;)
    {
        if (!m_nNextBlockSize)
        {
            if (m_pTcpSocket->bytesAvailable() < sizeof(quint16))
            {
                break;
            }
            in >> m_nNextBlockSize;
        }
        if (m_pTcpSocket->bytesAvailable() < m_nNextBlockSize)
        {
            break;
        }

        in >> m_ptxtInfo;
        m_nNextBlockSize = 0;
    }

    //qDebug() << m_ptxtInfo;

    // m_ptxtInfo = m_pTcpSocket->readAll();

    // m_pTcpSocket->close();
    //isConnect = true;

    if(m_ptxtInfo.length() > 10 && m_ptxtInfo.mid(0, 11) == "getAllData!")
    {
        //idNumber, balance, state, pay_day, paket;

        idNumber.clear();
        balance.clear();
        state.clear();
        pay_day.clear();
        paket.clear();
        isAuthOk = true;

        if (!dataSet.value("isEntered").toBool())
        {
            dataSet.setValue("isEntered", true);
            dataSet.setValue("name", enteredName);
            dataSet.setValue("pass", enteredPass);
        }


        // здесь возможная точка для взятия текущей даты от сервера <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        //
        //
        //  07.10.2018 22:17
        //  16




        QString temp(m_ptxtInfo.mid(27));
        serverDateTime = m_ptxtInfo.mid(11, 16);


        qDebug() << "In serverDateTime: " << serverDateTime;

        short space(0);
        for(auto& c:temp)
        {

            if (space == 0 && c != ' ')
            {
                idNumber+= c;
            }

            if (space == 1 && c != ' ')
            {
                balance += c;
            }

            if (space == 2 && c != ' ')
            {
                state += c;
            }

            if (space == 3 && c != ' ')
            {
                pay_day += c;
            }

            if (space >= 4)
            {
                paket += c;
            }

            if (c == ' ')
                ++space;
        }

        dataSet.setValue("id", idNumber);

        emit startReadInfo();



        // тут везде надо оставить только проверку на начальные слоги set, get, ask...

    }
    else if (m_ptxtInfo.length() > 10 && m_ptxtInfo.mid(0, 12) == "askPayments!")
    {
        payments = m_ptxtInfo;
        showPayments();

    }
    else if (m_ptxtInfo.mid(0, 11) == "askForMsgs!")
    {
        msgs = m_ptxtInfo.mid(11);
        showMsgs();

    }
    else if (m_ptxtInfo == "requestTrustedPay!PayDenied")
    {
        emit trustedPayDenied();

    }
    else if (m_ptxtInfo == "requestTrustedPay!PayOk")
    {
        emit trustedPayOk();
    }


    // Put here some other option

    else if(m_ptxtInfo == "denied"){
        isAuthOk = false;
        loginResult = "Неверная авторизация";
        switchToMe();
    }
    else
    {
        isAuthOk = false;
        loginResult = "Для работы приложения<br>"
                      "необходимо подключение<br>"
                      "к интернет, либо к сети<br>"
                      "Аррива. Проверьте подключение,<br>"
                      "либо обратитесь в тех. поддержку.";
        switchToMe();

    }


    // Saving user settings

    // qDebug() << idNumber;
    // qDebug() << balance;
    // qDebug() << state;
    // qDebug() << pay_day;
    // qDebug() << paket;



}

void MyClient::slotConnected()
{
    isConnect = true;
}

// ----------------------------------------------------------------------
void MyClient::Sender(const QString &msg)
{




    if(!m_pTcpSocket->waitForEncrypted()){

        //qDebug() << m_pTcpSocket->errorString();
    }
    connectToHost();


    //
    //
    //    QByteArray arrBlock;
    //    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    //    out.setVersion(QDataStream::Qt_5_9);
    //    out << quint16(0) << msg;
    //    out.device()->seek(0);
    //    out << quint16(arrBlock.size() - sizeof(quint16));
    //    m_pTcpSocket->write(arrBlock);
    //


    m_pTcpSocket->write(msg.toUtf8());

}

void MyClient::connectToHost()
{


    m_pTcpSocket->connectToHostEncrypted("10.4.43.99", 4242);
    //m_pTcpSocket->connectToHostEncrypted("192.168.7.128", 4242);


    if (!m_pTcpSocket->waitForConnected(9000))
    {
        loginResult = m_pTcpSocket->errorString() + "<br>"
                                                    "Для работы приложения<br>"
                                                    "необходимо подключение<br>"
                                                    "к интернет, либо к сети<br>"
                                                    "Аррива. Проверьте подключение,<br>"
                                                    "либо обратитесь в тех. поддержку.";
        switchToMe();
    }

}


QString MyClient::authResult()
{
    return loginResult;
    // denied or smth else, that would mean connection issue
}

bool MyClient::isAuthRight()
{
    return isAuthOk;
}

void MyClient::setAuthData(QString name, QString pass)
{
    //if (noCert)
    //{
    //    m_pTcpSocket->close();
    //    noCert = false;
    //    loginResult = "В целях безопасности,<br>"
    //                  "авторизуйтесь первый раз<br>"
    //                  "в пределах сети Успех!<br>"
    //                  "Например Ваша WiFi сеть.";
    //    isAuthOk = false;
    //    switchToMe();
    //    // qDebug() << "serverCert is empty!";
    //}

    if (name.isEmpty() || pass.isEmpty()){
        isAuthOk = false;
        loginResult = "Необходимо ввести\n"
                      "логин и пароль.";
        switchToMe();
    }
    else if(!dataSet.value("isEntered").toBool())
    {
        sslGetter.connectionToSrv("10.4.43.99", 4444);
        sslGetter.slotSender("(" + name + "#" + pass + ")");
    }
    else
    {
        enteredName = name;
        enteredPass = pass;
        Sender("(" + enteredName + "#" + enteredPass + ")getAllData!");
    }

}

void MyClient::quitAndClear()
{
    dataSet.setValue("isEntered", false);
    dataSet.remove("name");
    dataSet.remove("pass");

    idNumber.clear();
    balance.clear();
    state.clear();
    pay_day.clear();
    paket.clear();
}

bool MyClient::isAuth()
{
    if(dataSet.value("isEntered").toBool())
        return true;
    else return false;
}

// ----------------------------------------------------------------------
void MyClient::slotError(QAbstractSocket::SocketError err)
{
    QString strError =
            "Error: " + (err == QAbstractSocket::HostNotFoundError ?
                             "The host was not found." :
                             err == QAbstractSocket::RemoteHostClosedError ?
                                 "The remote host is closed." :
                                 err == QAbstractSocket::ConnectionRefusedError ?
                                     "The connection was refused." :
                                     QString(m_pTcpSocket->errorString())
                                     );
    //m_ptxtInfo->append(strError);
    loginResult = strError + "<br>Для работы приложения<br>"
                             "необходимо подключение<br>"
                             "к интернет, либо к сети<br>"
                             "Аррива. Проверьте подключение,<br>"
                             "либо обратитесь в тех. поддержку.";
}

bool MyClient::showDemo()
{
    return demo;
}

void MyClient::askForPayments()
{
    Sender("(" + dataSet.value("id").toString()
           + "#" + dataSet.value("pass").toString()
           + ")askPayments!");
}

void MyClient::askForTrustedPay()
{
    Sender("(" + dataSet.value("id").toString()
           + "#" + dataSet.value("pass").toString()
           + ")requestTrustedPay!");
}

void MyClient::askForMsgs()
{
    Sender("(" + dataSet.value("id").toString()
           + "#" + dataSet.value("pass").toString()
           + ")askForMsgs!");
}

int MyClient::payTableLength()
{
    return times_vct.size();
}

void MyClient::switchToMe()
{
    emit switchToHomePage();
}

void MyClient::makeBusyON()
{
    emit busyON();
}

void MyClient::makeBusyOFF()
{
    emit busyOFF();
}

void MyClient::fillHomePage()
{
    Sender("(" + dataSet.value("id").toString() + "#" + dataSet.value("pass").toString() + ")getAllData!");
    // emit startReadInfo();
}



//void MyClient::fillPaysPage()
//{
//    emit startReadPays();
//}





void MyClient::showPayments()
{


    QString result = payments.mid(12);

    times_vct.clear();
    cashes_vct.clear();
    comments_vct.clear();

    // payStrVec.reserve(payLines * 3);


    QString tmpPayStr;

    QChar dataType = ' ';

    for(auto &ch:result)
    {

        if(ch != 't' && ch != '$' && ch != '@'
                && ch != '~' && ch != "\n")
            tmpPayStr += ch;

        if(ch == "\n")
            tmpPayStr += "<br>";



        if(ch == 't')
            dataType = 't';
        if(ch == '$')
            dataType = '$';
        //if(ch == '@')
        //    break;


        if(dataType == ' ' && ch == ' ')
        {
            // qDebug() << "times_vct: " << tmpPayStr;
            times_vct.push_back(QDateTime::fromSecsSinceEpoch(tmpPayStr.toInt()).toString("dd.MM.yyyy hh:mm"));

            tmpPayStr.clear();
        }


        if(dataType == 't' && ch == ' ')
        {
            tmpPayStr += " руб.";
            cashes_vct.push_back(tmpPayStr);
            //qDebug() << "cashes_vct: " << tmpPayStr;
            tmpPayStr.clear();
        }



        if(dataType == '$' && ch == "~")
        {
            // qDebug() << "To the comments_vct: " << tmpPayStr;
            if(tmpPayStr.isEmpty())
                comments_vct.push_back(" - ");

            if(tmpPayStr.length() > 47)
            {
                int halfLen = tmpPayStr.length() / 2;
                QString tmpStr;
                bool added = false;
                for(auto &c:tmpPayStr)
                {
                    tmpStr+= c;
                    if(tmpStr.length() > halfLen && c == ' ' && added != true)
                    {
                        tmpStr += "<br>";
                        added = true;
                    }
                }
                tmpPayStr.clear();
                tmpPayStr = tmpStr;

            }

            comments_vct.push_back(tmpPayStr);
            tmpPayStr.clear();
        }

    }

    std::reverse(times_vct.begin(), times_vct.end());
    std::reverse(cashes_vct.begin(), cashes_vct.end());
    std::reverse(comments_vct.begin(), comments_vct.end());

    emit startReadPays();

}


void MyClient::sendMsgs(QString str)
{
    // setMsgs
    Sender("(" + dataSet.value("id").toString()
           + "#" + dataSet.value("pass").toString()
           + ")setMsgs:" + str);
}



void MyClient::showMsgs()
{

    //   Продлил до 08.06.16 01:27~time:1464906536~end()

    //   ... ~time:1472899145~end()~user:МОЖНО ЛИ ЕЩЕ НА...


    QString msgUnit;

    bool startUserData = false;



    QString val;


    for (auto &ch:msgs)
    {
        if (msgUnit.right(6) == "~user:")
        {
            QString tmp = msgUnit;
            auto len = tmp.length();
            msgUnit = tmp.mid(0, len - 6);
            startUserData = true;
        }
        msgUnit += ch;
        if (msgUnit.right(6) == "~time:")
        {
            auto len = msgUnit.length();
            if (startUserData)
                val = "Вы:<br>" + msgUnit.mid(0, len - 6);
            else
                val = "Оператор:<br>" + msgUnit.mid(0, len - 6);
            msgUnit.clear();
        }
        if (msgUnit.right(6) == "~end()")
        {
            auto len = msgUnit.length();
            if (startUserData)
                msg_lines.insert(msgUnit.mid(0, len - 6).toInt(), val);
            else
                msg_lines.insert(msgUnit.mid(0, len - 6).toInt(), val);
            msgUnit.clear();
        }
    }


    emit startReadMsgs();




    //qDebug() << "ADMIN DATA: ";
    //
    //for (auto &line:adm_vct)
    //{
    //    qDebug() << line;
    //}
    //
    //qDebug() << "USER DATA: ";
    //
    //for (auto &line:usr_vct)
    //{
    //    qDebug() << line;
    //}


}



QString MyClient::convertTime(int val)
{
    QDateTime time = QDateTime::fromSecsSinceEpoch(val);
    return time.toString("dd.MM.yyyy hh:mm");
}

QString MyClient::serverDate()
{
    return serverDateTime.mid(0, 10);
}

QString MyClient::serverTime()
{
    return serverDateTime.mid(11, 16);
}

QString MyClient::nextPayDay()
{
    // PSUDOCODE:
    // if (dd < pd)
    //     result = pd.mm.yyyy
    //             else result = pd.mm + 1.yyyy

    QString currentDate = serverDateTime.mid(0, 10);
    QString dd = currentDate.mid(0, 2);

    int int_dd;

    if (dd.mid(0) == "0")
        int_dd = dd.mid(1).toInt();
    else int_dd = dd.toInt();

    QString result;

    if (int_dd < pay_day.toInt())
        result = pay_day + "." + currentDate.mid(3, 8);
    else
    {
        int int_mm = currentDate.mid(4, 2).toInt();
        if (int_mm != 12)
            ++int_mm;
        if (int_mm == 12)
        {
            return pay_day + ".01" + currentDate.mid(6, 5);
        }

        result = pay_day + "." + QString::number(int_mm) + currentDate.mid(6, 5);
    }


    //qDebug() << result << " - RESULT";

    return result;
}




QString MyClient::givePayTime(int strN)
{
    return times_vct[strN];
}

QString MyClient::givePayCash(int strN)
{
    return cashes_vct[strN];
}

QString MyClient::givePayComm(int strN)
{
    return comments_vct[strN];
}




QString MyClient::showPlan()
{
    return paket;
}

QString MyClient::showBill()
{
    return balance;
}

QString MyClient::showId()
{
    return idNumber;
}

QString MyClient::showPay_day()
{
    return pay_day;
}

QString MyClient::showState()
{
    return state;
}

void MyClient::setAuthOn()
{
    dataSet.setValue("access", false);
    //connectToHost();
    Sender("(" + dataSet.value("name").toString()
           + "#" + dataSet.value("pass").toString()
           + ")setAuth:'on'");
}

void MyClient::setAuthNo()
{
    dataSet.setValue("access", true);
    // connectToHost();
    Sender("(" + dataSet.value("name").toString()
           + "#" + dataSet.value("pass").toString()
           + ")setAuth:'no'");
}

void MyClient::copyToBuf()
{
    buf->setText(idNumber, QClipboard::Clipboard);
}







