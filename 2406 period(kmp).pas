const maxn=1000020;
var c:char;
    next:array[0..maxn]of longint;
    i,j,ans,l:longint;
    a:ansistring;
begin
{assign(input,'period.in');
reset(input);}
readln(a);
while a<>'.' do
begin
i:=0;
next[1]:=0;
j:=0;
l:=length(a);
ans:=1;
for i:=2 to l do
    begin
    while (j>0)and(a[j+1]<>a[i]) do j:=next[j];
    if a[j+1]=a[i] then inc(j);
    next[i]:=j;
    if (j<>0)and(i mod (i-j)=0) then
       begin
       if i=l then ans:=i div (i-j);
       end;
    end;
writeln(ans);
readln(a);
end;
//close(output);
end.
