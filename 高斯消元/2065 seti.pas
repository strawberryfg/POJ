const maxn=100;
var test,now,n,i,j,k,x,y,todo,lcm,p:longint;
    g:array[0..maxn,0..maxn]of longint;
    b,ans:array[0..maxn]of longint;
    ch:char;
procedure exgcd(a,b:longint);
var tx,ty:longint;
begin
if b=0 then begin x:=1; y:=0; exit; end;
exgcd(b,a mod b);
tx:=x; ty:=y;
x:=ty;
y:=tx-a div b*ty;
end;
function gcd(x,y:longint):longint;
begin
if y=0 then exit(x)
   else exit(gcd(y,x mod y));
end;
function getlcm(x,y:longint):longint;
begin
exit(x*y div gcd(x,y));
end;
begin
{assign(input,'seti.in');
reset(input);}
readln(test);
for now:=1 to test do
    begin
    read(p);
    i:=0;
    while not eoln do
      begin
      read(ch);
      if (ch='*')or((ord(ch)>=ord('a'))and(ord(ch)<=ord('z'))) then
         begin
         inc(i);
         if ch='*' then b[i]:=0 else b[i]:=ord(ch)-ord('a')+1;
         end;
      end;
    n:=i;
    for i:=1 to n do
        begin
        g[i][1]:=1;
        for j:=2 to n do
            g[i][j]:=g[i][j-1]*i mod p;
        end;
    for i:=1 to n do
        begin
        for j:=i+1 to n do
            begin
            lcm:=getlcm(g[i][i],g[j][i]);
            x:=lcm div g[i][i];
            y:=lcm div g[j][i];
            b[j]:=(x*b[i]-y*b[j])mod p;
            if b[j]<0 then b[j]:=b[j]+p;
            for k:=i to n do
                begin
                g[j][k]:=(x*g[i][k]-y*g[j][k])mod p;
                if g[j][k]<0 then g[j][k]:=g[j][k]+p;
                end;
            end;
        end;
    for i:=n downto 1 do
        begin
        todo:=b[i];
        for j:=i+1 to n do
            begin
            todo:=(todo-ans[j]*g[i][j])mod p;
            if todo<0 then todo:=todo+p;
            end;
        exgcd(g[i][i],p);
        ans[i]:=x*(todo div gcd(g[i][i],p)) mod p;
        if ans[i]<0 then ans[i]:=ans[i]+p;
        end;
    for i:=1 to n-1 do write(ans[i],' ');
    write(ans[n]);
    writeln;
    end;
//close(input);
end.
