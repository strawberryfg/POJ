const maxn=500000; max=maxlongint;
var fa,rank,left,right,sum,key,num:array[0..maxn]of longint;
    i,t,x,y,k,root,tot,t1,t2,n,m:longint;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
sum[y]:=sum[x];
sum[x]:=sum[left[x]]+sum[right[x]]+1;
exit(y);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
sum[y]:=sum[x];
sum[x]:=sum[left[x]]+sum[right[x]]+1;
exit(y);
end;
function delete(now:longint;value:longint):longint;
begin
dec(sum[now]);
if value<key[now] then left[now]:=delete(left[now],value)
   else if value>key[now] then right[now]:=delete(right[now],value)
           else begin
                if (left[now]=0)and(right[now]=0) then
                   begin
                   exit(0);
                   end;
                if num[left[now]]>num[right[now]] then
                   begin
                   now:=rightrotate(now);
                   right[now]:=delete(right[now],value);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   left[now]:=delete(left[now],value);
                   end;
                end;
exit(now);
end;
function insert(var root:longint; value:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   num[tot]:=random(max)+1;
   key[tot]:=value;
   left[tot]:=0; right[tot]:=0; sum[tot]:=1;
   root:=tot;
   exit(root);
   end
else
   begin
   inc(sum[root]);
   if value<key[root] then
      begin
      left[root]:=insert(left[root],value);
      if num[left[root]]>num[root] then root:=rightrotate(root);
      end
   else begin
        right[root]:=insert(right[root],value);
        if num[right[root]]>num[root] then root:=leftrotate(root);
        end;
   exit(root);
   end;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
function query(now,value:longint):longint;
begin
if sum[right[now]]>=value then exit(query(right[now],value))
   else begin
        if sum[right[now]]+1=value then exit(key[now])
           else begin
                exit(query(left[now],value-1-sum[right[now]]));
                end;
        end;
end;
begin
{assign(input,'kth.in');
reset(input);}
readln(n,m);
randomize;
for i:=1 to n do
    begin
    fa[i]:=i; rank[i]:=1;
    root:=insert(root,1);
    end;
for i:=1 to m do
    begin
    read(t);
    if t=0 then
       begin
       read(x,y);
       readln;
       t1:=getfa(x);
       t2:=getfa(y);
       if t1<>t2 then
          begin
          fa[t2]:=t1;
          root:=delete(root,rank[t1]);
          root:=delete(root,rank[t2]);
          rank[t1]:=rank[t1]+rank[t2];
          root:=insert(root,rank[t1]);
          end;
       end
    else
       begin
       read(k);
       readln;
       writeln(query(root,k));
       end;
    end;
//close(input);
end.