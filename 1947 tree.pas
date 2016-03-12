const maxn=160;  maxx=100000000;
var n,p,i,x,y,ans:longint;
    g,f:array[1..maxn,1..maxn]of longint;
    num:array[1..maxn]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
procedure dp(x:longint);
var i,t,tmp,j,k:longint;
begin
for i:=1  to p do
    begin
    f[x,i]:=maxx;
    end;
f[x,1]:=0;
for i:=1 to num[x] do
    begin
    t:=g[x,i];
    dp(t);
    for j:=p downto 1 do
        begin
        tmp:=maxx;
        for k:=1 to j-1 do
            begin
            tmp:=min(tmp,f[x,k]+f[t,j-k]);
            end;
        f[x,j]:=min(f[x,j]+1,tmp);  // to cut or not to cut
        end;
    end;
end;
begin
{assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);}
readln(n,p);
for i:=1 to n-1 do
    begin
    readln(x,y);
    inc(num[x]);
    g[x,num[x]]:=y;
    end;
dp(1);
ans:=f[1,p];
for i:=2 to n do
    begin
    if f[i,p]+1<ans then ans:=f[i,p]+1;
    end;
writeln(ans);
{close(input);
close(output);}
end.