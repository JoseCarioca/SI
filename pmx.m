function offs = pmx(p)
%% This function will be PMXcrossover  OR  OXcrossover
%% p: two parents to cross, a parent per row

%% offs: two offsprings, a child per row

%% Follow the example and complete with the apropriate instructions
%p = [1 2 3 4 5 6 7 8 9; 4 5 2 1 8 7 6 9 3];
N=length(p);
%% f1 & f2: crossover points 
f1=ceil(25*N/100); 
f2=floor(75*N/100); %esto es 75
%% offspring
offs = zeros(2,N);
%% Copy values between f1:f2
% intercambio del centro
offs(1,f1:f2)=p(2,f1:f2);
offs(2,f1:f2)=p(1,f1:f2);

ic = [offs(1,f1:f2);offs(2,f1:f2)];
%innecesario
%em=find(offs(1,:)==0); %% empty positions to fill up
em = [(1:f1-1) (f2+1:N)]; %indexes to fill up

%% rellenar offs1 y offs2
for i = em
    %values not in conflict
    chr1 = find(ic(1,:) == p(1,i),1);
    if(isempty(chr1))
        offs(1,i) = p(1,i);
    end
    chr2=find(ic(2,:) == p(2,i),1);
    if(isempty(chr2))
        offs(2,i) = p(2,i);
    end
    %conflicts replaced by the interchanges
    if(offs(1,i) == 0)
        offs(1,i) = ic(2,chr1);
    end
     if(offs(2,i) == 0)
        offs(2,i) = ic(1,chr2);
    end
end
assert(numel(unique(offs(1,:))) == N, 'not valid perm in row 1)');
assert(numel(unique(offs(2,:))) == N, 'not valid perm in row 2)');
%%
end