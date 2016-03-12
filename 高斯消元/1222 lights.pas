const dx:array[1..4]of longint=(-1,0,1,0);
      dy:array[1..4]of longint=(0,1,0,-1);
type rec=record x,y:longint; end;
var test,i,j,k,p,now,swap,x,y,todo,num:longint;
    id,a,g,print:array[0..40,0..40]of longint;
    ans,hash,res,b,tmp:array[0..40]of longint;
    bel:array[0..40]of rec;
begin
{assign(input,'lights.in');
reset(input);
assign(output,'lights.out');
rewrite(output);}
readln(test);
for i:=1 to 5 do
    for j:=1 to 6 do
        begin
        id[i][j]:=(i-1)*6+j;
        bel[(i-1)*6+j].x:=i; bel[(i-1)*6+j].y:=j;
        end;
for now:=1 to test do
    begin
    for i:=1 to 5 do
        for j:=1 to 6 do
            read(a[i][j]);
    fillchar(g,sizeof(g),0);
    fillchar(b,sizeof(b),0);
    for i:=1 to 5 do
        for j:=1 to 6 do
            begin
            for k:=1 to 4 do
                begin
                x:=i+dx[k]; y:=j+dy[k];
                if (x>=1)and(x<=5)and(y>=1)and(y<=6) then
                   g[id[i][j]][id[x][y]]:=1;
                end;
            g[id[i][j]][id[i][j]]:=1;
            b[id[i][j]]:=0 xor a[i][j];
            end;
    fillchar(hash,sizeof(hash),0);
    i:=1; j:=1;
    while (i<=30)and(j<=30) do
      begin
      num:=-1;
      res[i]:=-1;
      for k:=i to 30 do if g[k][j]=1 then begin num:=k; break; end;
      if num<>-1 then
         begin
         hash[j]:=1;
         res[i]:=j;
         tmp:=g[i]; g[i]:=g[num]; g[num]:=tmp;
         swap:=b[i]; b[i]:=b[num]; b[num]:=swap;
         for k:=i+1 to 30 do
             if g[k][j]=1 then
                begin
                for p:=j to 30 do
                    g[k][p]:=g[k][p] xor g[i][p];
                b[k]:=b[k] xor b[i];
                end;
         inc(i);
         end;
      inc(j);
      end;
    fillchar(ans,sizeof(ans),0);
    for i:=30 downto 1 do
        begin
        if res[i]=-1 then continue;
        todo:=b[i];
        for j:=res[i]+1 to 30 do todo:=todo xor (ans[j] and g[i][j]);
        ans[res[i]]:=todo;
        end;
    for i:=1 to 30 do print[bel[i].x][bel[i].y]:=ans[i];
    writeln('PUZZLE #',now);
    for i:=1 to 5 do
        begin
        for j:=1 to 6 do
            write(print[i][j],' ');
        writeln;
        end;
    end;
{close(input);
close(output);}
end.