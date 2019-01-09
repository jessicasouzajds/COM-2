function cod_gol2312 = fun_gol(n,k)

    % Função que obtem parametros de Golay
    m = [1 0 0 1 1 1 0 0 0 1 1 1;   % Pt
         1 0 1 0 1 1 0 1 1 0 0 1; 
         1 0 1 1 0 1 1 0 1 0 1 0; 
         1 0 1 1 1 0 1 1 0 1 0 0; 
         1 1 0 0 1 1 1 0 1 1 0 0;
         1 1 0 1 0 1 1 1 0 0 0 1; 
         1 1 0 1 1 0 0 1 1 0 1 0;
         1 1 1 0 0 1 0 1 0 1 1 0;
         1 1 1 0 1 0 1 0 0 0 1 1; 
         1 1 1 1 0 0 0 0 1 1 0 1; 
         0 1 1 1 1 1 1 1 1 1 1 1];

    p = m';
    g = [eye(size(p ,1)) p]; 
    h = [m eye(size(m ,1))];

    e_hat = syndtable(h);

    for i=1:length(e_hat)
        % Para saber qual o valor da síndrome em binário   
        s(i,:) = mod((e_hat(i,:) * h'),2);  
    end

    u = de2bi(0:4095, 12);
    c = mod(u * g, 2);

    lut = struct('s', s, 'e_hat', e_hat);
    cod_gol2312 = struct('n', n, 'k', k, 'g', g, 'h', h, 'c', c, 'lut', lut);
end
