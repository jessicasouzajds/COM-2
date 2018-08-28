% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 1: Modulacao OFDM
% DIA 27/08/2018
% Aluna: Jessica de Souza e Luisa Machado

% Questao 1 de 4
    
function x = transmissor(X, N, mi)
  reshape_X = reshape(X, [N, length(X)/N]);   
  x_semPC = ifft(reshape_X);
  aux = x_semPC(N - mi + 1: end, :);
  x_comPC = [aux; x_semPC];

  x = reshape(x_comPC, 1, []);
endfunction