close all
clear
%definizione dei parametri
d0 = 1;
a1 = 0.5;
a2 = a1;
L1 = 0.25;
L2 = 0.25;
ml1 = 20;
ml2 = ml1;
ml3 = 10;
Il1 = 4;
Il2 = Il1;
Il4 = 1;
kr1 = 1;
kr2 = kr1;
kr3 = 50;
kr4 = 20;
Im1 = 0.01;
Im2 = Im1;
Im3 = 0.005;
Im4 = 0.001;
Fm1 = 0.00005;
Fm2 = Fm1;
Fm3 = 0.01;
Fm4 = 0.005;

%% Manipulability Ellipsoids for q1 (Elbow down)
i = 1;
%ManEllipsoid(-pi/4,pi/2,a1,a2,d0,i);
%w1 = ManMeasure(-pi/4,pi/2,a1,a2);

%% Manipulability Ellipsoids for q2 (Elbow up)
i = i+1;
%ManEllipsoid(pi/4,-pi/2,a1,a2,d0,i);
%w2 = ManMeasure(pi/4,-pi/2,a1,a2);

%% Manipulability Ellipsoids for q3 (Elbow down inverted)
i = i+1;
%ManEllipsoid(-pi/4,-pi/2,a1,a2,d0,i);
%w3 = ManMeasure(-pi/4,-pi/2,a1,a2);

%% Manipulability Ellipsoids for q4 (Elbow up inverted)
i = i+1;
%ManEllipsoid(pi/4,pi/2,a1,a2,d0,i);
%w4 = ManMeasure(pi/4,pi/2,a1,a2);

%% Manipulability Ellipsoids for q5 (Close to Singularity)
i = i+1;
%ManEllipsoid(-pi/6,pi/6,a1,a2,d0,i);
%w5 = ManMeasure(-pi/6,pi/6,a1,a2);

%% Manipulability Ellipsoids for q6 (Singularity)
i = i+1;
%ManEllipsoid(-pi/6,0,a1,a2,d0,i);

%% Creation of the path
% Percorso
p=[0.5 0.5 1 0;
 0.4 0.5 1 -pi/8;
 0.3 0.5 1 -pi/8;
 0.2 0.5 1 -pi/8;
 0.2 0.3 1 -pi/8; %5
0.3 0.3 1 -pi/8;
 0.35 0.35 1 pi/6;
 0.35 0.35 0.7 pi/6;
 0.4 0.45 0.7 pi/6;
 0.5 0.45 0.7 0;
 0.55 0.45 0.7 0;
 0.55 0.35 0.7 0; %12
 0.55 0.3 0.7 0;
 0.55 0.25 0.7 0;
 0.5 0.25 0.7 0;%15
 0.5 0.25 0.85 0;
 0.45 0.25 0.85 0;
 0.45 0.3 0.85 0; 
 0.45 0.35 0.85 0;%19
 0.45 0.4 0.85 0;
 0.45 0.45 0.85 0;
 0.5 0.5 1 0];
%con l'ultimo punto ritorno nel punto iniziale

P1=Line(p(1,1:3),p(2,1:3));
P2=Line(p(2,1:3),p(3,1:3));
P3=Line(p(3,1:3),p(4,1:3));
P4=Circ(p(4,1:3),(p(4,1:3)+p(5,1:3))./2,-pi);
P5=Line(p(5,1:3),p(6,1:3));
P6=viapoints(p(6,1:3),p(7,1:3),p(8,1:3),0.3);
P7=Line(p(8,1:3),p(9,1:3));
P8=Circ(p(9,1:3),(p(9,1:3)+p(10,1:3))./2,pi);
P9=Line(p(10,1:3),p(11,1:3));
P10=Line(p(11,1:3),p(12,1:3));
P11=Line(p(12,1:3),p(13,1:3));
P12=Line(p(13,1:3),p(14,1:3));
P13=Line(p(14,1:3),p(15,1:3));
P14=viapoints(p(15,1:3),p(16,1:3),p(17,1:3),0.3);
P15=Line(p(17,1:3),p(18,1:3));
P16=Line(p(18,1:3),p(19,1:3));
P17=Line(p(19,1:3),p(20,1:3));
P18=viapoints(p(20,1:3),p(21,1:3),p(22,1:3),0.3);
%le P grandi sono i percorsi,
% i p piccoli che fanno da argomento sono effettivamente i punti del
% percorso

P=[P1; P2(2:end,:); P3(2:end,:); P4(2:end,:); P5(2:end,:); P6(2:end,:); 
P7(2:end,:); P8(2:end,:); P9(2:end,:); P10(2:end,:); P11(2:end,:); P12(2:end,:)
P13(2:end,:); P14(2:end,:); P15(2:end,:); P16(2:end,:) ; P17(2:end,:); P18(2:end,:)];

P = [P; P(end,:); P(end,:)];

figure
plot3(P(:,1),P(:,2),P(:,3));
grid on
hold on
plot3(p(1:end,1),p(1:end,2),p(1:end,3),'*');
xlabel('x');
ylabel('y');
zlabel('z');
title('Path');

%% Trajectory (Trapezoidal velocity profile definition)

% Definizione dei parametri
v_max = 1;   % Velocità massima
a = 0.5;       % Accelerazione/decelerazione massima
t_acc_dec = v_max / a; % Tempo di accelerazione e decelerazione (2 secondi)
%voglio il passaggio da un punto ad un altro in 6 secondi, 2 secondi di
%accelerazione, 2 a velocità costante e 2 di decelerazione

% Tempi
t_acc = t_acc_dec;       % Tempo di accelerazione
t_dec = t_acc_dec;       % Tempo di decelerazione
t_const = 2;             % Tempo di velocità costante

% Tempo totali
t_total = t_acc + t_const + t_dec;

% Funzione di velocità
t = linspace(0, t_total, 1000); % Tempo
v = zeros(size(t)); % Inizializzazione della velocità

% Fase di accelerazione
idx_acc = t <= t_acc; %Questa riga crea un array logico idx_acc che è vero
% per tutti i valori di t inferiori o uguali al tempo di accelerazione t_acc. 
% Identifica i punti temporali in cui il robot sta ancora accelerando.

v(idx_acc) = a * t(idx_acc); %Questa riga assegna alla velocità v nei punti
% identificati da idx_acc un valore calcolato come l'accelerazione
% a moltiplicata per il tempo corrispondente t. 
% Questo rappresenta una velocità crescente linearmente con il tempo
% durante la fase di accelerazione.

% Fase di velocità costante
%faccio poi le stesse cose con i tratti a velocità costante e quello in cui
%decelero
idx_const = t_acc < t & t <= (t_acc + t_const);
v(idx_const) = v_max;

% Fase di decelerazione
idx_dec = (t_acc + t_const) < t & t <= t_total;
v(idx_dec) = v_max - a * (t(idx_dec) - (t_acc + t_const));

% Integrazione della velocità per ottenere la posizione
posizione = cumtrapz(t, v);  % Utilizzo di cumtrapz per l'integrazione cumulativa

% Calcolo dell'accelerazione (derivata della velocità)
accelerazione = gradient(v, t);  % Utilizzo di gradient per calcolare la derivata

% Plot della posizione
figure
subplot(3,1,1)
plot(t, posizione, 'LineWidth', 2);
grid on;
axis([0 t_total,0 v_max+3]); %ingrandisco gli assi per una migliore
%visualizzazione
xlabel('Time[s]');
ylabel('s(t)');
title('Position from Trapezoidal Velocity profile ');

% Plot della velocità
subplot(3,1,2);
plot(t, v, 'LineWidth', 2);
grid on;
axis([0 t_total,0 v_max+1]);
xlabel('Time[s]');
ylabel('$\dot{s(t)}$','interpreter','latex');
title('Trapezoidal Velocity profile');

% Plot dell'accelerazione
subplot(3,1,3);
plot(t, accelerazione, 'LineWidth', 2);
grid on;
axis([0 t_total,-a-0.1 a+0.1]);
xlabel('Time[s]');
ylabel('$\ddot{s(t)}$','interpreter','latex');
title('Acceleration from Trapezoidal Velocity profile');

%% End effector pose, velocity and acceleration
% Definizione del tempo totale della traiettoria
total_time =108; % 96 secondi perché ho 22 punti, ma 3 sono di via, quindi non
%li conto nel passaggio da un punto ad un altro, ho 18 tratti per 6 secondi
% Tempo di transizione tra i punti
trans_time = 6;

% Inizializzazione delle velocità istantanee
num_segments = size(p, 1) - 4; %considero 18 tratti, visto che il percorso si chiude, 
%quindi tolgo un punto, -3 punti di via
num_timesteps = trans_time*1000;

time = linspace(0, total_time, num_segments * num_timesteps);  % Asse dei tempi
velocities = zeros(num_segments * num_timesteps, 4);

% Calcolo delle velocità per ciascun segmento
for i = 1:num_segments
    % Calcolo della differenza di posizione tra i punti successivi
    dp = p(i+1,:) - p(i,:);
    
    % Profilo di velocità trapezoidale per il segmento
    t = linspace(0, trans_time, num_timesteps);  % Tempo per il segmento
    vel_profile = zeros(num_timesteps, 1);       % Inizializzazione della velocità
    
    % Fase di accelerazione
    idx_acc = t <= t_acc;
    vel_profile(idx_acc) = a * t(idx_acc);
    
    % Fase di velocità costante
    idx_const = t_acc < t & t <= (t_acc + t_const);
    vel_profile(idx_const) = v_max;
    
    % Fase di decelerazione
    idx_dec = (t_acc + t_const) < t & t <= t_total;
    vel_profile(idx_dec) = v_max - a * (t(idx_dec) - (t_acc + t_const));
    
    % Assegnazione delle velocità istantanee alla matrice
    for j = 1:4
        velocities((i-1)*num_timesteps + 1:i*num_timesteps, j) = vel_profile * (dp(j));
    end
end

%Ora voglio plottare le posizioni

num_points = size(p, 1); % Numero di punti nel vettore p

% Creazione dell'asse dei tempi per ciascun punto
time_points = linspace(0, total_time, num_points);

% Interpolazione lineare per ottenere posizioni continue nel tempo
pos_cont = zeros(length(time), 4);

for i = 1:4
    pos_cont(:, i) = interp1(time_points, p(:, i), time, 'spline');
end

% Calcolo delle accelerazioni tramite la derivata numerica delle velocità
dt = time(2) - time(1);  % Intervallo di campionamento
accelerations = diff(velocities) / dt;
accelerations = [accelerations;accelerations(end,1:4)];

% Visualizzazione dei risultati
figure;
hold on;
plot(time, pos_cont(:, 1), 'b', 'LineWidth', 2);
plot(time, pos_cont(:, 2), 'r', 'LineWidth', 2);
plot(time, pos_cont(:, 3), 'y', 'LineWidth', 2);
plot(time, pos_cont(:, 4), 'm', 'LineWidth', 2);
axis([0 total_time+1 -v_max-1 v_max+1])
xlabel('Time (s)');
ylabel('${x_e(t)}$','interpreter','latex');
legend('Px', 'Py', 'Pz', '\theta');
title('Positions and Orientation');
grid on;
hold off;
set(gcf, 'Position', [100, 100,1400, 600]);

figure;
hold on;
plot(time, velocities(:, 1), 'b', 'LineWidth', 2);
plot(time, velocities(:, 2), 'r', 'LineWidth', 2);
plot(time, velocities(:, 3), 'y', 'LineWidth', 2);
plot(time, velocities(:, 4), 'm', 'LineWidth', 2);
axis([0 total_time+1 -v_max v_max])
xlabel('Time (s)');
ylabel('$\dot{x_e(t)}$','interpreter','latex');
legend('Vx', 'Vy', 'Vz', '\omega');
title('Linear and Angular Velocities');
grid on;
hold off;
set(gcf, 'Position', [100, 100,1400, 600]);

figure;
hold on;
plot(time, accelerations(:, 1), 'b', 'LineWidth', 2);
plot(time, accelerations(:, 2), 'r', 'LineWidth', 2);
plot(time, accelerations(:, 3), 'y', 'LineWidth', 2);
plot(time, accelerations(:, 4), 'm', 'LineWidth', 2);
axis([0 total_time+1 -a a])
xlabel('Time (s)');
ylabel('$\ddot{x_e(t)}$','interpreter','latex');
legend('Ax', 'Ay', 'Az', '\alpha');
title('Linear and Angular Accelerations');
grid on;
hold off;
set(gcf, 'Position', [100, 100,1400, 600]);

%% CLIK algorithm with Jacobian inverse

%Matrice di guadagno
k = [100 100 100 100];
K = diag(k);

%Tempo di campionamento Tc
Tc = 0.001;
%Vettore dei tempi
T = (0:Tc:total_time-Tc)';

%traiettoria desiderata di riferimento (posizione e velocità)
xd = [pos_cont(:, 1) pos_cont(:, 2) pos_cont(:, 3) pos_cont(:, 4)];
dxd = [velocities(:, 1) velocities(:, 2) velocities(:, 3) velocities(:, 4)];

%Posizione iniziale nello spazio dei giunti
q0 = [0 pi/2 0 pi/2];

%Devo infine completare la traiettoria dinamica con un tratto costante di 1
%secondo per far vedere come vanno i plot
T1 = (total_time:Tc:total_time+1)';
xd1 = ones(size(T1,1),1)*p(end,:);
dxd1 = zeros(size(T1,1),4);

T = [T;T1];
xd = [xd;xd1];
dxd = [dxd;dxd1];

%devo modificare le matrici xd e dxd per poter essere interpretate dal
%blocco from workspace di Simulink; devo avere una struttura in cui la
%prima colonna è il timestamp, e poi ho i dati; quindi devo avere matrici
%del tipo |T|x|y|z|o

xdsim = [T xd];
dxdsim = [T dxd];

% Eseguo la simulazione in Simulink
sim('Schema_inversione_cinematica_con_inversa_Jacobiano.slx');

% Ottengo l'oggetto out dalla simulazione
out = sim('Schema_inversione_cinematica_con_inversa_Jacobiano.slx');

% Estraggo la matrice q dall'oggetto out
qd = out.q;
e = out.x_error;
sze = length(e)/4; %fratto 4 perché voglio dividere in 4 colonne
szqd = length(qd)/4;

%Ora però sono vettori colonna, devo trasformarli in matrici
E = reshape(e,4,sze);
Qd = reshape(qd,4,szqd);
%Ora ho una struttura del tipo riga di giunto 1, 2, 3, riga di o
%faccio quindi la trasposta per avere una struttura più comoda

E = E';
Qd = Qd';

%Traiettorie posizioni giunti
%faccio la stessa cosa fatta in precedenza per aumentare la lunghezza
%dei vettori delle traiettorie per il vettore dei giunti, aumento solo la
%lunghezza del vettore dei giunti, l'errore di posizione si vede già che va
%a 0
T_pos_e = linspace(0,total_time+5,sze);
T_pos_j = linspace(0,total_time,szqd);
T_pos_jc = (length(qd)/total_time)*5;
T_pos_j1 = (total_time:1/T_pos_jc:total_time+5);
T_pos_j = [T_pos_j T_pos_j1];

Qd1 = ones(size(T_pos_j1,2),1)*[Qd(end,:)];
Qd = [Qd ; Qd1];

figure;
plot(T_pos_j,Qd(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(T_pos_j,Qd(:,2),'g','LineWidth',2);
plot(T_pos_j,Qd(:,3),'m','LineWidth',2);
plot(T_pos_j,Qd(:,4),'y','LineWidth',2);
title('Joint Positions (Jacobian inverse)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600]);

%Norma dell'errore di posizione
figure;
norm_err = sqrt(E(:,1).^2+E(:,2).^2+E(:,3).^2);
plot(T_pos_e,norm_err,'LineWidth',2);
title('Position Error norm (Jacobian Inverse)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%Errore di orientamento

figure;
err_or = E(:,4);
plot(T_pos_e,err_or,'LineWidth',2);
title('Orientation Error (Jacobian Inverse)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%% CLIK algorithm with Jacobian transpose

%devo cambiare K
kt = [200 200 200 200];
KT = diag(kt);

%xdsim, ingresso del modello Simulink, rimane uguale a prima
sim('Schema_inversione_cinematica_con_trasposta_Jacobiano.slx');
outT = sim('Schema_inversione_cinematica_con_trasposta_Jacobiano.slx');

eT = outT.xt_error;
szeT = length(eT)/4;
ET = reshape(eT,4,szeT);
ET = ET';

%Le variabili di giunto evolvono in maniera analoga, quindi non le
%considero
%Norma dell'errore di posizione
figure;
norm_errT = sqrt(ET(:,1).^2+ET(:,2).^2+ET(:,3).^2);
plot(T_pos_e,norm_errT,'LineWidth',2);
title('Position Error norm (Jacobian Transpose)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%Errore di orientamento

figure;
err_orT = ET(:,4);
plot(T_pos_e,err_orT,'LineWidth',2);
title('Orientation Error (Jacobian Transpose)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%% CLIK algorithm with Jacobian pseudo-inverse and dexterity constraint

k_pinv = [100 100 100];
K_pinv = diag(k_pinv);
K0 = 10;

%Mi servono xd e dxd relativi al manipolatore ridondante; mi basta togliere
%la colonna y_traj da xd e dxd, li prendo gia come matrici da mettere in
%Simulink

xd_red_sim = [xdsim(:,1) xdsim(:,2) xdsim(:,4) xdsim(:,5)];
dxd_red_sim = [dxdsim(:,1) dxdsim(:,2) dxdsim(:,4) dxdsim(:,5)];

%Ho escluso la terza colonna che rappresentava i valori di y_traj

sim('Schema_inversione_cinematica_con_pseudo_inversa_Jacobiano.slx');
outP = sim('Schema_inversione_cinematica_con_pseudo_inversa_Jacobiano.slx');

wP = outP.w;
WP = wP';

%definisco un vettore dei tempi
TP = linspace(0,total_time+5,length(WP));

figure;
plot(TP,WP,'LineWidth',2);
title('Manipulability Measure for K0 = 10');
xlabel('[s]');
ylabel('w(q)');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%L'errore stavolta è già nel formato corretto, 3 colonne, data la divisione
%con il demux e mux, quindi non devo fare il reshape

EP = outP.x_error_pinv;
figure;
norm_errP = sqrt(EP(:,1).^2+EP(:,2).^2); %qui ho solo componenti x e z
plot(TP,norm_errP,'LineWidth',2);
title('Position Error norm (Jacobian Pseudo-Inverse)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%Errore di orientamento

figure;
err_orP = EP(:,3);
plot(TP,err_orP,'LineWidth',2);
title('Orientation Error (Jacobian Pseudo-Inverse)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%Variabili di giunto 

qp = outP.q_pinv;
Qp = reshape(qp,4,length(wP));
Qp = Qp';

figure;
plot(TP,Qp(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Qp(:,2),'g','LineWidth',2);
plot(TP,Qp(:,3),'m','LineWidth',2);
plot(TP,Qp(:,4),'y','LineWidth',2);
title('Joint Positions (Jacobian Pseudo-Inverse)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600])

%Vedo cosa succede per K0 = 0, mi aspetto che la misura di manipolabilità
%diminuisca
K0 = 0;
sim('Schema_inversione_cinematica_con_pseudo_inversa_Jacobiano.slx');
outP = sim('Schema_inversione_cinematica_con_pseudo_inversa_Jacobiano.slx');

wP = outP.w;
WP = wP';

figure;
plot(TP,WP,'LineWidth',2);
title('Manipulability Measure for K0 = 0');
xlabel('[s]');
ylabel('w(q)');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

qp = outP.q_pinv;
Qp = reshape(qp,4,length(wP));
Qp = Qp';

figure;
plot(TP,Qp(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Qp(:,2),'g','LineWidth',2);
plot(TP,Qp(:,3),'m','LineWidth',2);
plot(TP,Qp(:,4),'y','LineWidth',2);
title('Joint Positions (Jacobian Pseudo-Inverse, K0 = 0)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600])

%% Second order CLIK algorithm

%I controlli robusto, adattativo ed a dinamica inversa nello spazio
%operativo fanno uso di un algoritmo CLIK con inversa dello Jacobiano del
%secondo ordine, quindi bisogna prima implementare quest'ultimo
kp = [1000 1000 1000 1000];
KP = diag(kp);
kd = [25 25 25 25];
KD = diag(kd);

%poi mi serve un vettore delle accelerazioni da mettere in Simulink
ddxd = [accelerations(:,1) accelerations(:,2) accelerations(:,3) accelerations(:,4)];
ddxd1 = zeros(size(T1,1),4);

ddxd = [ddxd;ddxd1];
ddxdsim = [T ddxd];

sim('CLIK_II_ordine.slx');
outsecond= sim('CLIK_II_ordine.slx');

err_second = outsecond.x_error;
Err_second = reshape(err_second,4,length(WP));
Err_second = Err_second';

%Norma dell'errore di posizione
figure;
norm_errS = sqrt(Err_second(:,1).^2+Err_second(:,2).^2+Err_second(:,3).^2);
plot(T_pos_e,norm_errS,'LineWidth',2);
title('Position Error norm (II Order CLIK)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%Errore di orientamento

figure;
err_orS = Err_second(:,4);
plot(T_pos_e,err_orS,'LineWidth',2);
title('Orientation Error (II Order CLIK)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600]);

%gli errori con lo schema CLIK del secondo ordine sono ragionevoli

%% Robust Control

kp2 = [400 400 400 400];
KP2 = diag(kp2);
kd2 = [25 25 25 25];
KD2 = diag(kd2);

%Vettore condizioni iniziali
pi0 = [ml1 Il1 Im1 Fm1 ml2 Il2 Im2 Fm2 ml3 Im3 Fm3 Il4 Im4 Fm4];

sim('Controllo_Robusto.slx');
outRb = sim('Controllo_Robusto.slx');

err_rb = outRb.robcntrl_err;
Err_rb = reshape(err_rb,4,length(wP));
Err_rb = Err_rb';

%Norma dell'errore di posizione
figure;
norm_err_rb = sqrt(Err_rb(:,1).^2+Err_rb(:,2).^2+Err_rb(:,3).^2);
plot(T_pos_e,norm_err_rb,'LineWidth',2);
title('Position Error norm (Robust Control)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Errore di orientamento

figure;
err_rb_or = Err_rb(:,4);
plot(T_pos_e,err_rb_or,'LineWidth',2);
title('Orientation Error (Robust Control)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Andamento giunti

qrob = outRb.qrobcntrl;
Qrob = reshape(qrob,4,length(wP));
Qrob = Qrob';

figure;
plot(TP,Qrob(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Qrob(:,2),'g','LineWidth',2);
plot(TP,Qrob(:,3),'m','LineWidth',2);
plot(TP,Qrob(:,4),'y','LineWidth',2);
title('Joint Positions (Robust Control)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600]);

%Errore andamento giunti

err_q = outRb.errq;
Err_q = reshape(err_q,4,length(WP));
Err_q = Err_q';

figure;
plot(TP,Err_q(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Err_q(:,2),'g','LineWidth',2);
plot(TP,Err_q(:,3),'m','LineWidth',2);
plot(TP,Err_q(:,4),'y','LineWidth',2);
title('Joint Positions Error (Robust Control)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600]);

%Coppie ai giunti

tau_rb = outRb.tau;
Tau_rb = reshape(tau_rb,4,length(WP));
Tau_rb = Tau_rb';

figure;
plot(TP,Tau_rb(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Tau_rb(:,2),'g','LineWidth',2);
plot(TP,Tau_rb(:,3),'m','LineWidth',2);
plot(TP,Tau_rb(:,4),'y','LineWidth',2);
title('Joint Torques (Robust Control)');
xlabel('[s]'); 
ylabel('[Nm]');
legend('\tau_1','\tau_2','\tau_3','\tau_4');
set(gcf, 'Position', [100, 100,1400, 600])
%plottare poi anche le tau col chattering

%% Adaptive Control

kd3 = [950 950 950 950];
KD3 = diag(kd3);

lambda = [50 50 50 50];
Lambda = diag(lambda);

sim('Controllo_Adattativo.slx');
outAd = sim('Controllo_Adattativo.slx');

err_ad = outAd.adcntrl_err;
Err_ad = reshape(err_ad,4,length(wP));
Err_ad = Err_ad';

%Norma dell'errore di posizione
figure;
norm_err_ad = sqrt(Err_ad(:,1).^2+Err_ad(:,2).^2+Err_ad(:,3).^2);
plot(T_pos_e,norm_err_ad,'LineWidth',2);
title('Position Error norm (Adaptive Control)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Errore di orientamento

figure;
err_ad_or = Err_ad(:,4);
plot(T_pos_e,err_ad_or,'LineWidth',2);
title('Orientation Error (Adaptive Control)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Andamento giunti

qad = outAd.qadcntrl;
Qad = reshape(qad,4,length(wP));
Qad = Qad';

figure;
plot(TP,Qad(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Qad(:,2),'g','LineWidth',2);
plot(TP,Qad(:,3),'m','LineWidth',2);
plot(TP,Qad(:,4),'y','LineWidth',2);
title('Joint Positions (Adaptive Control)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600])

%Errore andamento giunti

err_qad = outAd.errq;
Err_qad = reshape(err_qad,4,length(WP));
Err_qad = Err_qad';

figure;
plot(TP,Err_qad(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Err_qad(:,2),'g','LineWidth',2);
plot(TP,Err_qad(:,3),'m','LineWidth',2);
plot(TP,Err_qad(:,4),'y','LineWidth',2);
title('Joint Positions Error (Adaptive Control)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600])

%Coppie ai giunti

tau_ad = outAd.tau;
Tau_ad = reshape(tau_ad,4,length(WP));
Tau_ad = Tau_ad';

figure;
plot(TP,Tau_ad(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Tau_ad(:,2),'g','LineWidth',2);
plot(TP,Tau_ad(:,3),'m','LineWidth',2);
plot(TP,Tau_ad(:,4),'y','LineWidth',2);
title('Joint Torques (Adaptive Control)');
xlabel('[s]'); 
ylabel('[Nm]');
legend('\tau_1','\tau_2','\tau_3','\tau_4');
set(gcf, 'Position', [100, 100,1400, 600]);

%Andamento parametri dinamici

pi_ad = outAd.pi_cap;
Pi_ad = reshape(pi_ad,14,length(WP));
Pi_ad = Pi_ad';

% Definisci una matrice di colori personalizzati (14x3 per 14 colori RGB)
customColors = [
    0.0, 0.0, 1.0; % Blu
    0.0, 1.0, 0.0; % Verde
    1.0, 0.0, 0.0; % Rosso
    0.0, 1.0, 1.0; % Ciano
    1.0, 0.0, 1.0; % Magenta
    1.0, 1.0, 0.0; % Giallo
    0.5, 0.0, 0.5; % Viola
    0.5, 0.5, 0.0; % Oliva
    0.0, 0.5, 0.5; % Verde acqua
    0.5, 0.5, 0.5; % Grigio
    0.2, 0.8, 0.2; % Verde chiaro
    0.8, 0.2, 0.8; % Viola chiaro
    0.8, 0.5, 0.2; % Arancione
    0.2, 0.2, 0.8; % Blu scuro
];

figure;
hold on;
for i = 1:14
    plot(TP, Pi_ad(:,i), 'Color', customColors(i, :), 'LineWidth', 2);
end
hold off;
grid on
title('Variability of the dynamic parameters');
xlabel('[s]'); 
ylabel('$\pi$','Interpreter','latex');
legend('ml_1','Il_1','Im_1','Fm_1','ml_2','Il_2','Im_2','Fm_2','ml_3','Im_3','Fm_3','Il_4','Im_4','Fm_4');
set(gcf, 'Position', [100, 100,1400, 600])

%Su ml3 c'è una variazione dal valore nominale, proprio a causa del carico
%in punta; come dal libro, quando variano i parametri nominali a causa di
%un carico in punta, ho una deviazione dal loro valore nominale

%% Inverse Dynamics Control in Operational Space

kp4 = [2500 2500 2500 2500];
KP4 = diag(kp4);
kd4 = [60 60 60 60];
KD4 = diag(kd4);
ki = [1 1 80 0];
KI = diag(ki);

sim('Controllo_Dinamica_Inversa_Spazio_Operativo.slx');
outid = sim('Controllo_Dinamica_Inversa_Spazio_Operativo.slx');

err_id = outid.idcntrl_err;
Err_id = reshape(err_id,4,length(wP));
Err_id = Err_id';

%Norma dell'errore di posizione
figure;
norm_err_id = sqrt(Err_id(:,1).^2+Err_id(:,2).^2+Err_id(:,3).^2);
plot(T_pos_e,norm_err_id,'LineWidth',2);
title('Position Error norm (Inverse Dynamics Control)');
xlabel('[s]');
ylabel('[m]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Errore di orientamento

figure;
err_id_or = Err_id(:,4);
plot(T_pos_e,err_id_or,'LineWidth',2);
title('Orientation Error (Inverse Dynamics Control)');
xlabel('[s]');
ylabel('[rad]');
grid on
set(gcf, 'Position', [100, 100,1400, 600])

%Andamento giunti

qid = outid.qidcntrl;
Qid = reshape(qid,4,length(wP));
Qid = Qid';

figure;
plot(TP,Qid(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Qid(:,2),'g','LineWidth',2);
plot(TP,Qid(:,3),'m','LineWidth',2);
plot(TP,Qid(:,4),'y','LineWidth',2);
title('Joint Positions (Inverse Dynamics Control)');
xlabel('[s]'); 
ylabel('[rad]/[m]');
legend('q_1','q_2','q_3','q_4');
set(gcf, 'Position', [100, 100,1400, 600])

%Coppie ai giunti

tau_id = outid.tau;
Tau_id = reshape(tau_id,4,length(wP));
Tau_id = Tau_id';

figure;
plot(TP,Tau_id(:,1),'r','LineWidth',2);
grid on;
hold on;
plot(TP,Tau_id(:,2),'g','LineWidth',2);
plot(TP,Tau_id(:,3),'m','LineWidth',2);
plot(TP,Tau_id(:,4),'y','LineWidth',2);
title('Joint Torques (Inverse Dynamics Control)');
xlabel('[s]'); 
ylabel('[Nm]');
legend('\tau_1','\tau_2','\tau_3','\tau_4');
set(gcf, 'Position', [100, 100,1400, 600]);







