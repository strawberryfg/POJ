const maxn=100020;
var t,cnt,n,m,i,t1,t2,a,b,tmp:longint;
    e,fa,rank:array[0..maxn]of longint;
    ch:char;
function getfa(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfa(fa[x]);
exit(fa[x]);
end;
procedure union(x,y:longint);
var t1,t2:longint;
begin
t1:=getfa(x); t2:=getfa(y);
if t1=t2 then exit;
if rank[t1]>rank[t2] then begin fa[t2]:=t1; rank[t1]:=rank[t1]+rank[t2]; end
   else begin
        fa[t1]:=t2;
        rank[t2]:=rank[t2]+rank[t1];
        end;
end;
begin
{assign(input,'criminal.in');
reset(input);}
readln(t);
for cnt:=1 to t do
    begin
    readln(n,m);
    for i:=1 to n do begin e[i]:=i; fa[i]:=i; rank[i]:=1; end;
    for i:=1 to m do
        begin
        readln(ch,a,b);
        if ch='A' then
           begin
           t1:=getfa(a); t2:=getfa(b);
           if t1=t2 then writeln('In the same gang.')
              else begin
                   tmp:=getfa(e[a]);
                   if t2=tmp then writeln('In different gangs.')
                      else writeln('Not sure yet.');
                   end;
           end
        else
           begin
           if e[a]=a then e[a]:=b
              else union(e[a],b);
           if e[b]=b then e[b]:=a
              else union(e[b],a);
           end;
        end;
    end;
//close(input);
end.