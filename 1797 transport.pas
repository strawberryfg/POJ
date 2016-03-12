const maxn=1020; maxm=2000000;
type rec=record u,v,w:longint; end;
var t,i,n,m,j,x,y,z,tot:longint;
    edge:array[1..maxm]of rec;
    fa:array[1..maxn]of longint;
procedure sort(l,r: longint);
      var
         i,j,x: longint;
         tmp:rec;
      begin
         i:=l;
         j:=r;
         x:=edge[(l+r) div 2].w;
         repeat
           while edge[i].w>x do
            inc(i);
           while x>edge[j].w do
            dec(j);
           if not(i>j) then
             begin
                tmp:=edge[i];
                edge[i]:=edge[j];
                edge[j]:=tmp;
                inc(i);
                dec(j);
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
procedure init;
var i:longint;
begin
tot:=0; fillchar(edge,sizeof(edge),0);
for i:=1 to n do fa[i]:=i;
end;
function getfa(num:longint):longint;
begin
if fa[num]=num then exit(num)
   else begin
        fa[num]:=getfa(fa[num]);
        exit(fa[num]);
        end;
end;
function kruskal:longint;
var a,b,i,j:longint;
begin
i:=0; j:=1;  //j : edge
while (i<n-1)and(j<=tot) do
 begin
 a:=getfa(edge[j].u); b:=getfa(edge[j].v);
 if a<>b then
    begin
    fa[b]:=a;
    inc(i);
    end;
 a:=getfa(1); b:=getfa(n);
 if a=b then exit(edge[j].w);
 inc(j);
 end;
end;
begin
{assign(input,'transport.in');
reset(input);}
readln(t);
for i:=1 to t do
    begin
    readln(n,m);
    init;
    for j:=1 to m do
        begin
        readln(x,y,z);
        inc(tot);
        edge[tot].u:=x; edge[tot].v:=y; edge[tot].w:=z;
        end;
    sort(1,m);
    writeln('Scenario #',i,':');
    writeln(kruskal);
    writeln;
    end;
//close(input);
end.