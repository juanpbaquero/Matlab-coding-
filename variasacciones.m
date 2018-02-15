

clear all

[PRECIOS,NOMBRES]=xlsread('precios_ej.xlsx') ;

PRECIOS(:,1)=[] ; %  ELiminando la primera columna

LOGPRECIOS=log(PRECIOS) ;

RETORNOS=diff(LOGPRECIOS) ;

MATRIZCORR=corr(RETORNOS)   ;


n=size(RETORNOS,2)   ;  %  numerode acciones

x=30        ;  % numero de periodos 

N=100   ; %  numero de simulaciones  

numerodias=size(PRECIOS,1); % numero de dias 

MATRIZ=randn(N,x,n) ;    % matriz de choques aleatorios

MEDIA=mean(RETORNOS)  ;     % media de los retornos

DESVIACIONEST=std(RETORNOS)  ;    % desviacion estandar de los retornos 

ULTIMOPRECIO=PRECIOS(end,:)  ;    % tomamos el ultimo precio de todas las acciones 

for i =1:n 

z(:,:,i)=(MEDIA(i)+MATRIZ(:,:,i)*DESVIACIONEST(i)) ;  %  el choque aleatorio operado con tendencia y desviacion 

Z(:,:,i)=cumsum(z(:,:,i),2) ;     % se acumula el z   de acuerdo a la formula recursiva 

P(:,:,i)=ULTIMOPRECIO(i)*exp(Z(:,:,i)) ;     % se efectua la similuacion 


PRECIOS2=PRECIOS(numerodias-49:end,:) ;     % cogemos los ultimos 50 dias del precio de la accion 

PRECIOS3(:,:,i)=repmat(PRECIOS2(:,i)',N,1);

SIMU(:,:,i)=[PRECIOS3(:,:,i), P(:,:,i)];    % pegamos la matriz de los ultimos 50 dias ( repetida ) con la simulacion 


figure(i)

plot(SIMU(:,:,i)') 
title(NOMBRES(i))
xlabel('Tiempo')
ylabel('Precio')

end





