type arr=array[-1..100]of longint;
var n,i,j:longint;
    c,res,final,tt:arr;
    h:array[2..120]of arr;
procedure print(x:arr);
var i:longint;
begin
write(x[x[-1]]);
for i:=x[-1]-1 downto 0 do
    begin
    if x[i]>999 then write(x[i])
       else if x[i]>99 then write('0',x[i])
            else if x[i]>9 then write('00',x[i])
                    else write('000',x[i]);
    end;
writeln;
end;
function mul(x,y:arr):arr;
var i,j,k,max:longint;
begin
max:=x[-1]+y[-1];
fillchar(c,sizeof(c),0);
for i:=0 to x[-1] do
    begin
    for j:=0 to y[-1] do
        begin
        c[i+j]:=c[i+j]+x[i]*y[j];
        k:=i+j;
        while c[k]>=10000 do
          begin
          if k>max then max:=k;
          c[k+1]:=c[k+1]+c[k] div 10000;
          c[k]:=c[k]mod 10000;
          inc(k);
          end;
        end;
    end;
if c[k]<>0 then max:=k;
c[-1]:=max;
exit(c);
end;
function divide(x,y:arr):arr;
var tmp,t,i:longint;
begin
tmp:=-1;
t:=0;
fillchar(c,sizeof(c),0);
for i:=x[-1] downto 0 do
    begin
    t:=t*10000+x[i];
    if t div y[0]>=1 then
       begin
       if tmp=-1 then tmp:=i;
       c[i]:=t div y[0];
       t:=t mod y[0];
       end;
    end;
c[-1]:=tmp;
exit(c);
end;
function gjf(x,y:arr):arr;
var i,tmp,max:longint;
begin
fillchar(c,sizeof(c),0);
max:=x[-1];
for i:=0 to x[-1] do
    begin
    tmp:=x[i]-y[i];
    if tmp<0 then
       begin
       c[i+1]:=c[i+1]-1;
       tmp:=10000+tmp;
       end;
    c[i]:=c[i]+tmp;
    end;
if c[max]=0 then dec(max);
c[-1]:=max;
exit(c);
end;
begin
readln(n);
while n<>-1 do
  begin
  res[-1]:=0; res[0]:=1;
  for i:=1 to n do
      begin
      tt[-1]:=0; tt[0]:=2*n+1-i;
      res:=mul(res,tt);
      tt[-1]:=0; tt[0]:=i;
      res:=divide(res,tt);
      end;
  final[-1]:=0; final[0]:=1;
  for i:=1 to n-1 do
      begin
      tt[-1]:=0; tt[0]:=2*n+1-i;
      final:=mul(final,tt);
      tt[-1]:=0; tt[0]:=i;
      final:=divide(final,tt);
      end;
  res:=gjf(res,final);
  print(res);
  readln(n);
  end;
end.