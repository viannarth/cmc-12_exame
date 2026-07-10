function J_rastreamento = custoRastreamento(simulacao, experimentos)

[x_scale, z_scale] = obterEscalasRastreamento(experimentos);

ex = simulacao.xr.signals.values - simulacao.x.signals.values;
ez = simulacao.zr.signals.values - simulacao.z.signals.values;

rmse_x = sqrt(mean(ex.^2)) / x_scale;
rmse_z = sqrt(mean(ez.^2)) / z_scale;

J_rastreamento = rmse_x + rmse_z;

end