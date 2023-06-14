#define _UNICODE

#include "playlistitem.h"

#include <QFileInfo>
#include <QUrl>
#include <MediaInfo/MediaInfo.h>


PlayListItem::PlayListItem(const QString &path, QObject *parent)
    : QObject(parent)
{
    MediaInfoLib::MediaInfo Mi;

    QFileInfo fileInfo(path);

    //必须要加#define _UNICODE 且使用 std::wstring
    std::wstring spath = path.toStdWString();
    Mi.Open(spath);

    //获取数据
    setFileName(fileInfo.fileName());
    setFilePath(fileInfo.absoluteFilePath());
    setFolderPath(fileInfo.absolutePath());
    
    //使用MediaInfo 传入数据需要以std::wstring格式
    std::wstring DurationInfo = Mi.Get(MediaInfoLib::stream_t::Stream_Video,0,QString("Duration/String4").toStdWString());

    //获取Duration数据
    setDuration(QString::fromStdWString(DurationInfo));

    Mi.Close();
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
