  function [kinmtps]=fekineps(nnel,dhdx,dhdy,shape)
%--------------------------------------------------------------------------------------------------------------
% Proposito de la funcion:
% determinar la expresion de la matriz cinematica que relacionada las deformaciones por corte con las
% rotaciones y desplazamientos por corte para la placa deformable en flexion.
%
% Sintesis:
% [kinmtps]=fekineps(nnel,dhdx,dhdy,shape)
%
% Descripcion de Variables:
% nnel- numero de nodos por elemento
% dhdx- derivada de las funciones de forma con respecto a x.
% dhdy- derivada de las funciones de forma con respecto a y.
% shape- funcion de forma
%--------------------------------------------------------------------------------------------------------------
%
for i=1: nnel
    i1=(i-1)*3+1;
    i2=i1+1;
    i3=i2+1;
    kinmtps(1,i1)=-shape(i);
    kinmtps(1,i3)=dhdx(i);
    kinmtps(2,i2)=-shape(i);
    kinmtps(2,i3)=dhdy(i);
end
%