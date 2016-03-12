const maxn=300000;
var tot,root,n,m,i,t,x,y,d,p,j:longint;
    key,min,delta,left,right,son,rev,fa:array[0..maxn]of longint;
    ch:char;
procedure update(x:longint);
begin
son[x]:=son[left[x]]+son[right[x]]+1;
min[x]:=key[x];
if left[x]<>0 then if min[left[x]]<min[x] then min[x]:=min[left[x]];
if right[x]<>0 then if min[right[x]]<min[x] then min[x]:=min[right[x]];
end;
procedure lazydown(x:longint);
var tmp:longint;
begin
if delta[x]<>0 then
   begin
   if left[x]<>0 then
      begin
      delta[left[x]]:=delta[left[x]]+delta[x];
      min[left[x]]:=min[left[x]]+delta[x];
      key[left[x]]:=key[left[x]]+delta[x];
      end;
   if right[x]<>0 then
      begin
      delta[right[x]]:=delta[right[x]]+delta[x];
      min[right[x]]:=min[right[x]]+delta[x];
      key[right[x]]:=key[right[x]]+delta[x];
      end;
   delta[x]:=0;
   end;
if rev[x]<>0 then
   begin
   rev[left[x]]:=1-rev[left[x]];
   rev[right[x]]:=1-rev[right[x]];
   tmp:=left[x]; left[x]:=right[x]; right[x]:=tmp;
   rev[x]:=0;
   end;
end;
function find(x,remain:longint):longint;
begin
lazydown(x);
if son[left[x]]>=remain then exit(find(left[x],remain))
   else begin
        if son[left[x]]+1=remain then exit(x)
           else exit(find(right[x],remain-1-son[left[x]]));
        end;
end;
procedure leftrotate(x:longint);
var y:longint;
begin
y:=fa[x];
lazydown(y);
lazydown(x);
right[y]:=left[x];
if left[x]<>0 then fa[left[x]]:=y;
left[x]:=y;
if fa[y]<>0 then
   begin
   if left[fa[y]]=y then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
update(y);
update(x);
end;
procedure rightrotate(x:longint);
var y:longint;
begin
y:=fa[x];
lazydown(y);
lazydown(x);
left[y]:=right[x];
if right[x]<>0 then fa[right[x]]:=y;
right[x]:=y;
if fa[y]<>0 then
   begin
   if left[fa[y]]=y then left[fa[y]]:=x
      else right[fa[y]]:=x;
   end;
fa[x]:=fa[y];
fa[y]:=x;
update(y);
update(x);
end;
procedure splay(x,y:longint);
begin
lazydown(x);
while fa[x]<>y do
  begin
  if fa[fa[x]]=y then
     begin
     if x=left[fa[x]] then rightrotate(x)
        else leftrotate(x);
     end
  else
     begin
     if fa[x]=left[fa[fa[x]]] then
        begin
        if x=left[fa[x]] then
           begin
           rightrotate(fa[x]);
           rightrotate(x);
           end
        else
           begin
           leftrotate(x);
           rightrotate(x);
           end;
        end
     else
        begin
        if x=right[fa[x]] then
           begin
           leftrotate(fa[x]);
           leftrotate(x);
           end
        else
           begin
           rightrotate(x);
           leftrotate(x);
           end;
        end;
     end;
  end;
if y=0 then root:=x;
end;
procedure insert(v,k:longint);
var x,y:longint;
begin
x:=find(root,k+1);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
inc(tot);
key[tot]:=v; son[tot]:=1; min[tot]:=v; delta[tot]:=0; rev[tot]:=0;
fa[tot]:=y;
left[y]:=tot; son[y]:=son[y]+1;
update(y);
update(x);
splay(tot,0);
end;
procedure delete(k:longint);
var x,y:longint;
begin
x:=find(root,k);
y:=find(root,k+2);
splay(x,0);
splay(y,x);
left[y]:=0;
update(y);
update(x);
splay(y,0);
end;
procedure operation(l,r,ind:longint);
var x,y,z,w,t,tmp:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
if ind=1 then
   begin
   min[left[y]]:=min[left[y]]+d;
   key[left[y]]:=key[left[y]]+d;
   delta[left[y]]:=delta[left[y]]+d;
   update(y);
   update(x);
   splay(left[y],0);
   end
else if ind=2 then rev[left[y]]:=1-rev[left[y]]
        else begin
             if d mod (r-l+1)=0 then exit;
             t:=r-d mod (r-l+1);
             if r=t+1 then
                begin
                y:=find(root,r+1);
                tmp:=key[y];
                delete(r);
                insert(tmp,l-1);
                exit;
                end;
             x:=find(root,t+2);
             splay(x,0);
             y:=find(root,r+2);
             splay(y,x);
             z:=find(root,r+1);
             splay(z,y);
             w:=find(root,l);
             splay(w,x);
             right[z]:=right[w];
             fa[right[w]]:=z; right[w]:=0;
             update(w); update(z);
             update(y); update(x);
             end;
end;
procedure query(l,r:longint);
var x,y:longint;
begin
x:=find(root,l);
y:=find(root,r+2);
splay(x,0);
splay(y,x);
writeln(min[left[y]]);
end;
begin
{assign(input,'super.in');
reset(input);
assign(output,'super.out');
rewrite(output);}
readln(n);
inc(tot); // 0
inc(tot); // the last
right[1]:=2;
root:=1;
fa[2]:=1;
son[1]:=2; son[2]:=1;
min[0]:=maxlongint;
key[1]:=maxlongint; key[2]:=maxlongint;
min[1]:=maxlongint; min[2]:=maxlongint;
for i:=1 to n do
    begin
    readln(t);
    insert(t,i-1);
    end;
readln(m);
for i:=1 to m do
    begin
    read(ch);
    if ch='A' then
       begin
       for j:=1 to 3 do read(ch);
       read(x,y,d);
       operation(x,y,1);
       end
    else if ch='I' then
            begin
            for j:=1 to 6 do read(ch);
            read(x,p);
            insert(p,x);
            end
         else if ch='D' then
                 begin
                 for j:=1 to 6 do read(ch);
                 read(x);
                 delete(x);
                 end
              else if ch='M' then
                      begin
                      for j:=1 to 3 do read(ch);
                      read(x,y);
                      query(x,y);
                      end
                   else begin
                        for j:=1 to 3 do read(ch);
                        if ch='E' then
                           begin
                           for j:=1 to 4 do read(ch);
                           read(x,y);
                           operation(x,y,2);
                           end
                        else begin
                             for j:=1 to 4 do read(ch);
                             read(x,y,d);
                             operation(x,y,3);
                             end;
                        end;
    readln;
    end;
{close(input);
close(output);}
end.