#include "mysql.h"

mysql::mysql(QObject *parent) : QObject(parent)
{
    init();
}//初始化

mysql::~mysql()
{
    closeSql();
}//销毁

bool mysql::init()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMARIADB");
    db.setHostName("localhost");
    db.setDatabaseName("test");
    db.setUserName("root");
    db.setPassword("zhengyawen666");
    if (!db.open()) {
        return db.open();
    } else {
        return true;
    }
}

bool mysql::closeSql()
{
    db.close();
    return false;
}

//查询数据
void mysql::selectAllData()
{
    QSqlQuery query;
    query.prepare(QString("SELECT * FROM test;"));
    if(query.exec()){
        while (query.next()) {
            int id = query.value("id").toInt();
            QString name = query.value("name").toString();

            emit sendQueryInfo(id,name);
        }

    }
}

//插入新数据
void mysql::insertData()
{
    QSqlQuery query;

    query.exec(QString("insert into test(id,name) values(5,'ZhangSan');"));
    //插入新数据后，发射信号，告诉视图进行更新
    emit updateView();

}

//删除数据
void mysql::deleteData()
{
    QSqlQuery query;

    query.exec(QString("delete from test where id = 1;"));
    //删除数据后，发射信号，告诉视图进行更新
    emit updateView();
}

//更改数据
void mysql::updateData()
{
    QSqlQuery query;

    query.exec(QString("update test set name = 'LiSi' where id = 5;"));
    //删除数据后，发射信号，告诉视图进行更新
    emit updateView();
}

