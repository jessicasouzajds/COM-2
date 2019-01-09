% --- SISTEMAS DE COMUNICACAO 2 ---
% Trabalho 2: Modulação por Espalhamento Espectral - DSSS
% DIA 28/09/2018
% Alunas: Jessica de Souza e Luísa Machado

% Questao 2 de 4

clear all;
close all;
clc;

% Especificações:
L = 4;
N = 4;
Rb = 200e3; % bit/s - Taxa de bits
spc = 50; % Número de amostras por chip
tot = 8; %total de bits transmitidos

% Bits de informação
u1 = [0 0];
u2 = [1 0];
u3 = [0.5 0.5];
u4 = [0 1];

% Polarizando a informação
U1 = 2*u1-1;
U2 = 2*u2-1;
U3 = 2*u3-1;
U4 = 2*u4-1;

% Superamostrando a informação:
spb = spc * N;
x_t1 = kron(U1, ones(1, spb));
x_t2 = kron(U2, ones(1, spb));
x_t3 = kron(U3, ones(1, spb));
x_t4 = kron(U4, ones(1, spb));

% Gerando o código de espalhamento:
code = hadamard(N);
codigo_u1 = kron(code(1,:), ones(1, spc));
codigo_u2 = kron(code(2,:), ones(1, spc));
codigo_u3 = kron(code(3,:), ones(1, spc));
codigo_u4 = kron(code(4,:), ones(1, spc));

% Superamostrando o código:
ft_repmat1 = length(x_t1)/length(codigo_u1);
ft_repmat2 = length(x_t2)/length(codigo_u2);
ft_repmat4 = length(x_t3)/length(codigo_u3);
ft_repmat3 = length(x_t4)/length(codigo_u4);

c_t1 = repmat(codigo_u1,[1 ft_repmat1]);
c_t2 = repmat(codigo_u2,[1 ft_repmat2]);
c_t3 = repmat(codigo_u3,[1 ft_repmat3]);
c_t4 = repmat(codigo_u4,[1 ft_repmat4]);

% Espalhando o sinal:
s_t1 = x_t1 .* c_t1;
s_t2 = x_t2 .* c_t2;
s_t3 = x_t3 .* c_t3;
s_t4 = x_t4 .* c_t4;

%canal s_t
s_t = s_t1 + s_t2 + s_t3 + s_t4;

% Vetor de tempo:
t = ((0:(length(x_t1)-1))/length(x_t1));
Tb = 1/Rb;

% Recuperando o sinal separado
y1 = s_t.*c_t1;
y2 = s_t.*c_t2;
y3 = s_t.*c_t3;
y4 = s_t.*c_t4;

% Fazendo o correlator
pulse = ones(1,spb)/spb;
cor1 = filter(pulse,1,y1);
cor2 = filter(pulse,1,y2);
cor3 = filter(pulse,1,y3);
cor4 = filter(pulse,1,y4);


% Obtendo a saida dos correlatores
vect = ones(1,length(t)/2);

%u1
var_u1 = cor1(spb:spb:end);
var1_u1 = var_u1(1)*vect;
var2_u1 = var_u1(2)*vect;
u1 = [var1_u1 var2_u1];

%u2
var_u2 = cor2(spb:spb:end);
var1_u2 = var_u2(1)*vect;
var2_u2 = var_u2(2)*vect;
u2 = [var1_u2 var2_u2];

%u3
var_u3 = cor3(spb:spb:end);
var1_u3 = var_u3(1)*vect;
var2_u3 = var_u3(2)*vect;
u3 = [var1_u3 var2_u3];

%u4
var_u4 = cor4(spb:spb:end);
var1_u4 = var_u4(1)*vect;
var2_u4 = var_u4(2)*vect;
u4 = [var1_u4 var2_u4];


%% Plotando os resultados

% (1) De x_1(t) a x_4(t)
figure,
    x(1)=subplot(411)
    plot(t,x_t1)
    title('x_1(t)');
    ylim([-2 2])

    x(2)=subplot(412)
    plot(t, x_t2)
    title('x_2(t)');
    ylim([-2 2])

    x(3)=subplot(413)
    plot(t,x_t3)
    title('x_3(t)');
    ylim([-2 2])

    x(4)=subplot(414)
    plot(t, x_t4)
    title('x_4(t)');
    ylim([-2 2])
linkaxes(x,'x');

% (2) De s_1(t) ate s_4(t)
figure,
    y(1)=subplot(411)
    plot(t,s_t1)
    title('s_1(t)');
    ylim([-2 2])

    y(2)=subplot(412)
    plot(t, s_t2)
    title('s_2(t)');
    ylim([-2 2])

    y(3)=subplot(413)
    plot(t,s_t3)
    title('s_3(t)');
    ylim([-2 2])

    y(4)=subplot(414)
    plot(t, s_t4)
    title('s_4(t)');
    ylim([-2 2])
linkaxes(y,'x');

% (3) r_t(t)
figure, plot(t,s_t);
title('r(t) sem ruido');
ylim([-3.5 3.5])

% (4) De y_1(t) a y_4(t)
figure,
    x(1)=subplot(411)
    plot(t,y1)
    title('y_1(t)');

    x(2)=subplot(412)
    plot(t, y2)
    title('y_2(t)');

    x(3)=subplot(413)
    plot(t,y3)
    title('y_3(t)');

    x(4)=subplot(414)
    plot(t, y4)
    title('y_4(t)');
linkaxes(x,'x');

% (5) Saida dos correlatores
figure,
    subplot(221), plot(t,u1);
    title('U_1');
    ylim([-2 2]);

    subplot(222), plot(t,u2);
    title('U_2');
    ylim([-2 2]);

    subplot(223), plot(t,u3);
    title('U_3');
    ylim([-2 2]);

    subplot(224), plot(t,u4);
    title('U_4');
    ylim([-2 2]);