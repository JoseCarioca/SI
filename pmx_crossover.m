function offs=pmx_crossover(p)
%% This function will be PMXcrossover  OR  OXcrossover
%% p: two parents to cross, a parent per row

%% offs: two offsprings, a child per row
%p = [1	2	4	3	5; 5	2	3	1	4] %increible conflicto con este
%% Follow the example and complete with the apropriate instructions
%p = [1 2 3 4 5 6 7  8 9;  4 5 2 1 8 7 6  9 3]  ;
%p =  [1 4 2 5 3; 3 2 5 4 1];
N=length(p);
assert(numel(unique(p(1,:))) == N, 'not valid input in row 1)');
assert(numel(unique(p(2,:))) == N, 'not valid input in row 2)');
%% f1 & f2: crossover points 
f1=ceil(25*N/100); 
f2=floor(75*N/100);
%% offspring
offs = zeros(2,N);
%% Copy values between f1:f2
offs(1,f1:f2)=p(2,f1:f2);
offs(2,f1:f2)=p(1,f1:f2);

ic = [offs(1,f1:f2);offs(2,f1:f2)]; %no me los guardo, al final necesito
em = [(1:f1-1) (f2+1:N)]; %indexes to fill up

%% rellenar offs1 y offs2
for p1=1:2
    p2 = mod(p1,2) + 1;
    for j = em
        c = p(p1,j); %candidate
        
        while any(ic(p2,:) == c) %while conflicts 
            c = ic(p1,(ic(p2,:) == c)); % look for swapped value -> new candidate 
        end
        offs(p1,j) = c; %asignamos candidato a posicion vacía
    end
end
    
assert(numel(unique(offs(1,:))) == N, 'not valid perm in row 1)');
assert(numel(unique(offs(2,:))) == N, 'not valid perm in row 2)');
end
