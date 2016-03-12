const dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
      maxn=120; inf=maxlongint;
var n,m,i,j,ans,sx,sy,ex,ey:longint;
    g:array[0..maxn,0..maxn]of longint;
procedure dfs(x,y,opt:longint);
var i,tx,ty,lx,ly,tmp:longint;
begin
if (x=ex)and(y=ey) then
   begin
   if (opt<ans) then ans:=opt;
   exit;
   end;
for i:=1 to 4 do
    begin
    tx:=x+dx[i]; ty:=y+dy[i];
    lx:=x; ly:=y;
    while (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(g[tx][ty]<>1) do
      begin
      if g[tx][ty]=3 then
         begin
         if (opt+1<=10) then dfs(tx,ty,opt+1);
         end;
      lx:=tx; ly:=ty;
      tx:=tx+dx[i]; ty:=ty+dy[i];
      end;
    if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=m)and(not((lx=x)and(ly=y))) then
       begin
       if (opt+1<=10) then
          begin
          g[tx][ty]:=0;
          dfs(lx,ly,opt+1);
          g[tx][ty]:=1;
          end;
       end;
    end;
end;
begin
{assign(input,'curling.in');
reset(input);
assign(output,'curling.out');
rewrite(output);}
readln(m,n);
while (m>0)and(n>0) do
  begin
  for i:=1 to n do
      for j:=1 to m do
          begin
          read(g[i][j]);
          if g[i][j]=2 then begin sx:=i; sy:=j; end
             else if g[i][j]=3 then begin ex:=i; ey:=j; end;
          end;
  ans:=inf;
  dfs(sx,sy,0);
  if ans=inf then writeln(-1) else writeln(ans);
  readln(m,n);
  end;
{close(input);
close(output);}
end.