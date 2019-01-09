% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 1: Modulacao OFDM
% DIA 27/08/2018
% Aluna: Jessica de Souza e Luisa Machado

% Questao 3 de 4

close all;
clear all;
clc;

% Modulacao BPSK.
% Canal de comunicacao dado por h[n] = [2 -0,5 0,5].
% Eb/No no RX variando de 0 a 10 dB, com passo de 1 dB.

% Definicao dos parametros
N = 16;   % Numero de subportadoras
mi = 4;   % Comprimento do prefixo ciclico
L = 50e3; % Numero de blocos OFDM transmitidos
h = [2 -0.5 0.5];

% Gerando a informacao, transformando para polar e transmitindo
info = randint(1, N*L, 2);
X = pskmod(info, 2);
x = transmissor(X, N, mi);
y = filter(h,1,x);  % convolucao antes de ir para Rx

Eb_No_max = 10;
for Eb_No = 0 : Eb_No_max
    info_rec = awgn(y, Eb_No, 'measured');
    X_til = receptor(info_rec, N, mi, h);
    info_demod = pskdemod(X_til, 2);
    
    % BER (Taxa de erro):
    [num_erro(Eb_No + 1), taxa_erro(Eb_No + 1)] = biterr(info, info_demod>0);
    Pb(Eb_No + 1) = qfunc(sqrt(2*10^(Eb_No/10)));
end

% Plotando os resultados
semilogy([0:Eb_No_max],taxa_erro,'r',"linewidth", 3)
hold on
semilogy([0:Eb_No_max],Pb,"linewidth", 3)
title('Pb');
ylabel('BER');
xlabel('Eb/N0 [dB]');
legend('Pratico', 'Teorico', 'Location', 'southwest')
hold off