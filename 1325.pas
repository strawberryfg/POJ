const maxn=520;
var n,m,k,x,y,t,ans,i:longint;
    vis:array[0..maxn]of boolean;
    final:array[0..maxn]of longint;
    edge:array[0..maxn,0..maxn]of longint;
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
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
begin
read(n);
while n<>0 do
  begin
  read(m,k);
  readln;
  for i:=0 to max(n,m)+1 do edge[i,0]:=0;
  for i:=1 to k do
      begin
      readln(t,x,y);
      inc(x); inc(y);
      if (x<>1)and(y<>1) then
         begin
         inc(edge[x,0]);
         edge[x,edge[x,0]]:=y;
         end;
      end;
  ans:=0;
  fillchar(final,sizeof(final),0);
  for i:=1 to n do
      begin
      fillchar(vis,sizeof(vis),false);
      if dfs(i) then inc(ans);
      end;
  writeln(ans);
  read(n);
  end;
end.