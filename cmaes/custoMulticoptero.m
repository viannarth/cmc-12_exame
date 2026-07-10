function J = custoMulticoptero(m, planta)

controlador = obterControlador(m);

experimentos = ['a', 'b', 'd', 'e'];

margem_bw = 5;
razao_bw = razaoLarguraBanda(controlador, planta);
J_bw = 50 * max(0, margem_bw - razao_bw);

J_rastreamentos = zeros(length(experimentos), 1);
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    simulacao = simularMulticoptero(controlador, planta, parametros);
    J_rastreamento = custoRastreamento(simulacao, experimentos);
    J_rastreamentos(i) = J_rastreamento;
end

J = J_bw + mean(J_rastreamentos);

end