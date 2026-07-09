function razao_bw = razaoLarguraBanda(controlador, planta)

    J = planta.J;
    g = planta.g;
    Kptheta = controlador.theta.Kp;
    Kvtheta = controlador.theta.Kv;
    Kpx = controlador.x.Kp;
    Kix = controlador.x.Ki;
    Kdx = controlador.x.Kd;

    Gftheta = tf(Kptheta*Kvtheta / J, [1, Kvtheta / J, Kptheta * Kvtheta / J]);

    % assume-se Gftheta = 1 para cálculo da banda passante de projeto de 
    % Gfx
    Gfx = tf(g * Kix, [1, g * Kdx, g * Kpx, g * Kix]);

    bw_theta = bandwidth(Gftheta);
    bw_x     = bandwidth(Gfx);
    razao_bw = bw_theta / bw_x;

end