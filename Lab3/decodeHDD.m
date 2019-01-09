% Função que realiza a decodificação de uma sequência binária 
% recebida via sindrome
function u_hat = decodeHDD(b, args)
    % Argumentos:
    % b = Sequência binária recebida
    % args = Representação do código

    % Transpõe a matriz H
    H_t = args.h.';

    for ii = 1:size(b, 1)
        % Multiplica pela sequência binária
        s = b(ii, 1:end) * H_t;
        S = mod(s, 2);

        % Encontra a posição correspondente na LUT
        LUT = args.lut;
        pos = find(ismember(LUT.s, S, 'rows'));
        e_hat = LUT.e_hat(pos, :);

        % Faz o XOR do valor encontrado com a sequência
        c_hat(ii, 1:args.n) = xor(e_hat, b(ii, 1:end));
    end

    % Obtém apenas os primeiros k dígitos correspondentes à informação
    u_hat = c_hat(1:end, 1:args.k);

end
