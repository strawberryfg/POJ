const spe:array[1..7,1..3]of char=(('M','O','N'),('T','U','E'),('W','E','D'),
                             ('T','H','U'),('F','R','I'),('S','A','T'),
                             ('S','U','N'));
      maxn=320;
      base=7;
type arr=array[1..3]of char;
var n,m,cnt,i,j,v,xa,xb,x,y,num,k,p,swap,lcm,flag,x0,xx,d,todo:longint;
    g:array[0..maxn,0..maxn]of longint;
    b,res,tmp,ans,hash:array[0..maxn]of longint;
    s:arr;
    ch:char;
    nosol,notunique,pd:boolean;
function find(x:arr):longint;
var i:longint;
begin
for i:=1 to 7 do
    if (spe[i][1]=x[1])and(spe[i][2]=x[2])and(spe[i][3]=x[3])  then exit(i);
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
procedure init;
var i:longint;
begin
fillchar(g,sizeof(g),0);
fillchar(hash,sizeof(hash),0);
fillchar(ans,sizeof(ans),0);
fillchar(b,sizeof(b),0);
for i:=1 to m do res[i]:=-1;
end;
begin
{assign(input,'widget.in');
reset(input);}
readln(n,m);
while not((n=0)and(m=0)) do
   begin
   init;
   for i:=1 to m do
       begin
       read(cnt);
       read(ch);
       for j:=1 to 3 do read(s[j]);
       xa:=find(s);
       read(ch);
       for j:=1 to 3 do read(s[j]);
       xb:=find(s);
       if xa=xb then b[i]:=1 else if xa<xb then b[i]:=xb-xa+1 else b[i]:=7-xa+1+xb;
       readln;
       for j:=1 to cnt do begin read(v); inc(g[i][v]); g[i][v]:=g[i][v] mod base; end;
       end;
   for i:=1 to m do b[i]:=b[i] mod base;
   i:=1; j:=1;
   while (i<=m)and(j<=n) do
      begin
      num:=-1;
      for k:=i to m do if g[k][j]>0 then begin num:=k; break; end;
      if num<>-1 then
         begin
         res[i]:=j;
         hash[j]:=1;
         tmp:=g[i]; g[i]:=g[num]; g[num]:=tmp;
         swap:=b[i]; b[i]:=b[num]; b[num]:=swap;
         for k:=i+1 to m do
             begin
             if g[k][j]<>0 then
                begin
                lcm:=getlcm(g[i][j],g[k][j]);
                x:=lcm div g[i][j];
                y:=lcm div g[k][j];
                b[k]:=(x*b[i]-y*b[k])mod base;
                if b[k]<0 then b[k]:=b[k]+base;
                for p:=j to n do
                    begin
                    g[k][p]:=(x*g[i][p]-y*g[k][p])mod base;
                    if g[k][p]<0 then g[k][p]:=g[k][p]+base;
                    end;
                end;
             end;
         inc(i);
         end;
      inc(j);
      end;
   nosol:=false;
   notunique:=false;
   for i:=1 to m do
       begin
       flag:=1;
       for j:=1 to n do if g[i][j]<>0 then begin flag:=0; break; end;
       if (flag=1)and(b[i]<>0) then begin nosol:=true; break; end;
       end;
   if nosol then writeln('Inconsistent data.')
      else if notunique then writeln('Multiple solutions.')
              else begin
                   for i:=m downto 1 do
                       begin
                       if res[i]=-1 then continue;
                       todo:=b[i];
                       for j:=res[i]+1 to n do
                           begin
                           todo:=(todo-ans[j]*g[i][j])mod base;
                           if todo<0 then todo:=todo+base;
                           end;
                       pd:=false;
                       for k:=3 to 9 do
                           begin
                           if g[i][res[i]]*k mod base=todo then
                              begin
                              if pd then begin notunique:=true; break; end;
                              pd:=true;
                              ans[res[i]]:=k;
                              end;
                           end;
                       if not pd then begin nosol:=true; break; end;
                       if notunique then break;
                       end;
                   if notunique then writeln('Multiple solutions.')
                      else if nosol then writeln('Inconsistent data.')
                              else begin
                                   for i:=1 to n do
                                       if hash[i]=0 then
                                          begin
                                          notunique:=true; break;
                                          end;
                                   if notunique then writeln('Multiple solutions.')
                                      else begin
                                           for i:=1 to n-1 do write(ans[i],' ');
                                           write(ans[n]);
                                           writeln;
                                           end;
                                   end;
                   end;
   readln(n,m);
   end;
//close(input);
end.