function J_rastreamento = custoRastreamento(simulacao)

xr = simulacao.xr.signals.values;
zr = simulacao.zr.signals.values;
 
escala_x = max(max(abs(xr)), 0.5);
escala_z = max(max(abs(zr)), 0.5);
 
ex = xr - simulacao.x.signals.values;
ez = zr - simulacao.z.signals.values;

% rmse normalizado
rmse_x = sqrt(mean(ex.^2)) / escala_x;
rmse_z = sqrt(mean(ez.^2)) / escala_z;

J_rastreamento = 5*rmse_x + 5*rmse_z;

end