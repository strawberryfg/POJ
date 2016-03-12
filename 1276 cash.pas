var cash,kk,cnt,i,n,d,num,j,k,fmax:longint;
    f:array[0..100020]of boolean;
    value:array[1..100]of longint;
begin
{assign(input,'cash.in');
reset(input);
assign(output,'cash.out');
rewrite(output);}
while not eof do
 begin
 read(cash); read(kk);
 cnt:=0;
 fmax:=0;
 fillchar(value,sizeof(value),0);
 for i:=1 to kk do
     begin
     read(n,d);
     num:=n;
     k:=1;
     while num - k>=0 do
       begin
       inc(cnt);
       value[cnt]:=d*k;
       num:=num-k;
       k:=k*2;
       end;
     if num>0 then begin inc(cnt); value[cnt]:=d*num; end;
     end;
 fillchar(f,sizeof(f),false);
 f[0]:=true;
 for i:=1 to cnt do
     begin
     for j:=cash downto value[i] do
         begin
         if f[j-value[i]]=true then
            f[j]:=true;
         if (f[j]=true)and(j>fmax) then fmax:=j;
         end;
     end;
 writeln(fmax);
 readln;
 end;
{close(input);
close(output);}
end.