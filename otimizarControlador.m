%% adicionar arquivos ao path
addpath("cmaes\", "planta\", "simulacao\", "utils\", "baseline\");

%% parametros da planta
planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();

%% obtencao do controlador baseline

% ganhos otimos apos grid search (lab 4)
% controlador_baseline.theta.Kp = 23.350691838712070;
% controlador_baseline.theta.Kv = 1.779312628981916;
% controlador_baseline.x.Ki = 8.200807845518947;
% controlador_baseline.x.Kd = 1.232376482779303;
% controlador_baseline.x.Kp = 3.990272085271330;
% controlador_baseline.z.Ki = 43.541068251647779;
% controlador_baseline.z.Kd = 6.303045015600226;
% controlador_baseline.z.Kp = 21.051223138217715;

% ganhos analiticos
controlador_baseline = projetarControladorMulticoptero(requisitos, planta);

%% inicializacao de hiperparametros do CMA-ES
m0 = log([controlador_baseline.theta.Kp, controlador_baseline.theta.Kv, ...
    controlador_baseline.x.Ki, controlador_baseline.x.Kd, ...
    controlador_baseline.x.Kp, controlador_baseline.z.Ki, ...
    controlador_baseline.z.Kd, controlador_baseline.z.Kp]');

sigma0 = 0.5;

max_iter = 5;

%% rodar CMA-ES para obter controlador otimo
[controlador_opt, historico] = cmaesMulticoptero(planta, m0, sigma0, ... 
    max_iter);

%% escolher ganhos

% escolher ultima amostra da iteracao
% controlador_cmaes = controlador_opt.mean; 

% escolher amostra com menor funcao de custo
controlador_cmaes = controlador_opt.best; 

%% escolher experimento para analise
experimento = 'a';
% experimento = 'b';
% experimento = 'c';
% experimento = 'd';
% experimento = 'e';
% experimento = 'f';
% experimento = 'g';

parametros = obterParametrosExperimento(experimento);

%% gerar simulacao com o controlador otimo
simulacao = simularMulticoptero(controlador_cmaes, planta, parametros);

%% tracar graficos da simulacao
tracarGraficosSimulacao(simulacao);

%% gerar animacao
fazerAnimacaoMulticoptero(simulacao, planta);