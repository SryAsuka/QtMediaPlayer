#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include "src/modelimageprovider.h"
#include "src/recentfilesmodel.h"
#include "src/playlistmodel.h"
#include "src/bulletxml.h"
#include "src/qsubtitleprovider.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // 设置图标
    app.setWindowIcon(QIcon(":/assets/icon/video.png"));

    PlayListModel *playlist = new PlayListModel(nullptr);
    ModelThumnailProvider *playthumnail = new ModelThumnailProvider(playlist);
    QSubtitleProvider *SubProvider = new QSubtitleProvider(nullptr);
    BulletXml bulletxml;
    RecentFilesModel *recentlist = new RecentFilesModel(nullptr);
    ModelThumnailProvider *recentthumnail = new ModelThumnailProvider(recentlist);


    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("QtMediaPlayer/qml/Main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);




    engine.rootContext()->setContextProperty("bulletxml", &bulletxml);

    engine.rootContext()->setContextProperty("mainPlaylist", playlist);
    engine.addImageProvider("playlistTh",playthumnail);
    engine.rootContext()->setContextProperty("mainRecentlist", recentlist);
    engine.addImageProvider("recentlistTh",recentthumnail);

    engine.rootContext()->setContextProperty ("subProvider",SubProvider);

    engine.load(url);

    return app.exec();
}
