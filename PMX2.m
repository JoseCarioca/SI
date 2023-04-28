function offs = PMX2(p)
 %p = [1 2 3 4 5 6 7 8 9; 4 5 2 1 8 7 6 9 3];
%p = [1	2	4	3	5; 5	2	3	1	4];
N=length(p);
f1=ceil(25*N/100); 
f2=floor(75*N/100);
assert(numel(unique(p(1,:))) == N, 'not valid input in row 1)');
assert(numel(unique(p(2,:))) == N, 'not valid input in row 2)');

offs = zeros(2,N);
% Copiar valores entre f1:f2 a hijos
offs(1,f1:f2) = p(2,f1:f2);
offs(2,f1:f2) = p(1,f1:f2);

ic = [p(1,f1:f2); p(2,f1:f2)];
%em = find(offs(1,:) == 0); % Posiciones vacias a rellenar
em = [(1:f1-1) (f2+1:N)]; %indexes to fill up
p1 = 1;
while p1 <= 2
    p2 = mod(p1,2) + 1;
    for j = em
        cand = p(p1,j); % Valor del candidato
        % Comprobar conflictos
        while any(ic(p2,:) == cand) % Mientras exista un valor conflictivo
            cand = ic(p1,(ic(p2,:) == cand)); % Buscamos el valor conflictivo de ese candidato y lo establecemos como candidato
        end
        offs(p1,j) = cand; % Asignamos a la posicion vacia del hijo evaluada el valor candidato
    end
    p1 = p1 + 1;
end
assert(numel(unique(offs(1,:))) == N, 'not valid solution1');
assert(numel(unique(offs(2,:))) == N, 'not valid solution2');
end

