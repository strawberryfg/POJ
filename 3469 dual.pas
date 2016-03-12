const maxn=100000; maxm=1000000;
type node=record first,last:longint; end;
     graphnode=record u,v,w,key,nxt:longint; end;
var n,m,s,t,k,a,b,i,j,tot,ans,now,min,num,x,y,w,p:longint;
    edge:array[0..maxn]of node;
    g:array[0..maxm]of graphnode;
    h,hash,pre,his,info:array[0..maxn]of longint;
    flag:boolean;
procedure addedge(x,y,w:longint);
begin
inc(tot); g[tot].u:=x; g[tot].v:=y; g[tot].w:=w;
if edge[x].first=0 then edge[x].first:=tot
   else g[edge[x].last].nxt:=tot;
edge[x].last:=tot;
if k<>0 then
   begin
   g[tot].key:=tot+1; inc(tot);
   g[tot].u:=y; g[tot].v:=x; g[tot].w:=w;
   if edge[y].first=0 then edge[y].first:=tot
      else g[edge[y].last].nxt:=tot;
   edge[y].last:=tot;
   g[tot].key:=tot-1;
   end;
end;
begin
{assign(input,'core.in');
reset(input);}
readln(n,m);
s:=0; t:=n+1;
for i:=1 to n do
    begin
    read(a,b);
    k:=0;
    addedge(s,i,a);
    k:=0;
    addedge(i,t,b);
    end;
for i:=1 to m do
    begin
    readln(x,y,w);
    k:=1;
    addedge(x,y,w);
    end;
now:=maxlongint;
hash[0]:=n+2;
ans:=0;
for i:=s to t do info[i]:=edge[i].first;
i:=s;
while h[s]<n+2 do
  begin
  flag:=false;
  his[i]:=now;
  p:=info[i];
  while p<>0 do
    begin
    j:=g[p].v;
    if (g[p].w>0)and(h[j]+1=h[i]) then
       begin
       flag:=true;
       if g[p].w<now then now:=g[p].w;
       pre[j]:=p;
       info[i]:=p;
       i:=j;
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
     min:=n+1; num:=-1;
     p:=edge[i].first;
     while p<>0 do
       begin
       j:=g[p].v;
       if (g[p].w>0)and(h[j]<min) then
          begin
          min:=h[j];
          num:=p;
          end;
       p:=g[p].nxt;
       end;
     dec(hash[h[i]]);
     if hash[h[i]]=0 then break;
     h[i]:=min+1;
     info[i]:=num;
     inc(hash[h[i]]);
     if i<>s then begin i:=g[pre[i]].u;  now:=his[i]; end;
     end;
  end;
writeln(ans);
//close(input);
end.