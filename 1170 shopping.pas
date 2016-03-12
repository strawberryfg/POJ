var k,p,s,n,i,j,l,m,u,a,b,c,d,e,tmp:longint;
    com,sales,pri,h:array[0..1000]of longint;
    f:array[0..5,0..5,0..5,0..5,0..5]of longint;
    g:array[0..200,0..5]of longint;
function getnum(cod:longint):longint;
var i:longint;
begin
for i:=1 to 5 do if cod=com[i] then exit(i);
end;
begin
{assign(input,'shopping.in');
reset(input);
assign(output,'shopping.out');
rewrite(output);}
readln(b);
for i:=1 to b do
    begin
    readln(c,k,p);
    com[i]:=c; sales[i]:=k; pri[i]:=p;
    end;
readln(s);
for i:=1 to s do
    begin
    read(n);
    for j:=1 to n  do
        begin
        read(c,k);
        tmp:=getnum(c);
        g[i,tmp]:=k;
        end;
    read(p);
    h[i]:=p;
    end;
for i:=0 to sales[1] do
    for j:=0 to sales[2] do
        for k:=0 to sales[3] do
            for l:=0 to sales[4] do
                for m:=0 to sales[5] do
                    begin
                    f[i,j,k,l,m]:=pri[1]*i+pri[2]*j+pri[3]*k+pri[4]*l+pri[5]*m;

                    for u:=1 to s do
                        begin
                        a:=i-g[u,1];
                        b:=j-g[u,2];
                        c:=k-g[u,3];
                        d:=l-g[u,4];
                        e:=m-g[u,5];
                        if (a<0)or(b<0)or(c<0)or(d<0)or(e<0) then continue;
                        if f[a,b,c,d,e]+h[u]<f[i,j,k,l,m] then
                           begin
                           f[i,j,k,l,m]:=f[a,b,c,d,e]+h[u];
                           end;
                        end;
                    end;
writeln(f[sales[1],sales[2],sales[3],sales[4],sales[5]]);
{close(input);
close(output);}
end.