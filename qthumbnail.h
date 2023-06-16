#ifndef QTHUMBNAIL_H
#define QTHUMBNAIL_H

#include <QObject>

class QThumbnail : public QObject
{

    Q_OBJECT

public:
    QThumbnail(QObject *parent = nullptr);

    QImage createThumbnail(const QString &path,int width);

};

#endif // QTHUMBNAIL_H
