#ifndef MYSQL_H
#define MYSQL_H

#include <QObject>

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QSqlField>
#include <QSqlRecord>
#include <QDebug>



class mysql : public QObject
{
    Q_OBJECT
public:
    explicit mysql(QObject *parent = 0);
    ~mysql();
    bool init();
    bool closeSql();

    Q_INVOKABLE void selectAllData();
    Q_INVOKABLE void insertData();
    Q_INVOKABLE void deleteData();
    Q_INVOKABLE void updateData();


signals:
    //信号：发送查询到的数据
    void sendQueryInfo(int mID,QString mName);
    //信号：通知QML更新视图
    void updateView();
private:
    QSqlDatabase db;

};

#endif // MYSQL_H

