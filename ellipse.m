%Funzione per il calcolo parametrico delle ellissoidi
function [x , y] = ellipse (a, b, c)
    t = linspace(0,2*pi);
    x=c(1)+a(1)*sin(t)+b(1)*cos(t);
    y=c(2)+a(2)*sin(t)+b(2)*cos(t);
end

%ora ho una serie di autovalori che ottengo con lo Jacobiano, per questo a
%e b hanno 2 componenti, per definire la direzione