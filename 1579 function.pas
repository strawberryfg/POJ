var x,y,z:longint;
    f:array[0..20,0..20,0..20]of longint;
function calc(i,j,k:longint):longint;
begin
if (i<=0)or(j<=0)or(k<=0) then exit(1);
if (i>20)or(j>20)or(k>20) then
   begin

   exit(calc(20,20,20));
   end;

if f[i,j,k]<>0 then exit(f[i,j,k]);
if (i<j)and(j<k) then
   begin
   f[i,j,k]:=calc(i,j,k-1)+calc(i,j-1,k-1)-calc(i,j-1,k);
   exit(f[i,j,k]);
   end;
f[i,j,k]:=calc(i-1,j,k)+calc(i-1,j-1,k)+calc(i-1,j,k-1)-calc(i-1,j-1,k-1);
exit(f[i,j,k]);
end;
begin
{assign(input,'function.in');
reset(input);
assign(output,'function.out');
rewrite(output);}
readln(x,y,z);
while not((x=-1)and(y=-1)and(z=-1)) do
 begin
 writeln('w(',x,', ',y,', ',z,') = ',calc(x,y,z),' ');
 readln(x,y,z);
 end;
{close(input);
close(output);}
end.