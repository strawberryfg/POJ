const maxn=520;
var n,k,i,x,y,ans:longint;
    edge:array[1..maxn,0..maxn]of longint;
    vis:array[1..maxn]of boolean;
    final:array[1..maxn]of longint;
function dfs(num:longint):boolean;
var i:longint;
begin
for i:=1 to edge[num,0] do
    begin
    if not vis[edge[num,i]] then
       begin
       vis[edge[num,i]]:=true;
       if (final[edge[num,i]]=0)or(dfs(final[edge[num,i]])) then
          begin
          final[edge[num,i]]:=num;
          exit(true);
          end;
       end;
    end;
exit(false);
end;
begin
readln(n,k);
for i:=1 to k do
    begin
    readln(x,y);
    inc(edge[x,0]);
    edge[x,edge[x,0]]:=y;
    end;
for i:=1 to n do
    begin
    fillchar(vis,sizeof(vis),false);
    if dfs(i) then inc(ans);
    end;
writeln(ans);
end.