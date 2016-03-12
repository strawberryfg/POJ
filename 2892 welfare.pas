const maxn=100000; maxrand=maxlongint;
var left,right,key,num:array[0..maxn]of longint;
    a,b,x,i,root,tot,last,n,m,sum:longint;
    ch,c:char;
    f:array[0..maxn]of longint;
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
function insert(var root:longint;value:longint):longint;
begin
if root=0 then
   begin
   inc(tot);
   left[tot]:=0; right[tot]:=0;
   key[tot]:=value;
   num[tot]:=random(maxrand)+1;
   root:=tot;
   exit(tot);
   end
else
   begin
   if value<key[root] then
      begin
      left[root]:=insert(left[root],value);
      if num[left[root]]>num[root] then root:=rightrotate(root);
      end
   else
      begin
      right[root]:=insert(right[root],value);
      if num[right[root]]>num[root] then root:=leftrotate(root);
      end;
   exit(root);
   end;
end;
function delete(now,value:longint):longint;
begin
if value<key[now] then left[now]:=delete(left[now],value)
   else if value>key[now] then right[now]:=delete(right[now],value)
           else begin
                if (left[now]=0)and(right[now]=0) then
                   exit(0);
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
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function findmax(now,value:longint):longint;
var res:longint;
begin
if value=key[now] then exit(value)
   else if value>key[now] then
           begin
           res:=key[now];
           if right[now]<>0 then res:=max(res,findmax(right[now],value));
           exit(res);
           end
        else
           begin
           res:=0;
           if left[now]<>0 then res:=max(res,findmax(left[now],value));
           exit(res);
           end;
end;
function findmin(now,value:longint):longint;
var res:longint;
begin
if value=key[now] then exit(value)
   else if value<key[now] then
           begin
           res:=key[now];
           if left[now]<>0 then res:=min(res,findmin(left[now],value));
           exit(res);
           end
        else
           begin
           res:=n+1;
           if right[now]<>0 then res:=min(res,findmin(right[now],value));
           exit(res);
           end;
end;
begin
{assign(input,'welfare.in');
reset(input);}
readln(n,m);
for i:=1 to m do
    begin
    read(ch);
    read(c);
    if ch='D' then
       begin
       read(x);
       root:=insert(root,x);
       inc(sum);
       f[sum]:=x;
       end
    else if ch='Q' then
            begin
            read(x);
            a:=findmax(root,x);
            b:=findmin(root,x);
            if a=b then writeln(0) else writeln(b-a-1);
            end
         else begin
              root:=delete(root,f[sum]);
              dec(sum);

              end;
    readln;
    end;
//close(input);
end.