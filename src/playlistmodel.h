/*  To get Get the videos in the same directory
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#ifndef PLAYLISTMODEL_H
#define PLAYLISTMODEL_H


#include <QAbstractTableModel>
#include <QQmlEngine>
#include <map>
#include <memory>
#include <QList>
#include <QMimeData>
#include <QMimeDatabase>

class PlayListItem;

using Playlist = QList<PlayListItem *>;


class PlayListModel : public QAbstractListModel
{
    Q_OBJECT

//    QML_ELEMENT

    Q_PROPERTY(bool isSibling MEMBER m_isSibling READ getIsSibling WRITE setIsSibling NOTIFY isSiblingChanged)

public:
    explicit PlayListModel(QObject *parent = nullptr);
    ~PlayListModel();

    enum {
        ItemRole = Qt::UserRole,
        TitleRole,
        PathRole,
        FolderPathRole,
        DurationRole,
    };

    //Listmodel 起手三样式
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    //清除记录
    Q_INVOKABLE void clear();

    //打开文件文件
    Q_INVOKABLE void openFile(const QString &path);


    //添加单个Item
    Q_INVOKABLE void appendItem(QUrl url);
    //移除单个Item
    Q_INVOKABLE void removeItem(int index);
    //get Path
    Q_INVOKABLE QString getPath(int index = -1);


    //MimeType分析函数
    QMimeType mimeTypeCheck(const QUrl url);

    //返回视频相应的字幕list
    Q_INVOKABLE QStringList subFilePaths(int index = -1);
    Q_INVOKABLE void appendSubFile(int index,const QString &path);
    Q_INVOKABLE QString setDefaultSub(int index = -1);

    //get,set,Changed
    Q_INVOKABLE bool getIsSibling() const;
    Q_INVOKABLE void setIsSibling(bool is);




Q_SIGNALS:
    void isSiblingChanged();
    void itemAdded(int index, QString path);
    void itemRemoved(int index, QString path);

private:

    //存放普通ListItem
    Playlist m_playlist;



    //find sibling Item 同目录下寻找
    void getSiblingItems(QUrl url);
    bool m_isSibling{true};

};

#endif // PLAYLISTMODEL_H
