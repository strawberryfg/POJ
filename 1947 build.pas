const maxn=500;
var n,p,i,j,x,y,ans:longint;
    edge:array[0..maxn,0..maxn]of longint;
    f:array[0..maxn,0..maxn]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure dp(x:longint);
var i,t,j,k,tmp:longint;
begin
f[x][1]:=0;
for i:=1 to edge[x][0] do
    begin
    t:=edge[x][i];
    dp(t);
    for j:=p downto 1 do
        begin
        tmp:=maxlongint div 2;
        for k:=1 to j-1 do
            begin
            tmp:=min(tmp,f[x][j-k]+f[t][k]);
            end;
        f[x][j]:=min(f[x][j]+1,tmp);
        end;
    end;
end;
begin
{assign(input,'build.in');
reset(input);}
readln(n,p);
for i:=1 to n-1 do
    begin
    readln(x,y);
    inc(edge[x][0]);
    edge[x][edge[x][0]]:=y;
    end;
for i:=0 to n do for j:=0 to n do f[i][j]:=maxlongint div 2;
dp(1);
ans:=f[1][p];
for i:=2 to n do ans:=min(ans,f[i][p]+1);
writeln(ans);
//close(input);
end.