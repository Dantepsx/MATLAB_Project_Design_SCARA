%Funzione per il calcolo della posa dell'end effector
function x = dirkyn(q, a1, a2, d0)
    x = zeros(4,1);
    x = [a2*cos(q(1)+q(2))+a1*cos(q(1));
        a2*sin(q(1)+q(2))+a1*sin(q(1));
        d0-q(3);
        q(1)+q(2)-q(4)];
end
