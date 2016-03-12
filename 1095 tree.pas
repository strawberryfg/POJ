type rec=record lc,rc:longint; end;
var f:array[0..20]of longint;
    res:qword;
    sum,total,i,j,n,last:longint;
    h:array[1..100]of rec;
procedure print(num:longint);
begin
if h[num].lc<>0 then
   begin
   write('(');
   print(h[num].lc);
   write(')');
   end;
write('X');
if h[num].rc<>0 then
   begin
   write('(');
   print(h[num].rc);
   write(')');
   end;
end;
procedure work(m,k,x:longint);
var sum,i,lnum,rnum,lind,rind,last,mo:longint;
begin
if m=1 then exit;
sum:=0;
for i:=0 to 18 do
    begin
    if sum+f[i]*f[m-1-i]>=k then break;
    sum:=sum+f[i]*f[m-1-i];
    end;
lnum:=i; rnum:=m-1-i;
if sum+f[i]*f[m-1-i]=k then
   begin
   last:=x;
   for i:=1 to lnum do
       begin
       h[last].lc:=total+1;
       inc(total);
       last:=total;
       end;
   inc(total);
   h[x].rc:=total;
   last:=total;
   for i:=1 to rnum-1 do
       begin
       h[last].lc:=total+1;
       inc(total);
       last:=total;
       end;
   exit;
   end;
mo:=k-sum;
lind:=mo div f[rnum];
rind:=mo mod f[rnum];
if rind<>0 then inc(lind);
if lnum>0 then
   begin
   inc(total);
   h[x].lc:=total;
   work(lnum,lind,total);
   end;
if rnum=0 then exit;
if rind=0 then
   begin
   inc(total); h[x].rc:=total;
   last:=total;
   for i:=1 to rnum-1 do
       begin
       h[last].lc:=total+1;
       inc(total);
       last:=total;
       end;
   exit;
   end;
inc(total);
h[x].rc:=total;
work(rnum,rind,total);
end;
begin
{assign(input,'tree.in');
reset(input);
assign(output,'tree.out');
rewrite(output);}
readln(n);
while n<>0 do
begin
total:=0;
f[0]:=1;
sum:=0;
for i:=1 to 18 do
    begin
    h[i].lc:=0; h[i].rc:=0;
    res:=1;
    for j:=1 to i do
        begin
        res:=qword(res)*qword(2*i+1-j) div j;
        end;
    res:=res div (i+1);
    f[i]:=res;
    end;
sum:=0;
for i:=1 to 18 do
    begin
    if sum+f[i]>=n then
       begin
       break;
       end;
    sum:=sum+f[i];
    end;
total:=0;
if sum+f[i]=n then
   begin
   total:=1;
   last:=1;
   for j:=1 to i-1 do
       begin
       h[last].lc:=total+1;
       inc(total);
       last:=total;
       end;
   print(1);
   writeln;
   end
else
   begin
   total:=1;
   work(i,n-sum,1);
   print(1);
   writeln;
   end;
readln(n);
end;
{close(input);
close(output);}
end.
