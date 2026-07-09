function J = custoMulticoptero(m, planta)

controlador.theta.Kp = exp(m(1));
controlador.theta.Kv = exp(m(2));
controlador.x.Ki = exp(m(3));
controlador.x.Kd = exp(m(4));
controlador.x.Kp = exp(m(5));
controlador.z.Ki = exp(m(6));
controlador.z.Kd = exp(m(7));
controlador.z.Kp = exp(m(8));

experimentos = ['a', 'b', 'c', 'd', 'e', 'f', 'g'];

margem_bw = 5;
razao_bw = razaoLarguraBanda(controlador, planta);
J_bw = 50 * max(0, margem_bw - razao_bw);

J = J_bw;
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    simulacao = simularMulticoptero(controlador, planta, parametros);
    J_rastreamento = custoRastreamento(simulacao);
    J = J + J_rastreamento;
end

end