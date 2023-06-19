/**
 * 作者：范榆康
 * 日期：2023.6.19上午
 * 将弹幕内容存为XML文件
 */

#ifndef BULLETXML_H
#define BULLETXML_H

#include <QDomDocument>
#include <QObject>

class BulletXml : public QObject
{
    Q_OBJECT
private:
    /**
     * @brief 弹幕格式
     */
    struct Danmu {
        QString timestamp;
        QString content;
        int fontsize;
        QString color;
    };

    QString filepath;

public:
    BulletXml();

    /**
     * @brief 初始化弹幕
     * @param filepath 视频文件所在文件夹路径
     * @param title 视频名称
     */
    Q_INVOKABLE
        void initDanmu (QString filepath, QString title);

    /**
     * @brief 暴露给qml函数，保存弹幕
     * @param timestamp 时间戳
     * @param content 弹幕内容
     * @param fontsize 文字大小，默认10
     * @param color 文字颜色，默认黑色
     */
    Q_INVOKABLE
        void saveDanmu(const QString& timestamp, const QString& content, int fontsize = 10, const QString& color = "black");

    /**
     * @brief 将弹幕存为XML文件
     * @param danmu 弹幕结构体
     */
    void saveToXML(const Danmu& danmu);
};

#endif // BULLETXML_H
