function J_rastreamento = custoRastreamento(simulacao)

ez = simulacao.zr.signals.values - simulacao.z.signals.values;
ex = simulacao.xr.signals.values - simulacao.x.signals.values;

rmse_z = sqrt(mean(ez.^2));
rmse_x = sqrt(mean(ex.^2));

J_rastreamento = rmse_z + rmse_x;

end