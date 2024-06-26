%% TRAVELING SALESMAN PROBLEM COMPARISON
function solution = TSP(ciudades,N,Pob,maxAttempts)
%% parámetros
%Numero de ciudades
%N =5; 
%Numero de individuos
%Pob = 8;
%las ciudades se encuentran en un mapa TAM^2
TAM = 10;
%max iteraciones
%maxAttempts = 1000;
%peor distancia posible (cambiado a otro num)
%MAX_F = N*(sqrt(2*(TAM^2)));
MAX_F = N*TAM;

%rng(0) %descomentar para pruebas 

%matriz de distancias
distancias = dist_euclidea(ciudades);
%disp(distancias);
solution = zeros(1,N+1);
%% población inicial
x = zeros(Pob,N);
for i=1:Pob
    x(i,:) = randperm(N);
end



% fitness = zeros(1,Pob);
% for i=1:Pob
%     fitness(i) = fitness_TSP(x(i,:),distancias,MAX_F);
% end
%disp(fitness);

while( maxAttempts > 0 ) %añadir mas condiciones
    %% fitness and selection
    parents = x; %save the previous pop
    %selected = RouletteSelection(@fitness_TSP,distancias,MAX_F, x);
    selected = Tournament(@fitness_TSP,distancias,MAX_F, x,3); %k = 3 de momento
    
    %% crossover
    for i=1:Pob/2
        assert(numel(unique(selected(i,1:N))) == N, 'roulette output not a perm1');
        assert(numel(unique(selected(i,N+1:end))) == N, 'roulette output not a perm2');
        %x(2*i-1:2*i,:) = PMX2(reshape(selected(i,:), [N, 2])'); %nota: pmx keeps some conflicts nota2:not anymore

        x(2*i-1:2*i,:) = OX2(reshape(selected(i,:), [N, 2])'); %nota: pmx keeps some conflicts nota2:not anymore
        assert(numel(unique(x(2*i-1,:))) == N, 'X output not a perm1');
        assert(numel(unique(x(2*i,:))) == N, 'X output not a perm2');
    end
    %disp(x);
    %% mutation?
    x = simple_mutation(x);

    %% replacement
    %Generational (do nothing)
    %......%

    % elite / comment this for generational replacement
    fitness = zeros(1,Pob*2);
    elite = vertcat(parents, x);
    for i=1:Pob*2
        fitness(i) = fitness_TSP(elite(i,:),distancias,MAX_F);
        assert(numel(unique(elite(i,:))) == N, 'mutation ¿? output not a perm %i');
    end

    [~,idx] = sort(fitness, 'descend'); %index order by fitness
    %select the pob best individuals
    for i=i:Pob
        x(i,:) = elite(idx(i),:);
    end
    %elite end

    %% stopping criteria
    %MaxAttempts DO NOTHING

    % convergence ? TODO

    
    %keep tracking
    solution = [elite(idx(1),:) fitness(idx(1))];
    %disp(solution);
    maxAttempts = maxAttempts - 1;

end
end



function sol = dist_euclidea(x)
n = length(x);
sol = eye(n);
sol(logical(sol)) = Inf;
for i=1:n-1
    for j=i+1:n
        sol(i,j) = sqrt((x(i,1) - x(j,1))^2 + (x(i,2) - x(j,2))^2);
        sol(j,i) = sol(i,j); %se guardan valores en ambas diagonales para facil acceso
    end
end
end


