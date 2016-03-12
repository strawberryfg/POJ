const maxn=120; maxx=1000000; maxm=1020;
var ss,ts:string;
    t,x,len,k,n,m,i,dir,head,tail:longint;
    code:integer;
    f,edge:array[0..maxn,0..maxm]of longint;
    dis,hash:array[0..maxn]of longint;
    mark:array[0..maxn]of boolean;
    q:array[1..maxx]of longint;
procedure init;
var i:longint;
begin
fillchar(f,sizeof(f),0);
fillchar(edge,sizeof(edge),0);
fillchar(q,sizeof(q),0);
fillchar(mark,sizeof(mark),false);
fillchar(hash,sizeof(hash),0);
for i:=1 to n do dis[i]:=0;
head:=1; tail:=0;
dis[0]:=0;
end;
function spfa:boolean;
var now,i,t:longint;
begin
while head<=tail do
 begin
 now:=q[head];
 for i:=1 to edge[now,0] do
     begin
     t:=edge[now,i];
     if (dis[now]+f[now,i]<dis[t]) then
        begin
        dis[t]:=dis[now]+f[now,i];
        if not mark[t] then
           begin
           mark[t]:=true;
           inc(tail);
           q[tail]:=t;
           inc(hash[t]);
           if hash[t]>n then exit(false);
           end;
        end;
     end;
 mark[now]:=false;
 inc(head);
 end;
exit(true);
end;
begin
{assign(input,'king.in');
reset(input);
assign(output,'king.out');
rewrite(output);}
read(n);
while n<>0 do
  begin
  read(m);
  init;
  readln;
  for i:=1 to m do
      begin
      readln(ss);
      t:=pos(' ',ss); ts:=copy(ss,1,t-1);
      val(ts,x,code);
      delete(ss,1,t);
      t:=pos(' ',ss); ts:=copy(ss,1,t-1);
      val(ts,len,code);
      delete(ss,1,t);
      ts:=copy(ss,1,2);
      if ts='gt' then dir:=1 else dir:=-1;
      delete(ss,1,3);
      val(ss,k,code);
      if dir=-1 then
         begin
         inc(edge[x-1,0]); edge[x-1,edge[x-1,0]]:=x+len;
         f[x-1,edge[x-1,0]]:=k-1;
         if not mark[x-1] then
            begin
            inc(tail); q[tail]:=x-1;
            mark[x-1]:=true;
            inc(hash[x-1]);
            end;
         end
      else
         begin
         inc(edge[x+len,0]); edge[x+len,edge[x+len,0]]:=x-1;
         f[x+len,edge[x+len,0]]:=-k-1;
         if not mark[x+len] then
            begin
            inc(tail); q[tail]:=x+len;
            mark[x+len]:=true;
            inc(hash[x+len]);
            end;
         end;
      end;
  if not spfa then writeln('successful conspiracy')
     else writeln('lamentable kingdom');
  read(n);
  end;
{close(input);
close(output);}
end.