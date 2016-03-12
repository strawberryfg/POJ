//22:14;
var i,j,t,p,a,b,len,k,ans,tmp,res,u,cnt:longint;
    row,col,f:array[0..10]of longint;
    g,tg:array[0..10,0..10]of longint;
    nine:array[0..10,0..10]of longint;
    c:char;
    flag:boolean;
procedure dfs(x,y:longint);
var i,t:longint;
begin
if x<1 then
   begin
   flag:=true;
   exit;
   end;
if y<1 then begin dfs(x-1,9); exit; end;
if g[x][y]<>0 then begin dfs(x,y-1); exit; end;
for i:=9 downto 1 do
    begin
    if (row[x] and (1 shl (i-1))=0)and(col[y] and (1 shl (i-1))=0) then
       begin
       t:=nine[x][y];
       if (f[t] and (1 shl (i-1))=0) then
          begin
          row[x]:=row[x]+1 shl (i-1);
          col[y]:=col[y]+1 shl (i-1);
          f[t]:=f[t]+1 shl (i-1);
          tg[x][y]:=i;
          dfs(x,y-1);
          if flag then exit;
          row[x]:=row[x]-1 shl (i-1);
          col[y]:=col[y]-1 shl (i-1);
          f[t]:=f[t]-1 shl (i-1);
          tg[x][y]:=0;
          end;
       end;
    end;
end;
begin
{assign(input,'sudoku.in');
reset(input);
assign(output,'sudoku.out');
rewrite(output); }
readln(cnt);
for u:=1 to cnt do
begin
for i:=1 to 9 do
    begin
    f[i]:=0;
    row[i]:=0;
    col[i]:=0;
    end;
for i:=1 to 9 do
    begin
    for j:=1 to 9 do
        begin
        read(c);
        g[i][j]:=ord(c)-48;
        t:=j div 3;
        if j mod 3<>0 then inc(t);
        p:=i div 3;
        if i mod 3<>0 then inc(p);
        tmp:=(p-1)*3+t;
        nine[i][j]:=tmp;
        if g[i][j]<>0 then
           begin
           f[tmp]:=f[tmp]+1 shl (g[i][j]-1);
           row[i]:=row[i]+1 shl (g[i][j]-1);
           col[j]:=col[j]+1 shl (g[i][j]-1);
           end;
        end;
    readln;
    end;
tg:=g;
flag:=false;
dfs(9,9);
for i:=1 to 9 do
    begin
    for j:=1 to 9 do
        write(tg[i][j]);
    writeln;
    end;
end;
{close(input);
close(output);}
end.