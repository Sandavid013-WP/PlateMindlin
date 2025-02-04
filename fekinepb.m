function [kinmtpb]=fekinepb(nnel,dhdx,dhdy)
%--------------------------------------------------------------------------------------------------------------
% Proposito de la funcion:
% Determinar la expresion de la matriz cinematica que relacionada las curvaturas por flexion con las
% rotaciones y desplazamientos para la placa en flexion deformable por corte.
%
% Sintesis:
% [kinmtpb]=fekinepb(nnel,dhdx,dhdy)
%
% Descripcion de Variables:
% nnel- numero de nodos por elemento
% dhdx- derivada de las funciones de forma con respecto a x.
% dhdy- derivada de las funciones de forma con respecto a y.
%--------------------------------------------------------------------------------------------------------------
%
for i=1: nnel
    i1=(i-1)*3+1;
    i2=i1+1;
    i3=i2+1;
    kinmtpb(1,i1)=dhdx(i);
    kinmtpb(2,i2)=dhdy(i);
    kinmtpb(3,i1)=dhdy(i);
    kinmtpb(3,i2)=dhdx(i);
    kinmtpb(3,i3)=0;
end
%