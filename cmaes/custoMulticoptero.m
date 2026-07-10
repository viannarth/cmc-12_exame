function J = custoMulticoptero(m, planta)

controlador = obterControlador(m);

experimentos = ['a', 'b', 'd', 'e'];

margem_bw = 5;
razao_bw = razaoLarguraBanda(controlador, planta);
J_bw = 50 * max(0, margem_bw - razao_bw);

% flag se houve divergencia na simulacao
divergencia = false;
J_rastreamentos = zeros(length(experimentos), 1);
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    try
        simulacao = simularMulticoptero(controlador, planta, parametros);
        J_rastreamentos(i) = custoRastreamento(simulacao, experimentos);
    catch
        divergencia = true;
        % logging da divergencia
        fprintf('Divergencia com m = [%s]', num2str(m'));
    end
end

J = J_bw + mean(J_rastreamentos);

if divergencia
    J = J + 1e4; % penalidade agressiva se houver divergencia
end

end