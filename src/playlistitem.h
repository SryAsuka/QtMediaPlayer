/*  To get Get the videos in the same directory
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#ifndef PLAYLISTITEM_H
#define PLAYLISTITEM_H
#include "qthumbnail.h"
#include "listitem.h"

#include <QObject>
#include <QMediaPlayer>


class PlayListItem: public ListItem
{
    Q_OBJECT
public:
    explicit PlayListItem(const QString &path, QObject *parent = nullptr);


    Q_INVOKABLE QString filePath() const;
    void setFilePath(const QString &filePath);

    Q_INVOKABLE QString fileName() const;
    void setFileName(const QString &fileName);

    Q_INVOKABLE QString folderPath() const;
    void setFolderPath(const QString &folderPath);

    Q_INVOKABLE QString duration() const;
    void setDuration(const QString &duration);

    Q_INVOKABLE QImage thumbnail() const override;

    void setThumbtail(const QImage &image) ;

private:
    QString m_fileName;
    QString m_filePath;
    QString m_folderPath;
    QString m_duration;

    QImage m_thumbnail;


};

#endif // PLAYLISTITEM_H
