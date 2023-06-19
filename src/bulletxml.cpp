#include "bulletxml.h"
#include <QFile>
#include <QTextStream>
#include <QDebug>

BulletXml::BulletXml()
{

}

void BulletXml::initDanmu(QString filepath, QString title)
{
    this->filepath = filepath;

    // 去除最后一个 . 之后的内容
    title = title.section('.', 0, -2);

    this->filepath.append(title).append(".xml");
}

void BulletXml::saveDanmu(const QString &timestamp, const QString &content, int fontsize, const QString &color)
{
    Danmu danmu { timestamp, content, fontsize, color };
    saveToXML(danmu);
}

void BulletXml::saveToXML(const Danmu &danmu)
{
    // 创建QDomDocument对象
    QDomDocument doc;

    // 创建XML头部
    QDomProcessingInstruction instruction;
    instruction = doc.createProcessingInstruction("xml", "version=\"1.0\" encoding=\"UTF-8\"");
    doc.appendChild(instruction);

    // 创建根元素
    QDomElement root = doc.createElement("DanmuInfo");
    doc.appendChild(root);

    // 创建弹幕元素
    QDomElement danmuElement = doc.createElement("Danmu");

    // 添加时间戳
    QDomElement timestampElement = doc.createElement("Timestamp");
    QDomText timestampText = doc.createTextNode(danmu.timestamp);
    timestampElement.appendChild(timestampText);
    danmuElement.appendChild(timestampElement);

    // 添加内容
    QDomElement contentElement = doc.createElement("Content");
    QDomText contentText = doc.createTextNode(danmu.content);
    contentElement.appendChild(contentText);
    danmuElement.appendChild(contentElement);

    // 添加大小
    QDomElement sizeElement = doc.createElement("Size");
    QDomText sizeText = doc.createTextNode(QString::number(danmu.fontsize));
    sizeElement.appendChild(sizeText);
    danmuElement.appendChild(sizeElement);

    // 添加颜色
    QDomElement colorElement = doc.createElement("Color");
    QDomText colorText = doc.createTextNode(danmu.color);
    colorElement.appendChild(colorText);
    danmuElement.appendChild(colorElement);

    root.appendChild(danmuElement);

    // 保存到文件
    QFile file(filepath);

    if(!file.open(QIODevice::WriteOnly | QIODevice::Append | QIODevice::Text))
    {
        qDebug() << "Error: Cannot write file" << file.errorString();
        return;
    }
    QTextStream out(&file);
    doc.save(out, 4);  // 缩进为4
    file.close();
}
