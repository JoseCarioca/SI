function [x,d] = SA(x,distancias,N,maxAttempts)
%% x: recorrido actual
%% N: nº ciudades, Pob: nº individuos
%% distancias: matriz de distancias precalculadas
%% maxAttempts: iteraciones máximas posibles

%%T, T_min
T = 20; T_min = 0.01; delta=0; p=0;
d = fEval(x,distancias);
i=1;
while(T>T_min && d > 675 && maxAttempts > 0)
    if mod(maxAttempts, 1000) == 0
            disp("Iteracion: " + maxAttempts);
    end
    [newX, newD] = bestSuccessor(d,x,distancias,i);
    d = fEval(x,distancias); %actualizamos coste (distancia)
    delta = newD - d;
    if (delta < 0)
        x = newX; %guardamos un sucesor mejor
    else
        p = exp(-delta/T);
        disp('p es: ' + p);
        if(p>rand(0,1))
            x = newX; %lo guarda igualmente
        end
    end
    disp('t es:');
    disp(T);
    
    maxAttempts = maxAttempts - 1;
    i = mod(i,N)+1;
    T = T-(1000-maxAttempts+1);


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

  %%devuelve la permutacion con menor conflictos
function [x,d] =  bestSuccessor(d,x,distancias,k)
    %% d = distancia del recorrido
    %% x = recorrido de ciudades
    %% indice para swaps
    n = length(x);
    q=-1; 
    best = d; %number of conflict
        for i = 1:n
            if(i~=k)
                aux = x; %copia temporal del estado inicial
                aux([i,k]) = aux([k,i]); %swap del valor i y k
                d = feval(aux,distancias);
                if(d<=best) %el igual es para fomentar los cambios
                    best = d;
                    q = i; %guarda el indice del swap del mejor sucesor
                end
            end
        end
        if(q>0)
            x([q,k]) = x([k,q]); %realizamos el mejor intercambio
        else
            disp('no se encontró un mejor perm de q');
        end
end

