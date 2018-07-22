#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "myclient.h"
#include "backend.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setApplicationDisplayName("Успех");

    app.setOrganizationName("Success");
    app.setOrganizationDomain("www.comfort-tv.ru/");
    app.setApplicationName("Success");




    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
