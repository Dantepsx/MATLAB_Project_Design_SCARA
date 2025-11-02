%Funzione per la rappresentazione delle ellissoidi di manipolabilità
function M = ManEllipsoid(theta1,theta2,a1,a2,d0,n)
    q = vector(theta1,theta2,0,0);
    J = jac(q,a1,a2);
    xe = dirkyn(q,a1,a2,d0);

    % Ellissoide di forza
    figure()
    [V1, D1]=eig(J(1:2,1:2)*J(1:2,1:2)'); %prendo prime 2 righe e prime 2 colonne
    %V1 sono gli autovettori, D1 sono gli autovalori riportati come matrice
    %formattati come matrice quadrata

    [x1, y1] = ellipse((D1(1,1)*(V1(:,1)/norm(V1(:,1)))/norm(D1)),...
        (D1(2,2)*(V1(:,2)/norm(V1(:,2)))/norm(D1)),[xe(1) xe(2)]);

    %con a e b sto facendo questo: moltiplico per un autovalore per dare la
    %lunghezza del vettore, moltiplico poi per gli autovettori per dare una
    %direzione, ma questi autovettori hanno coordinate x e y (sono vettori in
    %un piano bidimensionale), per questo prendo per a e b prima e seconda
    %colonna di v1, e poi normalizzo

    %con c scelgo i primi 2 elementi della posa dell'end effector, visto che
    %voglio la rappresentazione su un piano bidimensionale, quindi mi servono
    %coordinate x e y della posa
    plot(x1, y1)
    hold on
    grid on
    legend('Ellissoide in forza')

    %Ellissoide in velocità

    [V1, D1]=eig(pinv(J(1:2,1:2))'*pinv(J(1:2,1:2)));
    [x1, y1] = ellipse((D1(1,1)*(V1(:,1)/norm(V1(:,1)))/norm(D1)), ...
       (D1(2,2)*(V1(:,2)/norm(V1(:,2)))/norm(D1)),[xe(1) xe(2)]);
    plot(x1, y1);
    grid on
    plot(xe(1),xe(2),'*'); %plotta l'end effector
    plot(0,0,'ro'); %plotta l'origine del manipolatore
    xlabel('[m]');
    ylabel('[m]');
    plot([0 0.5*cos(q(1)) 0.5*cos(q(1))+0.5*cos(q(1)+q(2))],[0 0.5*sin(q(1)) ...
    0.5*sin(q(1))+0.5*sin(q(1)+q(2))],'k','LineWidth',2);

    %i primi 2 vettori sono coordinate per i bracci meccanici, 3 punti
    %coordinata x e 3 coordinata y, per rappresentare i primi 2 link; questi
    %vettori sono presi da p1 e p2
    %k mi dà delle linee nere rappresentanti i bracci del robot
    %LineWidth mi da la larghezza delle linee rappresentanti i bracci del robot

    legend('Force Ellipsoid','Velocity Ellipsoid');
    axis('equal');
    title('Manipulability Analysis for',strcat('q',num2str(n)));

end