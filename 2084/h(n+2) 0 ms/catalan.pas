type arr=array[-1..100]of longint;
var n,i,j:longint;
    c,res,tt:arr;
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
begin
readln(n);
h[2,0]:=1;
while n<>-1 do
  begin
  if h[n+2,0]<>0 then begin print(h[n+2]); readln(n); continue; end;
  i:=2;
  while h[i,0]<>0 do inc(i);
  dec(i);

  for j:=i to n+2 do
      begin
      res[-1]:=0;
      res[0]:=1;
      tt[0]:=4*j-6;
      res:=mul(res,tt);
      res:=mul(res,h[j]);
      tt[0]:=j;
      res:=divide(res,tt);
      h[j+1]:=res;
      end;
  print(h[n+2]);
  readln(n);
  end;
end.