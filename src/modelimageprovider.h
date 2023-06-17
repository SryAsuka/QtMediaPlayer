/*  To Pass the picture obtained by the list to Qml
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#ifndef MODELIMAGEPROVIDER_H
#define MODELIMAGEPROVIDER_H

#include <QAbstractListModel>
#include <QQuickImageProvider>
#include <QUuid>
#include "listitem.h"


class ModelThumnailProvider :public QQuickImageProvider
{
public:
    explicit ModelThumnailProvider(QAbstractItemModel *model)  : QQuickImageProvider(QQuickImageProvider::Image)
    {
        m_model = model;
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize) override
    {
//        int width = 50;
//        int height = 30;
//        Q_UNUSED(requestedSize)

//        if (size)
//            *size = QSize(width, height);

        //将id 和 ListModel 的 标题title 匹配
        QModelIndexList rTitle = m_model->match(m_model->index(0,0),Qt::UserRole + 1 , QVariant::fromValue(id),1, Qt::MatchRecursive);

//        for(auto i = 0 ; i< m_model->rowCount(); i++ ){

//            QString rTitle = qvariant_cast<QString>(m_model->data(m_model->index(i,0),
//                                                                  Qt::UserRole + 1 ));
        qDebug()<<"测试1 " <<rTitle;

            //
//            if(id == rTitle){
        // 将 匹配相同的tltle的request 返回 listItem 中的item的指针
        if(rTitle.size() >0 ){
            ListItem *it = qvariant_cast<ListItem *>(rTitle[0].data(Qt::UserRole));

            //返回指针所在的缩略图的QImage
            if(it){
                return it->thumbnail();
            }

//            }
        }
        return QImage();
    }

private:
    QAbstractItemModel *m_model;

};

#endif // MODELIMAGEPROVIDER_H
