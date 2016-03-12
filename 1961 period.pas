const maxn=1000020;
var c:char;
    a:array[1..maxn]of char;
    next:array[0..maxn]of longint;
    i,j,l,n:longint;
begin
assign(input,'period.in');
reset(input);
readln(l);
n:=0;
while l<>0 do
begin
inc(n);
writeln('Test case #',n);
i:=0;
fillchar(next,sizeof(next),0);
fillchar(a,sizeof(a),0);
while i<l do
  begin
  inc(i);
  read(c);
  a[i]:=c;
  end;
next[1]:=0;
j:=0;
for i:=2 to l do
    begin
    while (j>0)and(a[j+1]<>a[i]) do j:=next[j];
    if a[j+1]=a[i] then inc(j);
    next[i]:=j;
    if (j<>0)and(i mod (i-j)=0) then writeln(i,' ',i div (i-j));
    end;
readln(l);
writeln;
end;
//close(input);
end.
