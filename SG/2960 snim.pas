const maxn=10020;
var k,u,i,test,n,res,ans,t:longint;
    f,a:array[0..maxn]of longint;
function work(x:longint):longint;
var i,t:longint;
    g:array[0..maxn]of byte;
begin
if f[x]<>-1 then exit(f[x]);
fillchar(g,sizeof(g),0);
for i:=1 to k do
    begin
    if (x-a[i]>=0) then
       begin
       t:=work(x-a[i]);
       g[t]:=1;
       end;
    end;
f[x]:=0;
for i:=0 to maxn do
    if g[i]=0 then
       begin
       f[x]:=i;
       break;
       end;
exit(f[x]);
end;
begin
{assign(input,'s-nim.in');
reset(input);}
read(k);
while k<>0 do
  begin
  for u:=1 to k do
      read(a[u]);
  readln(test);
  for i:=0 to maxn do f[i]:=-1;
  f[0]:=0;
  for u:=1 to test do
      begin
      read(n);
      ans:=0;
      for i:=1 to n do
          begin
          read(t);
          res:=work(t);
          ans:=ans xor res;
          end;
      if ans=0 then write('L') else write('W');
      end;
  writeln;
  read(k);
  end;
//close(input);
end.