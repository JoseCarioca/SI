function f = fitness_TSP(x,dist,MAX)
%% devuelve fitness (distancia total) de un individuo
% el max no es un valor maximo real, por si acaso...
n = length(x);
f = MAX - dist(x(1),x(n)); %cierra el camino
for i=1:n-1
    f = f - dist(x(i),x(i+1));
end
assert(f>0, 'error:negative fitness');

end

