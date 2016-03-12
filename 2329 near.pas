const max=220; maxn=4000020; inf=maxlongint;
      d1:array[1..4]of longint=(-1,0,1,0);
      d2:array[1..4]of longint=(0,1,0,-1);
var n,i,j,tot,cnt,head,tail,tx,ty,nx,ny,x,y:longint;
    a,f,g,c:array[0..max,0..max]of longint;
    b,q:array[0..maxn,1..2]of longint;
    mark:array[0..max,0..max]of boolean;
begin
//assign(input,'near.in');
//reset(input);
readln(n);
for i:=1 to n do
    for j:=1 to n do
        begin
        read(a[i][j]);
        if a[i][j]=0 then f[i][j]:=inf;
        if a[i][j]<>0 then
           begin
           inc(tot);
           b[tot][1]:=i;
           b[tot][2]:=j;
           end;
        end;
for cnt:=1 to tot do
    begin
    head:=1; tail:=1;
    q[1][1]:=b[cnt][1]; q[1][2]:=b[cnt][2];
    fillchar(mark,sizeof(mark),false);
    mark[q[1][1]][q[1][2]]:=true;
    while head<=tail do
      begin
      nx:=q[head][1]; ny:=q[head][2];
      for i:=1 to 4 do
          begin
          tx:=nx+d1[i]; ty:=ny+d2[i];
          if (tx>=1)and(tx<=n)and(ty>=1)and(ty<=n) then
             begin
             if (a[tx][ty]=0)and(f[nx][ny]+1<=f[tx][ty]) then
                begin
                if (f[nx][ny]+1=f[tx][ty])and(g[tx][ty]<>cnt) then c[tx][ty]:=1
                   else begin g[tx][ty]:=cnt; c[tx][ty]:=0; end;
                f[tx][ty]:=f[nx][ny]+1;
                if not mark[tx][ty] then
                   begin
                   inc(tail);
                   mark[tx][ty]:=true;
                   q[tail][1]:=tx; q[tail][2]:=ty;
                   end;
                end;
             end;
          end;
      inc(head); mark[nx][ny]:=false;
      end;
    end;
for i:=1 to n do
    begin
    for j:=1 to n do
        begin
        if a[i][j]<>0 then write(a[i][j])
           else begin
                if c[i][j]=1 then write(0)
                   else begin
                        x:=b[g[i][j]][1]; y:=b[g[i][j]][2];
                        write(a[x][y]);
                        end;
                end;
        if j<>n then write(' ');
        end;
    writeln;
    end;
//close(input);
end.