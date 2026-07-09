function controlador = obterControlador(m)

controlador.theta.Kp = exp(m(1));
controlador.theta.Kv = exp(m(2));
controlador.x.Ki = exp(m(3));
controlador.x.Kd = exp(m(4));
controlador.x.Kp = exp(m(5));
controlador.z.Ki = exp(m(6));
controlador.z.Kd = exp(m(7));
controlador.z.Kp = exp(m(8));

end