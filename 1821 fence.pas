const maxn=18020; maxworker=150;
var n,k,i,tmp,j,f,t:longint;
    q:array[0..maxn]of longint;
    l,p,s:array[0..maxworker]of longint;
    g:array[0..maxworker,0..maxn]of longint;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function work(x,y:longint):longint;
begin
exit(g[i-1][x]-x*p[i]-(g[i-1][y]-y*p[i]));
end;
begin
{assign(input,'fence.in');
reset(input);}
readln(n,k);
for i:=1 to k do readln(l[i],p[i],s[i]);
for i:=1 to k-1 do
    for j:=i+1 to k do
        if s[i]>s[j] then
           begin
           tmp:=l[i]; l[i]:=l[j]; l[j]:=tmp;
           tmp:=p[i]; p[i]:=p[j]; p[j]:=tmp;
           tmp:=s[i]; s[i]:=s[j]; s[j]:=tmp;
           end;
for i:=1 to k do
    begin
    for j:=0 to s[i]-1 do
        g[i][j]:=g[i-1][j];
    f:=1; t:=0;
    for j:=max(s[i]-l[i],0) to s[i]-1 do
        begin
        if t=0 then
           begin
           inc(t); q[t]:=j;
           end
        else
           begin
           while (f<=t)and(work(j,q[t])>0) do dec(t);
           inc(t); q[t]:=j;
           end;
        end;
    for j:=s[i] to n do
        begin
        g[i][j]:=max(g[i-1][j],g[i][j-1]);
        while (f<=t)and(q[f]<j-l[i]) do inc(f);
        if f<=t then g[i][j]:=max(g[i][j],g[i-1][q[f]]-q[f]*p[i]+p[i]*j);
        end;
    end;
writeln(g[k][n]);
//close(input);
end.