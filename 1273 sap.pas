const maxn=300;
var n,m,i,a,b,c,now,j,min,num,ans,u:longint;
    edge,g:array[0..maxn,0..maxn]of longint;
    f,h,pre,hash,his:array[0..maxn]of longint;
    flag:boolean;
begin
{assign(input,'sap.in');
reset(input);
assign(output,'sap.out');
rewrite(output);}
while not eof do
begin
readln(m,n);
fillchar(g,sizeof(g),0);
fillchar(f,sizeof(f),0);
fillchar(hash,sizeof(hash),0);
fillchar(h,sizeof(h),0);
fillchar(his,sizeof(his),0);
for i:=1 to m do
    begin
    readln(a,b,c);
    g[a][b]:=g[a][b]+c;
    end;
hash[0]:=n;
for i:=1 to n do f[i]:=1;
i:=1;
now:=maxlongint;
ans:=0;
while h[1]<n do
   begin
   his[i]:=now;
   flag:=false;
   for j:=f[i] to n do
       begin
       if (g[i][j]>0)and(h[j]+1=h[i]) then
          begin
          flag:=true;
          f[i]:=j;
          if g[i][j]<now then now:=g[i][j];
          pre[j]:=i;
          i:=j;
          if i=n then
             begin
             ans:=ans+now;
             while i<>1 do
               begin
               dec(g[pre[i]][i],now);
               inc(g[i][pre[i]],now);
               i:=pre[i];
               end;
             now:=maxlongint;
             end;
          break;
          end;
       end;
   if not flag then
      begin
      min:=n-1;
      for j:=1 to n do
          begin
          if (g[i][j]>0)and(h[j]<min) then
             begin
             min:=h[j];
             num:=j;
             end;
          end;
      f[i]:=num;
      dec(hash[h[i]]);
      if hash[h[i]]=0 then break;
      h[i]:=min+1;
      inc(hash[h[i]]);
      if i<>1 then
         begin
         i:=pre[i];
         now:=his[i];
         end;
      end;
   end;
writeln(ans);
end;
{close(input);
close(output);}
end.