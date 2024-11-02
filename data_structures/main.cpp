#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "heapmanager.h"
#include "treemanager.h"
#include <iostream>
#include "graphmanager.h"

void printTreeStructure(TreeManager &manager) {
    QVariantList tree = manager.getTree();
    for (const QVariant &node : tree) {
        QVariantMap nodeMap = node.toMap();
        std::cout << "Index: " << nodeMap["index"].toInt()
                  << ", Value: " << nodeMap["value"].toInt()
                  << ", Left: " << (nodeMap["left"].toInt() == -1 ? "null" : QString::number(nodeMap["left"].toInt()).toStdString())
                << ", Right: " << (nodeMap["right"].toInt() == -1 ? "null" : QString::number(nodeMap["right"].toInt()).toStdString())
                << std::endl;
    }
}

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    HeapManager heapManager;
    TreeManager treeManager;
    GraphManager graphManager;
    engine.rootContext()->setContextProperty("heapManager", &heapManager);
    engine.rootContext()->setContextProperty("treeManager", &treeManager);
    engine.rootContext()->setContextProperty("graphManager", &graphManager);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
