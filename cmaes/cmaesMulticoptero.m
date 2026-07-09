function controlador_opt = cmaesMulticoptero(planta, m0, sigma0, lambda, ...
    max_iter)

% inicializacao de parametros
n = length(m0);
m = m0; 
sigma = sigma0;
mu = floor(lambda / 2);

% iniciliazacao dos pesos
w = (mu:-1:1)'; 
w = w / sum(w); % normalizacao

mueff = 1 / sum(w.^2);

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

% aproximacao do valor esperado da distribuicao N(0, I)
EN = sqrt(n) * (1 - 1/(4*n) + 1/(21*n^2));

for iter = 1:max_iter
    % decomposicao de C para amostragem e calculo de C^(-1/2)
    % C = B * D^2 * B'
    [B, D2] = eig(C);
    D = sqrt(diag(D2));
    
    % matriz inversa da raiz quadrada: C^(-1/2) = B * D^(-1) * B'
    invsqrtC = B * diag(1 ./ D) * B';
    
    % avaliacao da amostra atual
    X = zeros(n, lambda);
    fitness = zeros(lambda, 1);
    for i = 1:lambda
        z = randn(n, 1);
        X(:, i) = m + sigma * (B * (D .* z));
        fitness(i) = custoMulticoptero(X(:, i), planta);
    end
    
    % ordenação da populacao (minimizacao)
    [~, idx] = sort(fitness);
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
    
    % atualização de sigma
    sigma = sigma * exp((cs / ds) * ((norm(ps) / EN) - 1));
end

controlador_opt.theta.Kp = exp(m(1));
controlador_opt.theta.Kv = exp(m(2));
controlador_opt.x.Ki = exp(m(3));
controlador_opt.x.Kd = exp(m(4));
controlador_opt.x.Kp = exp(m(5));
controlador_opt.z.Ki = exp(m(6));
controlador_opt.z.Kd = exp(m(7));
controlador_opt.z.Kp = exp(m(8));

end