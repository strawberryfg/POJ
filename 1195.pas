const maxn=1300;
var s,n,x1,x2,y1,y2,x,a,y:longint;
    ans:int64;
    bit:array[0..maxn,0..maxn]of int64;
procedure modify(x,y,delta:longint);
var ty:longint;
begin
ty:=y;
while x<=n do
 begin
 y:=ty;
 while y<=n do
   begin
   bit[x][y]:=int64(bit[x][y])+int64(delta);
   y:=y+y and -y;
   end;
 x:=x+x and -x;
 end;
end;
function query(x,y:longint):int64;
var ty:longint;
    sum:int64;
begin
ty:=y;
sum:=0;
while x>0 do
  begin
  y:=ty;
  while y>0 do
    begin
    sum:=int64(sum)+int64(bit[x][y]);
    y:=y-y and -y;
    end;
  x:=x-x and -x;
  end;
exit(sum);
end;
begin
{assign(input,'e:\1.in');
reset(input);}
read(s);
while (not eof)and(s<>3) do
  begin
  if s=0 then
     begin
     read(n);
     fillchar(bit,sizeof(bit),0);
     end
  else
     if s=1 then
        begin
        readln(x,y,a);
        inc(x); inc(y);
        modify(x,y,a);
        end
     else
        begin
        readln(x1,y1,x2,y2);
        inc(x1); inc(y1); inc(x2); inc(y2);
        ans:=0;
        ans:=int64(ans)+int64(query(x2,y2))-int64(query(x1-1,y2));
        ans:=int64(ans)-int64(query(x2,y1-1))+int64(query(x1-1,y1-1));
        writeln(ans);
        end;
  read(s);
  end;
//close(input);
end.