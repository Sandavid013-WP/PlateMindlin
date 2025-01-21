
%---------------------------------------------------------------------------------------------------------------
%                                       PROGRAMA PLACA 2D 2024
% Una placa cuadrada simplemente apoyada esta sujeta a una carga concentrada en su centro
% Encontrar la deflexion de la placa usando los elementos isoparametricos de la formulacion de 
% deformacion por corte. El tamaño de la placa es de 10[in]x 10[in] y su espesor es de 0.1[in].
% Esta hecha de acero y la carga aplicada es de 10 [lb].
%---------------------------------------------------------------------------------------------------------------
%
% Descripcion de las variables:
% k   = Elemento de la matriz
% kb = Elemento de la matriz para la flexion
% ks = Elemento de la matriz para el corte.
% f   = Elemento del vector.
% kk = Matriz del sistema.
% ff   = Vector del sistema.
% disp=Vector desplazamiento nodal del sistema.
% gcoord=Valores de las coordenada de cada nodo.
% nodes= Conectividad nodal de cada elemento.
% index= Vector del sistema que contiene los dofs asociados a cada elemento.
% pointb=Matriz que contiene los puntos de prueba para el termino en flexion.
% weightb= Matriz que contienen los coeficientes  de peso para el termino en flexion.
% points=Matriz que contiene los puntos de prueba para el termino en corte.
% weights= Matriz que contienen los coeficientes  de peso para el termino en corte.
% pointb=Matriz que contiene los puntos de prueba para el termino en flexion.
% bcdof= Vector que contiene los dofs asociados con las condiciones de contorno.
% bcval= Vector que contiene los valores de las condicones de forntera asociados con los dofs en bcdof.
% kinmtpb= Matriz para la ecuacion cinematica para la flexion.
% matmtpb= Matriz para las propiedades del material en flexion.
% kinmtps= Matriz para la ecuacion cinematica para el corte.
% matmtps= Matriz para las propiedades del material en corte.
%---------------------------------------------------------------------------------------------------------------
%
%---------------------------------------------------------------------------------------------------------------
% Ingreso de datos para los parametros de control
%---------------------------------------------------------------------------------------------------------------
nel=4;                                                                                                  % Numero de elementos.
nnel=4;                                                                                  %Numero de nodos por elemento.
ndof=3;                                                                                         % Numero de dofs por nodo.
nnode=9;                                                                         % Numero total de nodos en el sistema.
sdof=nnode*ndof;                                                                               % dofs totales del sistema.
edof=nnel*ndof;                                                                      % Grados de libertad por elemento.
emodule=30e6;                                                                     % Modulo de elasticidad del material. 
poisson=0.3;                                                                                        % Coeficiente de Poisson.
t=0.1;                                                                                                        % Espesor de la placa.
nglxb=2; nglyb=2;                                                % 2x2 Cuadratura de Gauss-Legendre para flexion.
nglxs=1; nglys=1;                                                 % 1x1 Cuadratura de Gauss-Legendre para corte.
                                                                          %  Se considera integracion reducida, tomando 
                                                                          %  solo un punto de integracion.  
%
%---------------------------------------------------------------------------------------------------------------
% Ingreso de los datos de los valores de las coordenadas nodales
% gcoord(i,j) donde i->numero de nodo. y j-> x o y
 %---------------------------------------------------------------------------------------------------------------
gcoord=[ 0.0 0.0 ; 2.5 0.0 ; 5.0 0.0; 0.0 2.5 ; 2.5 2.5; 5.0 2.5;0.0 5.0 ; 2.5 5.0 ; 5.0 5.0]; % Se modela solo un cuarto de placa
%
%---------------------------------------------------------------------------------------------------------------
% Ingreso de los datos para las conectividades nodales de cada elemento
% nodes(i,j) donde i->numero de elemento. y j-> conecta los nodes.
%---------------------------------------------------------------------------------------------------------------
nodes=[ 1 2 5 4; 2 3 6 5 ; 4 5 8 7; 5 6 9 8 ];
%
%---------------------------------------------------------------------------------------------------------------
% Ingreso de datos para las condiciones de frontera.
%---------------------------------------------------------------------------------------------------------------
bcdof=[1 2 3 4 6 7 9 11 12 16 20 21 23 25 26]; % dofs restringidos.
bcval=zeros(1,15); % describe que valores son cero.
%
%---------------------------------------------------------------------------------------------------------------
% Inicializacion de matrices y vectores
%---------------------------------------------------------------------------------------------------------------
ff=zeros(sdof,1);                                                                       % Vector fuerza para el sistema.
kk=zeros(sdof,sdof);                                                                                 % Matriz del sistema.
disp=zeros(sdof,1);                                                             % vector desplazamiento del sistema.
index=zeros(edof,1);                                                                                         % vector indice.
kinmtpb=zeros(3,edof);                                                          % Matriz cinematica para la flexion.
matmtpb=zeros(3,3);                                                            % Matriz constitutiva para la flexion.
kinmtps=zeros(2,edof);                                                             % Matriz cinematica para el corte.
matmtps=zeros(2,2);                                                               % Matriz constitutiva para el corte.
%
%---------------------------------------------------------------------------------------------------------------
% Vector Fuerza
%---------------------------------------------------------------------------------------------------------------
ff(27)=10;   %[kg]                        % Fuerza concentrada aplicada en el dof nro. 27 (+) hacia abajo.
                                                % Se consideran 3 dof por cada nodo.
%
%---------------------------------------------------------------------------------------------------------------
% Calculo de las matrices de los elementos y vectores y sus ensambles.
%---------------------------------------------------------------------------------------------------------------
% Para la rigidez en flexion
%
[pointb,weightb]=feglqd2(nglxb,nglyb);
%                                                                                                      % Puntos & Pesos
matmtpb=fematiso(1,emodule,poisson)*(t^3)/12;                          %Matriz de propiedades del material.
%
% Para la rigides en corte
%
[points,weights]=feglqd2(nglxs,nglys);
%                                                                                                                      % Puntos & Pesos
shearm=0.5*emodule/(1.0+poisson);                                                                     % Modulo de corte
shcof=5/6                                                                                   %Factor de correccion por corte
matmtps=shearm*shcof*t*[1 0;0 1];                                      %Matriz de propiedades del material.
%
for iel=1:nel                                                                           % Loop for the total nember of elements.
%
for i=1:nnel
    nd(i)=nodes(iel,i);                                                                     % extract nodes for (iel)-th element.
    xcoord(i)=gcoord(nd(i),1)                                                          % extract x value of the nodes.
    ycoord(i)=gcoord(nd(i),2)                                                          % extract y value of the nodes.
end
%
k=zeros(edof,edof);  % initicializacion de elementos  de la matriz.
kb=zeros(edof,edof); % initicializacion de elementos  de la matriz de flexion.
ks=zeros(edof,edof); % % initicializacion de elementos  de la matriz de corte
%
%---------------------------------------------------------------------------------------------------------------
% Integracion Numerica para los terminos en flexion
%---------------------------------------------------------------------------------------------------------------
for intx=1:nglxb
    x=pointb(intx,1); %sampling point in x-axis.
    wtx=weightb(intx,1);%weight in x-axis.
for inty=1:nglyb
     y=pointb(inty,2); %sampling point in y-axis.
    wty=weightb(inty,2);%weight in y-axis.
 %
 [shape,dhdr,dhds]=feisoq4(x,y); % Calcula la funciones de forma y 
 %                                           % las derivadas en el punto de muestreo.
 %
 jacob2=fejacob2(nnel,dhdr,dhds,xcoord,ycoord);   % Matriz Jacobiana.
 %
 detjacob=det(jacob2); % Determinante del Jacobiano.
 invjacob=inv(jacob2); % Inversa de la matriz Jacobiana.
 %
 [dhdx,dhdy]=federiv2(nnel,dhdr,dhds,invjacob); % Derivadas w.r.t
 %                                                                  % coordenadas fisicas.
 %
 kinmtpb=fekinepb(nnel,dhdx,dhdy);% Matriz cinematica en flexion
 %
 %---------------------------------------------------------------------------------------------------------------
 % Calculo de los elementos de la matriz de flexion
 %---------------------------------------------------------------------------------------------------------------
 kb=kb+(kinmtpb'*matmtpb*kinmtpb*wtx*wty*detjacob);
 %
end
end %  Fin del Loop para integracion de los terminos en flexion
%
%---------------------------------------------------------------------------------------------------------------
% Integracion Numerica para los terminos en corte
%---------------------------------------------------------------------------------------------------------------
for intx=1:nglxs
    x=points(intx,1); % Punto en el eje x-axis.
    wtx=weights(intx,1);%Peso en el x-axis.
for inty=1:nglys
     y=points(inty,2); % Punto en el eje y-axis.
    wty=weights(inty,2);%Peso en el y-axis.
 %
 [shape,dhdr,dhds]=feisoq4(x,y); % Calcula la funciones de forma y 
 %                                            % las derivadas en el punto de muestreo.
 %
 jacob2=fejacob2(nnel,dhdr,dhds,xcoord,ycoord);   % Matriz Jacobiana.
 %
 detjacob=det(jacob2); % Determinante del Jacobiano.
 invjacob=inv(jacob2); % Inversa de la matriz Jacobiana.
 %
 [dhdx,dhdy]=federiv2(nnel,dhdr,dhds,invjacob); % Derivadas w.r.t
 %                                                                  % coordenadas fisicas.
 %
 kinmtps=fekineps(nnel,dhdx,dhdy,shape); % Matriz cinematica en corte
 %
 %---------------------------------------------------------------------------------------------------------------
 % Calculo de los elementos de la matriz de corte
 %---------------------------------------------------------------------------------------------------------------
 ks=ks+kinmtps'*matmtps*kinmtps*wtx*wty*detjacob;
 %
end
end % Fin del Loop para integracion de los terminos del corte
%
%---------------------------------------------------------------------------------------------------------------
% Calculo de los elementos de la matriz del sistema
%--------------------------------------------------------------------------------------------------------------
k=kb+ks;
%
index=feeldof(nd,nnel,ndof); % Extrae el sistema de dofs asociados
%
kk=feasmbl1(kk,k,index); % Ensamble de las matrices elementales, para dar la matriz final del sistema
%
end
%
%--------------------------------------------------------------------------------------------------------------
% Aplicacion de las condiciones de frontera
%--------------------------------------------------------------------------------------------------------------
[kk,ff]=feaplyc2(kk,ff,bcdof,bcval);
%
%--------------------------------------------------------------------------------------------------------------
% Resolviendo la ecuacion matricial
%--------------------------------------------------------------------------------------------------------------
disp=kk\ff;
%
num=1:1:sdof;
displace=[num' disp] % Imprime los desplazamientos nodales

% Representación gráfica de la malla con nodos, elementos numerados y grados de libertad organizados
figure;
hold on;

% Dibujar los elementos
for iel = 1:size(nodes, 1)
    % Nodos del elemento actual
    elem_nodes = nodes(iel, :);
    
    % Coordenadas del elemento
    x = gcoord(elem_nodes, 1);
    y = gcoord(elem_nodes, 2);
    
    % Dibujar el elemento como un cuadrado
    fill(x, y, 'cyan', 'FaceAlpha', 0.3, 'EdgeColor', 'black');
    
    % Etiquetar el elemento en el centroide
    centroid_x = mean(x);
    centroid_y = mean(y);
    text(centroid_x, centroid_y, sprintf('%d', iel), 'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');
end

% Numerar nodos y mostrar DOFs organizados
for inode = 1:size(gcoord, 1)
    x = gcoord(inode, 1);
    y = gcoord(inode, 2);
    
    % Numerar el nodo
    text(x, y, sprintf('%d', inode), 'Color', 'blue', 'FontSize', 10, 'FontWeight', 'bold', ...
        'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
    
    % Mostrar los DOFs del nodo con mayor separación
    dof_x = (inode - 1) * ndof + 1;  % DOF en dirección x
    dof_y = (inode - 1) * ndof + 2;  % DOF en dirección y
    dof_w = (inode - 1) * ndof + 3;  % DOF de desplazamiento w
    
    % Etiquetar los DOFs cerca del nodo, separados verticalmente
    text(x - 0.3, y + 0.5, sprintf('X:%d', dof_x), 'Color', 'black', 'FontSize', 8, 'HorizontalAlignment', 'center');
    text(x - 0.3, y + 0.35, sprintf('Y:%d', dof_y), 'Color', 'black', 'FontSize', 8, 'HorizontalAlignment', 'center');
    text(x - 0.3, y + 0.2, sprintf('W:%d', dof_w), 'Color', 'black', 'FontSize', 8, 'HorizontalAlignment', 'center');
end

% Ajustar etiquetas de condiciones de frontera
text(0.5, -0.8, 'SIMPLE SUPPORT', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');
text(-0.8, 2.5, 'SIMPLE SUPPORT', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 10, 'FontWeight', 'bold');
text(5.2, 2.5, 'SYMMETRY', 'HorizontalAlignment', 'center', 'Rotation', 90, 'FontSize', 10, 'FontWeight', 'bold');
text(2.5, 5.2, 'SYMMETRY', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold');

% Configuración de la gráfica
xlabel('X [m]');
ylabel('Y [m]');
title('Malla 2x2: Nodos, Elementos y DOFs Organizados');
axis equal;
xlim([-1, 6]); % Ampliar la gráfica para incluir texto
ylim([-1, 6]); % Ampliar la gráfica para incluir texto
grid on;
hold off;

