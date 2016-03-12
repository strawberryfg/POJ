const maxn=2020;
var u,test,i,n,ans:longint;
    a:array[0..maxn]of longint;
procedure sort(l,r: longint);
      var i,j,x,y: longint;
      begin
         i:=l; j:=r; x:=a[(l+r) div 2];
         repeat
           while a[i]<x do inc(i);
           while x<a[j] do dec(j);
           if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); dec(j); end;
         until i>j;
         if l<j then sort(l,j);
         if i<r then sort(i,r);
      end;
begin
{assign(input,'georgia.in');
reset(input);
assign(output,'georgia.out');
rewrite(output);}
readln(test);
for u:=1 to test do
    begin
    readln(n);
    for i:=1 to n do read(a[i]);
    sort(1,n);
    ans:=a[n]-a[n-1]-1;
    i:=n;
    while i>2 do
      begin
      dec(i,2);
      ans:=ans xor (a[i]-a[i-1]-1);
      end;
    if ans<>0 then writeln('Georgia will win')
       else writeln('Bob will win');
    end;
{close(input);
close(output);}
end.