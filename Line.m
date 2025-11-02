%Funzione per traiettoria retta
function P = Line(p1, p2)
 %costruisce retta da estremi
 %d=sqrt((p2(1)-p1(1))^2+(p2(2)-p1(2))^2+(p2(3)-p1(3))^2);
 d=norm(p2-p1);
 s=linspace(0,1,ceil(1000*d)); %ceil arrotonda il valore all'intero più grande più vicino al valore
 P=(1-s).*p1'+s.*p2';
 P=P'; 
end
%s è la lunghezza d'arco, l'ascissa curvilinea
%se s = 0 sto nel punto iniziale, se s = 1 nel finale, come se avessi
%normalizzato l'intervallo di definizione di s, la definizione è identica a
%quella del libro, solo scritta in maniera diversa