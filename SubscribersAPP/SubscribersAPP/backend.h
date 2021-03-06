#ifndef BACKEND_H
#define BACKEND_H


#include <QtWidgets>
#include "myclient.h"


#include <QMainWindow>
#include <QObject>
#include <QString>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QMessageBox>
#include <QApplication>
#include <QGeoPositionInfoSource>
#include <QDesktopServices>
#include <QWindow>

#include <QClipboard>
#include <QGuiApplication>


class location
{
public:
    double longitude, latitude;
    QString address;
    double t_long, t_lat;

    location() = default;
    location(const double &lon, const double &lat):longitude(lon), latitude(lat){}
    location(const double &lon, const double &lat, const QString &addr, const double &t_long, const double &t_lat):
        longitude(lon), latitude(lat), address(addr), t_long(t_long), t_lat(t_lat) {}

    double ShowDiff(location &first, location &second)
    {
        return std::abs(pow(pow((second.latitude - first.latitude), 2) + pow((second.longitude - first.longitude), 2), 0.5));
    }

    bool operator <(location &obj)
    {
        location temp(longitude, latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) < ShowDiff(own, obj);
    }

    bool operator >(location &obj)
    {
        location temp(longitude, latitude);
        location own(t_long, t_lat);
        return ShowDiff(own, temp) > ShowDiff(own, obj);
    }
};


class BackEnd : public QObject
{
    Q_OBJECT
    //Q_PROPERTY(QString userName READ userName WRITE setUserName NOTIFY userNameChanged)
    //Q_PROPERTY(QString text MEMBER m_text NOTIFY textChanged)

public:
    QQmlContext *cont;
    QQmlApplicationEngine engine;

    QVector<location> cashpoints;




    location owner;
    QGeoPositionInfoSource *source = QGeoPositionInfoSource::createDefaultSource(this);
    QRect displaySize;



    BackEnd(QObject *parent = nullptr);

public slots:
    void trustedPay();
    QString showATM();
    void callUs();
    void goUrl();
    void social();
    double p_point_long(int i);
    double p_point_lat(int i);
    double p_owner_long();
    double p_owner_lat();

    int p_count();

};
























#endif // BACKEND_H
