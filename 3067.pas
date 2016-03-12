const maxn=1020; maxx=1000020;
var cnt,u,n,m,k,i:longint;
    ans:int64;
    bit:array[0..maxn]of longint;
    x,y:array[0..maxx]of longint;
procedure sort(l,r: longint);
      var i,j,tx,ty,tmp: longint;
      begin
         i:=l; j:=r; tx:=x[(l+r) div 2]; ty:=y[(l+r)div 2];
         repeat
           while (x[i]<tx)or((x[i]=tx)and(y[i]<ty)) do inc(i);
           while (tx<x[j])or((tx=x[j])and(ty<y[j])) do dec(j);
           if not(i>j) then
             begin
                tmp:=x[i]; x[i]:=x[j]; x[j]:=tmp;
                tmp:=y[i]; y[i]:=y[j]; y[j]:=tmp;
                inc(i); dec(j);
             end;
         until i>j;
         if l<j then sort(l,j);
         if i<r then sort(i,r);
      end;
function query(x:longint):longint;
var sum:longint;
begin
sum:=0;
while x>0 do
  begin
  sum:=sum+bit[x];
  x:=x-x and -x;
  end;
exit(sum);
end;
procedure modify(x,delta:longint);
begin
while x<=m do
 begin
 bit[x]:=bit[x]+delta;
 x:=x+x and -x;
 end;
end;
begin
readln(cnt);
for u:=1 to cnt do
    begin
    readln(n,m,k);
    for i:=1 to k do
        begin
        readln(x[i],y[i]);
        end;
    fillchar(bit,sizeof(bit),0);
    sort(1,k);
    ans:=0;
    for i:=1 to k do
        begin
        ans:=int64(ans)+int64(query(m))-int64(query(y[i]));
        modify(y[i],1);
        end;
    writeln('Test case ',u,': ',ans);
    end;
end.