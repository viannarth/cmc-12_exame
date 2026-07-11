function J = custoMulticoptero(m, m0, planta, custo_baseline)

J_bounds = custoLimites(m, m0);

controlador = obterControlador(m);

J_bw = custoBandaPassante(controlador, planta);

% flag se houve divergencia na simulacao
divergencia = false;

% avaliacao nos cenarios
experimentos = ['a', 'b', 'd', 'e'];

J_rastreamentos = zeros(length(experimentos), 1);
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    try
        simulacao = simularMulticoptero(controlador, planta, parametros);
        J_rastreamentos(i) = custoRastreamento(simulacao) / custo_baseline(i);
    catch
        divergencia = true;
        % logging da divergencia
        fprintf('Divergencia com m = [%s]\n', num2str(m'));
    end
end

J = J_bounds + J_bw + mean(J_rastreamentos);

if divergencia
    J = J + 1e4; % penalidade agressiva se houver divergencia
end

end