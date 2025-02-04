function [shapeq4,dhdrq4,dhdsq4]=feisoq4(rvalue,svalue)
%------------------------------------------------------------------------------------------------------------------
%Proposito:
%Calcular las funciones de forma isoparametricas para elemento cuadrilatero de 4 nodos y sus derivadas 
% en los puntos de integraci´on seleccionados en termino de las coordenadas naturales.
%Sintaxis:
% 
%[shapeq4,dhdrq4;dhdsq4]=feisoq4(rvalue,svalue)
%
% Descripcion de las Variables
% shapeq4: funciones de forma para el elemento de 4-nodos
% dhdrq4: derivada de la funcion de forma con respecto a la  coordenada natural r
% dhdsq4: derivada de la funcion de forma con respecto a la  coordenada natural s
% rvalue: valor de la  coordenada natural r en el punto seleccionado
% svalue: valor de la  coordenada natural s en el punto seleccionado
%
% Notas:
% El pimer nodo esta en (-1,.1) , el segundo nodo esta en (1,-1), el tercer nodo esta en (1,1) y el cuarto nodo
% esta en (-1,1) 
%------------------------------------------------------------------------------------------------------------------
%
% Funciones de Forma
%
shapeq4(1)= 0.25*(1-rvalue)*(1-svalue);
shapeq4(2)= 0.25*(1+rvalue)*(1-svalue);
shapeq4(3)= 0.25*(1+rvalue)*(1+svalue);
shapeq4(4)= 0.25*(1-rvalue)*(1+svalue);
%
% Las Derivadas de las funciones de forma respecto a la coordenada s resultan:
%
dhdrq4(1)= -0.25*(1-svalue);
dhdrq4(2)= 0.25*(1-svalue);
dhdrq4(3)= 0.25*(1+svalue);
dhdrq4(4)= -0.25*(1+svalue);
%Las Derivadas de las funciones de forma respecto a la coordenada r resultan:
dhdsq4(1)= -0.25*(1-rvalue);
dhdsq4(2)= -0.25*(1+rvalue);
dhdsq4(3)= 0.25*(1+rvalue);
dhdsq4(4)= 0.25*(1-rvalue); 
%
end