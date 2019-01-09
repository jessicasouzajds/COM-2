% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 2: Modulação por Espalhamento Espectral - DSSS
% DIA 28/09/2018
% Alunas: Jessica de Souza e Luisa Machado

% Questao 4 de 4

close all
clear all
clc

% Especificações:
m = 7;            % Código: MLS com m = 7
N = 2^m - 1;      % Número de chips por bit de informação N igual ao período do código.
Nb = 1e3;         % Número de bits transmitidos  **trocar para 5
h = [2 -0.5 0.5]; % Canal de comunicação dado
Eb_No_max = 10;

% Gerando a informação:
info_raw = randi([0 1], 1, Nb);

% Formatando a informação
filtro_nrz = ones(1,N);
x_n_up = upsample(info_raw,N);
x_n=filter(filtro_nrz,1,x_n_up);

% Gerando o código:
c = gerador([7 1], [1 0 0 0 0 0 0]);
ft_repmat = length(x_n)/length(c);   
c_n = repmat(c,[1 ft_repmat]); % O código se repete até o fator de repmat

% Passa a informação pelo código e a transforma para polar
s_n = x_n .* c_n;   
s_polar = (s_n*2)-1;

% Passa a informação pelo canal
info_tx = filter(h, 1, s_polar);

for Eb_N0 = 1 : Eb_No_max
    Eb_N0_linear = 10^(Eb_N0/10);
    r_n = awgn(info_tx, 10*log10(2*(Eb_N0_linear)/N), 'measured');
 
    y_n = r_n .* c_n;
    
    pulse = ones(1,N)/N;
    cor = filter(pulse,1,y_n);
    var_u = cor(N:N:end);
    info_hat = (var_u > 0);
    
    % BER (Taxa de erro):
    [num_erro(Eb_N0 + 1), taxa_erro(Eb_N0 + 1)] = biterr(info_raw, info_hat);
    Pb(Eb_N0 + 1) = qfunc(sqrt(2*10^(Eb_N0/10)));
end

% Plotando os resultados
figure,
    x(1) = subplot(211)
    plot(info_raw)
    title('Info Gerada');
    x(2) = subplot(212)
    plot(info_hat)
    title('Info recebida');
linkaxes(x,'x');

figure,
semilogy([0:Eb_No_max], taxa_erro,'r')
hold on
semilogy([0:Eb_No_max], Pb)
title('Pb');
ylabel('BER');
xlabel('Eb/N0 [dB]');
legend('Prático', 'Teórico', 'Location', 'southwest')
hold off