%% Tournament
function solution = Tournament(F,x,k)
%% F: fitness function
%% parents: selected populations
%% k: individuals fighting
%% sz: sz(1) = quantity of pop; sz(2) = length of individuals
[q,L] = size(x);
fitness = zeros(1,q);
winners = zeros(1,q);
solution = zeros(q/2,L*2); %already reshaped

%% fitness calculation
for i=1:q
   fitness(i) = F(x(i,:)); 
end
%% perform tournament
randnums = randi([1,q],q,k); %each row are competitors
% fitness of every competitor
competition = zeros(q,k);
for i=1:q
    for j=1:k
        competition(i,j) = fitness(randnums(i,j));
    end
end

%% selection
[~,idx] = max(competition,[],2);
for i=1:q/2
    solution(i,1:L) = x(randnums(idx(2*i-1)),:); %save first pair
    solution(i,L+1:end) = x(randnums(idx(2*i)),:); %save second pair
end

end

