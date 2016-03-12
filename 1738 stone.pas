const maxn=100020; inf=maxlongint;
var n,i,tot,cnt,ans,now,x,l,r:longint;
    a,next,pre:array[0..maxn]of longint;
procedure combine(x,y:longint);
begin
next[x]:=y;
pre[y]:=x;
end;
begin
{assign(input,'stone.in');
reset(input);
assign(output,'stone.out');
rewrite(output);}
readln(n);
while n<>0 do
  begin
  for i:=1 to n do read(a[i]);
  for i:=1 to n do
      begin
      pre[i]:=i-1;
      next[i]:=i+1;
      end;
  next[0]:=1;
  a[0]:=inf; a[n+1]:=inf;
  tot:=n+1;
  cnt:=n;  //n elements;
  ans:=0;
  for i:=1 to n-1 do
      begin
      x:=next[0];
      now:=1;
      while (now<=cnt-1) do
        begin
        if a[x]<=a[next[next[x]]] then break;
        inc(now);
        x:=next[x];
        end;
      inc(tot); a[tot]:=a[x]+a[next[x]];
      combine(pre[x],next[next[x]]);
      dec(cnt);
      now:=pre[x];
      while (a[now]<=a[tot]) do
         now:=pre[now];
      l:=now; r:=next[now];
      combine(l,tot);
      combine(tot,r);
      ans:=ans+a[tot];
      end;
  writeln(ans);
  readln(n);
  end;
{close(input);
close(output);}
end.