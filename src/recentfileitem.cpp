/*  To get Get the videos recently
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#include "recentfileitem.h"
#include <string>

#include <QImage>
#include <QFileInfo>
#include <QUrl>
#include <QString>

RecentFileItem::RecentFileItem(const QString &path, QObject *parent) :ListItem(parent)
{
    QFileInfo fileInfo(path);
    QThumbnail th = new QThumbnail(this);

    if(fileInfo.exists()){
        //获取数据
        setFileName(fileInfo.fileName());
        setFilePath(fileInfo.filePath());
        qDebug()<<fileInfo.filePath();
        setThumbtail(th.createThumbnail(fileInfo.filePath(),40));

    }else{
        //return no_video
        std::string cPath = path.toStdString();
        std::string cName = cPath.substr(cPath.find_last_of("/")+1);
        setFileName(QString::fromStdString(cName));
        setFilePath("null");
        setThumbtail(QImage(":/assets/picture/no_video.png"));
    }

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

