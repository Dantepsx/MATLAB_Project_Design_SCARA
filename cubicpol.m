%Funzione per polinomio cubico
function a = cubicpol(tf,sf)
%prendo in ingresso spazio finale e tempo finale
 %calcola s(t)
 A=[1 0 0 0;
 0 1 0 0;
 1 tf tf^2 tf^3;
 0 1 2*tf 3*tf^2];
 b=[0 0 sf 0]';
 a=inv(A)*b;
end

%Aa = b
%A è la matrice che moltiplica i coefficienti, a è il vettore dei
%coefficienti del polinomio cubico, mentre b è il vettore dei vincoli, qi,
%\dot qi, qf, \dot qf