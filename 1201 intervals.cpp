#include<iostream>
using namespace std;
const int nMax = 50005;
const int eMax = 500000;
const int inf = 0xffffff;

 
struct node{
    int v, w, next;
}edge[nMax * 4];
int k, max_num, edgeHead[nMax], dict[nMax];     // dict[i]表示区间[0, i]上的整点数。
int queue[eMax];
bool vis[nMax];

 
void add_edge(int u, int v, int w){    // 新增加的约束条件，即新增边。
    edge[k].v = v;
    edge[k].w = w;
    edge[k].next = edgeHead[u];
    edgeHead[u] = k;
    k ++;
}

 
void spfa(){
    int head = 0, tail = 1;
    for(int i = 0; i <= max_num; i ++)
        dict[i] = -inf;
    dict[0] = 0;
    queue[0] = 0;
    while(tail > head){
        int u = queue[head];
        vis[u] = true;
        for(int p = edgeHead[u]; p != 0; p = edge[p].next){
            int v = edge[p].v;
            if(dict[v] < dict[u] + edge[p].w){
                dict[v] = dict[u] + edge[p].w;
                if(!vis[v]){
                    vis[v] = true;
                    queue[tail ++] = v;

                    //  循环队列：if(tail == nMax) tail = 0;
                }
            }
        }
        vis[u] = false;
        head ++;

        //  循环队列：if(head == nMax) head = 0;
    }
}

 
int main(){
    int n;
    scanf("%d", &n);
    max_num = 0;
    k = 1;     //   由于spfa边存在与否的判断条件为p != 0，故k不能初始化为0。
    while(n --){
        int u, v, w;
        scanf("%d%d%d", &u, &v, &w);
        if(v + 1 > max_num) max_num = v + 1;
        add_edge(u, v + 1, w);     //  一般为(u - 1, v, w)，但这道题为了防止溢出用v + 1。

    }
    for(int i = 0; i <= max_num; i ++){
        add_edge(i, i + 1, 0);
        add_edge(i + 1, i, -1);
    }
    spfa();
    printf("%d\n", dict[max_num]);
    system("pause");
    return 0;
}
