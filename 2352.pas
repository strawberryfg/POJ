const maxn=32200;
var n,i,x,y:longint;
    hash,bit:array[0..maxn]of longint;
function sum(x:longint):longint;
var ans:longint;
begin
ans:=0;
while x>0 do
  begin
  ans:=ans+bit[x];
  x:=x-x and -x;
  end;
exit(ans);
end;
procedure modify(x,delta:longint);
begin
while x<=32001 do
  begin
  bit[x]:=bit[x]+delta;
  x:=x+x and -x;
  end;
end;
begin
readln(n);
for i:=1 to n do
    begin
    readln(x,y);
    inc(x);
    inc(hash[sum(x)]);
    modify(x,1);
    end;
for i:=0 to n-1 do writeln(hash[i]);
end.