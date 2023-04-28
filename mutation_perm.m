function x = mutation_perm(x)
%% funcion mutacion de permutaciones (para N reinas u otro)
%% dimensiones de matrizç
%no funciona, comprobar mods y demas
Npob = size(x,1);
length = size(x,2);
rate = 1/length;
random = rand(Npob,length);
cambios = find(random < rate)'; %los indices en un matriz van hacia abajo jaja
for i = cambios
    fila = mod(i,Npob);
    if fila == 0
        fila = 5;
    end
    j=(randi(5) -1)*length + fila; %ind aleatorio en esa misma fila
    aux=x(i);
    x(i)=x(j);
    x(j)=aux;
end
end