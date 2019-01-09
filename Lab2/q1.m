% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 2: Modulação por Espalhamento Espectral - DSSS
% DIA 28/09/2018
% Alunas: Jessica de Souza e Luísa Machado

% Questao 1 de 4

close all
clear all
clc

% Especificações:
Nb = 1000; % Número de bits transmitidos
L = 200;   % Código: pseudo-aleatório de período
N = 10;    % Número de chips por bit de informação
fc = 40e3; % Hz - Modulação BPSK
spc = 100; % Número de amostras por chip
Rb = 1e3;  % bit/s - Taxa de bits

% Gerando a informação:
bits = randi([0 1], 1, Nb);
info_polar = (bits .* 2) - 1;

% Superamostrando a informação:
spb = spc * N;
x_t = kron(info_polar, ones(1, spb));

% Gerando o código de espalhamento:
codigo = randi([0 1], 1, L);
codigo_polar = (codigo .* 2) - 1;

% Super amostrando o código:
codigo_up = kron(codigo_polar, ones(1, spc));
ft_repmat = length(x_t)/length(codigo_up);
c_t = repmat(codigo_up,[1 ft_repmat]);

% Espalhando o sinal:
s_t = x_t .* c_t;

% Vetor de tempo:
t = ((0:(length(x_t)-1))/length(x_t));
Tb = 1/Rb;

% Vetor de frequência:
fa = Rb * spb;
f = [-fa/2:(fa/2)-1];

% Obtendo a forma espectral
bpsk = cos(2*pi*fc*t);
s_bpsk = s_t .* bpsk;

S_f = fftshift(fft(s_t));
S_bpsk = fftshift(fft(s_bpsk));
C_f = fftshift(fft(c_t));
X_f = fftshift(fft(x_t));


%% Plotando os resultados

% Figura de saída 1:
figure,
    x(1) = subplot(411)
    plot(t, x_t)
    xlim([0 4*Tb])
    ylim([-1.5 1.5])
    title('x(t)');
    
    x(2) = subplot(412)
    plot(t, c_t)
    xlim([0 4*Tb])
    ylim([-1.5 1.5])
    title('c(t)');
   
    x(3) = subplot(413)
    plot(t, s_t)
    xlim([0 4*Tb])
    ylim([-1.5 1.5])
    title('s(t)');
    
    x(4) = subplot(414)
    plot(t, s_bpsk)
    xlim([0 4*Tb])
    ylim([-1.5 1.5])   
    title('s_{bpsk}(t)');
 linkaxes(x,'x');

% Figura de saída 2:

figure,
    y(1)=subplot(411)
    plot(f, abs(C_f))
    title('C(f)');
    xlim([-60000 60000]);

    y(2)=subplot(412)
    plot(f, abs(X_f))
    title('X(f)');
    xlim([-60000 60000]);

    y(3)=subplot(413)
    plot(f, abs(S_f))
    title('S(f)');
    xlim([-60000 60000]);

    y(4)=subplot(414)
    plot(f, abs(S_bpsk))
    title('S_{bpsk}(f)');
    xlim([-60000 60000]);
linkaxes(y,'x');