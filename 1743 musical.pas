const maxn=80020; max=200;
var n,i,j,k,le,ri,ans,mid,tn:longint;
    s,ts,r,tr,a,cnt,h:array[0..maxn]of longint;
procedure init;
begin
fillchar(a,sizeof(a),0);
fillchar(cnt,sizeof(cnt),0);
fillchar(r,sizeof(r),0);
fillchar(ts,sizeof(ts),0);
fillchar(tr,sizeof(tr),0);
fillchar(h,sizeof(h),0);
fillchar(s,sizeof(s),0);
end;
function check(x:longint):boolean;
var i,fmax,fmin,j:longint;
begin
i:=2;
while i<=n do
  begin
  while (i<=n)and(h[i]<x-1) do inc(i);
  if i>n then break;
  fmax:=s[i-1]; fmin:=s[i-1];
  j:=i;
  if s[i]>fmax then fmax:=s[i];
  if s[i]<fmin then fmin:=s[i];
  while (j+1<=n)and(h[j+1]>=x-1) do
    begin
    inc(j);
    if s[j]>fmax then fmax:=s[j];
    if s[j]<fmin then fmin:=s[j];
    end;
  if (fmax-fmin>x-1) then
     exit(true);
  i:=j+1;
  end;
exit(false);
end;
begin
{assign(input,'musical.in');
reset(input);}
readln(n);
while n<>0 do
  begin
  tn:=n;
  init;
  for i:=1 to n do
      read(a[i]);
  for i:=1 to n-1 do
      a[i]:=a[i+1]-a[i]+100;
  dec(n);
  for i:=1 to n do inc(cnt[a[i]]);
  for i:=1 to max do
      cnt[i]:=cnt[i-1]+cnt[i];
  for i:=n downto 1  do
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
    tr:=r;
    fillchar(cnt,sizeof(cnt),0);
    for i:=1 to n do inc(cnt[r[i+j]]);
    for i:=1 to n do cnt[i]:=cnt[i-1]+cnt[i];
    for i:=n downto 1  do
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
        if (tr[s[i]]<>tr[s[i-1]])or(tr[s[i]+j]<>tr[s[i-1]+j]) then
           inc(k);
        r[s[i]]:=k;
        end;
    j:=j*2;
    end;
  j:=0; h[1]:=0;
  for i:=1 to n do
      begin
      if r[i]>1 then
         begin
         k:=s[r[i]-1];
         while (a[i+j]=a[k+j])and(a[i+j]<>0)and(a[k+j]<>0) do inc(j);
         h[r[i]]:=j;
         if j>0 then dec(j);
         end;
      end;
  le:=1; ri:=tn div 2;
  ans:=0;
  while le<=ri do
    begin
    mid:=(le+ri)div 2;
    if check(mid) then begin ans:=mid; le:=mid+1; end
       else ri:=mid-1;
    end;
  if (ans=0)or(ans<5) then writeln(0)
     else writeln(ans);
  readln(n);
  end;
//close(input);
end.