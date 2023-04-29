%% COMPARATIVA AG

%% inicializacion de variables
s = rng(1);
N=15;
Pob=30;
MAX_ITERACIONES=2000;
TAM = 10;
MAX_F = N*TAM;
muestra = 50; %conteo para hacer una media
%cordenadas x&y de las ciudades
ciudades = TAM*rand(N,2);

% si se quiere ver las ciudades:
figure
plot(ciudades(:,1),ciudades(:,2), '+')


%% AG
BestSolution = zeros(1,N+1);
AvgSolution = 0;
Tiempo = 0;
AvgTime = 0; %media tiempo empleado
for i=1:muestra
    rng(i*5);
    tic;
    sol = TSP(ciudades,N,Pob,MAX_ITERACIONES);
    %[sol,itera,estancado] = pso(NReinas,NTableros,MAX_ITERACIONES);
    if(BestSolution(N+1)<sol(N+1)) 
        BestSolution = sol;
        disp(BestSolution(N+1));
    end
    Tiempo = Tiempo + toc;
    AvgSolution = AvgSolution + sol(N+1);
end
AvgTime = Tiempo/muestra;
AvgSolution = AvgSolution/muestra;
fprintf('Para %d ciudades, %d individuos, %d iteraciones y muestra de %d\n',N,Pob,MAX_ITERACIONES,muestra);
fprintf('mejor solucion: %d, distancia = %d \n',BestSolution(N+1),MAX_F-BestSolution(N+1));
fprintf('media tiempo: %d\n',AvgTime);
fprintf('media solucion: %d\n',AvgSolution);
fprintf('Distancia media: %d\n',MAX_F - AvgSolution);

figure
plot(ciudades(BestSolution(1:N),1),ciudades(BestSolution(1:N),2), '*-')
