var n,i,j,op,x,tot,st,en,tmp,ans,sum:longint;
    num,opt,dat,sig,hash,res:array[1..50]of longint;
    str:string;
    t:char;
    r,fmax,fmin,f:array[1..50,1..50]of longint;
    a:array[1..50,1..2]of longint;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function max(x,y:longint):longint;
begin
if x>y then exit(x) else exit(y);
end;
function calc(p:longint):longint;
var i,j,k,t1,t2:longint;
begin
for i:=1 to p do
    begin
    for j:=i to p do
        begin
        fmin[i,j]:=maxlongint; fmax[i,j]:=-maxlongint;
        end;
    end;
for i:=1 to p do
    begin
    fmax[i,i]:=dat[i]; fmin[i,i]:=dat[i];
    end;
for i:=2 to p do
    begin
    for j:=1 to p+1-i do
        begin
        for k:=j to j+i-2 do
            begin
            if sig[k]=1 then
               begin
               t1:=fmin[j,k]+fmin[k+1,j+i-1];
               fmin[j,j+i-1]:=min(fmin[j,j+i-1],t1);
               t1:=fmax[j,k]+fmax[k+1,j+i-1];
               fmax[j,j+i-1]:=max(fmax[j,j+i-1],t1);
               end
            else begin
                 t1:=fmax[j,k]*fmax[k+1,j+i-1];
                 t2:=fmin[j,k]*fmin[k+1,j+i-1];
                 fmax[j,j+i-1]:=max(fmax[j,j+i-1],max(t1,t2));
                 t1:=fmin[j,k]*fmax[k+1,j+i-1];
                 t2:=fmax[j,k]*fmin[k+1,j+i-1];
                 fmin[j,j+i-1]:=min(fmin[j,j+i-1],min(t1,t2));
                 end;
            end;
        end;
    end;
exit(fmax[1,p]);
end;
begin
{assign(input,'polygon.in');
reset(input);
assign(output,'polygon.out');
rewrite(output);}
readln(n);
readln(str);
if str[length(str)]<>' ' then str:=str+' ';
i:=1;
op:=1;
x:=0;
while i<=length(str) do
 begin
 t:=str[i];
 if t=' ' then
    begin
    if x<>0 then num[tot]:=op*x;
    x:=0;
    op:=1;
    end
 else if t='-' then begin op:=-1;  end
         else
         if (t='t')or(t='x') then
            begin
            inc(tot);
            if t='t' then opt[tot]:=1 else opt[tot]:=2;
            st:=tot-1; if st=0 then st:=n;
            en:=tot;
            a[tot,1]:=st; a[tot,2]:=en;
            r[st,en]:=opt[tot]; r[en,st]:=opt[tot];
            end
         else x:=x*10+ord(t)-48;
 inc(i);
 end;
ans:=-maxlongint;
for i:=1 to n do
    begin
    fillchar(fmax,sizeof(fmax),0);
    fillchar(fmin,sizeof(fmin),0);
    fillchar(f,sizeof(f),0);
    fillchar(dat,sizeof(dat),0);
    fillchar(sig,sizeof(sig),0);
    fillchar(hash,sizeof(hash),0);
    tot:=0;
    for j:=i-1 downto 1 do
        begin

        if hash[a[j,2]]=0 then
           begin
           inc(tot);
           hash[a[j,2]]:=1;
           dat[tot]:=num[a[j,2]];
           end;
        if hash[a[j,1]]=0 then
           begin
           inc(tot);
           hash[a[j,1]]:=1;
           dat[tot]:=num[a[j,1]];
           end;
        sig[tot-1]:=r[a[j,1],a[j,2]];
        end;
    for j:=n downto i+1 do
        begin

        if hash[a[j,2]]=0 then
           begin
           inc(tot);
           hash[a[j,2]]:=1;
           dat[tot]:=num[a[j,2]];
           end;
        if hash[a[j,1]]=0 then
           begin
           inc(tot);
           hash[a[j,1]]:=1;
           dat[tot]:=num[a[j,1]];
           end;
        sig[tot-1]:=r[a[j,1],a[j,2]];
        end;
    tmp:=calc(tot);
    if tmp>ans then
       begin
       ans:=tmp;
       sum:=1; res[1]:=i;
       end
    else if tmp=ans then
            begin
            inc(sum); res[sum]:=i;
            end;
    end;
writeln(ans);
for i:=1 to sum-1 do write(res[i],' ');
write(res[sum]);
writeln;
{close(input);
close(output);}
end.