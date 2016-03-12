const maxn=120; maxx=1000200;
var n,m,s,tt,i,x,y,b,e,c,ans:longint;
    edge:array[1..maxn,0..maxn]of longint;
    f:array[1..maxn,0..maxn,1..3]of longint;
    q:array[1..maxx]of longint;
    d:array[1..maxn]of longint;
    mark:array[1..maxn]of boolean;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
procedure spfa(x:longint);
var i,head,tail,now,t,tmp:longint;
begin
for i:=1 to n do d[i]:=maxlongint;
fillchar(mark,sizeof(mark),false);
d[s]:=x;
head:=1; tail:=1; q[1]:=s;
mark[s]:=true;
while head<=tail do
 begin
 now:=q[head];
 for i:=1 to edge[now,0] do
     begin
     t:=edge[now,i];
     tmp:=max(d[now],f[now,i,1]);
     if (tmp+f[now,i,3]<=f[now,i,2])and(d[now]+f[now,i,3]<d[t]) then
        begin
        d[t]:=tmp+f[now,i,3];
        if not mark[t] then
           begin
           inc(tail);
           q[tail]:=t;
           mark[t]:=true;
           end;
        end;
     end;
 inc(head);
 mark[now]:=false;
 end;
end;
begin
{assign(input,'escort.in');
reset(input);}
readln(n,m,s,tt);
for i:=1 to m do
    begin
    readln(x,y,b,e,c);
    if b+c>e then continue;
    inc(edge[x,0]); edge[x,edge[x,0]]:=y;
    f[x,edge[x,0],1]:=b; f[x,edge[x,0],2]:=e;  f[x,edge[x,0],3]:=c;
    end;
ans:=maxlongint;
for i:=0 to 10000 do
    begin
    spfa(i);
    if d[tt]=maxlongint then break;
    if d[tt]-d[s]<ans then
       ans:=d[tt]-d[s];
    end;
if ans=maxlongint then writeln('Impossible') else writeln(ans);
//close(input);
end.