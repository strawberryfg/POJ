const maxn=100200;
type rec=record l,r:longint; delta,sum:int64; end;
var a:array[0..maxn]of longint;
    tree:array[0..4*maxn]of rec;
    n,i,q,l,r:longint;
    d:int64;
    ch,c:char;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then begin tree[x].sum:=a[f]; exit; end
   else begin
        init(f,(f+t)div 2,x*2);
        init((f+t)div 2+1,t,x*2+1);
        tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
        end;
end;
procedure lazydown(x:longint);
begin
if tree[x].delta<>0 then
   begin
   tree[x*2].delta:=tree[x*2].delta+tree[x].delta;
   tree[x*2].sum:=tree[x*2].sum+tree[x].delta*(tree[x*2].r-tree[x*2].l+1);
   tree[x*2+1].delta:=tree[x*2+1].delta+tree[x].delta;
   tree[x*2+1].sum:=tree[x*2+1].sum+tree[x].delta*(tree[x*2+1].r-tree[x*2+1].l+1);
   tree[x].delta:=0;
   end;
end;
function query(f,t,x:longint):int64;
var mid:longint;
    ans:int64;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   exit(tree[x].sum);
   end;
lazydown(x);
mid:=(tree[x].l+tree[x].r)div 2;
ans:=0;
if f<=mid then ans:=ans+query(f,t,x*2);
if t>mid then ans:=ans+query(f,t,x*2+1);
exit(ans);
end;
procedure modify(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].delta:=tree[x].delta+d;
   tree[x].sum:=tree[x].sum+d*(tree[x].r-tree[x].l+1);
   exit;
   end;
lazydown(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then modify(f,t,x*2);
if t>mid then modify(f,t,x*2+1);
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
end;
begin
{assign(input,'integer.in');
reset(input);}
readln(n,q);
for i:=1 to n do read(a[i]);
readln;
init(1,n,1);
for i:=1 to q do
    begin
    read(ch); read(c);
    if ch='C' then
       begin
       read(l,r,d);
       modify(l,r,1);
       end
    else
       begin
       read(l,r);
       writeln(query(l,r,1));
       end;
    readln;
    end;
//close(input);
end.