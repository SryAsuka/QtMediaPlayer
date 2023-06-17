#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include "src/modelimageprovider.h"
#include "src/recentfilesmodel.h"
#include "src/playlistmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // 设置图标
    app.setWindowIcon(QIcon(":/assets/icon/video.png"));
    PlayListModel *playlist = new PlayListModel(nullptr);
    ModelThumnailProvider *playthumnail = new ModelThumnailProvider(playlist);


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("QtMediaPlayer/qml/Main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);



    engine.rootContext()->setContextProperty("mainPlaylist", playlist);
    engine.addImageProvider("playlistTh",playthumnail);
    engine.load(url);

    return app.exec();
}
