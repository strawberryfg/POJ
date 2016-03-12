const maxn=120;
var n,most,i,x,y:longint;
    vis:array[0..maxn]of boolean;
    w:array[0..maxn]of longint;
    edge,edge2:array[0..maxn,0..maxn]of longint;
    f:array[0..maxn,0..2*maxn,0..2]of longint;
procedure dfs(x:longint);
var i:longint;
begin
vis[x]:=true;
for i:=1 to edge[x][0] do
    begin
    if not vis[edge[x][i]] then
       begin
       inc(edge2[x][0]);
       edge2[x][edge2[x][0]]:=edge[x][i];
       dfs(edge[x][i]);
       end;
    end;
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure dp(x:longint);
var i,j,k,t,t1,t2:longint;
begin
for i:=0 to most do begin f[x][i][0]:=w[x]; f[x][i][1]:=w[x]; end;
for i:=1 to edge[x][0] do
    begin
    t:=edge[x][i];
    dp(t);
    for j:=most downto 1 do
        begin
        for k:=1 to j do
            begin
            t1:=f[t][k-1][0]; t2:=f[x][j-k][1];
            f[x][j][0]:=max(f[x][j][0],t1+t2);
            if k>=2 then
               begin
               t1:=f[t][k-2][1]; t2:=f[x][j-k][0];
               f[x][j][0]:=max(f[x][j][0],t1+t2);
               t1:=f[t][k-2][1]; t2:=f[x][j-k][1];
               f[x][j][1]:=max(f[x][j][1],t1+t2);
               end;
            end;
        end;
    end;
end;
begin
{assign(input,'apple.in');
reset(input);}
while not eof do
  begin
  readln(n,most);
  fillchar(vis,sizeof(vis),false);
  for i:=1 to n do begin read(w[i]); edge[i][0]:=0; edge2[i][0]:=0; end;
  fillchar(f,sizeof(f),0);
  for i:=1 to n-1 do
      begin
      readln(x,y);
      inc(edge[x][0]); edge[x][edge[x][0]]:=y;
      inc(edge[y][0]); edge[y][edge[y][0]]:=x;
      end;
  dfs(1);
  edge:=edge2;
  dp(1);
  writeln(max(f[1][most][0],f[1][most][1]));
  end;
//close(input);
end.