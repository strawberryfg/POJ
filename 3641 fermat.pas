var p,a:longint;
    flag:boolean;
function modu(x,y:longint):qword;
var b,c,d:qword;
begin
d:=x; c:=1; b:=y;
while b<>0 do
  begin
  if b mod 2=1 then c:=qword(c)*qword(d) mod p;
  d:=qword(d)*qword(d) mod p;
  b:=b div 2;
  end;
exit(c);
end;
function isprime(x:longint):boolean;
var i,t:longint;
begin
for i:=1 to 300 do
    begin
    t:=random(x-1)+1;
    if qword(modu(t,x-1))<>qword(1) then exit(false);
    end;
exit(true);
{for i:=2 to trunc(sqrt(x)) do if x mod i=0 then exit(false);
exit(true);}
end;
begin
readln(p,a);
randomize;
while not((p=0)and(a=0)) do
 begin
 flag:=isprime(p);
 if flag then writeln('no')
    else if qword(modu(a,p))<>qword(a) then writeln('no') else writeln('yes');
 readln(p,a);
 end;
end.