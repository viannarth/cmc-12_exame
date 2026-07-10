function J_bounds = custoLimites(m, m0)

m_min = m0 - log(10);
m_max = m0 + log(10);

abaixo = max(0, m_min - m);
acima  = max(0, m - m_max);

J_bounds = 50 * sum(abaixo.^2 + acima.^2);

end