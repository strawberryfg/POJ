var l,sum:longint;
    ten,fi,tt,gys,res,i,ans:qword;
function power(x,y:qword):qword;
var b,c,d:qword;
begin
d:=x; b:=y; c:=1;
while b>0 do
 begin
 if b mod 2=1 then c:=qword(c)*qword(d);
 d:=qword(d)*qword(d);
 b:=b div 2;
 end;
exit(c);
end;
function getfi(x:qword):qword;
var i,tx,res,cnt:qword;
begin
i:=2;
tx:=x;
res:=1;
while i<=trunc(sqrt(tx)) do
 begin
 cnt:=0;
 while x mod i=0 do
   begin
   x:=x div i;
   cnt:=qword(cnt)+qword(1);
   end;
 if cnt<>0 then res:=qword(res)*qword(i-1)*qword(power(i,cnt-1));
 if x=1 then break;
 i:=qword(i)+qword(1);
 end;
if x<>1 then res:=qword(res)*qword(x-1)*qword(power(x,0));
exit(res);
end;
function mul(x,y,mo:qword):qword;
var d,e,g,h:qword;
    i:longint;
begin
d:=y mod 100;
e:=y div 100;
g:=qword(x)*qword(e) mod mo;
h:=qword(x)*qword(d) mod mo;
d:=0;
for i:=1 to 100 do d:=(d+g)mod mo;
d:=(d+h)mod mo;
exit(d);
end;
function modu(x,y,mo:qword):qword;
var b,c,d:qword;
begin
d:=x; c:=1; b:=y;
while b>0 do
  begin
  if b mod 2=1 then c:=mul(c,d,mo);
  d:=mul(d,d,mo);
  b:=b div 2;
  end;
exit(c);
end;
function gcd(x,y:qword):qword;
var tmp,r:qword;
begin
if qword(x)<qword(y) then begin tmp:=x; x:=y; y:=tmp; end;
r:=x mod y;
while r<>0 do
  begin
  x:=y;
  y:=r;
  r:=x mod y;
  end;
exit(y);
end;
begin
readln(l);
while l<>0 do
  begin
  inc(sum);
  gys:=gcd(8,l);
  tt:=qword(9)*qword(l)div qword(gys);
  ten:=gcd(10,tt);
  if ten<>1 then writeln('Case ',sum,': ',0)
     else begin
          fi:=getfi(tt);
          ans:=fi;
          i:=1;
          while i<=trunc(sqrt(fi))do
            begin
            if fi mod i=0 then
               begin
               res:=modu(10,i,tt);
               if qword(res)=qword(1) then begin ans:=i; break; end;
               end;
            i:=qword(i)+qword(1);
            end;
          if ans=fi then
             begin
             i:=trunc(sqrt(fi));
             while i>1 do
               begin
               if fi mod i=0 then
                  begin
                  res:=modu(10,fi div i,tt);
                  if qword(res)=qword(1) then begin ans:=fi div i; break; end;
                  end;
               i:=qword(i)-qword(1);
               end;

             end;
          writeln('Case ',sum,': ',ans);
          end;
  readln(l);
  end;
end.
