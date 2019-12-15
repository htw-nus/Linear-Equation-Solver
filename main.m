%%% START OF READ, LIMITAION: 26 EQUATION STARTING WITH (a) ending with (z)
clc
syms x
fid = fopen('fgetl.txt');
iter_s = fgetl(fid);
iter = str2num(['uint8(',iter_s,')']);

st_x = 'x^';
ch = char(97:97+iter-1);

method = fgetl(fid);    % if iterative will add one to iter for arguments-

mat=[];
a=[];
b=[];
s=[];
happened = false;
for counter = 1:iter
    fn = fgetl(fid);
    TF = contains(fn,'a');
    if ~TF
        st_a='1*a + ';
        fn = strcat(st_a,fn);
    end

    
    for ns = 1:length(ch)
        st = strcat(st_x , int2str(abs(iter-ns+1)) );
        fn = strrep(fn,ch(ns),st);
    end
    
    c = coeffs(fn,[x],'All');
    c = eval(c);
    %c =vpa(c);
    
   
    if ~TF
        c(1) = 0 ;
    end
    
    mat = [mat;c];

    
end

fclose(fid);

%mat = float(mat)

for counter = 1:iter

    a = [a;mat(counter,1:end-1)];
    b = [b;mat(counter,end)] ;

end
b=-b;


method
a
b

disp('END OF READ')

%%% END OF READ


%%% FORWARD ELIMINATION
n = iter;

for k = 1:n-1
% pick pivot

%pivot
max=0;
for p = k:n
    if abs(a(p,k)) > max
        happened = true;
        max = abs(a(p,k));
        max_i = p;
    end
end

if happened
a([k max_i],:)=a([max_i k],:);
b([k max_i],:)=b([max_i k],:);
happened = false;
end



a;
  for i = k+1:n
    %
        fac_u = a(i,k)*1.0 ; 
        fac_d= a(k,k)*1.0 ;
        factor = fac_u / fac_d;
        for j = k : n
            i;
            j;
            k;
            a(i,j) = a(i,j) - factor*a(k,j);
            a;
        end
        b(i) = b(i) - factor* b(k); 
    end
end

%%% END OF FORWARD ELIMINATION

a
b
disp('END OF FORWARD ELIMINATION')




%%% BACK SUBSTITUTION

s(n) = b(n)/a(n,n);
n;
for i = n-1:-1:1
    
    sum = 0;
    for j = i+1:n
        i;
        j;
        a(i,j);
        s(j);
        sum = sum + a(i,j)*s(j);
    end
    sum
    s(i) = (b(i) - sum) / a(i,i);
end

s














