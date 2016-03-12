const d1:array[1..4]of longint=(0,1,0,-1);
      d2:array[1..4]of longint=(1,0,-1,0);
      max=350;
      inf=maxlongint;
      maxn=4000020;
var m,i,j,u,v,w,tu,tv,head,tail,nx,ny,tx,ty,mintime:longint;
    g,f:array[0..max,0..max]of longint;
    flag:boolean;
    mark:array[0..max,0..max]of boolean;
    q:array[0..maxn,1..2]of longint;
begin
{assign(input,'meteor.in');
reset(input);
assign(output,'meteor.out');
rewrite(output);}
readln(m);
for i:=0 to max do
    for j:=0 to max do
        f[i][j]:=inf;
for i:=1 to m do
    begin
    readln(u,v,w);
    if (g[u][v]=0)or(w+1<g[u][v]) then g[u][v]:=w+1;
    for j:=1 to 4 do
        begin
        tu:=u+d1[j]; tv:=v+d2[j];
        if (tu>=0)and(tv>=0) then
           begin
           if (g[tu][tv]=0)or(w+1<g[tu][tv]) then g[tu][tv]:=w+1;
           end;
        end;
    end;
head:=1; tail:=1; q[1][1]:=0; q[1][2]:=0;
f[0][0]:=0;
if g[0][0]=1 then flag:=false
   else begin
        flag:=false;
        while head<=tail do
          begin
          nx:=q[head][1]; ny:=q[head][2];
          for i:=1 to 4 do
              begin
              tx:=nx+d1[i]; ty:=ny+d2[i];
              if (tx>=0)and(ty>=0)and((g[tx][ty]=0)or(f[nx][ny]+1<g[tx][ty]-1)) then
                 begin
                 if f[nx][ny]+1<f[tx][ty] then
                    begin
                    f[tx][ty]:=f[nx][ny]+1;
                    if not mark[tx][ty] then
                       begin
                       mark[tx][ty]:=true;
                       inc(tail);
                       q[tail][1]:=tx; q[tail][2]:=ty;
                       end;
                    if g[tx][ty]=0 then
                       begin
                       flag:=true;
                       mintime:=f[tx][ty];
                       break;
                       end;
                    end;
                 end;
              end;
          if flag then break;
          inc(head);
          mark[nx][ny]:=false;
          end;
        end;
if not flag then writeln(-1) else writeln(mintime);
{close(input);
close(output);}
end.