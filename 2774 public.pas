const maxn=400020;
var i,j,k,n,ans,max:longint;
    a,cnt,r,tr,s,ts,h:array[0..maxn]of longint;
    x,y:ansistring;
begin
{assign(input,'public.in');
reset(input);}
readln(x);
readln(y);
for i:=1 to length(x) do
    a[i]:=ord(x[i]);
a[length(x)+1]:=ord('$');
for i:=1 to length(y) do
    a[length(x)+i+1]:=ord(y[i]);
n:=length(x)+1+length(y);
for i:=1 to n do
    begin
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
  tr:=r;
  fillchar(cnt,sizeof(cnt),0);
  for i:=1 to n do
      inc(cnt[r[i+j]]);
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
ans:=0;
for i:=2 to n do
    begin
    j:=s[i-1]; k:=s[i];
    if (j=length(x)+1)or(k=length(x)+1) then continue;
    if (j<=length(x))and(k<=length(x)) then continue;
    if (j>=length(x)+2)and(k>=length(x)+2) then continue;
    if h[i]>ans then ans:=h[i];
    end;
writeln(ans);
//close(input);
end.