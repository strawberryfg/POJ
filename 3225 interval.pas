//20:36;
const maxn=131071;
type rec=record l,r:longint; end;
var a,b,st,en,left,right,sum,i,cnt:longint;
    rev,col:array[0..4*maxn]of longint;
    tree:array[0..4*maxn]of rec;
    f:array[0..4*maxn]of rec;
    ch,c,cx,cy:char;
    flag:boolean;
procedure init(f,t,x:longint);
begin
tree[x].l:=f; tree[x].r:=t;
if f=t then exit;
init(f,(f+t)div 2,x*2);
init((f+t)div 2+1,t,x*2+1);
end;
procedure lazy(x:longint);
begin
if rev[x]<>0 then
   begin
   if col[x]<>-1 then col[x]:=1-col[x];
   rev[2*x]:=1-rev[2*x];
   rev[2*x+1]:=1-rev[2*x+1];
   rev[x]:=0;
   end;
if col[x]<>-1 then
   begin
   col[x*2]:=col[x]; col[x*2+1]:=col[x];
   rev[x*2]:=0; rev[x*2+1]:=0;
   col[x]:=-1;
   end;
end;
procedure makesame(f,t,x,d:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   col[x]:=d;
   rev[x]:=0;
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then makesame(f,t,x*2,d);
if t>mid then makesame(f,t,x*2+1,d);
end;
procedure reverse(f,t,x:longint);
var mid:longint;
begin
if (f<=tree[x].l)and(tree[x].r<=t) then
   begin
   rev[x]:=1-rev[x];
   exit;
   end;
lazy(x);
mid:=(tree[x].l+tree[x].r)div 2;
if f<=mid then reverse(f,t,x*2);
if t>mid then reverse(f,t,x*2+1);
end;
procedure query(x:longint);
begin
if tree[x].l<>tree[x].r then lazy(x)
   else if rev[x]<>0 then
           begin
           col[x]:=1-col[x];
           rev[x]:=0;
           end;
if (col[x]<>0)and(col[x]<>-1) then
   begin
   inc(sum); f[sum].l:=tree[x].l; f[sum].r:=tree[x].r; exit;
   end;
if tree[x].l=tree[x].r then exit;
query(2*x);
query(2*x+1);
end;
procedure work;
begin
sum:=0;
query(1);
if sum=0 then write('empty set')
   else begin
        left:=f[1].l; right:=f[1].r;
        flag:=false;
        for i:=2 to sum do
            begin
            if f[i].l=right+1 then right:=f[i].r
               else begin
                    if flag then write(' ');
                    flag:=true;
                    if left mod 2=1 then write('[',left div 2)
                       else write('(',left div 2-1);
                    write(',');
                    if right mod 2=0 then write(right div 2,')')
                       else write(right div 2,']');
                    left:=f[i].l; right:=f[i].r;
                    end;
            end;

           if flag then write(' ');
           flag:=true;
           if left mod 2=1 then write('[',left div 2)
              else write('(',left div 2-1);
           write(',');
           if right mod 2=0 then write(right div 2,')')
              else write(right div 2,']');

        end;
end;
begin
{assign(input,'interval.in');
reset(input);
assign(output,'interval.out');
rewrite(output);}
init(1,maxn,1);
while not eof do
  begin
  read(ch); read(c);
  a:=0;
  read(cx);
  read(c);
  while c<>',' do
    begin
    a:=a*10+ord(c)-48;
    read(c);
    end;
  read(c);
  b:=0;
  while (ord(c)>=48)and(ord(c)<=57) do
    begin
    b:=b*10+ord(c)-48;
    read(c);
    end;
  cy:=c;
  readln;
  if cx='(' then st:=2*a+2 else st:=2*a+1;
  if cy=')' then en:=2*b else en:=2*b+1;
  if ch='U' then
     begin
     makesame(st,en,1,1);
     end
  else if ch='I' then
          begin
          makesame(1,st-1,1,0);
          makesame(en+1,maxn,1,0);
          end
       else if ch='D' then
               begin
               makesame(st,en,1,0);
               end
            else if ch='C' then
                    begin
                    makesame(1,st-1,1,0);
                    makesame(en+1,maxn,1,0);
                    reverse(st,en,1);
                    end
                 else begin
                      reverse(st,en,1);
                      end;
  end;
work;
writeln;
{close(input);
close(output);}
end.