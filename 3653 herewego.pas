const maxx=1000000;
var n,m,i,j,t,num:longint;
    s,ts:string;
    code:integer;
    edge,f:array[1..600,0..600]of longint;
    mark:array[1..600]of boolean;
    q:array[1..maxx]of longint;
    dis:array[1..600]of longint;
procedure addedge(x1,y1,x2,y2,ind,p:longint);
var tmp,tt:longint;
begin
tmp:=(x1-1)*(m+1)+y1; tt:=(x2-1)*(m+1)+y2;
inc(edge[tmp,0]);
edge[tmp,edge[tmp,0]]:=tt;
f[tmp,edge[tmp,0]]:=p;
if ind=2 then
   begin
   inc(edge[tt,0]);
   edge[tt,edge[tt,0]]:=tmp;
   f[tt,edge[tt,0]]:=p;
   end;
end;
procedure spfa(s,e:longint);
var i,head,tail,now,t:longint;
begin
for i:=1 to (n+1)*(m+1) do dis[i]:=maxlongint;
dis[s]:=0;
fillchar(mark,sizeof(mark),false);
mark[s]:=true;
q[1]:=s;
head:=1; tail:=1;
while head<=tail do
  begin
  now:=q[head];
  for i:=1 to edge[now,0] do
      begin
      t:=edge[now,i];
      if dis[now]+2520 div f[now,i]<dis[t] then
         begin
         dis[t]:=dis[now]+2520 div f[now,i];
         if not mark[t] then
            begin
            mark[t]:=true;
            inc(tail);
            q[tail]:=t;
            end;
         end;
      end;
  inc(head);
  mark[now]:=false;
  end;
if dis[e]=maxlongint then writeln('Holiday')
   else writeln(dis[e],' blips');
end;
begin
{assign(input,'herewego.in');
reset(input);
assign(output,'herewego.out');
rewrite(output);}
readln(n,m);
while not((n=0)and(m=0)) do
begin
for i:=1 to n+1 do
    for j:=1 to m+1 do
        edge[(i-1)*(m+1)+j,0]:=0;
for i:=1 to 2*n+1 do
    begin
    if i mod 2=1 then
       begin
       readln(s);
       for j:=1 to m do
           begin
           t:=pos(' ',s);
           ts:=copy(s,1,t-1);
           val(ts,num,code);
           delete(s,1,t);
           if num<>0 then
              begin
              if s[1]='*' then addedge(i div 2+1,j,i div 2+1,j+1,2,num)
                 else if s[1]='>' then addedge(i div 2+1,j,i div 2+1,j+1,1,num)
                         else addedge(i div 2+1,j+1,i div 2+1,j,1,num);

              end;
           if j<>m then delete(s,1,2);
           end;
       end
    else
       begin
       readln(s);
       for j:=1 to m+1 do
           begin
           t:=pos(' ',s);
           ts:=copy(s,1,t-1);
           val(ts,num,code);
           delete(s,1,t);
           if num<>0 then
              begin
              if s[1]='*' then addedge(i div 2,j,i div 2+1,j,2,num)
                 else if s[1]='^' then addedge(i div 2+1,j,i div 2,j,1,num)
                         else addedge(i div 2,j,i div 2+1,j,1,num);
              end;
           if j<>m+1 then delete(s,1,2);
           end;
       end;
    end;
spfa(1,(n+1)*(m+1));
readln(n,m);
end;
{close(input);
close(output);}
end.