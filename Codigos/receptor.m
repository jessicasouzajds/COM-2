% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 1: Modulacao OFDM
% DIA 27/08/2018
% Aluna: Jessica de Souza e Luisa Machado

% Questao 2 de 4

%% Entradas:
% y = sequência recebida do canal (y[n])
% N = número de subportadoras 
% mi = comprimento do prefixo cíclico (mi)
% h = coeficientes do canal (h[n])

%% Saída:
% X_til = sequência na saída do equalizador (X_til[k])

function X_til = receptor(y, N, mi, h)
  reshape_y = reshape(y, (N + mi), []);
  y_semPC = reshape_y((mi + 1): end, :);
  H = fft(h.', N);
  Y = fft(y_semPC, N);
  aux = Y ./ repmat(H, 1, size(Y, 2));
  
  X_til = reshape(aux, 1, []);
endfunction