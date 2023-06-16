#ifndef LISTITEM_H
#define LISTITEM_H

#include <QObject>
#include <QImage>

class ListItem : public QObject
{
    Q_OBJECT
public:
    explicit ListItem(QObject *parent = nullptr){}

    virtual QImage thumbnail() const{
        return QImage();
    }

signals:

};

#endif // LISTITEM_H
