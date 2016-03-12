var numa,numb,n,h,i,j,down,up,k,fmax,res,high,ssum,total,tot:longint;
    catch,decline,sum,t:array[0..201]of longint;
    sigma:array[1..26,0..201]of longint;
    f:array[1..25,0..500]of longint;
    s,sig:array[1..26,0..500,1..26]of longint;
    pd:boolean;
function com(a,b,c,d,x:longint):boolean;
var i,ll,rr,mid:longint;
begin
inc(total);
{if (x=1) then
   begin
   if (s[a,b,1]<s[c,d,1]) then exit(false) else exit(true);
   end;
for i:=1 to x do
    begin
    inc(ssum);
    if (s[a,b,i]<s[c,d,i]) then exit(false);
    end;}
if sig[a,b,x]<sig[c,d,x] then exit(false);
ll:=1; rr:=x;
while ll<rr do
 begin
 inc(ssum);
 mid:=(ll+rr)div 2;
 if sig[a,b,mid]<sig[c,d,mid] then ll:=mid+1
    else rr:=mid-1;
 end;
if sig[a,b,ll]<sig[c,d,ll] then exit(false) else exit(true);

end;
begin
{assign(input,'fish.in');
reset(input);
assign(output,'fish.out');
rewrite(output);}
readln(n);
pd:=false;
while n<>0 do
begin
inc(tot);
if pd then writeln;
{fillchar(catch,sizeof(catch),0);
fillchar(decline,sizeof(decline),0);
fillchar(sigma,sizeof(sigma),0);
fillchar(t,sizeof(t),0);
fillchar(sum,sizeof(sum),0);}
fillchar(f,sizeof(f),0);
fillchar(s,sizeof(s),0);
fillchar(sig,sizeof(sig),0);
readln(h);
fmax:=0;
for i:=1 to n do read(catch[i]);
for i:=1 to  n do
    begin
    read(decline[i]);
    up:=h*12;
{    if decline[i]=0 then up:=h*12
                    else begin
                         up:=(catch[i] div decline[i])+1;
                         end;}
    sigma[i,1]:=catch[i];
    for j:=2 to up do
        begin
        if catch[i]-(j-1)*decline[i]<0 then
           sigma[i,j]:=sigma[i,j-1]
        else
           sigma[i,j]:=sigma[i,j-1]+catch[i]-(j-1)*decline[i];
        end;
    end;
for i:=1 to n-1 do
    begin
    read(t[i]);
    sum[i]:=sum[i-1]+t[i];
    end;
i:=1;
   { if decline[i]=0 then up:=h*12
                    else begin
                         up:=(catch[i] div decline[i])+1;
                         end;}
up:=h*12;
for i:=0 to up do
    begin
    f[1,i]:=sigma[1,i];
    s[1,i,1]:=i*5;
    sig[1,i,1]:=i*5;
    if f[1,i]>=fmax then
       begin
       fmax:=f[1,i];
       numa:=1; numb:=i;
       end;
    end;
for i:=2 to n do
    begin
    down:=sum[i-1]; up:= h*12;
    for j:=down to up do
        begin
         {   if decline[i]=0 then high:=h*12
                    else begin
                         high:=(catch[i] div decline[i])+1;
                         end;}
                                  high:=h*12;
        for k:=0 to high do
           begin
           inc(ssum);
           if j-k<sum[i-1] then continue;
           //if j-k-t[i-1]<sum[i-2] then continue;
           //if j-k<t[i-1] then continue;
           res:=f[i-1,j-k-t[i-1]]+sigma[i,k];

           if (res>f[i,j])
            or
            ((res=f[i,j])and(com(i-1,j-k-t[i-1],i,j,i-1)))      then
              begin
              sig[i,j]:=sig[i-1,j-k-t[i-1]];
              s[i,j]:=s[i-1,j-k-t[i-1]];
              s[i,j,i]:=k*5;
              sig[i,j,i]:=sig[i,j,i-1]+s[i,j,i];
              f[i,j]:=res;
              end;
           if (f[i,j]>fmax)or((f[i,j]=fmax)and(com(i,j,numa,numb,numa))) then
              begin
              numa:=i; numb:=j;
              fmax:=f[i,j];
              end;
           end;
        end;
    end;
for i:=1 to n-1 do
    begin
    if i>1 then write(' ');
    write(s[numa,numb,i],',');
    end;
write(' ',s[numa,numb,n]);
writeln;
writeln('Number of fish expected: ',fmax);
pd:=true;
readln(n);
end;
{writeln(ssum);
writeln(total);
writeln(tot);}
{close(input);
close(output);}
end.

