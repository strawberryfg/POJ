const maxn=1020; maxm=1020;
var ti,n,l,c,i,j,k,rest,cnt,sum,num,tmp,down,up:longint;
    upper:array[0..maxn]of longint;
    f:array[0..maxn,0..maxm]of longint;
    sumt,t:array[0..maxn]of longint;
    mark:boolean;
function calc(num:longint):longint;
begin
if num=0 then exit(0)
   else if (1<=num)and(num<=10) then exit(-c)
            else exit((num-10)*(num-10));
end;
begin
{assign(input,'scheduling.in');
reset(input);
assign(output,'scheduling.out');
rewrite(output);}
readln(n);
mark:=true;
while n<>0 do
 begin
 inc(ti);
 if not mark then writeln;
 mark:=false;
 readln(l,c);
 fillchar(t,sizeof(t),0);
 for i:=1 to maxn do
     begin
     for j:=1 to maxm do
         f[i,j]:=maxlongint;
     end;
 f[0,0]:=0;
 fillchar(sumt,sizeof(sumt),0);
 fillchar(upper,sizeof(upper),0);
 for i:=1 to n do
     begin
     read(t[i]);
     sumt[i]:=sumt[i-1]+t[i];
     end;
 rest:=0; cnt:=0;
 for i:=1 to n do
     begin
     if rest+t[i]>l then
        begin
        inc(cnt);
        upper[cnt]:=i-1;
        rest:=t[i];
        end
     else
        begin
        inc(rest,t[i]);
        end;
     end;
 if rest<>0 then
    begin
    inc(cnt); upper[cnt]:=i;
    end;
 writeln('Case ',ti,':');
 writeln;
 writeln('Minimum number of lectures: ',cnt);
 for i:=1 to cnt do //the first i lectures;
     begin
     for j:=i to upper[i] do
         begin
         sum:=t[j];
         num:=j-1;
         while (num>=1)and(sum+t[num]<=l) do
            begin
            inc(sum,t[num]);
            dec(num);
            end;
         down:=num;
         if i=1 then up:=0 else up:=j-1;
         for k:=down to up do
             begin
             tmp:=l-(sumt[j]-sumt[k]);
             tmp:=calc(tmp);
             if (f[i-1,k]<>maxlongint)and(f[i-1,k]+tmp<f[i,j]) then
                f[i,j]:=f[i-1,k]+tmp;
             end;
         end;
     end;
 writeln('Total dissatisfaction index: ',f[cnt,n]);
 readln(n);
 end;
{close(input);
close(output);}
end.