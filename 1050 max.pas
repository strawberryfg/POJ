var n,i,j,fmax,k,l,sum:longint;
    a:array[0..100,0..100]of longint;
    f:array[0..100,0..100]of longint;
    sumh,suml:array[0..100,0..100]of longint;
begin
{assign(input,'max.in');
reset(input);
assign(output,'max.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    for j:=1 to n do
        begin
        read(a[i,j]);
        sumh[i,j]:=sumh[i,j-1]+a[i,j];
        suml[i,j]:=suml[i-1,j]+a[i,j];
        end;
    end;
fmax:=0;
for i:=1 to n do
    begin
    for j:=1 to n do
        begin
        fillchar(f,sizeof(f),0);
        for k:=i to n do
            begin
            for l:=j to n do
                begin
                inc(sum);
                f[k,l]:=f[k-1,l]+sumh[k,l]-sumh[k,j-1];
                if f[k,l]>fmax then fmax:=f[k,l];
                end;
            end;
        end;
    end;
writeln(fmax);
//writeln(sum);
{close(input);
close(output);}
end.
