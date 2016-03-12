const maxn=80020; maxcnt=1000020;
var n,times,i,max,j,k,le,ri,mid,ans:longint;
    cnt:array[0..maxcnt]of longint;
    a,s,r,tr,ts,h:array[0..maxn]of longint;
function check(x:longint):boolean;
var i,j,sum:longint;
begin
i:=2;
while i<=n do
  begin
  while (i<=n)and(h[i]<x) do inc(i);
  if i>n then break;
  j:=i;
  sum:=2;
  if sum>=times then exit(true);
  while (j+1<=n)and(h[j+1]>=x) do
     begin
     inc(sum);
     if sum>=times then exit(true);
     inc(j);
     end;
//  if sum>=times then exit(true);
  i:=j+1;
  end;
exit(false);
end;
begin
{assign(input,'milkpatterns.in');
reset(input);}
readln(n,times);
for i:=1 to n do
    begin
    read(a[i]);
    inc(cnt[a[i]]);
    if a[i]>max then max:=a[i];
    end;
for i:=1 to max do cnt[i]:=cnt[i-1]+cnt[i];
for i:=n downto 1 do
    begin
    s[cnt[a[i]]]:=i;
    dec(cnt[a[i]]);
    end;
r[s[1]]:=1;
j:=1;
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
  r[s[1]]:=1;
  k:=1;
  for i:=2 to n do
      begin
      if (tr[s[i]]<>tr[s[i-1]])or(tr[s[i]+j]<>tr[s[i-1]+j]) then inc(k);
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
       while (i+j<=n)and(k+j<=n)and(a[i+j]=a[k+j]) do inc(j);
       h[r[i]]:=j;
       if j>0 then dec(j);
       end;
    end;
le:=1; ri:=n+1-times;
while le<=ri do
  begin
  mid:=(le+ri)div 2;
  if check(mid) then begin ans:=mid; le:=mid+1; end
     else ri:=mid-1;
  end;
writeln(ans);
//close(input);
end.