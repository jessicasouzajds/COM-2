% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 1: Modulacao OFDM
% DIA 27/08/2018
% Aluna: Jessica de Souza e Luisa Machado

% Questao 1 e questao 2 de 4

clear all;
close all;
clc;

% Definicao dos parametros
X = [1 1 -1 -1 -1 1 -1 1];  % X[k]
N = 4;                      % Numero de subportadoras
mi = 2;                     % Comprimento do prefixo ciclico

% Variacao do h[n] - Questao 2
%h = [1];
%h = [1 0.25];
h = [1 0.25 0.5];
%h = [1 0.25 0.5 0.25];

% Questao 1
x = transmissor(X, N, mi)

% Convolucao (prepara para enviar para o receptor)
y = filter(h,1,x);

% Questao 2
X_til = receptor(y, N, mi, h)