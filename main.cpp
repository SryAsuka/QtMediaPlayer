#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "mysql.h"

int main(int argc, char *argv[])
{
    //QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //注册 MySql 自定义类到 QML 的上下文背景中进行使用
    QQmlApplicationEngine engine;
    MySql mysql;

    const QUrl url(QStringLiteral("/root/untitled/Main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);
    engine.rootContext()->setContextProperty("mySql",&mysql);
    engine.load(url);

    return app.exec();
}

