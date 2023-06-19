/*  To get Get the videos in the same directory
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#include "playlistitem.h"

#include <QFileInfo>
#include <QUrl>
#include <QMediaPlayer>
#include <QMediaMetaData>


PlayListItem::PlayListItem(const QString &path, QObject *parent)
    : ListItem(parent)
{
    QFileInfo fileInfo(path);
    QMediaPlayer *m_player = new QMediaPlayer(this);
    QThumbnail th = new QThumbnail(this);

    m_player->setSource(fileInfo.absoluteFilePath());
    //获取数据
    setFileName(fileInfo.fileName());
    setFilePath(fileInfo.absoluteFilePath());
    setFolderPath(fileInfo.absolutePath());
    
    //获取Duration数据
    QMediaMetaData mediaData = m_player->metaData();
    setDuration(mediaData.stringValue(QMediaMetaData::Duration));

    //获取缩略图数据
    setThumbtail(th.createThumbnail(fileInfo.filePath(),150));
}



QString PlayListItem::filePath() const
{
    return m_filePath;
}

void PlayListItem::setFilePath(const QString &filePath)
{
    m_filePath = filePath;
}

QString PlayListItem::fileName() const
{
    return m_fileName;
}

void PlayListItem::setFileName(const QString &fileName)
{
    m_fileName = fileName;
}

QString PlayListItem::folderPath() const
{
    return m_folderPath;
}

void PlayListItem::setFolderPath(const QString &folderPath)
{
    m_folderPath = folderPath;
}

QString PlayListItem::duration() const
{
    return m_duration;
}

void PlayListItem::setDuration(const QString &duration)
{
    m_duration = duration;
}

QImage PlayListItem::thumbnail() const
{
    return m_thumbnail;
}

void PlayListItem::setThumbtail(const QImage &image){
    m_thumbnail = image;
}


