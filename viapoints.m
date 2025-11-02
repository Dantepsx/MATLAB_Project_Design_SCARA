%Funzione per i punti di via
function P = viapoints(pi,pv,pf,dtv)
%seconda interpretazione: v1 è la velocità iniziale e v2 quella finale,
%divido (perche spazio/tempo = velocità) per 0.5 per dire prima metà e seconda metà del percorso.
%av invece è un'accelerazione, differenza di velocità divisa per dtv, tempo
%in cui percorro la traiettoria con in mezzo il punto di via
%lv = lunghezza del percorso per il punto di via, vt + 1/2at^2
 v1=(pv-pi)./0.5; %velocità per la prima metà del percorso
 v2=(pf-pv)./0.5; %velocità per la seconda metà del percorso
 av=(v2-v1)./dtv; %accelerazione nel tempo in cui cambia la velocità
 l1=norm(v1)*(1-dtv)/2; %se dtv è il tempo in cui accelero, 1-dtv è il tempo per cui la velocità
 %è costante, velocità per tempo mi da spazio, divido per 2 perché ho 2
 %tratti in cui la velocità è costante, la parte iniziale e la parte
 %finale, in mezzo accelero, quindi l1 è la lunghezza del tratto iniziale,
 %l2 la lunghezza del tratto finale, lv la lunghezza del tratto in mezzo
 l2=norm(v2)*(1-dtv)/2;
 lv=norm(v1)*dtv+1/2*norm(av)*dtv^2;
 %e se v fossero le velocità e av l'accelerazione? questo spiega anche la
 %formula al rigo sopra e mi trovo anche dimensionalmente
 t1=linspace(0,(1-dtv)/2,ceil(l1*1000))'; %tempo in cui percorro il tratto iniziale
 tv=linspace(0,dtv,ceil(lv*1000))'; %tempo in cui percorro il tratto di accelerazione
 t2=linspace(0,(1-dtv)/2,ceil(l2*1000))'; %tempo in cui percorro il tratto finale
 
 P1=pi+v1.*t1; %prima porzione di percorso, spazio iniziale + vt (rettilineo uniforme)
 P2=P1(end,:)+v1.*tv+1/2.*av.*tv.^2; %dalla fine della prima porzione, accelero
 P3=P2(end,:)+v2.*t2; %ultima porzione a velocità costante
 P=[P1; P2(2:end,:); P3(2:end,:)];
end