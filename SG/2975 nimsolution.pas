const maxn=1020;
var i,n,sum,ans:longint;
    a:array[0..maxn]of longint;
begin
{assign(input,'nimsolution.in');
reset(input);}
readln(n);
while n<>0 do
  begin
  ans:=0;
  for i:=1 to n do
      begin
      read(a[i]);
      ans:=ans xor a[i];
      end;
  if ans=0 then writeln(0)
     else begin
          sum:=0;
          for i:=1 to n do
              if a[i] xor ans<a[i] then inc(sum);
          writeln(sum);
          end;
  readln(n);
  end;
//close(input);
end.
