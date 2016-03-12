const maxn=502;
var m,k,n,cnt,u,i,j,x,y,lim,fmax:longint;
//    edge:array[0..maxn,0..maxn]of longint;
    g:array[0..maxn,0..maxn]of boolean;
    f,tf:array[0..maxn,0..maxn]of longint;
    sum:array[0..maxn,1..2]of longint;
    belong:array[0..maxn]of longint;
procedure work(num:longint);
var i,t:longint;
begin
if (belong[num]<>0) then exit;
belong[num]:=cnt;
//inc(sum[cnt,x]);
for i:=1 to 2*m do
    begin
    if g[num,i] then  work(i);
    end;

end;
begin
{assign(input,'prison.in');
reset(input);
assign(output,'prison.out');
rewrite(output);}
readln(n);
for i:=1 to n do
    begin
    readln(m,k);
//    fillchar(edge,sizeof(edge),0);
    fillchar(g,sizeof(g),false);
    fillchar(belong,sizeof(belong),0);
    fillchar(sum,sizeof(sum),0);
    fillchar(f,sizeof(f),0);
    fillchar(tf,sizeof(tf),0);
    cnt:=0;
    for j:=1 to k do
        begin
        readln(x,y);
        g[x,y+m]:=true;
        g[y+m,x]:=true;
        end;

    for j:=1 to 2*m do
        begin
        if belong[j]=0 then
           begin
           inc(cnt);
           work(j);
           end;
        end;
    for j:=1 to m do inc(sum[belong[j],1]);
    for j:=m+1 to 2*m do inc(sum[belong[j],2]);
    f[0,0]:=1;
    lim:=m div 2;
    fmax:=0;
    for u:=1 to cnt do
        begin
        tf:=f;
        for j:=0 to m-sum[u,1] do
            begin
            for k:=0 to m-sum[u,2] do
                begin
                if tf[j,k]=1 then
                   begin
                   f[j+sum[u,1],k+sum[u,2]]:=1;
                   if (j+sum[u,1]=k+sum[u,2])and(j+sum[u,1]<=lim) then
                      begin
                      if j+sum[u,1]>fmax then fmax:=j+sum[u,1];
                      end;
                   end;
                end;
            end;

        end;
    writeln(fmax);
    end;
{close(input);
close(output);}
end.
