const maxn=210;
var n,cnt,i,x,y:longint;
    a,b,st:string;
    edge:array[1..maxn,0..maxn]of longint;
    pd:boolean;
    f,g,h:array[1..maxn,0..1]of longint;
    list,tmp:array[1..maxn]of string;
function max(a,b:longint):longint;
begin
if a>b then exit(a) else exit(b);
end;
procedure dp(x:longint);
var sum,res,i,t:longint;
begin
if edge[x,0]=0 then
   begin
   f[x,0]:=0; f[x,1]:=1;
   g[x,0]:=1; g[x,1]:=1; //0:only;
   exit;
   end;
sum:=0;
res:=0;
for i:=1 to edge[x,0] do
    begin
    t:=edge[x,i];
    dp(t);
    if f[t,0]=f[t,1] then
       begin
       g[x,0]:=0;
       end
    else if f[t,0]>f[t,1] then
            begin
            if g[t,0]=0 then g[x,0]:=0;
            end
         else begin
              if g[t,1]=0 then g[x,0]:=0;
              end;
    if g[t,0]=0 then g[x,1]:=0;
    sum:=sum+max(f[t,0],f[t,1]);
    res:=res+f[t,0];
    end;
f[x,0]:=sum;
f[x,1]:=res+1;
end;
function check(st:string):longint;
var i:longint;
begin
for i:=1 to cnt do if list[i]=st then exit(i);
exit(0);
end;
begin
{assign(input,'party.in');
reset(input);}
readln(n);
for i:=1 to maxn do
    begin
    h[i,0]:=1; h[i,1]:=1;
    end;
while n<>0 do
 begin
 readln(st);
 cnt:=0;
 list:=tmp;
 g:=h;
 fillchar(f,sizeof(f),0);
 fillchar(edge,sizeof(edge),0);
 inc(cnt); list[cnt]:=st;
 for i:=1 to n-1 do
     begin
     readln(st);
     x:=pos(' ',st);
     a:=copy(st,1,x-1);
     delete(st,1,x);
     b:=st;

     x:=check(a);
     y:=check(b);
     if x=0 then
        begin
        inc(cnt); list[cnt]:=a;
        x:=cnt;
        end;
     if y=0 then
        begin
        inc(cnt); list[cnt]:=b;
        y:=cnt;
        end;

     inc(edge[y,0]);
     edge[y,edge[y,0]]:=x;
     end;
 dp(1);
 {pd:=solve;}
 write(max(f[1,0],f[1,1]),' ');
 if f[1,0]=f[1,1] then write('No')
    else if (f[1,0]>f[1,1])and(g[1,0]=0) then write('No')
             else if (f[1,0]<f[1,1])and(g[1,1]=0) then write('No')
                  else write('Yes');
{ if pd then write('Yes') else write('No');}
 writeln;
 readln(n);
 end;
{close(input);}
end.
