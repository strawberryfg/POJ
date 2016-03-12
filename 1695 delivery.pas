var m,t,n,i,j,k,fmin:longint;
    g:array[0..31,0..31]of longint;
    f:array[0..31,0..31,0..31]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
begin
{assign(input,'delivery.in');
reset(input);
assign(output,'delivery.out');
rewrite(output);}
readln(m);
for t:=1 to m do
    begin
    readln(n);
    fillchar(g,sizeof(g),0);
    fillchar(f,sizeof(f),0);
    for i:=1 to n-1 do
        begin
        for j:=i+1 to n do
            begin
            read(g[i,j]);
            g[j,i]:=g[i,j];
            end;
        readln;
        end;
    for i:=1 to n do
        begin
        for j:=1 to n do
            begin
            for k:=1 to n do
                f[i,j,k]:=maxlongint;
            end;
        end;
    f[1,1,1]:=0;
    fmin:=maxlongint;
    for k:=1 to n do
        begin
        for j:=k to n do
            begin
            for i:=j to n do
                begin
                if f[i,j,k]=maxlongint then continue;
                if (i+1<=n)and(i+1>=j)and(j>=k) then
                   begin
                   f[i+1,j,k]:=min(f[i+1,j,k],f[i,j,k]+g[i,i+1]);
                   if (i+1=n)and(f[i+1,j,k]<fmin) then fmin:=f[i+1,j,k];
                   end;
                if (i+1<=n)and(i+1>=i)and(i>=k) then
                   begin
                   f[i+1,i,k]:=min(f[i+1,i,k],f[i,j,k]+g[j,i+1]);
                   if (i+1=n)and(f[i+1,i,k]<fmin) then fmin:=f[i+1,i,k];
                   end;
                if (i+1<=n)and(i>=j) then
                   begin
                   f[i+1,i,j]:=min(f[i+1,i,j],f[i,j,k]+g[k,i+1]);
                   if (i+1=n)and(f[i+1,i,j]<fmin) then fmin:=f[i+1,i,j];
                   end;
                end;
            end;
        end;
    writeln(fmin);
    end;
{close(input);
close(output);}
end.
