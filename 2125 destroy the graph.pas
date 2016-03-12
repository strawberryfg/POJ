const maxn=400; maxm=20000; inf=100000000;
type rec=record first,last:longint; end;
     node=record u,v,w,key,nxt:longint; end;
var tot,sum,n,m,i,x,y,w,s,t,k,p,now,ans,min,num,j:longint;
    edge:array[0..maxn]of rec;
    g:array[0..maxm]of node;
    vis:array[0..maxn]of boolean;
    res:array[0..maxm]of longint;
    hash,pre,his,h,a,b:array[0..maxn]of longint;
    flag:boolean;
procedure addedge(be,en,w:longint);
begin
inc(tot); g[tot].u:=be; g[tot].v:=en; g[tot].w:=w;
if edge[be].first=0 then edge[be].first:=tot
   else g[edge[be].last].nxt:=tot;
edge[be].last:=tot;
g[tot].key:=tot+1;
inc(tot); g[tot].u:=en; g[tot].v:=be; g[tot].w:=0;
if edge[en].first=0 then edge[en].first:=tot
   else g[edge[en].last].nxt:=tot;
edge[en].last:=tot;
g[tot].key:=tot-1;
end;
procedure dfs(x:longint);
var p:longint;
begin
vis[x]:=true;
p:=edge[x].first;
while p<>0 do
  begin
  if (g[p].w>0)and(not vis[g[p].v]) then
     dfs(g[p].v);
  p:=g[p].nxt;
  end;
end;
begin
{assign(input,'destroy.in');
reset(input);}
readln(n,m);
s:=0; t:=2*n+1;
for i:=1 to n do
    begin
    read(w);
    a[i]:=w;
    addedge(i+n,t,w);
    end;
for i:=1 to n do
    begin
    read(w);
    b[i]:=w;
    addedge(s,i,w);
    end;
for i:=1 to m do
    begin
    read(x,y);
    addedge(x,y+n,inf);
    end;
now:=maxlongint;
hash[0]:=2*n+2;
i:=s;
ans:=0;
while h[s]<2*n+2 do
  begin
  his[i]:=now;
  flag:=false;
  p:=edge[i].first;
  while p<>0 do
    begin
    k:=g[p].v;
    if (g[p].w>0)and(h[k]+1=h[i]) then
       begin
       flag:=true;
       if g[p].w<now then now:=g[p].w;
       pre[k]:=p;
       i:=k;
       if i=t then
          begin
          ans:=ans+now;
          while i<>s do
            begin
            dec(g[pre[i]].w,now);
            inc(g[g[pre[i]].key].w,now);
            i:=g[pre[i]].u;
            end;
          now:=maxlongint;
          end;
       break;
       end;
    p:=g[p].nxt;
    end;
  if not flag then
     begin
     min:=2*n+1; num:=-1;
     p:=edge[i].first;
     while p<>0 do
       begin
       k:=g[p].v;
       if (g[p].w>0)and(h[k]<min) then
          begin
          min:=h[k];
          num:=k;
          end;
       p:=g[p].nxt;
       end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then
        break;
     h[i]:=min+1;
     inc(hash[h[i]]);
     if i<>0 then begin i:=g[pre[i]].u; now:=his[i]; end;
     end;
  end;
writeln(ans);
dfs(s);
for i:=1 to tot do
    begin
    if i mod 2=0 then continue;
    if (vis[g[i].u])and(not vis[g[i].v])and(g[i].w=0) then
       begin
       inc(sum);
       res[sum]:=i;
       end;
    end;
writeln(sum);
for i:=1 to sum do
    begin
    if g[res[i]].u=0 then writeln(g[res[i]].v,' -')
       else writeln(g[res[i]].u-n,' +');
    end;
//close(input);
end.