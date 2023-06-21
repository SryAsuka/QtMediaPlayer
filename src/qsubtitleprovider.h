#ifndef QSUBTITLEPROVIDER_H
#define QSUBTITLEPROVIDER_H

#include <QObject>

#include <QObject>
#include <QStringList>
#include "srtparser.h"
#include "playlistmodel.h"


class QSubtitleProvider : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString subText MEMBER m_subText READ subText WRITE setSubText NOTIFY subTextChanged)


public:
    QSubtitleProvider(QObject *parent = nullptr);


    void selectedSubFile(const QString &path);

    void readSrtSubFile(const QString &path);
    Q_INVOKABLE void getSrtSubText(double playTime);

    void setSubText(QString text);
    Q_INVOKABLE QString subText();

Q_SIGNALS:
    void subTextChanged();


private:

    std::vector<SubtitleItem *> m_srtSub;

    QString m_subText;

};

#endif // QSUBTITLEPROVIDER_H
