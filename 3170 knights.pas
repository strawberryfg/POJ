const dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
      maxn=1010; maxx=4000020;
      inf=maxlongint;
var m,n,sx,sy,ex,ey,i,j,tot,ans,x,y:longint;
    a:array[0..maxn*maxn,1..2]of longint;
    q:array[0..maxx,1..2]of longint;
    g:array[0..maxn,0..maxn]of longint;
    mark:array[0..maxn,0..maxn,1..2]of boolean;
    f:array[0..maxn,0..maxn,1..2]of longint;
procedure bfs(opt,x,y:longint);
var head,tail,nx,ny,tx,ty,i,hou,qian:longint;
begin
head:=1; tail:=1; q[1][1]:=x; q[1][2]:=y;
f[x][y][opt]:=0;
hou:=1; qian:=1;
while (hou<qian)or((hou=qian)and(head<=tail)) do
  begin
  nx:=q[head][1]; ny:=q[head][2];
  for i:=1 to 4 do
      begin
      tx:=nx+dx[i]; ty:=ny+dy[i];
      if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>1) then
         begin
         if (opt=1)and((tx=ex)and(ty=ey)) then continue;
         if f[nx][ny][opt]+1<f[tx][ty][opt] then
            begin
            f[tx][ty][opt]:=f[nx][ny][opt]+1;
            if not mark[tx][ty][opt] then
               begin
               mark[tx][ty][opt]:=true;
               inc(tail);
               if tail>maxx then begin inc(qian); tail:=1; end;
               q[tail][1]:=tx; q[tail][2]:=ty;
               end;
            end;
         end;
      end;
  inc(head);
  if head>maxx then begin inc(hou); head:=1; end;
  mark[nx][ny][opt]:=false;
  end;
end;
begin
{assign(input,'knights.in');
reset(input);}
readln(m,n);
for i:=1 to n do
    for j:=1 to m do
        begin
        read(g[i][j]);
        f[i][j][1]:=inf;
        f[i][j][2]:=inf;
        if g[i][j]=2 then begin sx:=i; sy:=j; end
           else if g[i][j]=3 then begin ex:=i; ey:=j; end
                   else if g[i][j]=4 then begin inc(tot); a[tot][1]:=i; a[tot][2]:=j; end;
        end;
bfs(1,sx,sy);
bfs(2,ex,ey);
ans:=inf;
for i:=1 to tot do
    begin
    x:=a[i][1]; y:=a[i][2];
    if (f[x][y][1]<>inf)and(f[x][y][2]<>inf)and(f[x][y][1]+f[x][y][2]<ans) then
       ans:=f[x][y][1]+f[x][y][2];
    end;
writeln(ans);
//close(input);
end.