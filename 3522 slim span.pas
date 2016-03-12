const maxn=102; maxm=12000;
type rec=record u,v,w:longint; end;
var edge:array[1..maxm]of rec;
    n,m,i,j,k,x,y,z,fmin,t1,t2:longint;
    fa:array[1..maxn]of longint;
procedure sort(l,r: longint);
      var
         i,j,tt: longint;
         tmp:rec;
      begin
         i:=l;
         j:=r;
         tt:=edge[(l+r) div 2].w;
         repeat
           while edge[i].w<tt do
            inc(i);
           while tt<edge[j].w do
            dec(j);
           if not(i>j) then
             begin
                tmp:=edge[i];
                edge[i]:=edge[j];
                edge[j]:=tmp;
                inc(i);
                j:=j-1;
             end;
         until i>j;
         if l<j then
           sort(l,j);
         if i<r then
           sort(i,r);
      end;
function getfa(x:longint):longint;
begin
if fa[x]=x then exit(x)
   else begin
        fa[x]:=getfa(fa[x]);
        exit(fa[x]);
        end;
end;
begin
{assign(input,'slimspan.in');
reset(input);
assign(output,'slimspan.out');
rewrite(output);}
readln(n,m);
while not((n=0)and(m=0)) do
 begin
 for i:=1 to m do
     begin
     readln(x,y,z);
     edge[i].u:=x; edge[i].v:=y; edge[i].w:=z;
     end;
 if m=0 then begin writeln(-1);readln(n,m); continue; end;
 sort(1,m);
 fmin:=maxlongint;
 for i:=1 to m-n+2 do
     begin
     for j:=1 to n do fa[j]:=j;
     k:=0;
     for j:=i to m do
         begin
         t1:=getfa(edge[j].u); t2:=getfa(edge[j].v);
         if t1<>t2 then
            begin
            fa[t2]:=t1;
            inc(k);
            if k=n-1 then
               begin
               if edge[j].w-edge[i].w<fmin then fmin:=edge[j].w-edge[i].w;
               break;
               end;
            end;
         end;
     end;
 if fmin=maxlongint then writeln(-1) else writeln(fmin);
 readln(n,m);
 end;
{close(input);
close(output);}
end.
