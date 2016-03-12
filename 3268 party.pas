const maxn=1020; maxm=1020; maxx=3000000;
var n,m,x,i,a,b,t,fmax:longint;
    edge,edge2,f,tf:array[1..maxn,0..maxm]of longint;
    mark:array[1..maxn]of boolean;
    dis,dis2:array[1..maxn]of longint;
    q:array[1..maxx]of longint;
procedure spfa(s:longint);
var i,now,t,head,tail:longint;
begin
head:=1; tail:=1; q[1]:=s; mark[s]:=true;
for i:=1 to n do dis[i]:=maxlongint;
dis[s]:=0;
while head<=tail do
  begin
  now:=q[head];
  for i:=1 to edge[now,0] do
      begin
      t:=edge[now,i];
      if dis[now]+f[now,i]<dis[t] then
         begin
         dis[t]:=dis[now]+f[now,i];
         if not mark[t] then
            begin
            inc(tail);
            q[tail]:=t;
            mark[t]:=true;
            end;
         end;
      end;
  mark[now]:=false;
  inc(head);
  end;
end;
procedure spfa2(s:longint);
var i,now,t,head,tail:longint;
begin
head:=1; tail:=1;
fillchar(mark,sizeof(mark),false);
fillchar(q,sizeof(q),0);
mark[s]:=true;
q[1]:=s;
for i:=1 to n do dis2[i]:=maxlongint;
dis2[s]:=0;


while head<=tail do
  begin
  now:=q[head];
  for i:=1 to edge2[now,0] do
      begin
      t:=edge2[now,i];
      if dis2[now]+tf[now,i]<dis2[t] then
         begin
         dis2[t]:=dis2[now]+tf[now,i];
         if not mark[t] then
            begin
            inc(tail);
            q[tail]:=t;
            mark[t]:=true;
            end;
         end;
      end;
  mark[now]:=false;
  inc(head);
  end;
end;
begin
{assign(input,'party.in');
reset(input);
assign(output,'party.out');
rewrite(output);}
readln(n,m,x);
for i:=1 to m do
    begin
    readln(a,b,t);
    inc(edge[a,0]); edge[a,edge[a,0]]:=b; f[a,edge[a,0]]:=t;
    inc(edge2[b,0]); edge2[b,edge2[b,0]]:=a; tf[b,edge2[b,0]]:=t;
    end;
spfa(x);
spfa2(x);
fmax:=0;
for i:=1 to n do
    begin
    if dis[i]+dis2[i]>fmax then fmax:=dis[i]+dis2[i];
    end;
writeln(fmax);
{close(input);
close(output);}
end.