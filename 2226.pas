const maxn=500;
var n,m,i,j,k,v,cnt1,cnt2,ans:longint;
    g:array[0..maxn,0..maxn]of char;
    final:array[0..maxn]of longint;
    map,a,b:array[0..maxn,0..maxn]of longint;
    vis:array[0..maxn]of boolean;
function dfs(num:longint):boolean;
var i:longint;
begin
for i:=1 to cnt2 do
    begin
    if (map[num,i]=1)and(not vis[i]) then
       begin
       vis[i]:=true;
       if (final[i]=0)or(dfs(final[i])) then
          begin
          final[i]:=num;
          exit(true);
          end;
       end;
    end;
exit(false);
end;
begin
readln(n,m);
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(g[i,j]);
        end;
    readln;
    end;
cnt1:=0;
for i:=1 to n do
    begin
    j:=1;
    while j<=m do
     begin
     while g[i,j]='.' do inc(j);
     if j>m then break;
     k:=j;
     while (k+1<=m)and(g[i,k+1]='*') do inc(k);
     inc(cnt1);
     for v:=j to k do a[i,v]:=cnt1;
     j:=k+1;
     end;
    end;
cnt2:=0;
for i:=1 to m do
    begin
    j:=1;
    while j<=n do
     begin
     while g[j,i]='.' do inc(j);
     if j>n then break;
     k:=j;
     while (k+1<=n)and(g[k+1,i]='*') do inc(k);
     inc(cnt2);
     for v:=j to k do b[v,i]:=cnt2;
     j:=k+1;
     end;
    end;
for i:=1 to n do
    for j:=1 to m do
        if g[i,j]='*' then map[a[i,j],b[i,j]]:=1;
for i:=1 to cnt1 do
    begin
    fillchar(vis,sizeof(vis),false);
    if dfs(i) then inc(ans);
    end;
writeln(ans);
end.