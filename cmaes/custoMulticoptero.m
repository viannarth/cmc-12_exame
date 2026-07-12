function J = custoMulticoptero(m, m0, planta, custo_baseline)

J_bounds = custoLimites(m, m0);

controlador = obterControlador(m);

J_bw = custoBandaPassante(controlador, planta);

% avaliacao nos cenarios
experimentos = ['a', 'b', 'd', 'e', 'f'];

J_rastreamentos = zeros(length(experimentos), 1);
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    simulacao = simularMulticoptero(controlador, planta, parametros);
    J_rastreamentos(i) = custoRastreamento(simulacao) / custo_baseline(i);
end

J = J_bounds + J_bw + mean(J_rastreamentos);

end