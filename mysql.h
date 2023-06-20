#ifndef MYSQL_H
#define MYSQL_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlField>
#include <QSqlRecord>
#include <QDebug>
#include<QVector>
#include<QString>
#include<QVariantList>
class MySql : public QObject
{
    Q_OBJECT
public:
    explicit MySql(QObject *parent = 0);
    ~MySql();
    bool init();
    bool closeSql();

    Q_INVOKABLE void selectContextData();
//    Q_INVOKABLE void insertData();
//    Q_INVOKABLE void deleteData();
//    Q_INVOKABLE void updateData();
    Q_INVOKABLE QStringList getMsgList();
   // Q_INVOKABLE void setMsgList(QVector<QString> mlist);


signals:
    //信号：发送查询到的数据
    void sendQueryInfo(QStringList  mContexts);
//    //信号：将查询到的数据放在qml的数组中 用于后续显示
//    void insetList(QString context);
    //信号：通知QML更新视图
    void updateView();
private:
    QSqlDatabase db;
    QStringList  msg;

};

Q_DECLARE_METATYPE(MySql)

#endif // MYSQL_H

