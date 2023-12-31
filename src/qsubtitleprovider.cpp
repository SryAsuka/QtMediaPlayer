/*  To abstract the recent/play list , make get thumbnail easier
 *  Author: SryAsuka
 *  Data: 2023.6
**/

#include "qsubtitleprovider.h"

#include <QString>
#include <QFileInfo>
#include <QDir>
#include <QStringList>

QSubtitleProvider::QSubtitleProvider(QObject *parent)
{
    //    readSubFile("/root/tmp/Three.Little.Pigs.1933.srt");
}

void QSubtitleProvider::selectedSubFile(const QString &path)
{
    QFileInfo fileInfo(path);
    QString suffix = fileInfo.suffix();
    if(suffix == "srt"){
        qDebug()<<"The file is an STR file";
        m_srtSub.clear();
        m_subText.clear();
        emit subTextChanged();
        readSrtSubFile(fileInfo.absoluteFilePath());
    } else if(suffix == "ass"){
        qDebug()<<"The file is an ASS file,but no method to parser";
    } else if(suffix == "null"){
        qDebug()<<"do not show";
        m_srtSub.clear();
        m_subText.clear();
        emit subTextChanged();
    }else{
        qDebug()<<"error subtitle";
        m_srtSub.clear();
        m_subText.clear();
        emit subTextChanged();
    }
}

void QSubtitleProvider::readSrtSubFile(const QString &path)
{
    QFileInfo fileInfo(path);
    if(fileInfo.exists()){
        SubtitleParserFactory *subParserFactory = new SubtitleParserFactory(path.toStdString());
        SubtitleParser *parser = subParserFactory->getParser();

        m_srtSub = parser->getSubtitles();
        qDebug()<<"sucess srt";
    }else
        qDebug()<<"error srt";
}

void QSubtitleProvider::getSrtSubText(double playTime){
    for(SubtitleItem* element : m_srtSub){
        double startTime = element->getStartTime();
        double endTime = element->getEndTime();
        if( (startTime <= playTime) && (playTime <= endTime)) {
            setSubText(QString::fromStdString(element->getText()));
        }
    }
}

void QSubtitleProvider::setSubText(QString text){
    m_subText = text;
    emit subTextChanged();
}

QString QSubtitleProvider::subText(){
    return m_subText;
}
