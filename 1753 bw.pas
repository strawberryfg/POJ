const max=4000020; maxstate=131072;
      dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
var i,j,p,head,tail,now,t,k,ans,tmp,x,y:longint;
    q,step:array[0..max]of longint;
    hash:array[0..maxstate]of longint;
    c:char;
    flag:boolean;
begin
{assign(input,'bw.in');
reset(input);
assign(output,'bw.out');
rewrite(output);}
for i:=1 to 4 do
    begin
    for j:=1 to 4 do
        begin
        read(c); if c='b' then p:=1 else p:=0;
        t:=1 shl ((i-1)*4+j-1);
        q[1]:=q[1]+t*p;
        end;
    readln;
    end;
head:=1; tail:=1;
flag:=false; step[1]:=0;
hash[q[1]]:=1;
if (q[1]=0)or(q[1]=1 shl 16-1) then
   flag:=true
else
begin
while head<=tail do
  begin
  now:=q[head];
  for i:=1 to 4 do
      begin
      for j:=1 to 4 do
          begin
          tmp:=now;
          for k:=1 to 4 do
              begin
              x:=i+dx[k]; y:=j+dy[k];
              if (x>=1)and(x<=4)and(y>=1)and(y<=4) then
                 begin
                 t:=1 shl ((x-1)*4+y-1);
                 tmp:=tmp xor t;
                 end;
              end;
          t:=1 shl ((i-1)*4+j-1);
          tmp:=tmp xor t;
          if hash[tmp]=0 then
             begin
             hash[tmp]:=1;
             inc(tail);
             q[tail]:=tmp;
             step[tail]:=step[head]+1;
             if (tmp=0)or(tmp=1 shl 16-1) then
                begin
                flag:=true;
                ans:=step[tail];
                break;
                end;
             end;
          end;
      if flag then break;
      end;
  if flag then break;
  inc(head);
  end;
end;
if not flag then writeln('Impossible')
   else writeln(ans);
{close(input);
close(output);}
end.