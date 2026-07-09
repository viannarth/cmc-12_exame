function J = custoMulticoptero(m, planta)

controlador = obterControlador(m);

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