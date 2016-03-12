const inf=1000000000; maxn=1020; maxm=10020;
var tot,i,n,m,j,x,y,l,s,e:longint;
    edge,f:array[1..maxn,0..maxm]of longint;
    dis,cnt:array[1..maxn,0..1]of longint;
    vis:array[1..maxn,0..1]of boolean;
procedure dij(s,e:longint);
var i,j,fmin,u,flag,t,v,sum:longint;
begin
for i:=1 to n do
    begin
    dis[i,0]:=inf; dis[i,1]:=inf;
    cnt[i,0]:=0; cnt[i,1]:=0;
    end;
cnt[s,0]:=1; dis[s,0]:=0;
fillchar(vis,sizeof(vis),false);
for i:=1 to 2*n do
    begin
    fmin:=inf;
    for j:=1 to n do
        begin
        if (not vis[j,0])and(dis[j,0]<fmin) then
           begin
           u:=j;
           flag:=0;
           fmin:=dis[j,0];
           end
        else if (not vis[j,1])and(dis[j,1]<fmin) then
                begin
                u:=j;
                flag:=1;
                fmin:=dis[j,1];
                end;
        end;
    vis[u,flag]:=true;
    if fmin=inf then break;
    for j:=1 to edge[u,0] do
        begin
        t:=edge[u,j];
        v:=f[u,j];
        if fmin+v<dis[t,0] then
           begin
           dis[t,1]:=dis[t,0];
           cnt[t,1]:=cnt[t,0];
           dis[t,0]:=fmin+v;
           cnt[t,0]:=cnt[u,flag];
           end
        else
           if fmin+v=dis[t,0] then
              begin
              cnt[t,0]:=cnt[t,0]+cnt[u,flag];
              end
           else
              if fmin+v<dis[t,1] then
                 begin
                 dis[t,1]:=fmin+v;
                 cnt[t,1]:=cnt[u,flag];
                 end
              else
                 if fmin+v=dis[t,1] then
                    begin
                    cnt[t,1]:=cnt[t,1]+cnt[u,flag];
                    end;
        end;
    end;
sum:=cnt[e,0];
if dis[e,1]=dis[e,0]+1 then inc(sum,cnt[e,1]);
writeln(sum);
end;
begin
{assign(input,'seeing.in');
reset(input);
assign(output,'seeing.out');
rewrite(output);}
readln(tot);
for i:=1 to tot do
    begin
    readln(n,m);
    for j:=1 to n do edge[j,0]:=0;
    for j:=1 to m do
        begin
        readln(x,y,l);
        inc(edge[x,0]);
        edge[x,edge[x,0]]:=y;
        f[x,edge[x,0]]:=l;
        end;
    readln(s,e);
    dij(s,e);
    end;
{close(input);
close(output);}
end.