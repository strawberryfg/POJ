const maxn=80020;
var i,n,tot:longint;
    ans,sum:int64;
    a,stack:array[0..maxn]of int64;
    num:array[0..maxn]of int64;
begin
{assign(input,'badhair.in');
reset(input);
assign(output,'badhair.out');
rewrite(output);}
readln(n);
for i:=1 to n do read(a[i]);
stack[1]:=a[n]; tot:=1; num[1]:=1;
stack[0]:=maxlongint;
for i:=n-1 downto 1 do
    begin
    sum:=0;
    while (tot>0)and(a[i]>stack[tot]) do
          begin
          sum:=sum+num[tot];
          ans:=ans+num[tot];
          dec(tot);
          end;
    if stack[tot]>a[i] then
       begin
       inc(tot); stack[tot]:=a[i];
       num[tot]:=sum+1;
       end
    else
       num[tot]:=sum+1+num[tot];
    end;
writeln(ans);
{close(input);
close(output);}
end.