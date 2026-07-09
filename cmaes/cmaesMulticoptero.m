function controlador_opt = cmaesMulticoptero(planta, m0, sigma0, max_iter)

% inicializacao de parametros gerais
n = length(m0);
m = m0;
sigma = sigma0;

% iniciliazacao de parametros da selecao
lambda = 4 + floor(3*log(n));
mu = floor(lambda / 2);
w = (mu:-1:1)'; 
w = w / sum(w); % normalizacao
mueff = 1 / sum(w.^2);

% inicializacao de parametros da adaptacao
cc = 4 / n;
cs = 4 / n;
c1 = 2 / n^2;
cmu = mueff / n^2;

% restricao c1 + cmu <= 1
if (c1 + cmu > 1)
    cmu = 1 - c1;
end

% damping de sigma
ds = 1 + sqrt(mueff / n);

% inicializacao da matriz de covariancia e dos passos
C = eye(n);
pc = zeros(n, 1);
ps = zeros(n, 1);

% aproximacao do valor esperado da distribuicao ||N(0, I)||
chiN = sqrt(n) * (1 - 1/(4*n) + 1/(21*n^2));

% armazenando a melhor amostra
best_m = m0;
best_fitness = Inf;
for iter = 1:max_iter
    % decomposicao de C para amostragem e calculo de C^(-1/2)
    % C = B * D^2 * B'
    [B, D2] = eig(C);
    D2 = max(D2, 1e-14); % evita valor negativo/nulo por arredondamento
    D = sqrt(diag(D2));
    
    % matriz inversa da raiz quadrada: C^(-1/2) = B * D^(-1) * B'
    invsqrtC = B * diag(1 ./ D) * B';
    
    % avaliacao da amostra atual
    X = zeros(n, lambda);
    fitness = zeros(lambda, 1);
    for i = 1:lambda
        z = randn(n, 1);
        % adiciona mutacao por meio da distribuicao normal multivariada
        X(:, i) = m + sigma * (B * (D .* z)); 
        % avaliacao da amostra atual
        fitness(i) = custoMulticoptero(X(:, i), planta);
    end
    
    % ordenação da populacao (minimizacao)
    [fitness_sorted, idx] = sort(fitness);

    % atualizacao da melhor amostra
    if fitness_sorted(1) < best_fitness
        best_fitness = fitness_sorted(1);
        best_m = X(:, idx(1));
    end

    % atualizacao da populacao
    X_sorted = X(:, idx(1:mu));
    
    % armazenando a media antiga
    m_old = m;
    
    Y = (X_sorted - m_old) / sigma;
    
    % atualizacao da media
    m = X_sorted * w;
    
    % atualizacao dos evolution paths
    pc = (1 - cc) * pc + sqrt(cc * (2 - cc) * mueff) * ((m - m_old) / sigma);
    ps = (1 - cs) * ps + sqrt(cs * (2 - cs) * mueff) * invsqrtC * ((m - m_old) / sigma);
    
    % atualizacao da matriz de covariância
    C = (1 - c1 - cmu) * C + c1 * (pc * pc') + cmu * (Y * diag(w) * Y');

    % forcando que a matriz de covariancia se mantenha simetrica
    C = triu(C) + triu(C,1)';
    
    % atualização de sigma
    sigma = sigma * exp((cs / ds) * ((norm(ps) / chiN) - 1));
end

controlador_opt = obterControlador(best_m);

end