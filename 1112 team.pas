const maxn=200;
var i,n,t,j,cnt,x,y,nx,ny,tx,ty,a,b,k,fmin,now,tt:longint;
    pd,mark:boolean;
    p,q,belong:array[0..maxn]of longint;
    g,edge,sum:array[0..maxn,0..maxn]of longint;
    dp,fdp:array[0..maxn,0..maxn]of longint;
    fr,tmp:array[0..maxn,0..maxn,1..2]of longint;
    f:array[0..maxn,0..1,0..maxn]of longint;
procedure work(num,x:longint);
var i,t:longint;
begin
if (belong[num]<>-1)and(belong[num]<>x) then
   begin
   pd:=false;
   exit;
   end;
if (belong[num]<>-1)and(belong[num]=x) then exit;
belong[num]:=x;
inc(sum[cnt,x]); f[cnt,x,sum[cnt,x]]:=num;
for i:=1 to edge[num,0] do
    begin
    t:=edge[num,i];
    if t<>num then work(t,1-x);
    if not pd then exit;
    end;
end;
begin
{assign(input,'team.in');
reset(input);
assign(output,'team.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    read(t);
    while t<>0 do
      begin
      g[i,t]:=1;
      read(t);
      end;
    belong[i]:=-1;
    end;
for i:=1 to n do
    begin
       mark:=false;
       for j:=1 to n do
           begin
           if i<>j then
              begin
              if not((g[i,j]=1)and(g[j,i]=1)) then
                 begin
                 inc(edge[i,0]);
                 edge[i,edge[i,0]]:=j;
                 mark:=true;
                 end;
              end;
           end;
       if not mark then
          begin
          inc(edge[i,0]); edge[i,1]:=i;
          end;
    end;
pd:=true;
for i:=1 to n do
    begin
    if belong[i]=-1 then
       begin
       inc(cnt);
       work(i,0);
       end;
    if not pd then break;
    end;
fmin:=maxlongint;
if not pd then writeln('No solution')
   else begin
        fdp[0,0]:=1;
        //fr[0,0,1]:=-1; fr[0,0,2]:=-1;
        for i:=1 to cnt do
            begin
            a:=sum[i,0]; b:=sum[i,1];
            dp:=fdp;
            for j:=0 to n-a do
                begin
                for k:=0 to n-b do
                    begin
                    if (dp[j,k]=1) then
                       begin
                       if dp[j+a,k+b]=0 then
                          begin
                          fdp[j+a,k+b]:=1;
                          fr[j+a,k+b,1]:=j;
                          fr[j+a,k+b,2]:=k;
                          tmp[j+a,k+b,1]:=i;
                          tmp[j+a,k+b,2]:=0;

                          if (i=cnt)and(j+a+k+b=n)and(abs(j+a-k-b)<fmin) then
                             begin
                             fmin:=abs(j+a-k-b);
                             x:=j+a; y:=k+b;
                             end;
                          end;
                       if dp[j+b,k+a]=0 then
                          begin
                          fdp[j+b,k+a]:=1;
                          fr[j+b,k+a,1]:=j;
                          fr[j+b,k+a,2]:=k;
                          tmp[j+b,k+a,1]:=i;
                          tmp[j+b,k+a,2]:=1;
                          if (i=cnt)and(j+b+k+a=n)and(abs(j+b-k-a)<fmin) then
                             begin
                             fmin:=abs(j+b-k-a);
                             x:=j+b; y:=k+a;
                             end;
                          end;
                       end;
                    end;
                end;
            end;

nx:=x; ny:=y;
while ((nx<>0)or(ny<>0)) do
  begin
  now:=tmp[nx,ny,1];
  if tmp[nx,ny,2]=0 then
     begin
     tt:=p[0];
     inc(p[0],sum[now,0]);
     for i:=1 to sum[now,0] do
         begin
         p[tt+i]:=f[now,0,i];
         end;
     tt:=q[0];
     inc(q[0],sum[now,1]);
     for i:=1 to sum[now,1] do
         begin
         q[tt+i]:=f[now,1,i];
         end;
     end
  else
     begin
     tt:=p[0];
     inc(p[0],sum[now,1]);
     for i:=1 to sum[now,1] do
         begin
         p[tt+i]:=f[now,1,i];
         end;
     tt:=q[0];
     inc(q[0],sum[now,0]);
     for i:=1 to sum[now,0] do
         begin
         q[tt+i]:=f[now,0,i];
         end;
     end;
  tx:=fr[nx,ny,1]; ty:=fr[nx,ny,2];
  nx:=tx; ny:=ty;
  end;
write(p[0],' ');
for i:=1 to p[0]-1 do write(p[i],' '); write(p[p[0]]);
writeln;
write(q[0],' ');
for i:=1 to q[0]-1 do write(q[i],' '); write(q[q[0]]);
writeln;
end;
{close(input);
close(output);}
end.