% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 3: Códigos de Bloco
% DIA 01/10/2018
% Aluna: Jessica de Souza e Luísa Machado

% Questao 2 de 3

clear all;
close all;
clc;

% Parametros
b = [1 0 1 1 0 0 0];
b_polar = (b * 2) - 1;
args = fun_ham(7, 4);

% Chama o decodificador
u_hat = decodeSDD(b_polar, args)