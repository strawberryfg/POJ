const maxn=3020;
type rec=record first,last:longint; end;
     re=record u,v,key,nxt:longint; end;
var edge:array[0..maxn]of rec;
    g:array[0..maxn]of re;
    a,cnt:array[0..maxn]of longint;
    f:array[0..maxn,0..maxn]of longint;
    tot,n,m,i,j,x,y,count,ans:longint;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure dfs(x:longint);
var i,t:longint;
begin
if edge[x].first=0 then
   begin
   cnt[x]:=1;
   exit;
   end;
t:=edge[x].first;
while t<>0 do
    begin
    dfs(g[t].v);
    cnt[x]:=cnt[x]+cnt[g[t].v];
    t:=g[t].nxt;
    end;
end;
procedure work(x:longint);
var sum,i,j,k,t,tmp:longint;
begin
if edge[x].first=0 then
   begin
   f[x][1]:=a[x];
   exit;
   end;
sum:=0;
t:=edge[x].first;
while t<>0 do
    begin
    tmp:=g[t].v;
    work(tmp);
    sum:=sum+cnt[tmp];
    for j:=sum downto 1 do
        begin
        for k:=0 to j do
            begin
            f[x][j]:=max(f[x][j],f[tmp][k]+f[x][j-k]-g[t].key);
            end;
        end;
    t:=g[t].nxt;
    end;
end;
procedure addedge(x,y,w:longint);
begin
inc(tot);
g[tot].u:=x; g[tot].v:=y; g[tot].key:=w;
if edge[x].first=0 then
   begin
   edge[x].first:=tot;
   edge[x].last:=tot;
   end
else
   begin
   g[edge[x].last].nxt:=tot;
   edge[x].last:=tot;
   end
end;
begin
{assign(input,'tele.in');
reset(input);
assign(output,'tele.out');
rewrite(output);}
readln(n,m);
for i:=1 to n-m do
    begin
    read(count);
    for j:=1 to count do
        begin
        read(x,y);
        addedge(i,x,y);
        end;
    end;
dfs(1);
for i:=0 to n do for j:=1 to n do f[i][j]:=-(maxlongint div 2-1);
for i:=n-m+1 to n do read(a[i]);
work(1);
ans:=0;
for i:=m downto 1 do
    begin
    if f[1][i]>=0 then begin ans:=i; break; end;
    end;
writeln(ans);
{close(input);
close(output);}
end.