const maxn=100020;
type rec=record l,r,lmax,rmax,max,lmin,rmin,min,sum:longint; end;
var tree:array[0..4*maxn]of rec;
    num:array[0..maxn]of longint;
    n,m,i,x,d,ans:longint;
    ans1,ans2:rec;
function getmax(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function getmin(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function update(y,a,b:rec):rec;
var res:rec;
begin
res:=y;
res.lmax:=getmax(a.lmax,a.sum+b.lmax);
res.rmax:=getmax(b.rmax,b.sum+a.rmax);
res.max:=getmax(a.max,b.max);
res.max:=getmax(res.max,a.rmax+b.lmax);
res.lmin:=getmin(a.lmin,a.sum+b.lmin);
res.rmin:=getmin(b.rmin,b.sum+a.rmin);
res.min:=getmin(a.min,b.min);
res.min:=getmin(res.min,a.rmin+b.lmin);
exit(res);
end;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then
   begin
   tree[x].sum:=num[f];
   tree[x].lmax:=num[f];
   tree[x].rmax:=num[f];
   tree[x].max:=num[f];
   tree[x].lmin:=num[f];
   tree[x].rmin:=num[f];
   tree[x].min:=num[f];
   exit;
   end;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
tree[x]:=update(tree[x],tree[x*2],tree[x*2+1]);
end;
procedure modify(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   tree[x].sum:=d;
   tree[x].lmax:=d;
   tree[x].rmax:=d;
   tree[x].max:=d;
   tree[x].lmin:=d;
   tree[x].rmin:=d;
   tree[x].min:=d;
   exit;
   end;
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then modify(f,t,x*2);
if t>mid then modify(f,t,x*2+1);
tree[x].sum:=tree[x*2].sum+tree[x*2+1].sum;
tree[x]:=update(tree[x],tree[x*2],tree[x*2+1]);
end;
function query(f,t,x:longint):rec;
var res,a,b:rec;
    mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then exit(tree[x])
   else begin
        mid:=(tree[x].l+tree[x].r)div 2;
        if t<=mid then exit(query(f,t,x*2))
           else if f>mid then exit(query(f,t,x*2+1))
                   else begin
                        a:=query(f,t,x*2);
                        b:=query(f,t,x*2+1);
                        res:=update(res,a,b);
                        exit(res);
                        end;
        end;
end;
begin
{assign(input,'potted.in');
reset(input);}
readln(n);
for i:=1 to n do read(num[i]);
init(1,n,1);
readln(m);
for i:=1 to m do
    begin
    readln(x,d);
    modify(x,x,1);
    ans1:=query(1,n,1);
    if ans1.max=tree[1].sum then
       writeln(tree[1].sum-ans1.min)
    else
       begin
       ans:=getmax(tree[1].sum-ans1.min,ans1.max);
       writeln(ans);
       end;
    end;
//close(input);
end.