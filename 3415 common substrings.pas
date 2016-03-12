const maxn=600200;
var i,j,k,n,num:longint;
    ans:int64;
    cnt,r,tr,s,ts,a,h,sum:array[0..maxn]of longint;
    s1,s2:ansistring; //ansistring;
    st:array[0..maxn]of record v,x,y:longint;  key:int64; end;
procedure init;
begin
fillchar(cnt,sizeof(cnt),0); //important;
fillchar(r,sizeof(r),0);
fillchar(h,sizeof(a),0);
end;
procedure work(opt:longint);
var i,j,k,top,t,next:longint;
    now:int64;
begin
sum[0]:=0;
for i:=1 to n do
    begin
    if opt=1 then t:=1 else t:=0;
    if s[i]<=length(s1) then sum[i]:=sum[i-1]+t
       else sum[i]:=sum[i-1]+1-t; //B string
    end;
i:=2;
while (i<=n)do
  begin
  while (i<=n)and(h[i]<num) do inc(i);
  if i>n then break;
  j:=i;
  while (j+1<=n)and(h[j+1]>=num) do inc(j);
  st[0].v:=-maxlongint;
  st[0].x:=i-1; st[0].y:=i-1;
  st[0].key:=0;
  top:=0;
  now:=0;
  for k:=i to j do
      begin
      while (st[top].v>=h[k]) do
         begin
         now:=now-st[top].key;
         dec(top);
         end;
      next:=top;
      inc(top);
      st[top].v:=h[k];
      st[top].y:=k;
      st[top].x:=st[next].y;
      st[top].key:=int64(int64(st[top].v)-int64(num)+int64(1))*int64(int64(sum[st[top].y-1])-int64(sum[st[top].x-1]));
      now:=now+st[top].key;
      if opt=1 then
         begin
         if s[k]>=length(s1)+2 then
            begin
            ans:=ans+now;
//            now:=0;
            end;
         end
      else
         begin
         if s[k]<=length(s1) then
            begin
            ans:=ans+now;
//            now:=0;
            end;
         end;
      end;
  i:=j+1;
  end;
end;
begin
{assign(input,'common.in');
reset(input);
assign(output,'common.out');
rewrite(output);}
readln(num);
while num<>0 do
  begin
  readln(s1);
  readln(s2);
  init;
  for i:=1 to length(s1) do a[i]:=ord(s1[i]);
  a[length(s1)+1]:=36;
  for i:=1 to length(s2) do a[length(s1)+1+i]:=ord(s2[i]);
  n:=length(s1)+1+length(s2);
  sum[0]:=0;
  for i:=1 to n do inc(cnt[a[i]]);
  for i:=1 to 200 do cnt[i]:=cnt[i-1]+cnt[i];
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
    tr:=r;
    fillchar(cnt,sizeof(cnt),0);
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
  h[1]:=0; j:=0;
  for i:=1 to n do
      begin
      if r[i]>1 then
         begin
         k:=s[r[i]-1];
         while (i+j<=n)and(k+j<=n)and(a[i+j]=a[k+j]) do inc(j);
         h[r[i]]:=j;
         if j>0 then dec(j);
         end;
      end;
  ans:=0;
  work(1);
  work(2);
  writeln(ans);
  readln(num);
  end;
{close(input);
close(output);}
end.
