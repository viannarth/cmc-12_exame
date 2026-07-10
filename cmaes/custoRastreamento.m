function J_rastreamento = custoRastreamento(simulacao)

ex = simulacao.xr.signals.values - simulacao.x.signals.values;
ez = simulacao.zr.signals.values - simulacao.z.signals.values;

% rmse normalizado
if all(ex == 0)
    rmse_x = 0;
else
    rmse_x = sqrt(mean(ex.^2)) / max(abs(ex));
end

if all(ez == 0)
    rmse_z = 0;
else
    rmse_z = sqrt(mean(ez.^2)) / max(abs(ez));
end

J_rastreamento = 5*rmse_x + 5*rmse_z;

end