const maxn=10020;
var n,i,k,fmax,j,ans,t:longint;
    f,tme:array[0..maxn]of longint;
begin
{assign(input,'chores.in');
reset(input);
assign(output,'chores.out');
rewrite(output); }
readln(n);
for i:=1 to n do
    begin
    read(tme[i]);
    read(k);
    fmax:=0;
    for j:=1 to k do
        begin
        read(t);
        if f[t]>fmax then fmax:=f[t];
        end;
    f[i]:=fmax+tme[i];
    if f[i]>ans then ans:=f[i];
    end;
writeln(ans);
{close(input);
close(output);}
end.