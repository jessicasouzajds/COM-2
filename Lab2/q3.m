% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 2: Modulação por Espalhamento Espectral - DSSS
% DIA 28/09/2018
% Alunas: Jessica de Souza e Luísa Machado

% Questao 3 de 4

clear all;
close all;
clc;

%% ex 7.1 livro
gerador([3 1],[1 0 0])

%% ex 7.2 (a) livro
gerador([5 2],[1 0 0 0 0])

%% ex 7.2 (b) livro
estado = [1 0 0 0 0];
taps = [5 4 2 1];
seq = gerador(taps, estado);
m = length(estado);
T_max = 2^m -1;

% Fazendo a autocorrelação
c_t = (seq*2)-1; % Codifica o sinal para NRZ
axis_x = -T_max-1:T_max+1;

j = 1;
for i = axis_x(1):axis_x(end)
  c_t_tau = circshift(c_t,i,2);
  autocor(j) = ((sum(c_t.*c_t_tau))/axis_x(end-1));
  j = j+1;  
end

%% Plotando a autocorrelacao
figure,stem(axis_x,autocor,'r');
ylabel('R_c(\tau)');
axis([axis_x(1) axis_x(end) -0.2 1.2]);

%% Autocorrelação com sequencia aleatoria
    info = randi([0 1], 1, 31);

    % Fazendo a autocorrelação
    c_t = (info*2)-1;
    axis_x = -length(info)-1:length(info)+1;

    j = 1;
    for i = axis_x(1):axis_x(end)
        c_t_tau = circshift(c_t,i,2);
        autocor(j) = ((sum(c_t.*c_t_tau))/axis_x(end-1));
        j = j+1;  
    end

    %% Plotando a autocorrelação
    figure,stem(axis_x,autocor,'r')
    ylabel('R_c(\tau)')
    axis([axis_x(1) axis_x(end) -0.2 1.2]);