#include "treemanager.h"
#include <QDebug>
#include <algorithm>

TreeManager::TreeManager(QObject *parent) : QObject(parent), root(nullptr), nextIndex(0) {}

TreeManager::~TreeManager() {
    deleteTree(root);
}

void TreeManager::addNode(int value) {
    root = addNode(root, value);
    emit treeChanged();
}

TreeNode* TreeManager::addNode(TreeNode* node, int value) {
    if (!node) {
        return new TreeNode(value, nextIndex++);
    } else if (value < node->value) {
        node->left = addNode(node->left, value);
    } else if (value > node->value) {
        node->right = addNode(node->right, value);
    } else {
        return node;
    }

    updateHeight(node);
    return balance(node);
}

int TreeManager::removeNode(int value) {
    root = removeNode(root, value);
    emit treeChanged();
    return value;
}

TreeNode* TreeManager::removeNode(TreeNode* node, int value) {
    if (!node) return nullptr;

    if (value < node->value) {
        node->left = removeNode(node->left, value);
    } else if (value > node->value) {
        node->right = removeNode(node->right, value);
    } else {
        if (!node->left) {
            TreeNode* temp = node->right;
            delete node;
            return temp;
        } else if (!node->right) {
            TreeNode* temp = node->left;
            delete node;
            return temp;
        } else {
            TreeNode* temp = findMin(node->right);
            node->value = temp->value;
            node->index = temp->index;
            node->right = removeNode(node->right, temp->value);
        }
    }

    updateHeight(node);
    return balance(node);
}

TreeNode* TreeManager::findMin(TreeNode* node) {
    while (node && node->left) {
        node = node->left;
    }
    return node;
}

void TreeManager::deleteTree(TreeNode* node) {
    if (node) {
        deleteTree(node->left);
        deleteTree(node->right);
        delete node;
    }
}

QVariantList TreeManager::getTree() {
    QVariantList list;
    buildTree(root, list);
    std::sort(list.begin(), list.end(), [](const QVariant &a, const QVariant &b) {
        return a.toMap()["index"].toInt() < b.toMap()["index"].toInt();
    });
    return list;
}

int TreeManager::getRoot()
{
    return root->index;
}

void TreeManager::buildTree(TreeNode* node, QVariantList &list) {
    if (!node) return;

    QVariantMap nodeMap;
    nodeMap["value"] = node->value;
    nodeMap["index"] = node->index;
    nodeMap["left"] = node->left ? node->left->index : -1;
    nodeMap["right"] = node->right ? node->right->index : -1;

    list.append(nodeMap);

    buildTree(node->left, list);
    buildTree(node->right, list);
}


int TreeManager::height(TreeNode* node) {
    return node ? node->height : 0;
}

int TreeManager::getBalance(TreeNode* node) {
    return node ? height(node->left) - height(node->right) : 0;
}

void TreeManager::updateHeight(TreeNode* node) {
    if (node) {
        node->height = 1 + std::max(height(node->left), height(node->right));
    }
}

TreeNode* TreeManager::rotateRight(TreeNode* y) {
    TreeNode* x = y->left;
    TreeNode* T2 = x->right;

    x->right = y;
    y->left = T2;

    updateHeight(y);
    updateHeight(x);

    return x;
}

TreeNode* TreeManager::rotateLeft(TreeNode* x) {
    TreeNode* y = x->right;
    TreeNode* T2 = y->left;

    y->left = x;
    x->right = T2;

    updateHeight(x);
    updateHeight(y);
    return y;
}

TreeNode* TreeManager::balance(TreeNode* node) {
    updateHeight(node);

    int balanceFactor = getBalance(node);

    if (balanceFactor > 1) {
        if (getBalance(node->left) < 0) {
            node->left = rotateLeft(node->left);
        }
        return rotateRight(node);
    }

    if (balanceFactor < -1) {
        if (getBalance(node->right) > 0) {
            node->right = rotateRight(node->right);
        }
        return rotateLeft(node);
    }

    if (node->left) {
        node->left = balance(node->left);
    }
    if (node->right) {
        node->right = balance(node->right);
    }

    return node;
}
