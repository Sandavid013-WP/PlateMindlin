function   jacob2=fejacob2(nnel,dhdr,dhds,xcoord,ycoord)
%------------------------------------------------------------------------------------------------------------------
%Proposito:
%determinar el Jacobiano del mapeo Bidimensional 
%Sintaxis:
% [jacob2]=fejacob2(nnel,dhdr,dhds,xcoord,ycoord)
%
% Descripcion de las Variables
% Jacob2: jacobiano para una diminesion
% nnel: Numero de nodos por elemento
% dhdr: derivada de la funcion de forma en coordenada natural r
% dhds: derivada de la funcion de forma en coordenada natural s
%xcoord: valor en x de la coordenada de cada nodo
%ycoord: valor en y de la coordenada de cada nodo
%------------------------------------------------------------------------------------------------------------------
%
jacob2=zeros(2,2);                            % inicializa una matriz llamads jacob2  de 2x2 con elemntos nulos
%
for i=1:nnel % Loop desde el nodo 1 del elemento hasta el nodo nnel( cantidad de nodos del elemento)
    jacob2(1,1)=jacob2(1,1)+dhdr(i)*xcoord(i);
    jacob2(1,2)=jacob2(1,2)+dhdr(i)*ycoord(i);
    jacob2(2,1)=jacob2(2,1)+dhds(i)*xcoord(i);
    jacob2(2,2)=jacob2(2,2)+dhds(i)*ycoord(i);
end
%
%------------------------------------------------------------------------------------------------------------------
