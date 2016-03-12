const maxn=1020; maxm=1000000; inf=1000000;
var edge,f:array[0..maxn,0..maxn]of longint;
    dis,hash:array[0..maxn]of longint;
    n,m1,m2,a,b,d,i,head,tail:longint;
    q:array[1..maxm]of longint;
    mark:array[0..maxn]of boolean;
procedure addedge(x,y,len:longint);
begin
inc(edge[x,0]);
edge[x,edge[x,0]]:=y;
f[x,edge[x,0]]:=len;
end;
function spfa:longint;
var i,now,t:longint;
begin

head:=1;
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
            mark[t]:=true;
            inc(tail);
            q[tail]:=t;
            inc(hash[t]);
            if hash[t]>=n then exit(-1);
            end;
         end;
      end;
  mark[now]:=false;
  inc(head);
  end;
if dis[n]=inf then exit(-2) else exit(dis[n]-dis[1]);
end;
begin
{assign(input,'layout.in');
reset(input);
assign(output,'layout.out');
rewrite(output);}
readln(n,m1,m2);
for i:=1 to n do
    begin
    inc(edge[i,0]); edge[i,edge[i,0]]:=1;
    end;
for i:=1 to n do dis[i]:=inf;
for i:=1 to m1 do
    begin
    readln(a,b,d);
    addedge(a,b,d);
    if not mark[a] then
       begin
       inc(tail);
       q[tail]:=a;
       dis[a]:=inf;
       if a=1 then dis[a]:=0;
       mark[a]:=true;
       inc(hash[a]);
       end;
    end;
for i:=1 to m2 do
    begin
    readln(a,b,d);
    addedge(b,a,-d);
    if not mark[b] then
       begin
       inc(tail);
       q[tail]:=b;
       dis[b]:=inf;
       if b=1 then dis[b]:=0;
       mark[b]:=true;
       inc(hash[b]);
       end;
    end;
for i:=2 to n do
    begin
    addedge(i,i-1,0);
    if not mark[i] then
       begin
       inc(tail);
       q[tail]:=i;
       dis[i]:=inf;
       mark[i]:=true;
       inc(hash[i]);
       end;
    end;
writeln(spfa);
{close(input);
close(output);}
end.
