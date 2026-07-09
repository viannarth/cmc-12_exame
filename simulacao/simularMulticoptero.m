function simulacao = simularMulticoptero(controlador, planta, parametros)
% simulacao = simularMulticoptero(controlador, planta, tf, xr, zr, carga, 
% ventoX) simula um voo do multicoptero.
% A entrada controlador eh dada por:
% controlador.theta.Kp: ganho proporcional do controlador horizontal.
% controlador.theta.Kv: ganho integrativo do controlador horizontal.
% controlador.x.Kp: ganho proporcional do controlador horizontal.
% controlador.x.Ki: ganho integrativo do controlador horizontal.
% controlador.x.Kd: ganho derivativo do controlador horizontal.
% controlador.z.Kp: ganho proporcional do controlador vertical.
% controlador.z.Ki: ganho integrativo do controlador vertical.
% controlador.z.Kd: ganho derivativo do controlador vertical.
% A entrada planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A entrada parametros eh dada por:
% parametros.tf: tempo final da simulacao.
% parametros.xr: referencia de posicao x (usada num bloco From Workspace).
% parametros.zr: referencia de posicao z (usada num From Workspace).
% parametros.carga: carga adicionado ao multicoptero em t = 3 s.
% parametros.ventoX: vento na direcao x acionado em t = 3 s.
% A saida eh a struct simulacao com as trajetorias geradas pela simulacao.

controlador.m = planta.m;
controlador.g = planta.g;

% Configurando as variaveis usadas no Simulink
assignin('base', 'xr', parametros.xr);
assignin('base', 'zr', parametros.zr);
assignin('base', 'x0', 0);
assignin('base', 'z0', 0);
assignin('base', 'theta0', 0);
assignin('base', 'controlador', controlador);
assignin('base', 'planta', planta);
assignin('base', 'carga', parametros.carga);
assignin('base', 'ventoX', parametros.ventoX);

% Carregando o Simulink
load_system('multicoptero');

% Configurando o tempo final de simulacao
set_param('multicoptero', 'StopTime', sprintf('%g', parametros.tf));

% Rodando a simulacao
simulacao = sim('multicoptero');
simulacao.experimento = parametros.experimento;

end
