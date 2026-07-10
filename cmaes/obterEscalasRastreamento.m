function [x_scale, z_scale] = obterEscalasRastreamento(experimentos)

x_scale = 0;
z_scale = 0;
for i = 1:length(experimentos)
    parametros = obterParametrosExperimento(experimentos(i));
    x_scale = max(x_scale, max(abs(parametros.xr.signals.values)));
    z_scale = max(z_scale, max(abs(parametros.zr.signals.values)));
end

end