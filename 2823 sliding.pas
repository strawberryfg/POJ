const maxn=1000200;
var n,k,f,t,i:longint;
    a,q,min,max:array[0..maxn]of longint;
begin
{assign(input,'sliding.in');
reset(input);}
readln(n,k);
for i:=1 to n do read(a[i]);
f:=1; t:=0; q[0]:=0;
for i:=1 to n do
    begin
    while (f<=t)and(q[f]<=i-k)do inc(f);
    while (f<=t)and(a[q[t]]>=a[i])do dec(t);
    inc(t); q[t]:=i;
    if i>=k then min[i]:=a[q[f]];
    end;
for i:=k to n-1 do write(min[i],' ');
write(min[n]);
writeln;
f:=1; t:=0; q[0]:=0;
for i:=1 to n do
    begin
    while (f<=t)and(q[f]<=i-k)do inc(f);
    while (f<=t)and(a[q[t]]<=a[i])do dec(t);
    inc(t); q[t]:=i;
    if i>=k then max[i]:=a[q[f]];
    end;
for i:=k to n-1 do write(max[i],' ');
write(max[n]);
writeln;
//close(input);
end.