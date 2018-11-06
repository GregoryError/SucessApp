#include <QCoreApplication>
#include "sec_srv.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    sec_srv server(4444);



    return a.exec();
}
