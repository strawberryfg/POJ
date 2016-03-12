const maxn=300020;
var i,j,n,tot,k,len,sum,ans,now,tmp,delta,tt,t:longint;
    two:array[0..20]of longint;
    cnt,r,tr,s,ts,h,a,res:array[0..maxn]of longint;
    s1:ansistring; //ansistring;
    f:array[0..maxn,0..20]of longint;
    flag:boolean;
procedure pre;
var i:longint;
begin
two[0]:=1;
for i:=1 to 18 do two[i]:=two[i-1]*2;
end;
function min(x,y:longint):longint;
begin
if x<y then exit(x) else exit(y);
end;
function check(x:longint):longint;
var i:longint;
begin
for i:=0 to 17 do if (x>=two[i])and(x<two[i+1]) then exit(i);
end;
function lcp(u,v:longint):longint;
var x,y,t,res:longint;
begin
if r[u]>r[v] then begin u:=u+v; v:=u-v; u:=u-v; end;
x:=r[u]+1; y:=r[v];
t:=check(y-x+1);
res:=min(f[x][t],f[y+1-two[t]][t]);
exit(res);
end;
procedure init;
begin
fillchar(cnt,sizeof(cnt),0);
fillchar(r,sizeof(r),0);
end;
begin
{assign(input,'repetition.in');
reset(input);}
pre;
readln(s1);
tot:=0;
while s1[1]<>'#' do
  begin
  inc(tot);
  init;
  n:=length(s1);
  for i:=1 to n do begin a[i]:=ord(s1[i]); inc(cnt[a[i]]); end;
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
      if a[s[i-1]]<>a[s[i]] then inc(j);
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
        if (tr[s[i-1]]<>tr[s[i]])or(tr[s[i-1]+j]<>tr[s[i]+j]) then inc(k);
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
         while (k+j<=n)and(i+j<=n)and(a[i+j]=a[k+j])do inc(j);
         h[r[i]]:=j;
         if j>0 then dec(j);
         end;
      end;
  for i:=1 to n do f[i][0]:=h[i];
  t:=check(n);
  for j:=1 to t do
      begin
      for i:=1 to n+1-two[j] do
          begin
          f[i][j]:=min(f[i][j-1],f[i+two[j-1]][j-1]);
          end;
      end;
  ans:=0;
  res[0]:=0;
  for len:=1 to n do
      begin
      for j:=0 to (n-1)div len-1 do
          begin
          now:=j*len+1;
          tmp:=lcp(now,now+len);
          delta:=len-tmp mod len;
          sum:=tmp div len+1;
          if (now-delta>=0)and(tmp mod len<>0) then
             begin
             tt:=lcp(now-delta,now-delta+len);
             if tt>=tmp then inc(sum);
             end;
          if sum>ans then
             begin
             ans:=sum;
             res[0]:=1;
             res[1]:=len;
             end
          else if sum=ans then
                  begin
                  inc(res[0]);
                  res[res[0]]:=len;
                  end;
          end;
      end;
  flag:=false;
  for i:=1 to n do
      begin
      for j:=1 to res[0] do
          begin
          tmp:=lcp(s[i],s[i]+res[j]);
          if tmp>=(ans-1)*res[j] then
             begin
             write('Case ',tot,': ');
             for k:=0 to res[j]*ans-1 do
                 write(char(a[s[i]+k]));
             writeln;
             flag:=true;
             break;
             end;
          end;
      if flag then break;
      end;
  readln(s1);
  end;
//close(input);
end.