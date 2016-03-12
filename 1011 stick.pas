const maxn=100;
var n,tmp,len,depth,sum,i,j,ans:longint;
    flag:boolean;
    a,hash:array[0..maxn]of longint;
procedure dfs(dep,remain,last,num:longint);
var st,i:longint;
begin
if (remain=0)and(num=0) then
   begin
   flag:=true;
   exit;
   end;
if remain=0 then begin dfs(dep+1,len,last,num); exit; end;
if remain=len then
   begin
   st:=1;
   while (st<=n)and(hash[st]=1) do inc(st);
   if st>n then exit;
   end
else st:=last+1;
i:=st;
while i<=n do
    begin
    if (hash[i]=0)and(a[i]<=remain) then
       begin
       hash[i]:=1;
       dfs(dep,remain-a[i],i,num-1);
       hash[i]:=0;
       if flag then exit;
       if remain-a[i]=0 then exit;
       if remain=len then exit;
       while (a[i]=a[i+1]) do  inc(i);
       end;
    inc(i);
    end;

end;
begin
{assign(input,'sticks.in');
rset(input);}
readln(n);
while n<>0 do
  begin
  for i:=1 to n do read(a[i]);
  for i:=1 to n-1 do
      for j:=i+1 to n do
          if a[i]<a[j] then
             begin
             tmp:=a[i]; a[i]:=a[j]; a[j]:=tmp;
             end;
  sum:=0;
  for i:=1 to n do sum:=sum+a[i];
  for i:=a[1] to sum do
      begin
      if sum mod i=0 then
         begin
         len:=i;
         depth:=sum div i;
         flag:=false;
         fillchar(hash,sizeof(hash),0);
         dfs(1,i,0,n);
         if flag then begin ans:=i; break; end;
         end;
      end;
  writeln(ans);
  readln(n);
  end;
//close(input);
end.