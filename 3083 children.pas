const max=120; maxn=4000020; inf=maxlongint;
      dx:array[0..3]of longint=(-1,0,1,0);
      dy:array[0..3]of longint=(0,1,0,-1);
      px:array[0..3]of longint=(-1,0,1,0);
      py:array[0..3]of longint=(0,-1,0,1);
var cnt,u,i,j,m,n,ans1,ans2,ans3,sx,sy,ex,ey:longint;
    g:array[0..max,0..max]of char;
    f:array[0..max,0..max]of longint;
    q:array[0..maxn,1..2]of longint;
    vis:array[0..max,0..max]of boolean;
    flag:boolean;
procedure bfsmin;
var i,j,head,tail,nx,ny,tx,ty:longint;
begin
for i:=1 to n do for j:=1 to m do f[i][j]:=inf;
fillchar(vis,sizeof(vis),false);
vis[sx][sy]:=true;
f[sx][sy]:=1;
head:=1; tail:=1; q[1][1]:=sx; q[1][2]:=sy;
while head<=tail do
  begin
  nx:=q[head][1]; ny:=q[head][2];
  for i:=0 to 3 do
      begin
      tx:=nx+dx[i]; ty:=ny+dy[i];
      if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>'#') then
         begin
         if f[nx][ny]+1<f[tx][ty] then
            begin
            f[tx][ty]:=f[nx][ny]+1;
            if not vis[tx][ty] then
               begin
               inc(tail); q[tail][1]:=tx; q[tail][2]:=ty;
               vis[tx][ty]:=true;
               end;
            end;
         end;
      end;
  inc(head);
  end;
ans3:=f[ex][ey];
end;
function dfsleft(x,y,d:longint):longint;
var i,tx,ty,tmp:longint;
begin
if (x=ex)and(y=ey) then begin  exit(1); end;
for i:=0 to 3 do
    begin
    tmp:=(d+i)mod 4;
    tx:=x+dx[tmp]; ty:=y+dy[tmp];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>'#') then
       begin
       break;
       end;
    end;
dfsleft:=dfsleft(tx,ty,(tmp+3)mod 4)+1;
end;
function dfsright(x,y,d:longint):longint;
var i,tx,ty,tmp:longint;
begin
if (x=ex)and(y=ey) then begin exit(1); end;
for i:=0 to 3 do
    begin
    tmp:=(d+i)mod 4;
    tx:=x+px[tmp]; ty:=y+py[tmp];
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>'#') then
       begin
       break;
       end;
    end;
dfsright:=dfsright(tx,ty,(tmp+3)mod 4)+1;
end;
begin
{assign(input,'children.in');
reset(input);}
readln(cnt);
for u:=1 to cnt do
    begin
    readln(m,n);
    for i:=1 to n do
        begin
        for j:=1 to m do
            begin
            read(g[i][j]);
            if g[i][j]='S' then begin sx:=i; sy:=j; end
               else if g[i][j]='E' then begin ex:=i; ey:=j; end;
            end;
        readln;
        end;
    bfsmin;
    ans1:=dfsleft(sx,sy,0);
    ans2:=dfsright(sx,sy,0);
    writeln(ans1,' ',ans2,' ',ans3);
    end;
//close(input);
end.