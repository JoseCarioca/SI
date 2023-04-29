function offs=OXcrossover(p)

% p: two parents to cross
% f1 & f2: crossover points
% offs: two offsprings
N=length(p);
f1=ceil(25*N/100); 
f2=floor(75*N/100);
assert(numel(unique(p(1,:))) == N, 'not valid input in row 1)');
assert(numel(unique(p(2,:))) == N, 'not valid input in row 2)');  
offs = zeros(2,N);
 
% Copiar valores entre f1:f2 a hijos
offs(1,f1:f2)=p(1,f1:f2);
offs(2,f1:f2)=p(2,f1:f2);


 p1=1;
 while p1<=2
     p2=mod(p1,2)+1;
     j=f2+1;  
     k=f2+1;
     while j~=f1
        %ver conflictos
        cand = (p(p2,k) == offs(p1,:));
        if cand == 0
            offs(p1,j)=p(p2,k);
            %laps
            j=mod(j,N)+1;
        end
        k=mod(k,N)+1;
     end
     p1=p1+1;
 end
assert(numel(unique(offs(1,:))) == N, 'not valid solution1');
assert(numel(unique(offs(2,:))) == N, 'not valid solution2');
end
 
 
 