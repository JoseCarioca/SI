%% Ruleta
function solution = RouletteSelection(F,dist,MAX_F,x)
%% F: fitness function
%% parents: selected populations
%% n: sum of fitness for calculation of probabilities.
%% sz: sz(1) = quantity of pop; sz(2) = length of individuals
sz = size(x);
table = zeros(sz(1),3);
parents = zeros(sz(1),sz(2));
n = 0;

%% fitness calculation
for i=1:sz(1)
   assert(numel(unique(x(i,:))) == sz(2), 'roulette input not a perm');
   table(i,1) = F(x(i,:),dist,MAX_F);
   n = n + table(i,1);
end

%% probabilites 
table(1,2) = table(1,1)/n; %% primera fuera del bucle
table(1,3) = table(1,2);
for i=2:sz(1)
   table(i,2) = table(i,1)/n; %prob
   table(i,3) = table(i-1,3) + table(i,2); %accumulative prob
end
%disp(table);
%% spins and selection
for i=1:sz(1)
    dart = rand();

    j = 1;
    while(dart>table(j,3))
        j = j + 1;
    end

parents(i,:) = x(j,:);

end
%% HERMANO QUE COJONES DE RESHAPE
solution = reshape(parents', [sz(2)*2,sz(1)/2])';
end

