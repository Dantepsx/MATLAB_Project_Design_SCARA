%Funzione per traiettoria di rotazione
function O = Rotation(p1, p2, points)
 t=linspace(0,1,points);
 a=cubicpol(1,1); %uso la funzione polinomio cubico per calcolare i coefficienti in base ai vincoli
 s=a(4)*t.^3+a(3)*t.^2+a(2)*t+a(1); % è il polinomio cubico
 O=(1-s).*p1'+s.*p2'; %tale e quale a quella di posizione rettilinea, ma fatta con angoli
 O=O';
end
p=[0.1 0.1 1 0;
 0.1 0.2 1 -pi/3;
 0.1 0.3 1 -pi/3;
 0.2 0.3 1 -pi/3;
 0.2 0.25 1 -pi/3; %5
0.25 0.25 1 -pi/3;
 0.3 0.25 1 pi/4;
 0.3 0.25 0.7 pi/4;
 0.3 0.3 0.7 pi/4;
 0.4 0.3 0.7 0;
 0.4 0.25 0.7 0;
 0.4 0.2 0.7 0; %12
 0.4 0.1 0.7 0;
 0.35 0.1 0.7 0;
 0.3 0.1 0.7 0;
 0.3 0.1 1 0;
 0.3 0.05 1 0;
 0.2 0.05 1 0;
 0.2 0.1 1 0; %devo calcolare le nuove condizioni iniziali, e a 56 secondi succede qualcosa che mi fa avere il picco nell'errore
 0.15 0.1 1 0; %Ho comunque un errore troppo alto per l'inversa dello jacobiano, le traiettorie fanno schifo
 0.1 0.1 1 0]