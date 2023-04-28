function x = simple_mutation(x)
%mutacion por individuo
Npob = size(x,1);
length = size(x,2);
rate = 1/length;
random = rand(Npob,length);

for i=1:Npob
    for j=1:length
        if random(i,j) < rate
            r = randi(length);
            aux = x(i,j);
            x(i,j) = x(i,r); %cambiamos elemento por otro aleatorio de la misma fila
            x(i,r) = aux;
        end
    end
end

end