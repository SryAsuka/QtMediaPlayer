#include "mysql.h"

MySql::MySql(QObject *parent) : QObject(parent)
{
    init();
}//初始化

MySql::~MySql()
{
    closeSql();
}//销毁

bool MySql::init()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMARIADB");
    db.setHostName("localhost");
    db.setDatabaseName("barrage");
    db.setUserName("root");
    db.setPassword("zhengyawen666");
    if (!db.open()) {
        return db.open();
    } else {
        return true;
    }
}

bool MySql::closeSql()
{
    db.close();
    return false;
}

//查询数据 将id为1的用户的评论全部查询出来并且带回去
void MySql::selectContextData()
{
    QSqlQuery query;
    query.prepare(QString("select context from context where id = '1' ;"));
    if(query.exec()){
        while (query.next()) {
            QString context = query.value("context").toString();
            msg.append(context);
            emit sendQueryInfo(msg);
        }

    }
}

QStringList  MySql::getMsgList()
{
    return msg;
}
    ////插入新数据
//void mysql::insertData()
//{
//    QSqlQuery query;

//    query.exec(QString("insert into test(id,name) values(5,'ZhangSan');"));
//    //插入新数据后，发射信号，告诉视图进行更新
//    emit updateView();

//}

////删除数据
//void mysql::deleteData()
//{
//    QSqlQuery query;

//    query.exec(QString("delete from test where id = 1;"));
//    //删除数据后，发射信号，告诉视图进行更新
//    emit updateView();
//}

////更改数据
//void mysql::updateData()
//{
//    QSqlQuery query;

//    query.exec(QString("update test set name = 'LiSi' where id = 5;"));
//    //删除数据后，发射信号，告诉视图进行更新
//    emit updateView();
//}

