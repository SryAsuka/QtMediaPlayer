#include "recentfileitem.h"


#include <QFileInfo>
#include <QUrl>

RecentFileItem::RecentFileItem(const QString &path, QObject *parent) :QObject(parent)
{
    QFileInfo fileInfo(path);

    //获取数据
    setFileName(fileInfo.fileName());
    setFilePath(fileInfo.filePath());

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
