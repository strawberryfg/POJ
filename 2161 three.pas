const maxn=1000020;
var now,po:longint;
    f,g,l,r,son:array[0..maxn]of longint;
    s:ansistring;
procedure init(x:longint);
var i:longint;
begin
if s[po]='a' then begin son[x]:=0; dec(po); exit; end;
son[x]:=ord(s[po])-48;
l[x]:=now+1; r[x]:=now+son[x];
dec(po); now:=r[x];
for i:=r[x] downto l[x] do init(i);
end;
procedure dp(x:longint);
var i,ans,j,tmp:longint;
begin
if son[x]=0 then begin f[x]:=1; exit; end;
f[x]:=maxlongint;
for i:=l[x] to r[x] do dp(i);
for i:=l[x] to r[x] do
    begin
    ans:=0;
    for j:=0 to son[x]-1 do
        begin
        tmp:=i+j;
        if tmp>r[x] then tmp:=tmp-r[x]+l[x]-1;
        if j+f[tmp]>ans then ans:=j+f[tmp];
        end;
    if ans<f[x] then
       begin
       f[x]:=ans;
       g[x]:=i;
       end;
    end;
end;
procedure print(x:longint);
var i,tmp:longint;
begin
if son[x]=0 then write('a')
   else begin
        for i:=0 to son[x]-1 do
            begin
            tmp:=i+g[x];
            if tmp>r[x] then tmp:=tmp-r[x]+l[x]-1;
            print(tmp);
            end;
        write(son[x]);
        end;
end;
begin
{assign(input,'three.in');
reset(input);
assign(output,'three.out');
rewrite(output);}
readln(s);
po:=length(s);
now:=1;
init(1);
dp(1);
writeln(f[1]);
print(1);
writeln;
{close(input);
close(output);}
end.