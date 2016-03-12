const maxn=120; maxm=4020; maxx=10020; max=4000000;
var k,n,m,i,s,d,l,t,fmin,head,tail:longint;
    q,a:array[1..max]of longint;
    mark:array[1..maxn,0..maxx]of boolean;
    f:array[1..maxn,0..maxx]of longint;
    w,edge,len:array[1..maxn,0..maxm]of longint;
function spfa:longint;
var now,x,i,j,t:longint;
begin
head:=1; tail:=1; q[1]:=1; mark[1,0]:=true;
a[1]:=0;
for i:=1 to maxn do
    begin
    for j:=0 to maxx do
        f[i,j]:=maxlongint;
    end;
f[1,0]:=0;
while head<=tail do
  begin
  now:=q[head];
  x:=a[head];
  for i:=1 to edge[now,0] do
      begin
      t:=edge[now,i];
      if (x+w[now,i]>k) then continue;
      if f[now,x]+len[now,i]<f[t,x+w[now,i]] then
         begin
         f[t,x+w[now,i]]:=f[now,x]+len[now,i];
         if (t=n)and(x+w[now,i]<=k)and(f[t,x+w[now,i]]<fmin) then
            fmin:=f[t,x+w[now,i]];
         if not mark[t,x+w[now,i]] then
            begin
            inc(tail);
            q[tail]:=t;
            a[tail]:=x+w[now,i];
            mark[t,x+w[now,i]]:=true;
            end;
         end;
      end;
  mark[now,x]:=false;
  inc(head);
  end;
if fmin=maxlongint then exit(-1) else exit(fmin);
end;
begin
{assign(input,'roads.in');
reset(input);}
readln(k);
readln(n);
readln(m);
for i:=1 to m do
    begin
    readln(s,d,l,t);
    inc(edge[s,0]);
    edge[s,edge[s,0]]:=d;
    len[s,edge[s,0]]:=l;   //length
    w[s,edge[s,0]]:=t;   //toll
    end;
fmin:=maxlongint;
writeln(spfa);
//close(input);
end.