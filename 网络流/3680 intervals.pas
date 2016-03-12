const maxn=555; inf=maxlongint; maxq=1002000;
type rec=record x,y:longint; end;
     node=record u,v,c,key,op,nxt:longint; end;
var test,u,n,m,k,i,j,s,t,cnt,tot,ans:longint;
    st,ed,v:array[0..maxn]of longint;
    a,b,h:array[0..2*maxn]of longint;
    f:array[0..maxn]of rec;
    dis,fa,edge,hash:array[0..maxn]of longint;
    q:array[0..maxq]of longint;
    mark:array[0..maxn]of boolean;
    g:array[0..7*maxn]of node;
procedure addedge(x,y,flow,cost:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].c:=flow; g[tot].key:=cost;
g[tot].nxt:=edge[x]; edge[x]:=tot; g[tot].op:=tot+1;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].c:=0; g[tot].key:=-cost;
g[tot].nxt:=edge[y]; edge[y]:=tot; g[tot].op:=tot-1;
end;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i);
while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; y:=b[i]; b[i]:=b[j]; b[j]:=y; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
procedure init;
var i:longint;
begin
tot:=0;
for i:=0 to maxn do edge[i]:=0;
fillchar(hash,sizeof(hash),0);
end;
function spfa:boolean;
var i,x,p,head,tail:longint;
begin
for i:=s to t do dis[i]:=-inf;
for i:=s to t do fa[i]:=0;
dis[s]:=0;
head:=1; tail:=1;
q[1]:=s;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
while head<=tail do
  begin
  x:=q[head];
  p:=edge[x];
  while p<>0 do
    begin
    if (dis[x]<>-inf)and(g[p].c>0)and(dis[x]+g[p].key>dis[g[p].v]) then
       begin
       dis[g[p].v]:=dis[x]+g[p].key;
       fa[g[p].v]:=p;
       if not mark[g[p].v] then
          begin
          inc(tail);
          q[tail]:=g[p].v;
          mark[g[p].v]:=true;
          end;
       end;
    p:=g[p].nxt;
    end;
  inc(head);
  mark[x]:=false;
  end;
if dis[t]=-inf then exit(false) else exit(true);
end;
procedure doit;
var p,min:longint;
begin
ans:=0;
while spfa do
  begin
  p:=fa[t];
  min:=inf;
  while p>0 do
    begin
    if g[p].c<min then min:=g[p].c;
    p:=fa[g[p].u];
    end;
  p:=fa[t];
  ans:=ans+dis[t]*min;
  while p>0 do
    begin
//    writeln(g[p].u,' ',g[p].v);
    dec(g[p].c,min);
    inc(g[g[p].op].c,min);
    p:=fa[g[p].u];
    end;
{  writeln('flow:   ',min);
  writeln('cost:   ',dis[t]);  }
  end;
end;
begin
{assign(input,'e:\work\intervals.in');
reset(input);
assign(output,'e:\work\intervals.out');
rewrite(output);}
readln(test);
for u:=1 to test do
    begin
    readln(n,k);
    for i:=1 to n do
        begin
        readln(st[i],ed[i],v[i]);
        a[i*2-1]:=st[i]; b[i*2-1]:=i;
        a[i*2]:=ed[i]; b[i*2]:=i;
        end;
    init;
    sort(1,2*n);
    i:=1;
    cnt:=0;
    while i<=2*n do
      begin
      j:=i;
      while (j+1<=2*n)and(a[j+1]=a[i]) do inc(j);
      inc(cnt);
      for m:=i to j do
          begin
          if st[b[m]]=a[m] then f[b[m]].x:=cnt
             else f[b[m]].y:=cnt;
          end;
      h[cnt]:=a[i];
      i:=j+1;
      end;
    for i:=1 to n do
        begin
        addedge(f[i].x,f[i].y,1,v[i]);
{        if f[i].x+1=f[i].y then
           hash[f[i].x]:=1;}
        end;
    s:=0;
    t:=cnt+1;
    addedge(s,1,k,0);
    addedge(cnt,t,k,0);
    for i:=1 to cnt-1 do

           addedge(i,i+1,k,0);
    doit;
    writeln(ans);
    end;
{close(input);
close(output);}
end.