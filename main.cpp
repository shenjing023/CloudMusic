#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QTextCodec>
#include "cpp/Network/network.h"
#include "cpp/audiodata.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //QTextCodec::setCodecForLocale(QTextCodec::codecForName("utf-8"));//不能设置，如果设置了，本地音乐的中文会乱码
    qmlRegisterType<Network>("Network",1,0,"Network");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("AudioData",new AudioData);
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
