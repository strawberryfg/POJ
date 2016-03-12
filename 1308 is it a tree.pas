const n=1020;
var a,b,tot,i,cnt:longint;
    fa,rank,inner:array[0..n]of longint;
    flag,pd:boolean;
function getfather(x:longint):longint;
begin
if fa[x]<>x then fa[x]:=getfather(fa[x]);
exit(fa[x]);
end;
procedure union(a,b:longint);
var t1,t2:longint;
begin
t1:=getfather(a); t2:=getfather(b);
if t1=t2 then begin flag:=false; exit; end;
if rank[t1]>rank[t2] then
   begin
   fa[t2]:=t1;
   rank[t1]:=rank[t1]+rank[t2];
   end
else
   begin
   fa[t1]:=t2;
   rank[t2]:=rank[t2]+rank[t1];
//   if rank[t1]=rank[t2] then inc(rank[t2]);
   end;
end;
begin
{assign(input,'isitatree.in');
reset(input);}
read(a,b);
tot:=0;
while not((a<0)and(b<0)) do
  begin
  inc(tot);
  for i:=0 to n do begin fa[i]:=i; rank[i]:=1; inner[i]:=0; end;
  flag:=true;
  while (a>0)and(b>0) do
    begin
    inc(inner[b]);
    union(a,b);
    read(a,b);
    end;
  if not flag then writeln('Case ',tot,' is not a tree.')
     else begin
          cnt:=0;
          pd:=true;
          for i:=1 to n do
              begin
              if (fa[i]=i)and(rank[i]<>1) then inc(cnt);
              if inner[i]>1 then begin pd:=false; end;
              end;
          if (cnt>1)or(not pd) then writeln('Case ',tot,' is not a tree.')
             else writeln('Case ',tot,' is a tree.');
          end;
  read(a,b);
  end;
//close(input);
end.