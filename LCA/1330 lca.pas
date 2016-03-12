const maxn=40020;
type rec=record u,v,nxt:longint; end;
var tot,test,u,n,ans,i,s,x,y,st,en:longint;
    fa,vis,checked,edge,cnt:array[0..maxn]of longint;
    g:array[0..maxn]of rec;
procedure addedge(x,y:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=edge[x]; edge[x]:=tot;
inc(tot); g[tot].u:=y; g[tot].v:=x; g[tot].nxt:=edge[y]; edge[y]:=tot;
end;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure init;
begin
tot:=0;
fillchar(cnt,sizeof(cnt),0);
fillchar(edge,sizeof(edge),0);
fillchar(g,sizeof(g),0);
fillchar(vis,sizeof(vis),0);
fillchar(checked,sizeof(checked),0);
end;
procedure tarjan(x:longint);
var p,t1:longint;
begin
vis[x]:=1;
p:=edge[x];
fa[x]:=x;
while p<>0 do
  begin
  if (vis[g[p].v]=0) then
     begin
     tarjan(g[p].v);
     t1:=getfa(g[p].v);
     fa[t1]:=x;
     end;
  p:=g[p].nxt;
  end;
checked[x]:=1;
if (x=st)and(checked[en]=1) then ans:=getfa(en);
if (x=en)and(checked[st]=1) then ans:=getfa(st);
end;
begin
{assign(input,'lca.in');
reset(input);
assign(output,'lca.out');
rewrite(output);}
readln(test);
for u:=1 to test do
    begin
    init;
    readln(n);
    for i:=1 to n-1 do
        begin
        readln(x,y);
        addedge(x,y);
        inc(cnt[y]);
        end;
    for i:=1 to n do fa[i]:=i;
    readln(st,en);
    ans:=0;
    for i:=1 to n do if cnt[i]=0 then begin s:=i; break; end;
    tarjan(s);
    writeln(ans);
    end;
{close(input);
close(output);}
end.
