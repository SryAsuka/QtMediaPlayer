#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "modelimageprovider.h"
#include "recentfilesmodel.h"
#include "playlistmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);



    QQmlApplicationEngine engine;
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);



    PlayListModel *main_playlist = new PlayListModel(nullptr);
    RecentFilesModel *main_recent = new RecentFilesModel(nullptr);

    ModelThumnailProvider *recentthumnail = new ModelThumnailProvider(main_recent);
    ModelThumnailProvider *playthumnail = new ModelThumnailProvider(main_playlist);

    engine.addImageProvider("recent",recentthumnail);
    engine.addImageProvider("playlist",playthumnail);
    engine.rootContext()->setContextProperty("main_playlist", main_playlist);


    engine.loadFromModule("QtMediaPlayer", "Window");

    return app.exec();
}
