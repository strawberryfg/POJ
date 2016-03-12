var c,d,sum,mo:int64;
    n,m,i,j,a,b:longint;
begin
{assign(input,'raising.in');
reset(input);}
readln(n);
for i:=1 to n do
    begin
    readln(mo);
    readln(m);
    sum:=0;
    for j:=1 to m do
        begin
        readln(a,b);
        c:=1; d:=a;
        while b>0 do
          begin
          if b mod 2=1 then c:=int64(c)*int64(d)mod mo;
          b:=b div 2;
          d:=int64(d)*int64(d) mod mo;
          end;
        sum:=int64(sum)+int64(c);
        sum:=sum mod mo;
        end;
    writeln(sum);
    end;
{close(input);}
end.