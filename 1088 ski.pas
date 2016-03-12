var n,m,i,j,ans:longint;
    a,f:array[0..101,0..101]of longint;
function dp(x,y:longint):longint;
var fmax,t:longint;
begin
if f[x,y]<>0 then exit(f[x,y]);
fmax:=0;
if (y-1>=1)and(a[x,y]>a[x,y-1]) then
   begin
   t:=dp(x,y-1);
   if t>fmax then fmax:=t;
   end;
if (y+1<=m)and(a[x,y]>a[x,y+1]) then
   begin
   t:=dp(x,y+1);
   if t>fmax then fmax:=t;
   end;
if (x-1>=1)and(a[x,y]>a[x-1,y]) then
   begin
   t:=dp(x-1,y);
   if t>fmax then fmax:=t;
   end;
if (x+1<=n)and(a[x,y]>a[x+1,y]) then
   begin
   t:=dp(x+1,y);
   if t>fmax then fmax:=t;
   end;
f[x,y]:=fmax+1;
exit(f[x,y]);
end;
begin
{assign(input,'ski.in');
reset(input);
assign(output,'ski.out');
rewrite(output);}
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(a[i,j]);
        end;
    readln;
    end;
ans:=0;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        dp(i,j);
        end;
    end;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        if f[i,j]>ans then ans:=f[i,j];
        end;
    end;
writeln(ans);
{close(input);
close(output);}
end.