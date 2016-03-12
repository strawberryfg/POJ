//19:36; 20:52;
const inf=maxlongint;
      maxx=1600020; maxn=520;
type optarr=record x,y,c:longint; end;
var que:array[0..maxx,1..3]of optarr;
    start:array[1..3]of optarr;
    tt:optarr;
    n,m,i,j,cnt,ex,ey,head,tail,u,v,w,ans,k,tmp:longint;
    g:array[0..maxn,0..maxn]of char;
    f:array[0..maxn,0..maxn,0..3]of longint;
procedure check(a,b,c,d,opt:longint);
var x1,y1,x2,y2:longint;
begin
if (a<=0)or(c<=0) then exit;
if (g[a][b]='#')or((opt<>1)and(g[c][d]='#')) then exit;
if (g[a][b]='E')and(opt=1) then exit;
if (a>c)or((a=c)and(b>d)) then begin x1:=c; y1:=d; x2:=a; y2:=b;  end
   else begin x1:=a; y1:=b; x2:=c; y2:=d; end;
if f[u][v][w]+1<f[x1][y1][opt] then
   begin
   inc(tail);
   que[tail][1].x:=x1; que[tail][1].y:=y1;
   que[tail][2].x:=x2; que[tail][2].y:=y2;
   que[tail][3].c:=opt;
   f[x1][y1][opt]:=f[u][v][w]+1;
   if (opt=1)and(x1=ex)and(y1=ey) then
      if f[x1][y1][opt]<ans then
         ans:=f[x1][y1][opt];
   end;
end;
begin
{assign(input,'bloxorz.in');
reset(input);}
readln(n,m);
while (n>0)and(m>0) do
begin
cnt:=0;
for i:=1 to n do
    begin
    for j:=1 to m do
        begin
        read(g[i][j]);
        for k:=0 to 3 do
            f[i][j][k]:=inf;
        if g[i][j]='O' then begin ex:=i; ey:=j; end
           else if g[i][j]='X' then begin inc(cnt); start[cnt].x:=i; start[cnt].y:=j; end;
        end;
    readln;
    end;
if (cnt>1) then
   begin
   if start[1].x>start[2].x then begin tt:=start[1]; start[1]:=start[2]; start[2]:=tt; end
      else if (start[1].x=start[2].x)and(start[1].y>start[2].y) then begin tt:=start[1]; start[1]:=start[2]; start[2]:=tt; end;
   end;
if cnt=1 then begin tmp:=1; end
   else if (start[1].x=start[2].x) then begin  tmp:=2; end
           else begin tmp:=3; end;
f[start[1].x][start[1].y][tmp]:=0;
head:=1; tail:=1;
que[1]:=start;
que[1][3].c:=tmp;
ans:=inf;
while head<=tail do
  begin
  u:=que[head][1].x; v:=que[head][1].y; w:=que[head][3].c;
  if que[head][3].c=1 then
     begin
     check(que[head][1].x,que[head][1].y+1,que[head][1].x,que[head][1].y+2,2);
     check(que[head][1].x,que[head][1].y-1,que[head][1].x,que[head][1].y-2,2);
     check(que[head][1].x+1,que[head][1].y,que[head][1].x+2,que[head][1].y,3);
     check(que[head][1].x-1,que[head][1].y,que[head][1].x-2,que[head][1].y,3);
     end
  else if que[head][3].c=2 then
          begin
          check(que[head][2].x,que[head][2].y+1,n+1,m+1,1);
          check(que[head][1].x,que[head][1].y-1,n+1,m+1,1);
          check(que[head][1].x-1,que[head][1].y,que[head][2].x-1,que[head][2].y,2);
          check(que[head][1].x+1,que[head][1].y,que[head][2].x+1,que[head][2].y,2);
          end
       else begin
            check(que[head][1].x-1,que[head][1].y,n+1,m+1,1);
            check(que[head][2].x+1,que[head][2].y,n+1,m+1,1);
            check(que[head][1].x,que[head][1].y-1,que[head][2].x,que[head][2].y-1,3);
            check(que[head][1].x,que[head][1].y+1,que[head][2].x,que[head][2].y+1,3);
            end;
  inc(head);
  end;
if ans=inf then writeln('Impossible')
   else writeln(ans);
readln(n,m);
end;
//close(input);
end.