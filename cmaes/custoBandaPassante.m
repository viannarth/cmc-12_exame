function J_bw = custoBandaPassante(controlador, planta)

J = planta.J;
g = planta.g;
Kptheta = controlador.theta.Kp;
Kvtheta = controlador.theta.Kv;
Kix = controlador.x.Ki;
Kdx = controlador.x.Kd;
Kpx = controlador.x.Kp;

Gftheta = tf(Kptheta*Kvtheta / J, [1, Kvtheta / J, Kptheta * Kvtheta / J]);

% assume-se Gftheta = 1 para calculo da banda passante de projeto de 
% Gfx
Gfx = tf(g * Kix, [1, g * Kdx, g * Kpx, g * Kix]);

bw_theta = bandwidth(Gftheta);
bw_x     = bandwidth(Gfx);
razao_bw = bw_theta / bw_x;

% manter a razao de bandas passantes em uma faixa razoavel para que a malha
% de arfagem seja suficientemente rapida, mas nao rapida demais
max_bw = 15;
min_bw = 5;

J_bw = 50 * max(0, min_bw - razao_bw) + 20 * max(0, razao_bw - max_bw);

end