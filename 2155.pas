//22:41;
var bit:array[0..1010,0..1010]of longint;
    cnt,u,x1,x2,y1,y2,n,m,i:longint;
    c:char;
procedure add(x,y,delta:longint);
var ty:longint;
begin
ty:=y;
while x<=n do
 begin
 y:=ty;
 while y<=n do
   begin
   inc(bit[x][y],delta);
   y:=y+y and -y;
   end;
 x:=x+x and -x;
 end;
end;
function query(x,y:longint):longint;
var ty,sum:longint;
begin
ty:=y;
sum:=0;
while x>0 do
  begin
  y:=ty;
  while (y>0) do
    begin
    sum:=sum+bit[x][y];
    y:=y-y and -y;
    end;
  x:=x-x and -x;
  end;
exit(sum);
end;
begin
readln(cnt);
for u:=1 to cnt do
    begin
    readln(n,m);
    fillchar(bit,sizeof(bit),0);
    for i:=1 to m do
        begin
        read(c);
        if c='C' then
           begin
           readln(x1,y1,x2,y2);
           add(x1,y1,1);
           add(x2+1,y1,-1);
           add(x1,y2+1,-1);
           add(x2+1,y2+1,1);
           end
        else
           begin
           readln(x1,y1);
           writeln(query(x1,y1)mod 2);
           end;
        end;
    writeln;
    end;
end.