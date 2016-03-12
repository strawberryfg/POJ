const maxrand=100000000; maxn=100000;
var tot,root,t,k,p,min,max:longint;
    a,left,right,key,num:array[0..maxn]of longint;
function leftrotate(x:longint):longint;
var y:longint;
begin
y:=right[x];
right[x]:=left[y];
left[y]:=x;
exit(y);
end;
function rightrotate(x:longint):longint;
var y:longint;
begin
y:=left[x];
left[x]:=right[y];
right[y]:=x;
exit(y);
end;
function insert(var root:longint;n,v:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   left[tot]:=0; right[tot]:=0;
   key[tot]:=v;
   num[tot]:=random(maxrand)+1;
   a[tot]:=n;
   root:=tot;
   exit(root);
   end
else
   begin
   if v<key[root] then
      begin
      left[root]:=insert(left[root],n,v);
      if num[left[root]]>num[root] then
         root:=rightrotate(root);
      end
   else
      begin
      right[root]:=insert(right[root],n,v);
      if num[right[root]]>num[root] then
         root:=leftrotate(root);
      end;
   exit(root);
   end;
end;
function dfs(x:longint):longint;
begin
if right[x]=0 then exit(x)
   else exit(dfs(right[x]));
end;
function dfs2(x:longint):longint;
begin
if left[x]=0 then exit(x)
   else exit(dfs2(left[x]));
end;
function delete(now:longint;v:longint):longint;
begin
if v<key[now] then left[now]:=delete(left[now],v)
   else if v>key[now] then right[now]:=delete(right[now],v)
           else begin
                if (left[now]=0)and(right[now]=0) then
                   begin
                   exit(0);
                   end;
                if num[left[now]]>num[right[now]] then
                   begin
                   now:=rightrotate(now);
                   right[now]:=delete(right[now],v);
                   end
                else
                   begin
                   now:=leftrotate(now);
                   left[now]:=delete(left[now],v);
                   end;
                end;
exit(now);
end;
begin
{assign(input,'doublequeue.in');
reset(input);
assign(output,'doublequeue.out');
rewrite(output);}
randomize;
read(t);
while t<>0 do
  begin
  if t=1 then readln(k,p)
     else readln;
  if t=1 then root:=insert(root,k,p)
     else if t=2 then
             begin
             max:=dfs(root);
             writeln(a[max]);
             root:=delete(root,key[max]);
             end
          else
             begin
             min:=dfs2(root);
             writeln(a[min]);
             root:=delete(root,key[min]);
             end;
  read(t);
  end;
{close(input);
close(output);}
end.