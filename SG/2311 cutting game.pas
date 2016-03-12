const maxn=210;
var n,m,t,i,j:longint;
    g:array[0..maxn]of longint;
    f:array[0..maxn,0..maxn]of longint;
function work(x,y:longint):longint;
var i,t:longint;
begin
if f[x][y]<>-1 then exit(f[x][y]);
fillchar(g,sizeof(g),0);
for i:=2 to x div 2 do
    begin
    t:=work(i,y) xor work(x-i,y);
    g[t]:=1;
    end;   
for i:=2 to y div 2 do
    begin
    t:=work(x,i) xor work(x,y-i);
    g[t]:=1;
    end;
for i:=0 to maxn do
    begin
    if g[i]=0 then
       begin
       f[x][y]:=i;
       break;
       end;
    end;
exit(f[x][y]);
end;
begin
{assign(input,'cutting.in');
reset(input);}
for i:=0 to maxn do
    for j:=0 to maxn do
        f[i][j]:=-1;
while not eoln do
  begin
  readln(n,m);
  t:=work(n,m);
  if t=0 then writeln('LOSE')
     else writeln('WIN');
  end;
//close(input);
end.