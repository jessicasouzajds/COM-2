% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 1: Modulacao OFDM
% DIA 27/08/2018
% Aluna: Jessica de Souza e Luisa Machado

% Questao 4 de 4

close all;
clear all;
clc;

% Modulação BPSK.
% Canal de comunicação dado por h[n] = [2/sqrt(5) 0 1/sqrt(5)].
% Ausência de ruído.

% Definicao dos parametros
Rb = 16e6;   % Taxa de bits de informação
N = 64;      % Número de subportadoras
mi = 16;     % Comprimento do prefixo cíclico
L = 100;     % Número de blocos OFDM transmitidos
h = [2/sqrt(5) 0 1/sqrt(5)];
Nsamp = 5;   % Para a interpolacao
Tb = 1/Rb;   % Tempo de bit

info = randint(1, N*L, 2);
X = pskmod(info, 2);
x = transmissor(X, N, mi);

% convolucao (preparando para o receptor)
y = filter(h,1,x);

% superamostrando o sinal para a interpolacao
xx = resample(x,Nsamp,1);
yy = resample(y,Nsamp,1);

% vetor de tempo:
aux = mi/N; % considera o PC para taxa de simbolos
fa = Nsamp * Rb * (1 + aux);
t = (0:(length(xx)-1))/length(xx);

% vetor de frequencia:
f = (t.*fa)-fa/2;

% Transformada de Fourier inversa
XX = fftshift(fft(xx));
YY = fftshift(fft(yy));

% Plotando os resultados
figure,
subplot(211),plot(t,xx);
xlim([0 0.01])
ylim([-0.4 0.4]);
subplot(212),plot(f,10*log10(abs(XX)));

figure,
subplot(211),plot(t,yy);
xlim([0 0.01])
ylim([-0.4 0.4]);
subplot(212),plot(f,10*log10(abs(YY)));