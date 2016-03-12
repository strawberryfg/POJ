const maxn=2020;
var n,i,t:longint;
    f:array[0..maxn]of longint;
function work(x:longint):longint;
var g:array[0..maxn]of longint;
    i:longint;
begin
if x<=0 then exit(0);
if f[x]<>-1 then exit(f[x]);
fillchar(g,sizeof(g),0);
for i:=1 to x do
    g[work(i-3) xor work(x-i-2)]:=1;
for i:=0 to maxn do
    if g[i]=0 then
       begin
       f[x]:=i;
       exit(f[x]);
       end;
end;
begin
{assign(input,'crosses.in');
reset(input);}
readln(n);
for i:=0 to n do f[i]:=-1;
t:=work(n);
if t<>0 then writeln(1) else writeln(2);
//close(input);
end.
