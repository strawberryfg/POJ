const maxn=1020;
var n,i,top,k,l:longint;
    ans:extended;
    x,y,stack,a:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,tx,ty,tt: longint;
begin
i:=l; j:=r; tx:=x[(l+r) div 2]; ty:=y[(l+r)div 2];
repeat
  while (x[i]<tx)or((x[i]=tx)and(y[i]<ty)) do inc(i);
  while (tx<x[j])or((tx=x[j])and(ty<y[j])) do dec(j);
  if not(i>j) then begin tt:=x[i]; x[i]:=x[j]; x[j]:=tt; tt:=y[i]; y[i]:=y[j]; y[j]:=tt; tt:=a[i]; a[i]:=a[j]; a[j]:=tt; inc(i); dec(j); end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
function cross(u,v,w:longint):longint;
begin
exit((x[v]-x[u])*(y[w]-y[u])-(x[w]-x[u])*(y[v]-y[u]));
end;
function calc(u,v:longint):extended;
begin
exit(sqrt((x[u]-x[v])*(x[u]-x[v])+(y[u]-y[v])*(y[u]-y[v])));
end;
begin
{assign(input,'wall.in');
reset(input);}
readln(n,l);
for i:=1 to n do begin readln(x[i],y[i]); a[i]:=i; end;
sort(1,n);
top:=0;
for i:=1 to n do
    begin
    while (top>1)and(cross(stack[top-1],stack[top],i)<=0)do dec(top);
    inc(top); stack[top]:=i;
    end;
k:=top;
for i:=n-1 downto 1 do
    begin
    while (top>k)and(cross(stack[top-1],stack[top],i)<=0)do dec(top);
    inc(top); stack[top]:=i;
    end;
if n>1 then dec(top);
ans:=calc(stack[1],stack[top]);
for i:=1 to top-1 do ans:=ans+calc(stack[i],stack[i+1]);
writeln(round(ans+2*pi*l));
//close(input);
end.