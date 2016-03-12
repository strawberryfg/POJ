const maxn=80020;
type rec=record l,r,cover:longint; end;
var i,j,ans,u,n,t,p,now,sum:longint;
    tree:array[0..4*maxn]of rec;
    a,b,ind,l,r,hash:array[0..maxn]of longint;
    procedure sort(l,r: longint);
      var
         i,j,x,y: longint;
      begin
         i:=l;
         j:=r;
         x:=a[(l+r) div 2];
         repeat
           while a[i]<x do
            inc(i);
           while x<a[j] do
            dec(j);
           if not(i>j) then
             begin
                y:=a[i];
                a[i]:=a[j];
                a[j]:=y;
                y:=ind[i];
                ind[i]:=ind[j];
                ind[j]:=y;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
tree[x].cover:=0;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure lazy(x:longint);
begin
if (tree[x].cover<>0)and(tree[x].cover<>-1) then
   begin
   tree[2*x].cover:=tree[x].cover;
   tree[2*x+1].cover:=tree[x].cover;
   tree[x].cover:=-1;
   end;
end;
procedure modify(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].cover:=now;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then modify(f,t,x*2);
if t>mid then modify(f,t,x*2+1);
end;
procedure query(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
    begin
    if (tree[x].cover<>0)and(tree[x].cover<>-1) then hash[tree[x].cover]:=1
       else begin
            if tree[x].l=tree[x].r then exit;
            query(f,t,x*2);
            query(f,t,x*2+1);
            end;
    exit;
    end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then query(f,t,x*2);
if t>mid then query(f,t,x*2+1);
end;
begin
{assign(input,'mayor.in');
reset(input);}
readln(t);
for u:=1 to t do
    begin
    readln(n);
    for i:=1 to n do
        begin
        read(t,p);
        a[2*i-1]:=t;
        ind[2*i-1]:=2*i-1;
        a[2*i]:=p;
        ind[2*i]:=2*i;
        end;
    sort(1,2*n);
    i:=1;
    sum:=0;
    fillchar(hash,sizeof(hash),0);
    fillchar(tree,sizeof(tree),0);
    while i<=2*n do
      begin
      inc(sum);
      j:=i;
      if ind[i] mod 2=0 then r[ind[i] div 2]:=sum
         else l[(ind[i]+1)div 2]:=sum;
      while (j+1<=2*n)and(a[j+1]=a[i]) do
        begin
        inc(j);
        if ind[j] mod 2=0 then r[ind[j] div 2]:=sum
           else l[(ind[j]+1)div 2]:=sum;
        end;
      i:=j+1;
      end;
    init(1,sum,1);
    for i:=1 to n do
        begin
        now:=i;
        modify(l[i],r[i],1);
        end;
    query(1,sum,1);
    ans:=0;
    for i:=1 to n do if hash[i]<>0 then inc(ans);
    writeln(ans);
    end;
//close(input);
end.