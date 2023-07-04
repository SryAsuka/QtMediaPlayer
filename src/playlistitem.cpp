/*  To get Get the videos in the same directory
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#include "playlistitem.h"

#include <QFileInfo>
#include <QUrl>
#include <QMediaPlayer>
#include <QMediaMetaData>
#include <QDirIterator>
#include <QStringList>


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
    setSubFilePaths(findSubFiles(fileInfo.absoluteFilePath()));
    
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

QStringList PlayListItem::subFilePaths() const
{
    return m_subFilesPaths;
}

void PlayListItem::setSubFilePaths(const QStringList &newSubFiles)
{
    m_subFilesPaths = newSubFiles;
}

QStringList PlayListItem::findSubFiles(const QString &path){

    //prepare
    QStringList pSubFiles;
    QString videoPath = path;
    QFileInfo videoInfo(videoPath);

    //to match
    QString videoBaseName = videoInfo.completeBaseName();

    if(videoInfo.exists() && videoInfo.isFile()){
        QDirIterator it(videoInfo.absolutePath(),QDir::Files,QDirIterator::NoIteratorFlags);
        while (it.hasNext()) {
            QString siblingFile = it.next();

            QFileInfo siblingFileInfo(siblingFile);
            if(hasSuffix(siblingFileInfo,{"srt","ass"})){
                if(siblingFileInfo.completeBaseName().startsWith(videoBaseName)){
                    pSubFiles.append(siblingFileInfo.absoluteFilePath());
                }
            }
        }
    }

    return pSubFiles;
}

QString PlayListItem::setDefaultSub()
{
    if(!m_subFilesPaths.isEmpty())
        return m_subFilesPaths.first();
    else
        return "null";
}

bool PlayListItem::hasSuffix(const QFileInfo &fileInfo, const QStringList &suffixes){
    return suffixes.QStringList::contains(fileInfo.suffix(),Qt::CaseInsensitive);
}

void PlayListItem::appendSubFile(const QString &path)
{
    QFileInfo fileInfo(path);
    QString suffix = fileInfo.suffix();
    if( suffix == "srt" || suffix == "ass")
    {
        m_subFilesPaths.append(fileInfo.absoluteFilePath());
    }
}

