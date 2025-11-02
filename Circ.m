%Funzione per traiettoria di circonferenza
function P = Circ(p1,c,ang)
 %construisce arco di circonferenza da p1 centrata in c
 radius=sqrt((c(1)-p1(1))^2+(c(2)-p1(2))^2);
 arc=abs(radius*ang);
 phase=atan2((p1(2)-c(2))/radius,(p1(1)-c(1))/radius); %faccio fratto il raggio per normalizzare
 %La fase serve perché altrimenti l'arco di circonferenza viene plottato al
 %contrario, come se fosse nel primo quadrante, mentre noi lo vogliamo nel
 %terzo e quarto
 s=linspace(0,1,ceil(1000*arc));
 
 P=zeros(length(s),3);
 P(:,1)=c(1)+radius*(cos(s*ang-phase)); %coordinata x del centro+raggio per il coseno mi metto sul cerchio
 P(:,2)=c(2)+radius*(-sin(s*ang-phase)); %coordinate y circonferenza
 P(:,3)=p1(3);
end