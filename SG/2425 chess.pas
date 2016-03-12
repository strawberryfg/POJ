const max=1020; maxn=1020;
var n,i,j,m,t,ans:longint;
    f:array[0..max]of longint;
    edge:array[0..maxn,0..maxn]of longint;
function work(x:longint):longint;
var i:longint;
    g:array[0..max]of integer;
begin
if f[x]<>-1 then exit(f[x]);
fillchar(g,sizeof(g),0);
for i:=1 to edge[x][0] do
    begin
    g[work(edge[x][i])]:=1;
    end;
for i:=0 to max do
    if g[i]=0 then
       begin
       f[x]:=i;
       exit(f[x]);
       end;
end;
begin
{assign(input,'chess.in');
reset(input);}
readln(n);
while n<>0 do
begin
for i:=0 to n-1 do f[i]:=-1;
for i:=0 to n-1 do
    begin
    read(edge[i][0]);
    for j:=1 to edge[i][0] do read(edge[i][j]);
    end;
read(m);
while m<>0 do
   begin
   ans:=0;
   for j:=1 to m do
       begin
       read(t);
       ans:=ans xor work(t);
       end;
   if ans=0 then writeln('LOSE')
      else writeln('WIN');
   read(m);
   end;
readln(n);
end;
//close(input);
end.