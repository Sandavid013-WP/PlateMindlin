function[point2,weight2]=feglqd2(nglx,ngly)
%--------------------------------------------------------------------------------------------------------------
% Proposito:
% Determinar los puntos de integracion 
% y coeficientes de pesos de la cuadratura de Gauss-Legendre para integracion sobre un dominio 
% Bidimsensional.
%
% Sintaxis:
% [point2,weight2]=feglqd2(nglx;ngly)
%
% Descripcion de las variables:
% nglx      = numero de puntos de integracion en el eje x.
% ngly      = numero de puntos de integracion en el eje y.
% point2   = vector conteniendo los puntos de integracion.
% weight2 = vector conteniendo los coeficientes de peso.
%--------------------------------------------------------------------------------------------------------------
%
% Determinacion del mas grande entre nglx y ngly
%
if nglx>ngly
ngl=nglx;
else
ngl=ngly;
end
%
% Inicializacion
point2=zeros(ngl,2);
weight2=zeros(ngl,2);
%
% Encuentro de los correspondientes puntos de integracion y pesos
%
[pointx,weightx]=feglqd1(ngl);
[pointy,weighty]=feglqd1(ngl);     % Cuadratura para dos dimensiones.
%
for intx=1:nglx; 
    point2(intx,1)=pointx(intx);
    weight2(intx,1)=weightx(intx);
end
%
for inty=1:ngly; 
    point2(inty,2)=pointy(inty);
    weight2(inty,2)=weighty(inty);
end
%