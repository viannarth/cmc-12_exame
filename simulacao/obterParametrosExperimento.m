function parametros = obterParametrosExperimento(experimento)
% parametros = simularExperimentoMulticoptero(experimento) obtem os 
% parametros para a simulacao de um cenario de voo do multicoptero. A 
% entrada da funcao eh o caractere experimento, que indica qual experimento 
% deve ser executado. A saida eh a struct parametros com os valores de 
% referencia das posicoes x e y e com a carga ou o vento, alem do tempo 
% total de simulacao.
% A saida parametros eh dada por:
% parametros.tf: tempo final da simulacao.
% parametros.xr: referencia de posicao x (usada num bloco From Workspace).
% parametros.zr: referencia de posicao z (usada num From Workspace).
% parametros.carga: carga adicionado ao multicoptero em t = 3 s.
% parametros.ventoX: vento na direcao x acionado em t = 3 s.
% parametros.experimento: experimento executado.

tf = 10;
parametros.xr.signals.dimensions = 1;
parametros.zr.signals.dimensions = 1;
dt = 1e-3;

if experimento == 'a'
    parametros.xr.time = [0; tf];
    parametros.xr.signals.values = [0; 0];
    parametros.zr.time = [0; tf];
    parametros.zr.signals.values = [1; 1];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = 0;
elseif experimento == 'b'
    parametros.xr.time = [0; 1 - dt; 1; tf];
    parametros.xr.signals.values = [0; 0; 1; 1];
    parametros.zr.time = [0; tf];
    parametros.zr.signals.values = [1; 1];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = 0;
elseif experimento == 'c'
    parametros.xr.time = [0; 1 - dt; tf];
    parametros.xr.signals.values = [0; 0; 4];
    parametros.zr.time = [0; tf];
    parametros.zr.signals.values = [1; 1];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = 0;
elseif experimento == 'd'
    parametros.xr.time = [0; tf];
    parametros.xr.signals.values = [0; 0];
    parametros.zr.time = [0; tf];
    parametros.zr.signals.values = [1; 1];
    parametros.tf = tf;
    parametros.carga = 0.2;
    parametros.ventoX = 0;
elseif experimento == 'e'
    parametros.xr.time = [0; 1 - dt; tf];
    parametros.xr.signals.values = [0; 0; 4];
    parametros.zr.time = [0; tf];
    parametros.zr.signals.values = [1; 1];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = -2;
elseif experimento == 'f'
    tf = 10;
    t = (1+dt:dt:(tf-1))';
    parametros.xr.time = [0; 1; t; tf];
    parametros.xr.signals.values = [0; 0; cos(3 * 2 * pi * (t - 1) / (tf - 2) + pi / 2); 0];
    parametros.zr.time = [0; 1; t; tf];
    parametros.zr.signals.values = [2; 2; sin(2 * 2 * pi * (t - 1) / (tf - 2)) + 2; 2];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = 0;
elseif experimento == 'g'
    tf = 20;
    t = (1+dt:dt:(tf-1))';
    parametros.xr.time = [0; 1; t; tf];
    parametros.xr.signals.values = [0; 0; cos(3 * 2 * pi * (t - 1) / (tf - 2) + pi / 2); 0];
    parametros.zr.time = [0; 1; t; tf];
    parametros.zr.signals.values = [2; 2; sin(2 * 2 * pi * (t - 1) / (tf - 2)) + 2; 2];
    parametros.tf = tf;
    parametros.carga = 0;
    parametros.ventoX = 0;
end

% guardando o experimento
parametros.experimento = experimento;

end
