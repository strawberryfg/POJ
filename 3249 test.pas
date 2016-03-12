const maxn=100020; maxm=1000020;
type re=record fir,last:longint; end;
     rec=record u,v,nxt:longint; end;
var n,m,i,tot,x,y,p,t,tmp,fmax:longint;
    edge:array[1..maxn]of re;
    g:array[1..maxm]of rec;
    f,v,inner,outer:array[1..maxn]of longint;
    vis:array[1..maxn]of boolean;
    a:array[1..maxn]of longint;
procedure dfs(x:longint);
var t,tmp:longint;
begin
vis[x]:=true;
t:=edge[x].fir;
while t<>0 do
 begin
 tmp:=g[t].v;
 if not vis[tmp] then dfs(tmp);
 t:=g[t].nxt;
 end;
inc(p);
a[p]:=x;
end;
begin
{assign(input,'test.in');
reset(input);}
while not eof do
  begin
  readln(n,m);
  for i:=1 to n do
      begin
      readln(v[i]);
      edge[i].fir:=0; edge[i].last:=0;
      inner[i]:=0;
      outer[i]:=0;
      end;
  tot:=0;
  for i:=1 to m do
      begin
      readln(x,y);
      inc(tot);
      g[tot].u:=x; g[tot].v:=y; g[tot].nxt:=0;
      inc(inner[y]);
      inc(outer[x]);
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
  for i:=1 to n do
      begin
      if inner[i]=0 then f[i]:=v[i]
         else f[i]:=-maxlongint;
      end;
  p:=0;
  fillchar(vis,sizeof(vis),false);
  for i:=1 to n do if not vis[i] then dfs(i);
  for i:=p downto 1 do
      begin
      t:=edge[a[i]].fir;
      while t<>0 do
        begin
        tmp:=g[t].v;
        if f[a[i]]+v[tmp]>f[tmp] then f[tmp]:=f[a[i]]+v[tmp];
        t:=g[t].nxt;
        end;
      end;
  fmax:=-maxlongint;
  for i:=1 to n do
      begin
      if (outer[i]=0)and(f[i]>fmax) then
         fmax:=f[i];
      end;
  writeln(fmax);
  end;
//close(input);
end.