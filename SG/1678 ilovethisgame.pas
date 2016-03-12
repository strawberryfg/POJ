const maxn=10020; inf=maxlongint;
var test,u,n,l,r,i,max,j,ans:longint;
    a,dp:array[0..maxn]of longint;
procedure sort(l,r: longint);
var i,j,x,y: longint;
begin
i:=l; j:=r; x:=a[(l+r) div 2];
repeat
while a[i]<x do inc(i);
while x<a[j] do dec(j);
if not(i>j) then begin y:=a[i]; a[i]:=a[j]; a[j]:=y; inc(i); j:=j-1; end;
until i>j;
if l<j then sort(l,j);
if i<r then sort(i,r);
end;
begin
{assign(input,'ilovethisgame.in');
reset(input);}
readln(test);
for u:=1 to test do
    begin
    readln(n,l,r);
    for i:=1 to n do read(a[i]);
    sort(1,n);
    for i:=1 to n do dp[i]:=-inf;
    for i:=n downto 1 do
        begin
        max:=-inf;
        for j:=i+1 to n do
            begin
            if a[j]-a[i]>r then break;
            if a[j]-a[i]>=l then
               begin
               if dp[j]>max then max:=dp[j];
               end;
            end;
        if max=-inf then max:=0;
        dp[i]:=a[i]-max;
        end;
    ans:=-inf;
    for i:=1 to n do
        begin
        if a[i]>r then break;
        if a[i]>=l then
           if dp[i]>ans then ans:=dp[i];
        end;
    if ans=-inf then ans:=0;
    writeln(ans);
    end;
//close(input);
end.