const maxl=1000000;maxn=1000000;
type treenode=record
    l,r:longint;
    cover,lc,rc:longint;
    end;
var tree:array[1..maxl shl 1-1]of treenode;
    index:array[1..maxn shl 1]of record a,w,flag:longint; end;
    a,b,w:array[1..maxn]of longint;
    h:array[0..maxn]of longint;
    tot,n,i,t:longint;
    ans,temp:int64;
  procedure sorth(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=h[(l+r) div 2];
         repeat
           while h[i]<x do
            inc(i);
           while x<h[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=h[i];
                h[i]:=h[j];
                h[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sorth(l,j);
         if i<r then
           sorth(i,r);
      end;
function find(x:longint):longint;
var l,r,mid:longint;
begin
l:=1; r:=n;
while l<=r do
  begin
  mid:=(l+r)shr 1;
  if h[mid]<x then l:=mid+1
     else if h[mid]>x then r:=mid-1
         else begin find:=mid; exit; end;
  end;
end;
procedure sortindex(l,r:longint);
var i,j,x1,x2,y:longint;
begin
x1:=index[(l+r)shr 1].a;
x2:=index[(l+r)shr 1].flag;
i:=l; j:=r;
repeat
while (index[i].a<x1)or((index[i].a=x1)and(index[i].flag<x2)) do inc(i);
while (x1<index[j].a)or((x1=index[j].a)and(x2<index[j].flag)) do dec(j);
if not(i>j) then
   begin
   if (index[i].a>index[j].a)or((index[i].a=index[j].a)and(index[i].flag>index[j].flag)) then
      begin
      y:=index[i].a;
      index[i].a:=index[j].a;
      index[j].a:=y;
      y:=index[i].w;
      index[i].w:=index[j].w;
      index[j].w:=y;
      y:=index[i].flag;
      index[i].flag:=index[j].flag;
      index[j].flag:=y;
      end;
   inc(i);
   dec(j);
   end;
until i>j;
if l<r then sortindex(i,r);
if l<j then sortindex(l,j);
end;
procedure build(a,b:longint);
var mid,now:longint;
begin
inc(tot);
now:=tot;
tree[now].l:=a;
tree[now].r:=b;
if b-a>1 then
   begin
   mid:=(a+b)shr 1;
   tree[now].lc:=tot+1;
   build(a,mid);
   tree[now].rc:=tot+1;
   build(mid,b);
   end;
end;
procedure insert(x,a,b:longint);
var mid:longint;
begin
if (a<=tree[x].l)and(tree[x].r<=b) then
   begin
   inc(tree[x].cover);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if a<mid then insert(tree[x].lc,a,b);
if mid<b then insert(tree[x].rc,a,b);
end;

procedure delete(x,a,b:longint);
var mid:longint;
begin
if (a<=tree[x].l)and(tree[x].r<=b) then
   begin
   dec(tree[x].cover);
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if a<mid then delete(tree[x].lc,a,b);
if mid<b then delete(tree[x].rc,a,b);
end;
function count(x:longint):longint;
var ans:longint;
begin
if tree[x].cover>0 then
   begin
   count:=h[tree[x].r]-h[tree[x].l];
   exit;
   end
else begin
     ans:=0;
     if tree[x].lc<>0 then ans:=ans+count(tree[x].lc);
     if tree[x].rc<>0 then ans:=ans+count(tree[x].rc);
     count:=ans;
     end;
end;
begin
{assign(input,'cover.in');
reset(input);
assign(output,'cover.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    readln(a[i],b[i],w[i]);
    h[i]:=w[i];
    end;
sorth(1,n);
for i:=1 to n do
    w[i]:=find(w[i]);
t:=0;
for i:=1 to n do
    begin
    inc(t); index[t].a:=a[i]; index[t].w:=w[i]; index[t].flag:=1;
    inc(t); index[t].a:=b[i]; index[t].w:=w[i]; index[t].flag:=-1;
    end;
sortindex(1,t);
tot:=0;
build(0,n);
ans:=0;
index[t+1].a:=index[t].a;
for i:=1  to t do	
    begin
    if index[i].flag=1 then insert(1,0,index[i].w)
       else delete(1,0,index[i].w);
    temp:=index[i+1].a-index[i].a;
    temp:=temp*count(1);
    ans:=ans+temp;
    end;
writeln(ans);
{close(input);
close(output);}
end.