const maxcolor=35;
      maxn=800000;
type rec=record l,r:longint; end;
var ans,l,kind,opt,i,u,f,t,c:longint;
    ch:char;
    hash:array[0..maxcolor]of longint;
    tree:array[0..maxn]of rec;
    col:array[0..maxn]of longint;
procedure init(x,f,t:longint);
begin
tree[x].l:=f; tree[x].r:=t;
col[x]:=1;
if f=t then exit;
init(x*2,f,(f+t)div 2);
init(x*2+1,(f+t)div 2+1,t);
end;
procedure lazytag(x:longint);
begin
if col[x]>0 then
   begin
   col[x*2]:=col[x];
   col[x*2+1]:=col[x];
   col[x]:=-1;
   end;
end;
procedure modify(x,f,t,c:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
  col[x]:=c
else
  begin
  lazytag(x);
  mid:=(tree[x].l+tree[x].r)div 2;
  if f<=mid then modify(x*2,f,t,c);
  if t>mid then modify(x*2+1,f,t,c);
  end;
end;
procedure query(x,f,t:longint);
var mid:longint;
begin
if col[x]>0 then hash[col[x]]:=1
   else begin
        if tree[x].l=tree[x].r then exit;
        mid:=(tree[x].l+tree[x].r)div 2;
        if f<=mid then query(x*2,f,t);
        if t>mid then query(x*2+1,f,t);
        end;
end;
begin
{assign(input,'color.in');
reset(input);}
readln(l,kind,opt);
init(1,1,l);
for u:=1 to opt do
    begin
    read(ch);
    if ch='C' then
       begin
       read(f,t,c);
       if f>t then begin f:=f+t; t:=f-t; f:=f-t; end;
       modify(1,f,t,c);
       end
    else
       begin
       read(f,t);
       if f>t then begin f:=f+t; t:=f-t; f:=f-t; end;
       fillchar(hash,sizeof(hash),0);
       query(1,f,t);
       ans:=0;
       for i:=1 to kind do inc(ans,hash[i]);
       writeln(ans);
       end;
    readln;
    end;
//close(input);
end.