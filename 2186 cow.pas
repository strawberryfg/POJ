const maxn=10020; maxm=50020;
type rec=record u,v,nxt:longint; end;
     re=record fir,last,cnt:longint; end;
var n,m,i,x,y,tot,top,tme,cnt,res,sum:longint;
    vis,instack:array[1..maxn]of boolean;
    dfn,low,stack,belong,f,num:array[1..maxn]of longint;
    edge:array[1..maxn]of re;
    a:array[1..maxm]of rec;
    pd:boolean;
procedure tarjan(x:longint);
var i,t:longint;
begin
vis[x]:=true;
inc(tme); dfn[x]:=tme; low[x]:=tme;
inc(top); stack[top]:=x; instack[x]:=true;
i:=edge[x].fir;
while i<>0 do
    begin
    t:=a[i].v;
    if dfn[t]=0 then
       begin
       tarjan(t);
       if low[t]<low[x] then low[x]:=low[t];
       end
    else if (instack[t])and(dfn[t]<low[x]) then low[x]:=dfn[t];
    i:=a[i].nxt;
    end;
if dfn[x]=low[x] then
   begin
   inc(cnt);
   while stack[top+1]<>x do
     begin
     stack[top+1]:=0;
     instack[stack[top]]:=false; belong[stack[top]]:=cnt;
     inc(num[cnt]);
     dec(top);
     end;
   end;
end;
begin
{assign(input,'cow.in');
reset(input);
assign(output,'cow.out');
rewrite(output);}
readln(n,m);
for i:=1 to m do
    begin
    readln(x,y);
    inc(tot);
    a[tot].u:=x; a[tot].v:=y;
    inc(edge[x].cnt);
    if edge[x].fir=0 then
       begin
       edge[x].fir:=tot;
       edge[x].last:=tot;
       a[tot].nxt:=0;
       end
    else
       begin
       a[edge[x].last].nxt:=tot;
       edge[x].last:=tot;
       a[tot].nxt:=0;
       end;
    end;
for i:=1 to n do
    begin
    if vis[i]=false then tarjan(i);
    end;
for i:=1 to m do
    begin
    x:=a[i].u; y:=a[i].v;
    if belong[x]<>belong[y] then   //u - > v
       inc(f[belong[x]]);
    end;
pd:=true; sum:=0;
for i:=1 to cnt do
    begin
    if f[i]=0 then
       begin
       inc(sum);
       res:=i;
       end;
    if sum>1 then begin pd:=false;break; end;
    end;
if not pd then writeln(0) else writeln(num[res]);
{close(input);
close(output);}
end.