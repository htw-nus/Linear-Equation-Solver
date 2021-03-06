function [s,time] = lu_decomposition(a,b)
tic
mat = a ;
l=[];

%%% FORWARD ELIMINATION
n = size(a);
n = n(1);
happened = false;


for k = 1:n-1
% pick pivot

%pivot
max=0;
for p = k:n
    if abs(a(p,k)) > max
        happened = false; %%%%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4444454
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

if a(k,k) == 0
    error "division by zero"
end
    
  for i = k+1:n
    %
        fac_u = a(i,k)*1.0 ; 
        fac_d= a(k,k)*1.0 ;
        factor = fac_u / fac_d;
        l(i,k) = factor;
        for j = k : n    %% 1:n
            i;
            j;
            k;
            a(i,j) = a(i,j) - factor*a(k,j);
            a;
        end
        %b(i) = b(i) - factor* b(k);  %%% msh b3ml li el (b) 7aga fi el lu
    end
end

%%% END OF FORWARD ELIMINATION

a;
b;

%disp('END OF FORWARD ELIMINATION')

for i = 1:n
   l(i,i) = 1 ;
end


u = a
l
b;


%%% FORWARD SUBSTITUTION

s_l=[];
s_l(1) = b(1)/l(1,1);
n;
for i = 2:n
    
    sum = 0;
    for j = 1:i-1
        i;
        j;
        l(i,j);
        s_l(j);
        sum = sum + l(i,j)*s_l(j);
    end
    s_l(i) = (b(i) - sum) / l(i,i);
end

s_l;

%%% END OF FORWARD SUBS


u;
s_l = s_l'; %% turn col row

%%% BACK SUBSTITUTION
s=[];
s(n) = s_l(n)/u(n,n);
n;
for i = n-1:-1:1
    
    sum = 0;
    for j = i+1:n
        i;
        j;
        u(i,j);
        s_l(j);
        sum = sum + u(i,j)*s(j);
    end
    s(i) = (s_l(i) - sum) / u(i,i);
end






s = s';
time = toc;


