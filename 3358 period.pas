var ss,ts:string;
    sum,cnt,tt:longint;
    p,q,ans,i,t:qword;
    code:integer;
    flag:boolean;
function gcd(x,y:qword):qword;
var r:qword;
begin
r:=x mod y;
while r<>0 do
  begin
  x:=y;
  y:=r;
  r:=x mod y;
  end;
exit(y);
end;
function modu(x,y,mo:qword):qword;
var b,c,d:longint;
begin
b:=y; d:=x; c:=1;
while b>0 do
 begin
 if b mod 2=1 then c:=qword(c)*qword(d) mod mo;
 d:=qword(d)*qword(d) mod mo;
 b:=b div 2;
 end;
exit(c);
end;
function power(x,y:qword):qword;
var b,c,d:qword;
begin
b:=y; d:=x; c:=1;
while b>0 do
 begin
 if b mod 2=1 then c:=qword(c)*qword(d);
 d:=qword(d)*qword(d);
 b:=b div 2;
 end;
exit(c);
end;
function getfi(x:qword):qword;
var
    res,tx,i:qword;
    now:longint;
begin
tx:=x;
res:=1;
i:=2;
while i<=trunc(sqrt(tx)) do
begin

    now:=0;

    while x mod i=0 do
       begin

       x:=x div i;
       inc(now);
       end;
    if now<>0 then res:=qword(res)*qword(i-1)*qword(power(i,now-1));
    if x=1 then break;
i:=qword(i)+qword(1);

end;
if x<>1 then res:=qword(res)*qword(x-1);
exit(res);
end;
begin

while not eof do
begin
readln(ss);
inc(sum);
tt:=pos('/',ss);
ts:=copy(ss,1,tt-1);
val(ts,p,code);
delete(ss,1,tt);
val(ss,q,code);
t:=gcd(q,p);
p:=p div t; q:=q div t;
cnt:=0;
while q mod 2=0 do
  begin
  q:=q div 2;
  inc(cnt);
  end;
if q=1 then
   begin
   writeln('Case #',sum,': ',1,',',1,' ');
   continue;
   end;
ans:=getfi(q);
flag:=false;
i:=1;
while i<=trunc(sqrt(ans)) do
  begin
  if ans mod i=0 then
     begin
     if qword(modu(2,i,q))=qword(1) then
        begin
        ans:=i;
        flag:=true;
        break;
        end;
     end;
  i:=qword(i)+qword(1);
  end;
if not flag then
   begin
   i:=trunc(sqrt(ans));
   while i>1 do
     begin
     if ans mod i=0 then
        begin
        if qword(modu(2,ans div i,q))=qword(1) then
           begin
           ans:=ans div i;
           flag:=true;
           break;
           end;
        end;
     i:=qword(i)-qword(1);
     end;
   end;
writeln('Case #',sum,': ',cnt+1,',',ans,' ');
end;
end.