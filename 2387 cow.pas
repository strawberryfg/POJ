//18:38;
const maxn=2020;
      inf=maxlongint;
var m,n,tot,i,j,x,y,z,num,now:longint;
    edge,f:array[0..maxn,0..maxn]of longint;
    dis:array[0..maxn]of longint;
    vis:array[0..maxn]of boolean;
    heap,po:array[0..maxn]of longint;
procedure down(x:longint);
var t1,t2,p,tmp:longint;
begin
while x*2<=tot do
  begin
  t1:=dis[heap[x*2]]; if x*2+1<=tot then t2:=dis[heap[x*2+1]] else t2:=maxlongint;
  if t1<=t2 then p:=0 else p:=1;
  if dis[heap[x]]>dis[heap[x*2+p]] then
     begin
     tmp:=po[heap[x]]; po[heap[x]]:=po[heap[x*2+p]]; po[heap[x*2+p]]:=tmp;
     tmp:=heap[x];     heap[x]:=heap[x*2+p];         heap[x*2+p]:=tmp;
     x:=x*2+p;
     end
  else
     break;
  end;
end;
procedure modify(id,key:longint);
var p,tmp:longint;
begin
if key<dis[id] then
   begin
   dis[id]:=key;
   p:=po[id];
   while p div 2>=1 do
     begin
     if dis[heap[p]]<dis[heap[p div 2]] then
        begin
        tmp:=po[heap[p]]; po[heap[p]]:=po[heap[p div 2]]; po[heap[p div 2]]:=tmp;
        tmp:=heap[p];     heap[p]:=heap[p div 2];         heap[p div 2]:=tmp;
        p:=p div 2;
        end
     else
        break;
     end;
   end;
end;
procedure pop;
begin
num:=heap[1]; now:=dis[num];
po[heap[tot]]:=1;
heap[1]:=heap[tot];
heap[tot]:=0;
dec(tot);
if tot>0 then down(1);
end;
begin
{assign(input,'cow.in');
reset(input);}
readln(m,n);
for i:=1 to n do for j:=1 to n do f[i][j]:=inf;
for i:=1 to m do
    begin
    readln(x,y,z);
    if z<f[x][y] then
       begin
       f[x][y]:=z;
       f[y][x]:=z;
       end;
    end;
for i:=1 to n do
    begin
    dis[i]:=inf;
    vis[i]:=false;
    end;
dis[1]:=0;
for i:=1 to n do begin heap[i]:=i; po[i]:=i; end;
tot:=n;
while tot>0 do
  begin
  num:=0; now:=inf;
  pop;
  if now=inf then break;
  for i:=1 to n do
      begin
      if (f[i][num]<>inf)and(dis[num]+f[num][i]<dis[i]) then
         modify(i,dis[num]+f[num][i]);
      end;
 // vis[num]:=true;
  end;
writeln(dis[n]);
//close(input);
end.