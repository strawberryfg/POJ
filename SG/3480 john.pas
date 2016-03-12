var test,u,i,ans,max,n,t:longint;
begin
{assign(input,'john.in');
reset(input);}
readln(test);
for u:=1 to test do
    begin
    ans:=0;
    max:=0;
    readln(n);
    for i:=1 to n do
        begin
        read(t);
        ans:=ans xor t;
        if t>max then max:=t;
        end;
    if ((ans<>0)and(max>1))or((ans=0)and(max=1)) then
       writeln('John')
    else
       writeln('Brother');
    end;
//close(input);
end.