const maxn=1020;
var t,i,n,m,x,y,cnt,p,j,k:longint;
    vis:array[1..maxn]of boolean;
    pd:boolean;
    edge,edge2,g,h:array[1..maxn,0..maxn]of longint;
    a,col,inner,stack,hash:array[1..maxn]of longint;
procedure dfs(num:longint);
var i:longint;
begin
vis[num]:=true;
for i:=1 to edge[num,0] do
    begin
    if not vis[edge[num,i]] then dfs(edge[num,i]);
    end;
inc(p); a[p]:=num;
end;
procedure dfs2(num:longint);
var i:longint;
begin
col[num]:=cnt;
for i:=1 to edge2[num,0] do
    begin
    if col[edge2[num,i]]=0 then dfs2(edge2[num,i]);
    end;
end;
procedure topsort;
var top,i:longint;
begin
top:=0;
for i:=1 to cnt do
    if inner[i]=0 then
       begin
       inc(top); stack[top]:=i;
       if top>1 then begin pd:=false; exit; end;
       end;
fillchar(hash,sizeof(hash),0);
while top<>0 do
 begin
 for i:=1 to h[stack[top],0] do
     dec(inner[h[stack[top],i]]);
 hash[stack[top]]:=1;
 stack[top]:=0;
 dec(top);
 if top=0 then
    begin
    for i:=1 to cnt do
       if (hash[i]=0)and(inner[i]=0) then
          begin
          inc(top); stack[top]:=i;
          if top>1 then begin pd:=false; exit; end;
          end;
    end;
 end;
end;
begin
{assign(input,'utov.in');
reset(input);
assign(output,'utov.out');
rewrite(output);}
readln(t);
for i:=1 to t do
    begin
    readln(n,m);
    fillchar(vis,sizeof(vis),false);
    fillchar(col,sizeof(col),0);
    fillchar(edge,sizeof(edge),0);
    fillchar(edge2,sizeof(edge2),0);
    fillchar(inner,sizeof(inner),0);
    fillchar(h,sizeof(h),0);
    fillchar(a,sizeof(a),0);
    fillchar(g,sizeof(g),0);
    cnt:=0;  p:=0;
    for j:=1 to m do
        begin
        readln(x,y);
        inc(edge[x,0]); edge[x,edge[x,0]]:=y;
        inc(edge2[y,0]); edge2[y,edge2[y,0]]:=x;
        end;
    for j:=1 to n do
        if not vis[j] then dfs(j);
    for j:=p downto 1 do
        begin
        if col[a[j]]=0 then
           begin
           inc(cnt);
           dfs2(a[j]);
           end;
        end;
    for j:=1 to n do
        begin
        for k:=1 to edge[j,0] do
            begin
            if (col[j]<>col[edge[j,k]]) then
               g[col[j],col[edge[j,k]]]:=1;
            end;
        end;
    for j:=1 to cnt do
        begin
        for k:=1 to cnt do
            begin
            if (j<>k)and(g[j,k]=1) then
               begin
               inc(h[j,0]); h[j,h[j,0]]:=k;
               inc(inner[k]);
               end;
            end;
        end;
    pd:=true;
    if cnt=1 then pd:=true else topsort;
    if pd then writeln('Yes') else writeln('No');
    end;
{close(input);
close(output);}
end.