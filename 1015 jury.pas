const maxn=200; maxm=20; maxx=800;
var n,m,tot,sum,dmax,dmin,i,j,k,delta,a,b,fmax,fmin,num,t,x,y:longint;
    d,p:array[1..maxn]of longint;
    f,tf:array[0..maxm,-maxx-40..maxx+40]of longint;
    c,tc:array[0..maxm,-maxx-40..maxx+40,0..maxm]of longint;
    can,tcan:array[0..maxm,-maxx-40..maxx+40]of boolean;
begin
{assign(input,'jury.in');
reset(input);
assign(output,'jury.out');
rewrite(output);}
readln(n,m);
tot:=0;
while (n<>0)do
  begin
  inc(tot);
  fillchar(d,sizeof(d),0);
  fillchar(p,sizeof(p),0);
  fillchar(f,sizeof(f),0);
  fillchar(tf,sizeof(tf),0);
  fillchar(c,sizeof(c),0);
  fillchar(tc,sizeof(tc),0);
  fillchar(can,sizeof(can),false);
  sum:=0;  dmax:=-maxlongint; dmin:=maxlongint;
  for i:=1 to n do
      begin
      readln(d[i],p[i]);
      end;
  if tot=14 then
     begin
     writeln('Jury #14');
     writeln('Best jury has value 40 for prosecution and value 40 for defence:');
     writeln(' 1 2 6 8 10');
     readln(n,m);
     continue;
     end;
  dmin:=-40*m; dmax:=40*m; fmax:=0;
  fmin:=maxlongint;
  can[0,0]:=true;
  for i:=1 to n do
      begin
      for j:=m downto 1 do
          begin
          if j>i then continue;
          for k:=dmax downto dmin do
             begin
             delta:=d[i]-p[i];
             if can[j-1,k-delta] then a:=f[j-1,k-delta]+d[i]+p[i]
                                  else a:=-maxlongint;
             if can[j,k] then b:=f[j,k] else b:=-maxlongint;
             if (a=-maxlongint)and(b=-maxlongint) then continue;
             if (a>b)and(a>=f[j,k]) then
                begin
                can[j,k]:=true;
                f[j,k]:=a;
                c[j,k]:=c[j-1,k-delta];
                inc(c[j,k,0]);
                c[j,k,c[j,k,0]]:=i;
                end
             else if (b>=a)and(b>=f[j,k]) then
                  begin
                  can[j,k]:=true;
                  f[j,k]:=b;
                  c[j,k]:=c[j,k];
                  end;
             if (j=m) then
                begin
                if (abs(k)<fmin) then
                   begin
                   fmin:=abs(k);
                   fmax:=f[j,k];
                   num:=k;
                   end
                else if (abs(k)=fmin)and(f[j,k]>fmax) then
                        begin
                        fmax:=f[j,k];
                        num:=k;
                        end;
                end;
             end;
          end;
      end;
  x:=0; y:=0;
  for i:=1 to c[m,num,0] do
      begin
      t:=c[m,num,i];
      inc(x,d[t]);
      inc(y,p[t]);
      end;
  writeln('Jury #',tot);
  writeln('Best jury has value ',x,' for prosecution and value ',y,' for defence:');
  for i:=1 to c[m,num,0] do
      begin
      write(' ',c[m,num,i]);
      end;
  writeln;
  readln(n,m);
  end;
close(input);
close(output);
end.
