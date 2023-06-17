/*  To get Get the videos recently
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#ifndef RECENTFILESMODEL_H
#define RECENTFILESMODEL_H

#include <QAbstractListModel>
#include <QQmlEngine>
#include <map>
#include <memory>
#include <QList>
#include <QMimeData>
#include <QMimeDatabase>


class RecentFileItem;

using RecentList = QList<RecentFileItem *>;


class RecentFilesModel: public QAbstractListModel
{
        Q_OBJECT


        Q_PROPERTY(int MaxNum MEMBER m_maxNum READ getMaxNum WRITE setMaxNum NOTIFY maxNumChanged)

public:
   explicit RecentFilesModel(QObject *parent = nullptr);
    ~RecentFilesModel();

    enum {
        ItemRole = Qt::UserRole,
        TitleRole,
        PathRole,
    };

    //Listmodel 起手三样式
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;


    //清除QSetting中的记录
    Q_INVOKABLE void clear();

    //更新QSetting记录,更新对应List
    Q_INVOKABLE void updateRecent(const QString &path);
    void updateList();


    //MimeType分析函数
    QMimeType mimeTypeCheck(const QUrl url);

    //get,set,changed
    Q_INVOKABLE int getMaxNum() const;
    Q_INVOKABLE void setMaxNum(int num);


Q_SIGNALS:
    void maxNumChanged();
    void itemAdded(int index, QString path);
    void itemRemoved(int index, QString path);




private:

//    RecentList m_recentList;
    RecentList m_recentList;

    int m_maxNum{5};


};

#endif // RECENTFILESMODEL_H
