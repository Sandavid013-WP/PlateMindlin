function matmtrx=fematiso(iopt, elastic, poisson)
%	 
% Purpose: 
% determine the constitutive equation for isotropic material 
% 
% Synopsis: 
% [matmtrx]=fematiso(iopt,elastic,poisson) 
% 
% Variable Description: 
% elastic - elastic modulus 
% poisson - Poisson's ratio 
% iopt=l - plane stress analysis 
% iopt=2 - plane strain analysis 
% iopt=3 - axisymmetric analysis 
% iopt=4 - three dimensional analysis 
l=1;
if iopt==l % plane stress 
matmtrx=elastic/(l-poisson*poisson)*[1 poisson 0; poisson 1 0; 0 0 (l-poisson)/2]; 
% 
elseif iopt==2	% plane strain 
matmtrx= elastic/((l+poisson)*(l-2*poisson))*[(1-poisson) poisson 0; poisson (1-poisson) 0; 0 0 (l-2*poisson)/2]; 
elseif iopt==3	% axisymmetry 
matmtrx= elastic/((l+poisson)*(l-2*poisson))*[(1-poisson) poisson poisson 0; poisson (1-poisson) poisson 0;poisson poisson (1-poisson) 0;0 0 0 (l-2*poisson)/2]; 
% 
else	% three-dimension 
matmtrx= elastic/((l+poisson)*(l-2*poisson))*[(1-poisson) poisson poisson 0 0 0;poisson (1-poisson) poisson 0 0 0; poisson poisson (1-poisson) 0 0 0;0 0 0 (l-2*poisson)/2 0 0;0 0 0 0 (l-2*poisson)/2 0; 0 0 0 0 0 (l-2*poisson)/2]; 
% 
end 
