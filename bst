#include<iostream>
#include<stdlib.h>
using namespace std;

///structure Node declaration
struct Node
{
    int data;
    struct Node *rchild;
    struct Node *lchild;
};

///class BST declaration
class BST
{
    struct Node *root;
public:
    BST()
    {
        root = NULL;
    }
    Node* create(int data);
    void Insert(struct Node* &root,int data);
    void displayPreorder(struct Node* root);
    void displayInorder(struct Node* root);
    void displayPostorder(struct Node* root);
    void Search(struct Node *root,int elt);
    int Count(struct Node* root);
    int findMax(struct Node* root);
    int findMin(struct Node* root);
    int sum(struct Node* root);
    int height(struct Node* root);
    Node* Mirror(struct Node* root);
    void levelOrder(struct Node* root);
    void currentLevelOrder(struct Node* root,int level);
    Node* findPre(struct Node* root,int key);
    Node* findSuc(struct Node* root,int key);
};

///Node creation
Node* BST::create(int data)
{
    struct Node *n = new Node;
    n->data = data;
    n->rchild = n->lchild = NULL;
    return n;
}

///Node Insertion
void BST::Insert(struct Node* &root,int data)
{
    if(root == NULL)
    {
        root = create(data);
    }
    else if(root->data > data)
    {
        Insert(root->lchild,data);
    }
    else
    {
        Insert(root->rchild,data);
    }
}

///Preorder
void BST::displayPreorder(struct Node *root)
{
    if(root != NULL)
    {
        cout<<root->data<<"-->";
        displayPreorder(root->lchild);
        displayPreorder(root->rchild);
    }
}

///Postorder
void BST::displayPostorder(struct Node *root)
{
    if(root != NULL)
    {
        displayPostorder(root->lchild);
        displayPostorder(root->rchild);
        cout<<root->data<<"-->";
    }
}

///Inorder
void BST::displayInorder(struct Node *root)
{
    if(root != NULL)
    {
        displayInorder(root->lchild);
        cout<<root->data<<"-->";
        displayInorder(root->rchild);
    }
}

///Search
void BST::Search(struct Node *root,int elt)
{
    if(root == NULL)
    {
        cout<<"Key Not found"<<endl;
        return;
    }
    if(root->data > elt)
    {
        Search(root->lchild,elt);
    }
    if(root->data == elt)
    {
        cout<<"Found"<<endl;
        return ;
    }
    else
    {
        Search(root->rchild,elt);
    }
}

///Count
int BST :: Count(struct Node* root)
{
    if(root == NULL)
    {
        return 0;
    }
    else
    {
        return Count(root->lchild) + 1 + Count(root->rchild);
    }
}

///Maximum
int BST :: findMax(struct Node* root)
{
    if(root == NULL)
    {
        return 0;
    }
    if(root->rchild == NULL)
    {
        return root->data;
    }
    else
    {
        return findMax(root->rchild);
    }
}

///Minimum
int BST :: findMin(struct Node* root)
{
    if(root == NULL)
    {
        return 0;
    }
    if(root->lchild == NULL)
    {
        return root->data;
    }
    else
    {
        return findMin(root->lchild);
    }
}

///Sum
int BST :: sum(struct Node* root)
{
    if(root == NULL)
    {
        return 0;
    }
    if(root != NULL)
    {
        return root->data + sum(root->lchild) + sum(root->rchild);
    }
}

///Height of the tree
int BST :: height(struct Node* root)
{
    int left,right;
    if(root == NULL)
    {
        return 0;
    }
    else
    {
        left = height(root->lchild);
        right = height(root->rchild);
        return max(left,right) + 1;
    }
}

///Mirror of the BST
Node* BST :: Mirror(struct Node* root)
{
    ///mirror of inorder traversal
    if(root == NULL)
        return NULL;
   struct Node* n = create(root->data);
   n->lchild = Mirror(root->rchild);
   n->rchild = Mirror(root->lchild);
   return n;
}

///Level Order traversal
void BST :: levelOrder(struct Node* root)
{
    int h,i;
    h = height(root);
    for(i=1; i<=h; i++)
    {
        currentLevelOrder(root,i);
    }
}

///Current level order traversal
void BST :: currentLevelOrder(struct Node* root,int level)
{
    if(root == NULL)
    {
        return ;
    }
    if(level == 1)
    {
        cout<<root->data<<endl;
    }
    else if(level > 1)
    {
        currentLevelOrder(root->lchild,level-1);
        currentLevelOrder(root->rchild,level-1);
    }
}

///Predecessor
Node* BST :: findPre(struct Node* root,int key)
{
    struct Node* pre = NULL;
    if(root == NULL)
    {
        return NULL;
    }
    while(root != NULL)
    {
        if(root->data < key)
        {
            pre = root;
            root = root->rchild;
        }
        else if(root->data > key)
        {
            root = root->lchild;
        }
        else
        {
            if(root->lchild != NULL)
            {
                struct Node* temp;
                temp = root->lchild;
                while(temp->rchild != NULL)
                {
                    temp = temp->rchild;
                }
                pre = temp;
            }
            break;
        }
    }
    return root != NULL ? pre : NULL;
}

///Successor
Node* BST :: findSuc(struct Node* root,int key)
{
    struct Node* suc = NULL;
    if(root == NULL)
    {
        return NULL;
    }
    while(root != NULL)
    {
        if(root->data > key)
        {
            suc = root;
            root = root->lchild;
        }
        else if(root->data < key)
        {
            root = root->rchild;
        }
        else
        {
            if(root->rchild != NULL)
            {
                struct Node* temp;
                temp = root->rchild;
                while(temp->lchild != NULL)
                {
                    temp = temp->lchild;
                }
                suc = temp;
            }
            break;
        }
    }
    return root != NULL ? suc : NULL;
}

///main begins
int main()
{
    BST b;
    struct Node *root = NULL;
    struct Node* mirror = NULL;
    struct Node* pre = NULL;
    struct Node* suc = NULL;
    int i,data,n,choice,elt,key;
    while(1)
    {
        cout<<"1.Insert BST"<<endl;
        cout<<"2.Display BST"<<endl;
        cout<<"3.Search in BST"<<endl;
        cout<<"4.Count"<<endl;
        cout<<"5.Maximum"<<endl;
        cout<<"6.Minimum"<<endl;
        cout<<"7.Sum of all keys"<<endl;
        cout<<"8.Height of BST "<<endl;
        cout<<"9.Mirror of BST "<<endl;
        cout<<"10.Level Order Traversal in BST"<<endl;
        cout<<"11.Predecessor"<<endl;
        cout<<"12.Successor"<<endl;
        cout<<"Enter your choice : ";
        cin>>choice;
        switch(choice)
        {
        case 1 :
            cout<<"Enter the no.of nodes to be inserted : ";
            cin>>n;
            for(i=0; i<n; i++)
            {
                cout<<"Enter the data : ";
                cin>>data;
                b.Insert(root,data);
            }
            break;
        case 2 :
            cout<<"PREORDER"<<endl;
            b.displayPreorder(root);
            cout<<"\n";
            cout<<"INORDER"<<endl;
            b.displayInorder(root);
            cout<<"\n";
            cout<<"POSTORDER"<<endl;
            b.displayPostorder(root);
            cout<<"\n";
            break;
        case 3 :
            cout<<"Enter the element to be searched : ";
            cin>>elt;
            b.Search(root,elt);
            break;
        case 4 :
            cout<<"Enter the number of nodes in the tree : "<<b.Count(root)<<endl;
            break;
        case 5 :
            cout<<"The maximum element of the binary search tree : "<<b.findMax(root)<<endl;
            break;
        case 6 :
            cout<<"The minimum element of the binary search tree : "<<b.findMin(root)<<endl;
            break;
        case 7 :
            cout<<"The sum of all keys of BST : "<<b.sum(root)<<endl;
            break;
        case 8 :
            cout<<"The height of binary search tree : "<<b.height(root)<<endl;
            break;
        case 9 :
            mirror = b.Mirror(root);
            b.displayInorder(mirror);
            cout<<endl;
            break;
        case 10 :
            b.levelOrder(root);
            break;
        case 11 :
            cout<<"Enter the key value : ";
            cin>>key;
            pre = b.findPre(root,key);
            if(pre != NULL)
            {
                cout<<pre->data;
            }
            else
            {
                cout<<"No inorder predecessor exists"<<endl;
            }
            break;
        case 12 :
            cout<<"Enter the key value : ";
            cin>>key;
            suc = b.findSuc(root,key);
            if(suc != NULL)
            {
                cout<<suc->data;
            }
            else
            {
                cout<<"No inorder successor exists"<<endl;
            }
            break;
        default:
            exit(0);
        }
    }
    ///main ends
    return 0;
}



