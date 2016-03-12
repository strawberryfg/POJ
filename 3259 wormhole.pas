const maxn=520;  maxm=2800; maxx=1000000;
var ff,i,n,m,w,j,s,e,t,head,tail,now:longint;
    pd:boolean;
    edge,f:array[1..maxn,0..maxm]of longint;
    mark:array[1..maxn]of boolean;
    dis,hash:array[1..maxn]of longint;
    q:array[1..maxx]of longint;
begin
{assign(input,'wormhole.in');
reset(input);
assign(output,'wormhole.out');
rewrite(output); }
readln(ff);
for i:=1 to ff do
    begin
    readln(n,m,w);
    fillchar(edge,sizeof(edge),0);
    fillchar(f,sizeof(f),0);
    fillchar(hash,sizeof(hash),0);
    fillchar(q,sizeof(q),0);
    fillchar(dis,sizeof(dis),0);
    fillchar(mark,sizeof(mark),false);
    for j:=1 to m do
        begin
        readln(s,e,t);
        inc(edge[s,0]); edge[s,edge[s,0]]:=e;
        f[s,edge[s,0]]:=t;
        inc(edge[e,0]); edge[e,edge[e,0]]:=s;
        f[e,edge[e,0]]:=t;
        end;
    for j:=1 to w do
        begin
        readln(s,e,t);
        inc(edge[s,0]); edge[s,edge[s,0]]:=e;
        f[s,edge[s,0]]:=-t;
        end;
    head:=1; tail:=1;
    q[1]:=1; mark[1]:=true; dis[1]:=0; hash[1]:=1;
    for j:=2 to n do dis[j]:=maxlongint;
    pd:=false;
    while head<=tail do
      begin
      now:=q[head];
      for j:=1 to edge[now,0] do
          begin
          t:=edge[now,j];
          if dis[now]+f[now,j]<dis[t] then
             begin
             dis[t]:=dis[now]+f[now,j];
             if not mark[t] then
                begin
                inc(tail);
                q[tail]:=t;
                mark[t]:=true;
                inc(hash[t]);
                if hash[t]>n then
                   begin
                   pd:=true;
                   break;
                   end;
                end;
             end;
          end;
      if pd then break;
      inc(head);
      mark[now]:=false;
      end;
    if pd then writeln('YES') else writeln('NO');
    end;
{close(input);
close(output);}
end.