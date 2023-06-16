#ifndef RECENTFILEITEM_H
#define RECENTFILEITEM_H
#include "qthumbnail.h"
#include "listitem.h"

#include <QObject>

class RecentFileItem :public ListItem
{
    Q_OBJECT

public:
    explicit RecentFileItem(const QString &path, QObject *parent = nullptr);

    Q_INVOKABLE QString filePath() const;
    void setFilePath(const QString &filePath);

    Q_INVOKABLE QString fileName() const;
    void setFileName(const QString &fileName);

    Q_INVOKABLE QImage thumbnail() const override;

    void setThumbtail(const QImage &image);



private:
    QString m_fileName;
    QString m_filePath;

    QImage m_thumbnail;

};




#endif // RECENTFILEITEM_H
