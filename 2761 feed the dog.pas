const maxn=1000000; maxq=600000; max=maxlongint;
var le,ri,ind,k,ans:array[0..maxq]of longint;
    left,right,l,r,sum,num,key,a:array[0..maxn]of longint;
    n,m,i,j,root,tot:longint;
procedure sort(l,r: longint);
      var i,j,x,y,tmp: longint;
      begin
         i:=l; j:=r; x:=le[(l+r) div 2]; y:=ri[(l+r)div 2];
         repeat
           while (le[i]<x)or((le[i]=x)and(ri[i]<y)) do inc(i); while (x<le[j])or((x=le[j])and(y<ri[j])) do dec(j);
           if not(i>j) then
             begin
                tmp:=le[i]; le[i]:=le[j]; le[j]:=tmp; tmp:=ri[i]; ri[i]:=ri[j]; ri[j]:=tmp; tmp:=ind[i]; ind[i]:=ind[j]; ind[j]:=tmp; tmp:=k[i]; k[i]:=k[j]; k[j]:=tmp;
                inc(i); dec(j);
             end;
         until i>j;
         if l<j then sort(l,j); if i<r then sort(i,r);
      end;
function leftrotate(x:longint):longint;
var y,numy:longint;
begin
y:=right[x];
right[x]:=left[y];
numy:=sum[left[y]];
left[y]:=x;
r[x]:=numy;
sum[x]:=l[x]+r[x]+1;
l[y]:=sum[x];
sum[y]:=l[y]+r[y]+1;
exit(y);
end;
function rightrotate(x:longint):longint;
var y,numy:longint;
begin
y:=left[x];
left[x]:=right[y];
numy:=sum[right[y]];
right[y]:=x;
l[x]:=numy;
sum[x]:=l[x]+r[x]+1;
r[y]:=sum[x];
sum[y]:=l[y]+r[y]+1;
exit(y);
end;
function insert(var root:longint;number:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   left[tot]:=0; right[tot]:=0;
   sum[tot]:=1;
   num[tot]:=random(max)+1;
   key[tot]:=a[number];
   root:=tot;
   exit(root);
   end
else
   begin
   if a[number]<key[root] then
      begin
      left[root]:=insert(left[root],number);
      if num[left[root]]>num[root] then
         root:=rightrotate(root);
      end
   else
      begin
      right[root]:=insert(right[root],number);
      if num[right[root]]>num[root] then
         root:=leftrotate(root);
      end;
   l[root]:=sum[left[root]]; r[root]:=sum[right[root]];
   sum[root]:=l[root]+r[root]+1;
   exit(root);
   end;
end;
function delete(now:longint;number:longint):longint;
begin
if a[number]<key[now] then left[now]:=delete(left[now],number)
   else if a[number]>key[now] then right[now]:=delete(right[now],number)
           else begin
                if (left[now]=0)and(right[now]=0) then
                   begin
                   sum[now]:=0; l[now]:=0; r[now]:=0;
                   exit(0);
                   end;
                if num[left[now]]>num[right[now]] then
                   begin
                   now:=rightrotate(now);
                   right[now]:=delete(right[now],number);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   left[now]:=delete(left[now],number);
                   end;
                end;
l[now]:=sum[left[now]]; r[now]:=sum[right[now]];
sum[now]:=l[now]+r[now]+1;
exit(now);
end;
function query(remain,x:longint):longint;
begin
if remain<=l[x] then query:=query(remain,left[x])
   else if remain=l[x]+1 then exit(key[x])
           else begin
                query:=query(remain-l[x]-1,right[x]);
                end;
end;
begin
{assign(input,'feed.in');
reset(input);
assign(output,'e:\wqf\feed.out');
rewrite(output);}
readln(n,m);
for i:=1 to n do read(a[i]);
for i:=1 to m do begin readln(le[i],ri[i],k[i]); ind[i]:=i; end;
sort(1,m);
for i:=le[1] to ri[1] do
    begin
    if i=10443 then
       root:=root;
    root:=insert(root,i);

    end;
ans[ind[1]]:=query(k[1],root);
for i:=2 to m do
    begin
    if le[i]-ri[i-1]<=1 then
       begin
       for j:=le[i-1] to le[i]-1 do root:=delete(root,j);
       for j:=ri[i-1]+1 to ri[i] do root:=insert(root,j);
       end
    else
       for j:=le[i-1] to ri[i-1] do root:=delete(root,j);
    ans[ind[i]]:=query(k[i],root);
    end;
for i:=1 to m do writeln(ans[i]);
{close(input);
close(output);}
end.