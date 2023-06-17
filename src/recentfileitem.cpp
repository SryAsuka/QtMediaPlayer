#include "recentfileitem.h"

#include <QImage>
#include <QFileInfo>
#include <QUrl>

RecentFileItem::RecentFileItem(const QString &path, QObject *parent) :ListItem(parent)
{
    QFileInfo fileInfo(path);
    QThumbnail th = new QThumbnail(this);

    //获取数据
    setFileName(fileInfo.fileName());
    setFilePath(fileInfo.filePath());
    setThumbtail(th.createThumbnail(fileInfo.filePath(),30));

}

QString RecentFileItem::filePath() const
{
    return m_filePath;
}

void RecentFileItem::setFilePath(const QString &filePath)
{
    m_filePath = filePath;
}

QString RecentFileItem::fileName() const
{
    return m_fileName;
}

void RecentFileItem::setFileName(const QString &fileName)
{
    m_fileName = fileName;
}

QImage RecentFileItem::thumbnail() const
{
    return m_thumbnail;
}

void RecentFileItem::setThumbtail(const QImage &image){
    m_thumbnail = image;
}

