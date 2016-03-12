const max=1000000;
var n,tn,i,res,cnt,sum,s:longint;
    prime:array[1..max]of longint;
    a:array[1..max]of boolean;
    flag:boolean;
procedure eratos;

    var
       i,j : longint;

    begin
       a[1]:=false;
       for i:=2 to max do
         a[i]:=true;
       for i:=2 to max div 2 do
         if a[i] then
           for j:=2 to max div i do
             a[i*j]:=false;
       sum:=0;
       for i:=1 to max do
        begin
          if a[i] then
           begin

             inc(sum);
             prime[sum]:=i;
           end;
        end;
    end;
function calc(x,y:longint):longint;
var b,c,d:longint;
begin
d:=x; c:=1; b:=y;
while b<>0 do
  begin
  if b mod 2=1 then c:=c*d;
  d:=d*d;
  b:=b div 2;
  end;
exit(c);
end;
begin
readln(n);
 eratos;
while n<>0 do
  begin
  tn:=n;
  res:=1;

  s:=0;
  for i:=1 to sum do
      begin
      cnt:=0;
      while n mod prime[i]=0 do
        begin
        n:=n div prime[i];
        inc(cnt);
        end;
      if cnt<>0 then res:=res*(prime[i]-1)*calc(prime[i],cnt-1);
      if n=1 then break;
      end;
  if (prime[i]=tn)or(n=tn) then writeln(tn-1) else writeln(res);
  readln(n);
  end;
end.
