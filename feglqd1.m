function[point1,weight1]=feglqd1(ngl)
%--------------------------------------------------------------------------------------------------------------
%Proposito:
% Determinar los puntos de integracion y coeficientes de pesos de la cuadratura de 
% Gauss-Legendre para integracion sobre un dominio unidimsensional.
%
% Sintaxis:
% [point1,weight1]=feglqd1(ngl)
%
% Descripcion de las variables:
% ngl = numero de puntos de integracion.
% point1=vector conteniendo los puntos de integracion.
% weight1=vector conteniendo los coeficientes de peso.
%--------------------------------------------------------------------------------------------------------------
%
% Inicializacion
%
point1=zeros(ngl,1);
weight1=zeros(ngl,1);
%
% Encuentro de los correspondientes puntos de integracion y pesos
%
if ngl==1  % regla de la cuadratura con 1-punto.
point1(1)=0
weight1(1)=2
%
elseif ngl==2                                                                      % regla de la cuadratura con 2-puntos.
point1(1) =-0.577350269189626;
point1(2)=-point1(1);
weight1(1)=1;
weight1(2)=1;
%
elseif ngl==3                                                                      % regla de la cuadratura con 3-puntos.
point1(1) =-0.774596669241483;
point1(2)=0.0;
point1(3)=0.774596669241483;
weight1(1)=0.555555555555556;
weight1(2)=0.888888888888889;
weight1(3)=0.555555555555556;
%
elseif ngl==4                                                                      % regla de la cuadratura con 4-puntos.
point1(1) =-0.861136311594053;
point1(2)=-0.339981043584856;
point1(3)=0.339981043584856;
point1(4)=0.861136311594053;
weight1(1)=0.347854845137454;
weight1(2)=0.652145154862546;
weight1(3)=0.652145154862546;
weight1(4)=0.347854845137454;
%
else                                                                                    % regla de la cuadratura con 5-puntos.                                                                   
point1(1) =-0.906179845938664;
point1(2)=-0.53846931010105683;
point1(3)=0.0;
point1(4)=-point1(2);
point1(5)=-point1(1);
weight1(1)=0.236926885056189;
weight1(2)=0.478628670499366;
weight1(3)=0.568888888888889;
weight1(4)=weight1(2);
weight1(5)=weight1(1);
% 
end
% %