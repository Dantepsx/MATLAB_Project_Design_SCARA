%Funzione per la misura di manipolabilità
function w = ManMeasure(theta1,theta2,a1,a2)
    q = vector(theta1,theta2,0,0);
    J = jac(q,a1,a2);
    w = sqrt(det(J*J'));
end

