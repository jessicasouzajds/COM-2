function cod_ham74 = fun_ham(n, k)
% Função que obtem parametros de Hamming
p = [1 1 0
     1 0 1
     0 1 1
     1 1 1];

g = [eye(size(p ,1)) p];

h = [p' eye(size(p' ,1))];

e_hat = [0 0 0 0 0 0 0; eye(7)];

s = e_hat * h';

lut = struct('s', s, 'e_hat', e_hat);

u = de2bi(0:15, 4);
c = mod(u * g, 2);

cod_ham74 = struct('n', n, 'k', k, 'g', g, 'h', h, 'c', c, 'lut', lut);

end