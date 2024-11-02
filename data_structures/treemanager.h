#ifndef TREEMANAGER_H
#define TREEMANAGER_H

#include <QObject>
#include <QVariantList>

#include <QObject>

class TreeNode {
public:
    TreeNode(int val, int idx) : value(val), index(idx), height(1), left(nullptr), right(nullptr) {}

    int value;
    int index;
    int height;
    TreeNode* left;
    TreeNode* right;
};

class TreeManager : public QObject
{
    Q_OBJECT
public:
    explicit TreeManager(QObject *parent = nullptr);
    ~TreeManager();
    Q_INVOKABLE int getRoot();
    Q_INVOKABLE void addNode(int value);
    Q_INVOKABLE int removeNode(int value);
    Q_INVOKABLE QVariantList getTree();

signals:
    void treeChanged();

private:
    TreeNode* root;
    int nextIndex;

    TreeNode* addNode(TreeNode* node, int value);
    TreeNode* removeNode(TreeNode* node, int value);
    void buildTree(TreeNode* node, QVariantList &list);

    TreeNode* findMin(TreeNode* node);
    void deleteTree(TreeNode* node);

    int height(TreeNode* node);
    int getBalance(TreeNode* node);
    void updateHeight(TreeNode* node);
    TreeNode* rotateRight(TreeNode* y);
    TreeNode* rotateLeft(TreeNode* x);
    TreeNode* balance(TreeNode* node);
};

#endif // TREEMANAGER_H
