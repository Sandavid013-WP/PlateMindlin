function [kk, ff] = feaplyc2(kk, ff, bcdof, bcval) 
    % Purpose: Apply constraints to matrix equation [kk]x = ff 
    % 
    % Inputs:
    % kk - system matrix before applying constraints 
    % ff - system vector before applying constraints 
    % bcdof - a vector containing constrained degrees of freedom (d.o.f) 
    % bcval - a vector containing constrained values 
    %
    % Example:
    % If there are constraints at d.o.f=2 and 10 and their values are 0.0 and 2.5, respectively,
    % then bcdof(1)=2, bcdof(2)=10; and bcval(1)=0.0, bcval(2)=2.5.
    
    n = length(bcdof); 
    sdof = size(kk, 1);  % Consider the number of rows of kk as the number of degrees of freedom
    
    for i = 1:n 
        c = bcdof(i); 
        
        % Set entire row c and column c of kk to zero
        kk(c, :) = 0;  % This line uses colon `:` to set the entire row
        kk(:, c) = 0;  % This line uses colon `:` to set the entire column
        
        % Set the diagonal entry of kk to 1
        kk(c, c) = 1; 
        
        % Set the corresponding entry in the force vector to the constrained value
        ff(c) = bcval(i); 
    end 
end
