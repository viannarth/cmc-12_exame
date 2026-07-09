function controlador = projetarControladorVertical(requisitos, planta)
% controlador = projetarControladorVertical(requisitos, planta) 
% projeta o controlador vertical de forma analitica. As entradas da 
% funcao sao as structs requisitos e planta, que contem os requisitos e os 
% parametros da planta, respectivamente. Os requisitos sao:
% requisitos.tr: tempo de subidade de 0 a 100%.
% requisitos.Mp: sobressinal.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.

m = planta.m;
Mp = requisitos.Mp;
tr = requisitos.tr;

% usando a aproximacao por polos dominantes
xi = abs(log(Mp)) / sqrt(pi^2 + (log(Mp))^2);
wn = (pi - acos(xi)) / (tr * sqrt(1 - xi^2));
    
a = 5*xi*wn;
controlador.Kp = m*(2*a*xi*wn + wn^2);
controlador.Ki = m*a*wn^2;
controlador.Kd = m*(a + 2*xi*wn);

end
