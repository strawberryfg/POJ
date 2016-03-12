var k,n,i,j,st,en,down,up,u,fmax,ttt:longint;
    f,g:array[0..100,0..100]of longint;
begin
{assign(input,'flower.in');
reset(input);
assign(output,'flower.out');
rewrite(output);}
readln(k,n); //n :vase
for i:=1 to k do
    begin
    for j:=1 to n do
        begin
        read(g[i,j]);
        end;
    readln;
    end;
for i:=1 to k do
    begin
    for j:=1 to n do
        begin
        f[i,j]:=-maxlongint;
        end;
    end;
for i:=1 to k do
    begin
    st:=i-1;
    en:=k-i+1; //rest flower
    en:=n+1-en-1;
    down:=i;
    up:=k-i+1;
    up:=n+1-up;
    for j:=down to up do
        begin
        for u:=st to en do
            begin
            if j<=u then continue;
            if (f[i-1,u]<>-maxlongint)and(f[i-1,u]+g[i,j]>f[i,j]) then
               f[i,j]:=f[i-1,u]+g[i,j];
            if (i=k)and(f[i,j]>fmax) then
               begin
               fmax:=f[i,j];
               ttt:=1;
               end;
            end;
        end;
    end;
writeln(fmax);
{close(input);
close(output);}
end.