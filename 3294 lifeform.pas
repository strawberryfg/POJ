const maxn=400020;
var le,ri,mid,ans,max,i,j,k,u,p,n,sum,tot,now:longint;
    cnt,r,tr,s,ts,h,a,f,g,hash:array[0..maxn]of longint;
    s1:array[0..maxn]of char;
procedure init;
begin
fillchar(r,sizeof(r),0);
fillchar(cnt,sizeof(cnt),0);
fillchar(hash,sizeof(hash),0);
fillchar(f,sizeof(f),0);
end;
function check(x:longint):boolean;
var i,j,k,res:longint;
begin
i:=2;
while i<=n do
  begin
  while (i<=n)and(h[i]<x) do inc(i);
  if i>n then break;
  j:=i;
  res:=0;
  inc(tot);
  if hash[f[s[i-1]]]<>tot then
     begin
     inc(res);
     hash[f[s[i-1]]]:=tot;
     end;
  if hash[f[s[i]]]<>tot then
     begin
     inc(res);
     hash[f[s[i]]]:=tot;
     end;
  while (j+1<=n)and(h[j+1]>=x) do
    begin
    inc(j);
    if hash[f[s[j]]]<>tot then
        begin
        inc(res);
        hash[f[s[j]]]:=tot;
        if res>=u div 2+1 then exit(true);
        end;
    end;
  if res>=u div 2+1 then exit(true);
  i:=j+1;
  end;
exit(false);
end;
procedure print(x:longint);
var i,j,res,k:longint;
begin
i:=2;
while i<=n do
  begin
  while (i<=n)and(h[i]<x) do
    inc(i);
  if i>n then break;
  j:=i;
  res:=0;
  inc(tot);
  if hash[f[s[i-1]]]<>tot then
     begin
     inc(res);
     hash[f[s[i-1]]]:=tot;
     end;
  if hash[f[s[i]]]<>tot then
     begin
     inc(res);
     hash[f[s[i]]]:=tot;
     end;

  while (j+1<=n)and(h[j+1]>=x) do
     begin
     inc(j);

     if hash[f[s[j]]]<>tot then
        begin
        inc(res);
        hash[f[s[j]]]:=tot;
        end;
     end;
  if (res>=u div 2+1) then
     begin
     for k:=s[i-1] to s[i-1]+x-1 do write(char(a[k]));
     writeln;
     end;
  i:=j+1;
  end;
end;
begin
{assign(input,'lifeform.in');
reset(input);
assign(output,'e:\wqf\lifeform.out');
rewrite(output);}
readln(u);
p:=0;
while u<>0 do
  begin
  init;
  if p=1 then writeln;
  p:=1;
  n:=0; sum:=0; max:=0;
  for i:=1 to u do
      begin
      now:=0;
      while not eoln do
        begin
        inc(now);
        read(s1[now]);
        end;
      readln;
      if now>max then max:=now;
      inc(sum);
      if sum<>1 then
         begin
         inc(n);
         if sum>96 then a[n]:=sum-96+122 else a[n]:=sum;
         end;
      for j:=1 to now do
          begin
          inc(n);
          f[n]:=i;
          a[n]:=ord(s1[j]);
          end;
      end;
  for i:=1 to n do inc(cnt[a[i]]);
  for i:=1 to 300 do cnt[i]:=cnt[i]+cnt[i-1];
  for i:=n downto 1 do
      begin
      s[cnt[a[i]]]:=i;
      dec(cnt[a[i]]);
      end;
  j:=1;
  r[s[1]]:=1;
  for i:=2 to n do
      begin
      if a[s[i]]<>a[s[i-1]] then inc(j);
      r[s[i]]:=j;
      end;
  k:=j; j:=1;
  while k<n do
     begin
     fillchar(cnt,sizeof(cnt),0);
     tr:=r;
     for i:=1 to n do inc(cnt[r[i+j]]);
     for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
     for i:=n downto 1 do
         begin
         ts[cnt[r[i+j]]]:=i;
         dec(cnt[r[i+j]]);
         end;
     fillchar(cnt,sizeof(cnt),0);
     for i:=1 to n do
         begin
         r[i]:=tr[ts[i]];
         inc(cnt[r[i]]);
         end;
     for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
     for i:=n downto 1 do
         begin
         s[cnt[r[i]]]:=ts[i];
         dec(cnt[r[i]]);
         end;
     k:=1;
     r[s[1]]:=1;
     for i:=2 to n do
         begin
         if (tr[s[i]]<>tr[s[i-1]])or(tr[s[i]+j]<>tr[s[i-1]+j]) then
            inc(k);
         r[s[i]]:=k;
         end;
     j:=j*2;
     end;
  j:=0; h[1]:=0;
  for i:=1 to n do
      begin
      if r[i]<>1 then
         begin
         k:=s[r[i]-1];
         while (i+j<=n)and(k+j<=n)and(a[i+j]=a[k+j])do inc(j);
         h[r[i]]:=j;
         if j>0 then dec(j);
         end;
      end;
  le:=1; ri:=max; ans:=0;
  while le<=ri do
    begin
    mid:=(le+ri)div 2;
    if check(mid) then begin ans:=mid; le:=mid+1; end
       else ri:=mid-1;
    end;
  if ans=0 then writeln('?')
     else print(ans);
  readln(u);
  end;
{close(input);
close(output);}
end.