const maxn=30020; maxm=155000;
type rec=record fir,last:longint; end;
     re=record u,v,nxt:longint; end;
var g,h:array[1..maxm]of re;
    edge,edge2:array[0..maxn]of rec;
    n,m,tot,tme,top,sum,x,y,i,j,t,total,fmax,p:longint;
    instack,vis:array[0..maxn]of boolean;
    low,dfn,col,stack,a,inner,start,sigma,f,topsort:array[0..maxn]of longint;
procedure pre;
begin  fillchar(a,sizeof(a),0);
  fillchar(edge,sizeof(edge),0);
  fillchar(edge2,sizeof(edge2),0);
  fillchar(g,sizeof(h),0);
  fillchar(h,sizeof(g),0);
  fillchar(col,sizeof(col),0);
  fillchar(dfn,sizeof(dfn),0);
  fillchar(low,sizeof(low),0);
  fillchar(stack,sizeof(stack),0);
  fillchar(inner,sizeof(inner),0);
  fillchar(start,sizeof(start),0);
  fillchar(sigma,sizeof(sigma),0);
  fillchar(instack,sizeof(instack),false);
  p:=0; tot:=0; top:=0; tme:=0; total:=0; fmax:=-maxlongint;
end;
procedure init;
var i,x,y:longint;
begin
for i:=1 to n do
    begin
    readln(a[i]);
    if a[i]<0 then a[i]:=0;
    end;
for i:=1 to m do
    begin
    readln(x,y);
    inc(x); inc(y); // 0-n-1
    inc(tot);
    g[tot].u:=x; g[tot].v:=y;
    if edge[x].fir=0 then
       begin
       edge[x].fir:=tot;
       edge[x].last:=tot;
       end
    else
       begin
       g[edge[x].last].nxt:=tot;
       edge[x].last:=tot;
       end;
    end;
end;
procedure tarjan(x:longint);
var i,t:longint;
begin
inc(tme); low[x]:=tme; dfn[x]:=tme;
inc(top); stack[top]:=x; instack[x]:=true;
i:=edge[x].fir;
while i<>0 do
  begin
  t:=g[i].v;
  if dfn[t]=0 then
     begin
     tarjan(t);
     if low[t]<low[x] then low[x]:=low[t];
     end
  else if (instack[t])and(dfn[t]<low[x]) then low[x]:=dfn[t];
  i:=g[i].nxt;
  end;
if dfn[x]=low[x] then
   begin
   inc(sum);
   while stack[top+1]<>x do
    begin
    stack[top+1]:=0;
    instack[stack[top]]:=false; col[stack[top]]:=sum;
    dec(top);
    end;
   end;
end;
procedure buildgraph(x,y:longint);
begin
inc(inner[y]);
inc(total); h[total].u:=x; h[total].v:=y;
if edge2[x].fir=0 then
   begin
   edge2[x].fir:=total; edge2[x].last:=total;
   end
else
   begin
   h[edge2[x].last].nxt:=total;
   edge2[x].last:=total;
   end;
end;
procedure dfs(num:longint);
var i,t:longint;
begin
vis[num]:=true;
i:=edge2[num].fir;
while i<>0 do
  begin
  t:=h[i].v;
  if not vis[t] then dfs(t);
  i:=h[i].nxt;
  end;
inc(p);
topsort[p]:=num;
end;
begin
{assign(input,'christmas.in');
reset(input);
assign(output,'christmas.out');
rewrite(output);}
while not eof do
  begin
  readln(n,m);
  pre;
  init;
  for i:=1 to n do if dfn[i]=0 then tarjan(i);
  for i:=1 to m do
      begin
      if col[g[i].u]<>col[g[i].v] then
         buildgraph(col[g[i].u],col[g[i].v]);
      end;
  for i:=1 to sum do
      if inner[i]=0 then
         begin
         inc(start[0]);
         start[start[0]]:=i;
         end;
  for i:=1 to n do inc(sigma[col[i]],a[i]);
  for i:=1 to sum do vis[i]:=false;
  for i:=1 to sum do
     if not vis[i] then dfs(i);
  for i:=1 to sum do f[i]:=-maxlongint;
  for i:=1 to start[0] do f[start[i]]:=sigma[start[i]];
  for i:=p downto 1 do
      begin
      j:=edge2[topsort[i]].fir;
      while j<>0 do
        begin
        t:=h[j].v;
        if (f[topsort[i]]+sigma[t]>f[t]) then f[t]:=f[topsort[i]]+sigma[t];
        j:=h[j].nxt;
        end;
      if f[topsort[i]]>fmax then fmax:=f[topsort[i]];
      end;
  writeln(fmax);
  end;
{close(input);
close(output);}
end.
