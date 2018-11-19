#include <QtNetwork>
#include <QtGui>
#include "myclient.h"

// ----------------------------------------------------------------------
// (len1-29c#h7rJ2Pn4)getAllData!
// (len1-29c#h7rJ2Pn4)showPlan:59
// (len1-29c#h7rJ2Pn4)setNextPaket:7






sslClient::sslClient(QObject* prnt)
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
    QTimer::singleShot(4000, this, SLOT(timeOut()));
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
        emit startReadContent();
        pSslSocket->close();
    }
}


void MyClient::slotSetSsl()
{
    if (sslGetter.sslContent == "denied")
    {
        isAuthOk = false;
        loginResult = "Неверная авторизация.<br>"
                      "Проверьте правильность<br>"
                      "имени и пароля.";
        quitAndClear();
        switchToMe();
    }
    else
    {
        dataSet.setValue("SSL_CONTENT", sslGetter.sslContent);
        //CertArr.fromStdString(sslGetter.sslContent.toStdString());
        CertArr = dataSet.value("SSL_CONTENT").toByteArray();
        Sender("(" + enteredName + "#" + enteredPass + ")getAllData!");
    }
}

void sslClient::slotErrorSsl(QAbstractSocket::SocketError err)
{
    QString strError=
            "Error type: " + (err == QAbstractSocket::HostNotFoundError ?
                                  "The host was not found." :
                                  err == QAbstractSocket::RemoteHostClosedError ?
                                      "The remote host is closed." :
                                      err == QAbstractSocket::ConnectionRefusedError ?
                                          "The connection was refused." :
                                          QString(pSslSocket->errorString()));
    qDebug() << strError;
    sslContent = strError;
    emit connectionError();
}

void sslClient::slotSender(const QString& msg)
{
    pSslSocket->write(msg.toUtf8());
}

void sslClient::slotConnectedToServ()
{
    emit connectionEstablished();
}

void sslClient::timeOut()
{
    if (pSslSocket->state() == QAbstractSocket::ConnectingState)
    {
        pSslSocket->abort();
        pSslSocket->close();
        emit connectionTimeOut();
        qDebug() << "SIGNAL WOKS";
    }


}




//////////////////////////////////////////////////////////////////////// Secure connection:





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

    // QList<QSslError> errorsToIgnore;
    //
    CertArr = dataSet.value("SSL_CONTENT").toByteArray();
    //
    // const QString serverCertPath(":/new/prefix1/client1.pem");
    // //auto serverCert = QSslCertificate::fromPath(serverCertPath);
    // auto serverCert = QSslCertificate::fromData(CertArr);
    //
    // //Q_ASSERT(!serverCert.isEmpty());
    // if (serverCert.isEmpty())
    // {
    //     noCert = true;
    //     qDebug() << "serverCert is empty!";
    // }
    //
    //
    // if (!serverCert.isEmpty())
    //     errorsToIgnore << QSslError(QSslError::HostNameMismatch, serverCert.at(0));
    // m_pTcpSocket->ignoreSslErrors(errorsToIgnore);
    //


    connect(m_pTcpSocket, SIGNAL(readyRead()), SLOT(slotReadyRead()));
    connect(m_pTcpSocket, SIGNAL(connected()), SLOT(slotConnected()));



    connect(m_pTcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this,         SLOT(slotError(QAbstractSocket::SocketError))
            );

    connect(&sslGetter, SIGNAL(startReadContent()), this, SLOT(slotSetSsl()));   //////// ????????? <<<
    connect(&sslGetter, SIGNAL(connectionError()), this, SLOT(slotSslErrors()));
    connect(&sslGetter, SIGNAL(connectionTimeOut()), this, SLOT(slotSslErrors()));
    connect(&sslGetter, SIGNAL(connectionEstablished()), this, SLOT(slotAskForSsl()));


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


        if(pay_day.toInt() == 0)
        {
            int day_tmp = pay_day.toInt();
            ++day_tmp;
            pay_day = QString::number(day_tmp);
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


// ----------------------------------------------------------------------
void MyClient::Sender(const QString &msg)
{
    msgToSend = msg;


    QList<QSslError> errorsToIgnore;

    //CertArr = dataSet.value("SSL_CONTENT").toByteArray();






    //const QString serverCertPath(":/new/prefix1/client1.pem");
    //auto serverCert = QSslCertificate::fromPath(serverCertPath);
    auto serverCert = QSslCertificate::fromData(CertArr);

    //Q_ASSERT(!serverCert.isEmpty());
    if (serverCert.isEmpty())
    {
        noCert = true;
        qDebug() << "serverCert is empty!";
    }

    if (!serverCert.isEmpty())
        errorsToIgnore << QSslError(QSslError::HostNameMismatch, serverCert.at(0));
    m_pTcpSocket->ignoreSslErrors(errorsToIgnore);


    if(!m_pTcpSocket->waitForEncrypted()){
        //qDebug() << m_pTcpSocket->errorString();
    }

    connectToHost();

    // m_pTcpSocket->write(msg.toUtf8());
}

void MyClient::connectToHost()
{
    //m_pTcpSocket->connectToHostEncrypted("10.4.43.99", 4242);
    m_pTcpSocket->connectToHostEncrypted("192.168.7.128", 4242);
    QTimer::singleShot(6000, this, SLOT(slotLongConnection()));

    if (!m_pTcpSocket->waitForConnected(6000))
    {
        loginResult = m_pTcpSocket->errorString() + "<br>"
                                                    "Для работы приложения<br>"
                                                    "необходимо подключение<br>"
                                                    "к интернет, либо к сети<br>"
                                                    "Аррива. Проверьте подключение,<br>"
                                                    "либо обратитесь в тех. поддержку.";
        isAuthOk = false;
        switchToMe();
    }

}


void MyClient::slotConnected()
{
    isConnect = true;
    m_pTcpSocket->write(msgToSend.toUtf8());
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
    if (name.isEmpty() || pass.isEmpty()){
        isAuthOk = false;
        loginResult = "Необходимо ввести\n"
                      "логин и пароль.";
        switchToMe();
    }
    else
    {
        enteredName = name;
        enteredPass = pass;
        sslGetter.connectionToSrv("192.168.7.128", 4444);
        //sslGetter.connectionToSrv("10.4.43.99", 4444);
    }
}



void MyClient::slotAskForSsl()
{
    sslGetter.slotSender("(" + enteredName + "#" + enteredPass + ")");
}


void MyClient::slotLongConnection()
{
    if (m_pTcpSocket->state() == QAbstractSocket::ConnectingState)
    {
        m_pTcpSocket->abort();
        m_pTcpSocket->close();
        isAuthOk = false;
        loginResult =
                "<br>Для работы приложения<br>"
                "необходимо подключение<br>"
                "к интернет, либо к сети<br>"
                "Аррива. Проверьте подключение,<br>"
                "либо обратитесь в тех. поддержку.";
        isAuthOk = false;
        switchToMe();
    }
}

void MyClient::slotSslErrors()
{
    isAuthOk = false;
    loginResult =
            "В целях безопасности,<br>"
            "Ваш первый вход в систему<br>"
            "должен быть произведен<br>"
            "в пределах сети Успех!<br>"
            "Например используйте Вашу<br>"
            "домашнюю WiFi сеть.<br>"
            "Проверьте подключение,<br>"
            "или обратитесь в тех. поддержку.<br>"+
            sslGetter.sslContent;
    switchToMe();
}





void MyClient::quitAndClear()
{

    dataSet.remove("name");
    dataSet.remove("pass");
    dataSet.setValue("isEntered", false);
    dataSet.remove("SSL_CONTENT");

    sslGetter.sslContent.clear();
    idNumber.clear();
    balance.clear();
    state.clear();
    pay_day.clear();
    paket.clear();
}

bool MyClient::isAuth()
{
    return dataSet.value("isEntered").toBool();
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
    Sender("(" + dataSet.value("id").toString() + "#" + dataSet.value("pass").toString()
           + ")getAllData!");
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
    QString currentDate = serverDateTime.mid(0, 10);
    int currentYear = serverDateTime.mid(6, 4).toInt();

    int yearArr[12] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    if (currentDate.mid(6, 4).toInt() % 4 == 0)
        yearArr[1] = 29;

    QString dd = currentDate.mid(0, 2);

    int int_dd = 0;
    int int_mm = 0;

    if (dd.mid(0) == "0")
        int_dd = dd.mid(1).toInt();
    else int_dd = dd.toInt();

    QString str_mm = currentDate.mid(3, 2);
    if (str_mm.mid(0) == "0")
        int_mm = str_mm.mid(1).toInt();
    else int_mm = str_mm.toInt();

    QString result;

    if (int_dd < pay_day.toInt())
        result = pay_day + currentDate.mid(2, 8);
    else
    {
        if (int_mm != 12)
            ++int_mm;
        else
        {
            int_mm = 1;
            ++currentYear;
        }
    }

    if (pay_day.toInt() > yearArr[int_mm - 1])
        pay_day = QString::number(yearArr[int_mm - 1]);

    if (int_mm >= 10)
        result = pay_day + "." + QString::number(int_mm) + "." + QString::number(currentYear);
    else result = pay_day + ".0" + QString::number(int_mm) + "." + QString::number(currentYear);

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







