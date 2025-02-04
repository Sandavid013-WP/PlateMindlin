function[dhdx,dhdy]=federiv2(nnel,dhdr,dhds,invjacob)
%------------------------------------------------------------------------------------------------------------------
%Proposito:
%determinar las derivadas en 2D de las funciones de forma Isoparametricas con respecto al sistema de 
% coordenadas fisico.
%Sintaxis:
% [dhdx,dhdy]=federiv2(nnel,dhdr,dhds,invjacob)
%
% Descripcion de las Variables
% dhdx: derivada de la funcion de forma con respecto a la coordenada  fisica x
% dhdy: derivada de la funcion de forma con respecto a la  coordenada fisica y
% nnel: Numero de nodos por elemento
% dhdr: derivada de la funcion de forma con respecto a la coordenada natural r
% dhds: derivada de la funcion de forma con respecto a la coordenada natural s
% invjacob:inversa de la matriz jacobiana Bidimensional.
%------------------------------------------------------------------------------------------------------------------
%
for i=1:nnel        % Loop desde el nodo 1 del elemento hasta el nodo nnel( cantidad de nodos del elemento)
    dhdx(i)=invjacob(1,1)*dhdr(i)+invjacob(1,2)*dhds(i);
    dhdy(i)=invjacob(2,1)*dhdr(i)+invjacob(2,2)*dhds(i);
end
%