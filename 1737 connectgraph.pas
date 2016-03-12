const maxn=50;
type arr=array[-1..100]of longint;
var twice,tmp,tt,res,final,y:arr;
    c:array[0..maxn,0..maxn]of arr;
    two,f:array[0..maxn]of arr;
    num:array[1..1000]of longint;
    n,i,j,sum:longint;
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
function add(a,b:arr):arr;
var i,max:longint;

begin
if a[-1]>b[-1] then max:=a[-1] else max:=b[-1];
fillchar(y,sizeof(y),0);
for i:=0 to max do
    begin
    inc(y[i],a[i]+b[i]);
    inc(y[i+1],y[i] div 10000);
    y[i]:=y[i] mod 10000;
    end;
if y[max+1]<>0 then inc(max);
y[-1]:=max;
exit(y);
end;
function gj(a,b:arr):arr;
var i,p,max:longint;

begin
max:=a[-1];
fillchar(y,sizeof(y),0);
for i:=0 to max do
    begin
    p:=a[i]-b[i];
    if p<0 then
       begin
       y[i+1]:=y[i+1]-1;
       p:=p+10000;
       end;
    y[i]:=y[i]+p;
    end;
if y[max+1]<>0 then inc(max);
y[-1]:=max;
exit(y);
end;
function mul(a,b:arr):arr;
var i,j,k,max,p:longint;
begin
max:=a[-1]+b[-1];
fillchar(y,sizeof(y),0);
for i:=0 to a[-1] do
    begin
    for j:=0 to b[-1] do
        begin
        p:=a[i]*b[j];
        inc(y[i+j],p);
        k:=i+j;
        while y[k]>=10000 do
          begin
          if k>max then max:=k;
          inc(y[k+1],y[k] div 10000);
          y[k]:=y[k] mod 10000;
          inc(k);
          end;
        end;
    end;
        while y[k]>=10000 do
          begin
          if k>max then max:=k;
          inc(y[k+1],y[k] div 10000);
          y[k]:=y[k] mod 10000;
          inc(k);
          end;
if y[k]<>0 then if k>max then max:=k;
y[-1]:=max;
exit(y);
end;
begin
{assign(input,'connectgraph.in');
reset(input);
assign(output,'connectgraph.out');
rewrite(output);}
i:=1;
readln(num[i]);
while num[i]<>0 do
  begin
  inc(i);
  readln(num[i]);
  end;
n:=i-1;
twice[-1]:=0; twice[0]:=2;
tmp[-1]:=0; tmp[0]:=1;
for i:=0 to maxn do
    begin
    c[i,0,-1]:=0; c[i,0,0]:=1;  //c(i,0)=1;
    end;
for i:=1 to maxn do
    begin
    for j:=1 to i do
        begin
        c[i,j]:=add(c[i-1,j],c[i-1,j-1]);
        end;
    end;
two[0,-1]:=0; two[0,0]:=1;  //2^0=1;
for i:=1 to maxn do
    begin
    two[i]:=mul(twice,two[i-1]);
    end;
f[1,-1]:=0; f[1,0]:=1;
f[2,-1]:=0; f[2,0]:=1;
for i:=3 to maxn do
    begin
    fillchar(res,sizeof(res),0);
    fillchar(final,sizeof(final),0);
    for j:=1 to i-1 do
        begin
        res:=mul(f[j],f[i-j]);
        res:=mul(res,c[i-2,j-1]);
        tt:=gj(two[j],tmp);
        res:=mul(res,tt);
        final:=add(final,res);
        end;
    f[i]:=final;
    end;
for i:=1 to n do
    begin
    if (num[i]<=2) then writeln(1)
       else begin
            print(f[num[i]]);
            end;
    end;
{close(input);
close(output);}
end.