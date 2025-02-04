function [kk]=feasmbll(kk,k,index) 
%__	_	.	 
% Purpose: 
% Assembly of element matrices into the system matrix 
% 
% Synopsis: 
% [kk]=feasmbll(kk,k,index) 
% 
% Variable Description: 
% kk - system matrix 
% ? - element matri 
% index - d.o.f. vector associated with an element 
edof = length (index); 
for i=1:edof 
ii=index(i); 
for j=1:edof 
jj=index(j); 
kk(ii,jj)=kk(ii,jj)+k(i,j)
end 
end 
