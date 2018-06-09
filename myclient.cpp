#include <QtNetwork>
#include <QtGui>
#include "myclient.h"

// ----------------------------------------------------------------------
// (len1-29c#h7rJ2Pn4)getAllData!
// (len1-29c#h7rJ2Pn4)showPlan:59
// (len1-29c#h7rJ2Pn4)setNextPaket:7



MyClient::MyClient(QWidget* pwgt) : QWidget(pwgt), m_nNextBlockSize(0)
{

    //dataSet.setValue("isEntered", false);

    m_pTcpSocket = new QSslSocket(this);

    const QString rootCAPath(":/new/prefix1/rootCA.pem");
    auto rootCACert = QSslCertificate::fromPath(rootCAPath);
    Q_ASSERT(!rootCACert.isEmpty());
    m_pTcpSocket->setCaCertificates(rootCACert);


    QList<QSslError> errorsToIgnore;
    const QString serverCertPath(":/new/prefix1/client1.pem");
    auto serverCert = QSslCertificate::fromPath(serverCertPath);
    Q_ASSERT(!serverCert.isEmpty());
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

    if(!dataSet.value("isEntered").toBool())
        demo = true;

   // if(!m_pTcpSocket->waitForEncrypted())
   //
   //    // m_ptxtInfo->setText(m_pTcpSocket->errorString());
   //     connectToHost();
   //


}

// ----------------------------------------------------------------------
void MyClient::slotReadyRead()
{
    m_pTcpSocket->waitForReadyRead();
    m_ptxtInfo = m_pTcpSocket->readAll();
    m_pTcpSocket->close();
    //isConnect = true;

    if(m_ptxtInfo.length() > 10 && m_ptxtInfo.mid(0, 11) == "getAllData!")
    {
    //idNumber, balance, state, pay_day, paket;




    isAuthOk = true;
    if(!dataSet.value("isEntered").toBool()){
    dataSet.setValue("isEntered", true);
    dataSet.setValue("name", enteredName);
    dataSet.setValue("pass", enteredPass);
    }


    QString temp(m_ptxtInfo.mid(11));
    short space(0);
    for(auto& c:temp)
    {

        if(space == 0 && c != ' ')
        {
            idNumber+= c;
        }

        if(space == 1 && c != ' ')
        {
            balance += c;
        }

        if(space == 2 && c != ' ')
        {
            state += c;
        }

        if(space == 3 && c != ' ')
        {
            pay_day += c;
        }

        if(space >= 4)
        {
            paket += c;
        }


        if(c == ' ')
            ++space;
        }

        dataSet.setValue("id", idNumber);

    // тут везде надо оставить только проверку на начальные слоги set, get, ask...

    }else if(m_ptxtInfo.length() > 10 && m_ptxtInfo.mid(0, 12) == "askPayments!"){
        payments = m_ptxtInfo;
    }


    // Put here some other option


    else if(m_ptxtInfo == "denied"){
        isAuthOk = false;
        loginResult = "Неверная авторизация";

    }else{
        isAuthOk = false;
        loginResult = "Для работы приложения<br>"
                      "необходимо подключение<br>"
                      "к интернет, либо к сети<br>"
                      "Аррива. Проверьте подключение,<br>"
                      "либо обратитесь в тех. поддержку.";

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
    m_pTcpSocket->write(msg.toUtf8());
   // m_pTcpSocket->waitForBytesWritten();  // Удалил


}



void MyClient::connectToHost()
{
  //m_pTcpSocket->connectToHostEncrypted("176.125.152.88", 2323);
    m_pTcpSocket->connectToHostEncrypted("10.4.43.99", 4242);

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
    if(name.isEmpty() || pass.isEmpty()){
        isAuthOk = false;
        loginResult = "Необходимо ввести\n"
                         "логин и пароль.";
    }else{
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
    //dataSet.setValue("isEntered", true);
    if(dataSet.value("isEntered").toBool())
        return true;
    else return false;

    //return false;
    //return true;
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

QString MyClient::showPayments()
{

    QString result = payments.mid(12);
  //  QString temp = payments.mid(12);
  //  // raf data without key
  //  // qDebug() << temp;
  //
  //  QString dates, cash;
  //  QVector<QString> v_dates, v_cash;
  //
  //  int datesLenght(0);
  //
  //  for(auto &c:temp)
  //  {
  //      if(c == ' ' || c == '#')
  //      {
  //          v_dates.push_back(dates);
  //          dates.clear();
  //      }
  //
  //      ++datesLenght;
  //      if(c == '#')
  //      break;
  //      if(c != ' ' && c != '#')
  //      dates += c;
  //
  //  }
  //
  //  cash = temp.mid(datesLenght);
  //  cash += '#';
  //
  //  QString t_cash;
  //
  //  for(auto &c:cash)
  //  {
  //      if(c == ' ' || c == '#')
  //      {
  //          v_cash.push_back(t_cash);
  //         // qDebug() << t_cash;
  //          t_cash.clear();
  //      }
  //      if(c != ' ' && c != '#')
  //      t_cash += c;
  //  }
  //
  //
  //
  //  std::reverse(std::begin(v_cash), std::end(v_cash));
  //  std::reverse(std::begin(v_dates), std::end(v_dates));
  //
  //
  //
  //
  //
  //
  //  QString result;
  //  int v_i(0);
  //  QDateTime time_t;
  //
  //  for(auto &c:v_cash)
  //  {
  //     if(v_i == v_dates.size())
  //         break;
  //      time_t = QDateTime::fromTime_t(v_dates[v_i].toInt());
  //      result += time_t.toString() + "<br>" +
  //              " Сумма: " + c + "<br><br>";
  //      ++v_i;
  //  }
  //
    return result;

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







