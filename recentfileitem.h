#ifndef RECENTFILEITEM_H
#define RECENTFILEITEM_H

#include <QObject>

class RecentFileItem :public QObject
{
    Q_OBJECT

public:
    explicit RecentFileItem(const QString &path, QObject *parent = nullptr);

    Q_INVOKABLE QString filePath() const;
    void setFilePath(const QString &filePath);

    Q_INVOKABLE QString fileName() const;
    void setFileName(const QString &fileName);

private:
    QString m_fileName;
    QString m_filePath;


};




#endif // RECENTFILEITEM_H
