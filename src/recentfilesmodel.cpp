/*  To get Get the videos recently
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#include "recentfilesmodel.h"
#include "recentfileitem.h"

#include <QUrl>
#include <QVariant>
#include <QFileInfo>
#include <QMimeData>
#include <QMimeDatabase>
#include <QSettings>
#include <QImage>

RecentFilesModel::RecentFilesModel(QObject *parent):
   QAbstractListModel(parent)
{

    updateList();
    QSettings setting;
    qDebug()<<setting.value("recentFiles");
//    clear();

}
RecentFilesModel::~RecentFilesModel(){
    qDeleteAll(m_recentList);
    m_recentList.clear();

}


int RecentFilesModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_recentList.size();
}

QHash<int, QByteArray> RecentFilesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ItemRole] = "item";
    roles[TitleRole] = "title";
    roles[PathRole] = "path";
    return roles;
}

QVariant RecentFilesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || m_recentList.empty())
        return QVariant("");

    auto recentFileItem = m_recentList.at(index.row());
    switch (role) {
    case ItemRole:
        return QVariant::fromValue(recentFileItem);
    case TitleRole:
        return QVariant::fromValue(recentFileItem->fileName());
    case PathRole:
        return QVariant::fromValue(recentFileItem->filePath());
    }

    return QVariant("");
}


QMimeType RecentFilesModel::mimeTypeCheck(const QUrl url){

    QMimeDatabase db;
    QMimeType mimeType = db.mimeTypeForUrl(url);

    return mimeType;

}

void RecentFilesModel::updateRecent(const QString &path){
    QUrl currentUrl(path);
    QMimeType mimeType = mimeTypeCheck(currentUrl);
    QFileInfo openedFileInfo(currentUrl.toLocalFile());
    qDebug()<<openedFileInfo.absoluteFilePath();

    if(mimeType.name().startsWith("video/")){
        QSettings settings;

        //读取setting中的“recentfiles”
        QStringList recentFilePaths = settings.value("recentFiles").toStringList();

        //将最近打开的文件置顶
        //检索同名文件，将其删除
        recentFilePaths.removeAll(openedFileInfo.absoluteFilePath());
        //插入文件
        recentFilePaths.prepend(openedFileInfo.absoluteFilePath());
        //删除超过最大值的文件路径
        while(recentFilePaths.size() > getMaxNum()){
            recentFilePaths.removeLast();
        }

        settings.setValue("recentFiles",recentFilePaths);

        //update Recent List
        updateList();

        QSettings setting;
        qDebug()<<setting.value("recentFiles");
    }
}

void RecentFilesModel::updateList(){

    QSettings settings;
    QStringList recentFilePaths = settings.value("recentFiles").toStringList();
//    qDebug()<<itEnd<<"";

    int itEnd = 0;
    if(recentFilePaths.size() <= getMaxNum() ){
        itEnd = recentFilePaths.size();
    }else
        itEnd = getMaxNum();

    qDebug()<<m_recentList;


    beginResetModel();

    beginInsertRows(QModelIndex(),0,itEnd-1);
    m_recentList.clear();
    for (int i = 0; i < itEnd; ++i) {
        auto item = new RecentFileItem(recentFilePaths.at(i),this);
        m_recentList.append(item);
    }
    endInsertRows();


    endResetModel();
}

void RecentFilesModel::clear()
{
    QSettings setting;
    setting.clear();
    setting.remove("recentFiles");
    updateList();
}

int RecentFilesModel::getMaxNum() const{
    return m_maxNum;
}

void RecentFilesModel::setMaxNum(int num){
    m_maxNum = num;
    Q_EMIT maxNumChanged();
}



