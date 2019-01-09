% Função que realiza a decodificação de uma sequência binária 
% recebida via mínima distância Euclidiana ou máxima correlação
function u_hat = decodeSDD(r, code)
    % Argumentos:
    % r = Sequência de símbolos recebida
    % code = Representação do código

    % Transformando o código para polar
    c = 2 * code.c - 1;

    for ii = 1:size(r, 1)
        % Repetindo a sequência ao longo de todo o código
        rr = repmat(r(ii, 1:end), size(c, 1), 1);
      
        % Calcula a distância Euclidiana
        distE = sum((c - rr).^2, 2);
        % Encontra o índice da menor distância
        [valor_min indice] = min(distE);

        % Usa o indice para encontrar a palavra-código
        c_hat(ii, 1:code.n) = code.c(indice, :);
    end

    % Obtém apenas os primeiros k dígitos correspondentes à informação
    u_hat = c_hat(1:end, 1:code.k);

end
